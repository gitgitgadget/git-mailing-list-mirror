Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732D51FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 17:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761884AbcLSRWu (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 12:22:50 -0500
Received: from mout.gmx.net ([212.227.15.15]:62891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755900AbcLSRWp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 12:22:45 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhiPD-1bxtr13JH1-00MtLs; Mon, 19
 Dec 2016 18:22:32 +0100
Date:   Mon, 19 Dec 2016 18:22:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 11/34] sequencer (rebase -i): remove CHERRY_PICK_HEAD
 when no longer needed
In-Reply-To: <xmqqd1grsn53.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612191819470.54750@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de> <81ba5f7ddb3a1a66e878b955094b7ae00f2cd781.1481642927.git.johannes.schindelin@gmx.de> <xmqqd1grsn53.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Fin2fY5/EHrXwVdME0V9W7DFLQLV0//20YLTZMs5zyJcaWqwQLo
 MUW+7buh5krXLhmJ4Ft03CVa5MJ1qvY7bKgOvfRlMaZNYDRcSKtlVeEOrSpkvu/AS3QqlVj
 VKk3T0/ca8jV3viI39JBCLyjEi5D3h4pK9fb+HQyWXFAJBoSJNSuL+B9oz9MfU2fLDwU8fd
 MG4p4VyrFJuyBG5FRzN+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Elh4OAOfJI0=:4A/IEtVWU0FlPelf6pri6S
 HQTuVUDhuEaXEIvaSDNIHXo3uGoVrMyhwQQL1l+gJANMXvBBR7179yi96s33OCwRd2coMP7sI
 TBPaMcU6D/X0AC5yr/hqo2P6pTBwvkf0XmmTGXWJ8SJgaHSnxjwUUp4yq6sgFXjN+k8Ii8LxU
 nQ2LaFn09lDUq87SZr2b6kW76CD1N3HNMLxEUj9CWO6bg6SOx/PixzBctNGSoESAg98aUugeL
 WnlrOvvWS+ja3++C451ROe1w0kFQ4AlYnxlo4TrLYRwZNKsnlhxNVImCwBO7YzjpF6Ob9Vyv5
 dEfUCMwVWhVsaqHfCcyt/qRdSOW7hd2Lec7p5T2FErYqVyBCM7taTTv/zXNDz8c8nm1R0rfqu
 ON8qKRnOupWm/7qifD+Ln0MpH1X24iftauNOOle97HoHfrnnmOd5znSt8ALuyQrDqWP5ZVBuX
 Su7GdLhEeN0a716R1Fwwi+6ErjyrUZH8q3i7nqQa5yzAECG96bBbrDK1iFxBFUHEivR+3GexP
 UldUsu4NFjlx4WNbehzyzuyT2CaKCYcSd9Cab7b6Wk+9KIPXQ8UDmkK9YzZ4UCGpAEdhsvL3I
 fJUTJWDAirutUIWrQVdm/Msd9aJ0YNLSkKF0cWTnaZtNWL2/g5gk8dFYvJhdVppF+84jE3Gu/
 OVHt/hOTDM5HhEBuaB7ychUll2i/Pt/rJ5HP0cc8FQRD0WQS6aLuoBx1yPUi7M3lIx1buaFyf
 rWpWMMM6kXRCNR9m5dZImv9NLyHKrgWjKRY07BSM1Gx4bPXEDU1B4OaaqAEpkqZtYWl6zMyHk
 NJw7Ngq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 16 Dec 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The scripted version of the interactive rebase already does that.
> 
> Sensible.  I was wondering why this wasn't there while reviewing
> 10/34, comparing the two (this is not a suggestion to squash this
> into the previous step).

It's a bit of a historical wart, as I discovered test breakages only long
after implementing the fixup/squash commands (as you may have guessed, I
implemented the commands one after another, fixing things as discovered by
the test suite; it took something like a month until I got the
rebase--helper based rebase -i to pass t3404).

In the end, I decided not to squash this into 10/34 because it seemed to
be a significant enough change to merit its own commit.

Ciao,
Dscho
