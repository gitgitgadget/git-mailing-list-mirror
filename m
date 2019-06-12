Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BC301F462
	for <e@80x24.org>; Wed, 12 Jun 2019 18:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfFLSrd (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 14:47:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:39529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfFLSrd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 14:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560365247;
        bh=0H9wFVG0bwy459NUpAs/n6UNLFUgulsFbzVHJwuwwS0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bpzw1IjYMkDvpV+D9Iu4hh/+eSBShWA/dYM/FxoprTakdzu8Ba3PGeAm1KuU7Dw2s
         3fV4G7EZK197yCEMPuQ+Q9ECEIWmyWFfn0LLG5i095k1g3nS9Un97U5ruentUF0PVY
         M4/tMxa7UYc9DoltKdj2oTVLF+Rm2Ta1cjXP2ZWM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5tzh-1iYKdK1p4T-00xvEF; Wed, 12
 Jun 2019 20:47:27 +0200
Date:   Wed, 12 Jun 2019 20:47:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@DESKTOP-QUA364F.localdomain
To:     Espen Antonsen <espen@inspired.no>
cc:     git@vger.kernel.org
Subject: Re: Git status parse error after v.2.22.0 upgrade
In-Reply-To: <38b0f33a-1da1-4231-802e-ae14d9843ad2@www.fastmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906122046400.789@QRFXGBC-DHN364S.ybpnyqbznva>
References: <3bc58c33-4268-4e7c-bf1a-fe349b3cb037@www.fastmail.com> <nycvar.QRO.7.76.6.1906112127420.789@QRFXGBC-DHN364S.ybpnyqbznva> <38b0f33a-1da1-4231-802e-ae14d9843ad2@www.fastmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mHyU6D5OMbsn6VjmuqdF5wLT+mGcu+qiAacQCEXZWGz1AF4S/JH
 SsSegvGIo7+vEeqoeUWvz3viZMx8ILKyGtj9YTflA1A9zjLbu1myO8+kAp/h/6nL6CiC6ov
 d5LKV7fqaVa8ci6ptAT0rAa3GcstEHx9ryOzLCN3TAyI7/MVYSZ4COo2qj/Qg0pzd8Zf4r1
 7KpbZePgUDKrjA9tLmaQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kkls5VPwW9c=:1hUchfmQ0tAgpMyfKaOmVn
 R9Wtl07GUpih63/JtBokxeWKd6ocoVUBeBrc9q7yCnq+BWRXFhaufP4PyYDokED/opIi9Y2/D
 2qTV74lt623x0tQ8nr/UkX4wC12zkUnNgDgAEgWOVr94oTSmbI4jPl2S9eHB+6iKWviWFwdVh
 KHMPNkaq2W6CAMK5Iai9LZtlxzK2LZ5Dl6Bnhh/JcNb+kIcbl4TcrBRrPPEyH1xHMrfJVL1Jl
 o0ziIsu6tnlTTd80rRReJTrgprzetowRCnmuusIarHNPKj5vvIvDKZmqppNKs+2w6aT0Eyo75
 ql0A2k7D3d9hpThzt+0/Q+wMiUIu/qmbxgIQeNydXcm+p0tMoTHPx7w9NknxgPVLJAFBZpkaZ
 +P7kayn3aZ940zqYh65hbtEAAMtMeL1WhDhVYwAWkiRRhLT0OaKEuVReupRth3aXxH79KVy4S
 dXROh4ASZb3WUW9gBxJlV9Htjv4BUMjR4H+ykxGJp5BQW7LZYitkbSReuQ5RdxscMnLxXvDKz
 IHxz4BZSbaWqInPMeJ9pEzih7CP0wtxS0HupIr8t/smJLI2Rc24V0+WI2lWtFjqzL68uvHgKr
 gBcC9SM1yQDrx4VtezLROIcF9HpNAbmtcaevoASnY32viLWwh2y5TQy5BwSe+pBOxHluXRBHB
 GtWl0+TKV699Tv65n2fgtQumNR/sGF0nvskb9Afw3Wdpk6ODOcksbvaR48kRqb4ZnCd/PjjxI
 VnEV6RWmDwS1nsJlaZNzipajtx9twmmIVMRXjbjp16yxZ9Mr7LRSzm5o034vZZn4nknyyy5kY
 NR62fKvsBpS4PoSRRSeaqpDNsHrfEM1Ot/2//5y6sl6h8iFqNbQ4EkcQ4T7OfmNQRluhQQkzy
 p2YRDEH9nVis4DBwvsFRVF9zS7IEQXpWfe0GjLoN3vpPrwEn4L1uPb5oX1jyB4nCvLp/UqEl/
 5u5L2deAHWMSrDWbrP/+ryT63ssKr962JlVGS9JQ7qh6si1dB7AIy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Espen,

On Wed, 12 Jun 2019, Espen Antonsen wrote:

> I don't have any hooks, just the default sample scripts. GIT_TRACE
> doesn't show anything else.

Okay, it was just a guess.

And here is another guess: unless you impart with more details about your
test case, I guess there is little anybody else can do to help you.

Ciao,
Johannes
