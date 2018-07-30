Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91EFF1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 12:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbeG3OYy (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 10:24:54 -0400
Received: from mout.gmx.net ([212.227.15.15]:59117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbeG3OYy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 10:24:54 -0400
Received: from [192.168.0.129] ([37.201.193.26]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M08eS-1fyche0Gy4-00uIyV; Mon, 30
 Jul 2018 14:49:58 +0200
Date:   Mon, 30 Jul 2018 14:49:56 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        bmwill@google.com, peff@google.com
Subject: Re: [PATCH] config: fix case sensitive subsection names on writing
In-Reply-To: <xmqqh8kkjg23.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807301438440.10478@tvgsbejvaqbjf.bet>
References: <CAGZ79kaVS96_K-G-_hEnRecBS843tjn7=Am0xZQjZABCdC7L0A@mail.gmail.com> <20180727233606.179965-1-sbeller@google.com> <xmqqh8kkjg23.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zqf08AKCALxcqSj7ZrnEqCVHA53zPUjPa161lptwWddLPyxyNKM
 ETjjazIzDlu6JN3P2bvtOBGq4PReOAaxeIDzHl7bXL4IXi9EDyO4rDmhNZPFfCv9l9e+j2o
 A8uwFK7aJraByqhGo7w3p8Z10CYBqSOO+CSeY3iIrunUvlL9axBBlKxKeZIH+umI7BytMrl
 vHE8SNz5SQ2hG6CONWm1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:szyf1Q072Sc=:ih7Tv+0Gan+s3qejLpf8Fk
 cL4830OJEiRwtYfQwb4Xe0cT5wgfYYCtyJJnNLxDW6JZ23WmfupcrnVVbCBxovL3VW49VIQJr
 +lqVfcO7OgEcKM1NN8auaiOBbqvZbM0tR2T7ofF6OxpBUzoY7JtrFvNuMjlpz/BTvvSHt5RGV
 JIoLHl83yqqGz0+Dz3kFwElBMfCSXql4WrZwaTH896UsluXhHoTS1Pa1RzuMi0KX9L8RwRpw+
 oKjI3RZztIr/PMSZ6MUVj1u26Cvnby+MjCMIrSjpZU54PN6G7ir+oRd1Xry2eJAPmaap/ggT4
 pF3DS4nvmNAqAZaHk7UhMrNsRV+YlYZCKQWMGeapineyXQRcoLpJFEpOTHjte6DyR/IVxCZqz
 D+Y4nDuCXVzFrBaVLCZDr7vmkc1k5tpT3dageld85leAHFB64VbPDb9nouSBCQitgV7Dn9XF4
 ms6Nc+dGNANJ3s8Dss7fFDO1kGhpKnX0zGoqiAYnCqFhSKRQUPZYnri0X5klGmU1V3jIFR10C
 SrHCui34M5BUPyHDJYCBFcrpEUwkBGHXP7ZxvX5OnGtbqmLu218wX4oqUzdo8p+d8C7icPDWR
 Tl50eMJGpJA/63ppLXeYZA16ZVLXVigu11xRJhUYpgZbU+BDl+bHU2bioVwFi7Jx/x9u2qlco
 KAzV7grK0GBzeheFZnIPleFDbiDfqUXSiEfblTjfztM9f7coI+f4n7rmNE12FfbRkgEGSM0bj
 KqjhV0CCrvv+0ZL2Pes3R6xGcj7dA4b7CYEKXN29RjFetDUL6iqwsChaLPEGTCSTUqQ+gcqfc
 xhy3ePc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 27 Jul 2018, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
>
> [...]

Thanks for the patch!

The only thing that was not clear to me from the patch and from the commit
message was: the first part *is* case insensitive, right? How does the
patch take care of that? Is it relying on `git_config_parse_key()` to do
that? If so, I don't see it...

> I would still hold the judgment on "all except only this one"
> myself.  That's a bit too early in my mind.

Agreed. I seem to remember that I had a funny problem "in the reverse",
where http.<url>.* is case-sensitive, but in an unexpected way: if the URL
contains upper-case characters, the <url> part of the config key needs to
be downcased, otherwise the setting won't be picked up.

Ciao,
Dscho
