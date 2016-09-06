Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 806041F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 16:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965032AbcIFQoM (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 12:44:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:51521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935033AbcIFQoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 12:44:09 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M3ARX-1aowGq0WkZ-00ssAz; Tue, 06 Sep 2016 18:43:55
 +0200
Date:   Tue, 6 Sep 2016 18:43:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael J Gruber <git@drmicha.warpmail.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gpg-interface: reflect stderr to stderr
In-Reply-To: <alpine.DEB.2.20.1609061839370.129229@virtualbox>
Message-ID: <alpine.DEB.2.20.1609061843120.129229@virtualbox>
References: <ced7502d-0095-bd90-19e3-c14d0e4d4f07@drmicha.warpmail.net> <18a7e2984121d988137c135ec560fee56506981b.1473167263.git.git@drmicha.warpmail.net> <alpine.DEB.2.20.1609061827290.129229@virtualbox> <alpine.DEB.2.20.1609061839370.129229@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KWvAnJjM0JcJfwTEuXAeP/ycI1c0hbWpOxmrRtOzNO+7ntW1VBa
 7a3hzCP84IDusSIF/tadb43Bhva4HBn6V9sfb/2/c74OkMvAX1Kw4wQQSIZKq1JGSsiGysW
 4ZQ9udsFp9OFLKWQUBdjsmsN19u22/H07rrNQiXpSdsaJ7SbRqgKQ8XyZZ+CU3ElXCF+snp
 +gIQy/KDy/3wZsNb5NL0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RSRr3BfeeZo=:0n5JiCM0b5+2vH1tSzs6Qj
 a6UnvbZfpkzEgyqlsiS5h79uQ1o6MJHOFTE2LoxtxrmlgFDTMPsylToCjrzg1TwPL+ocQJ2+0
 EvcGDLHhZKsB6rnOvlx/J4zT6sIUVWMU6H6RYXWnv4u4+XWziR15heaBWNm+OF9/eBOTubBce
 cmkRIrENEWXlt5czt2lhG5I+IfTziJhNx+FQx8lq1zcgPjCtzcPRW4Q0EeVb22q02lZDHD1MF
 KajfLbwPS0vyPfSZuhiiVbFSxVaUsb/+ajI9gOazRLWjRbEE/ANxcFhu4ggsFjDZ4nPH7jQsf
 56F6me6cb4DWKuRC8NFxfMu3NliQbIdetC+x9lkyzzwy4RDFsJlL4eqoGPkmJ9MmaX7Qzobsm
 POZnDnaxZ6roypkGdYpVKuYhhIis27PYaHoUfRW3Vnsq6o2qIA8CLjyCAAVz2cS/6bv34Br5M
 cpjmefzQAi4CtdL0SwW6e6gCg+JnLMiZdPts2oxhQB/m4KVgxadkoJKUrQoGkIvt+T2/1p17i
 Al8OrLET7NirvVrCs8MSRY3WAUQl0goEmlhOmzC0t+OigpOv3/iQjJDeP7FreSxKblKoXI65J
 aTXbG4I6AZY+fUptiCEOkSAmw0l1AoRmK6UsEHsuUMFOleeHA3uiWMxQhL7XRtbs+Aoq2Y4LJ
 HcFzmrX3YYFVy2mHh2o5UjbVHd+QNSbth3rE1JS98zIQnVXMKijdpj6MQpkWT4OHsAs3Yt1na
 ILz6KUFwf8OYSfEu16CTHLW9hJTLoLOPIypGEbjF+eiN9MpBHWJTgF9KPClnZO2sTnDm/M9Gd
 rIRIOzt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

okay, final mail on this issue today:

On Tue, 6 Sep 2016, Johannes Schindelin wrote:

> Your original issue seemed to be that the gpg command could succeed, but
> still no signature be seen. There *must* be a way to test whether the
> called program added a signature, simply by testing whether *any*
> characters were written.
> 
> And if characters were written that were not actually a GPG signature,
> maybe the enterprisey user who configured the gpg command to be her magic
> script actually meant something else than a GPG signature to be added?

I actually just saw that this is *precisely* what the code does already:

        if (ret || signature->len == bottom)
                return error(_("gpg failed to sign the data"));

Why is this not good enough?

Ciao,
Dscho
