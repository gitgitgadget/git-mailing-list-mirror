Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 465291F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 22:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754323AbeGFWid (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 18:38:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:37737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754225AbeGFWic (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 18:38:32 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9b03-1fOaw23slD-00CwEQ; Sat, 07
 Jul 2018 00:38:26 +0200
Date:   Sat, 7 Jul 2018 00:38:09 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Subject: Re: ag/rebase-i-rewrite-todo, was Re: What's cooking in git.git (Jun
 2018, #07; Thu, 28)
In-Reply-To: <xmqqwou8jgp5.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807070035210.75@tvgsbejvaqbjf.bet>
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807031438240.75@tvgsbejvaqbjf.bet> <xmqq601smexy.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807062117170.75@tvgsbejvaqbjf.bet> <xmqqwou8jgp5.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:s5QPptuY56n7hPX66l2zONFv4t2Wn+ozQmQTLzBpcUhWfDOMdab
 rnnJxuQNZqoEpnqLrhBsAXx0VvMShK4EQuGz8EIrHBjV+gTHji72y1fBvj7gbg5AIQHYbH/
 +qdH8q7YJ46M8FPylVHROzvVCPaXfneVh1gXCnGMRoC5dWloFPwc2RIVdMZAkZEBw3aUaSp
 2xy27mW6AsKicM1UIpRtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5ZkqJvAi1m4=:8CMD110yw6jhs2dINpRLOQ
 tcY/l83p1ssSdKCsdogiK3FT17UT47yAMDvqPePGXfdqkQ63AXgz8tVOlz2N/c8ZQ6FYEEI/C
 EmBIxcoCoXzT+imFGLWHVQrNrilAcrdKh9vw4/iiMhWbIIKt94AO6iquZqsHDd8QcTYdTXuMl
 JqYBZ2zpmHZqao7IURN2Ba1jZVlKIiDYheJc1k5HTRpRg4VA3a3Tfrfv7b+tnRTfzjeSaYj8e
 w3am107HHTE6zptTQsnkWJaUPqXI8Zf81dZVMpt6Sz/qyVLurcLprnRhrSrWWPJgNsohP5cKF
 GI2JsqtKoa36Ovgn4AaevZXeAmC3q8vn75SJEfDfFt4HFHZ+XhO2qkNDQLt65L0JBoCP3MFRb
 5rbhhfw/1Sz9VgFl2Do+XCiu5mcl4WNuJJyT50l5vQV38KUOEsebD1Zw5Mfr6lsX5GLce6+9U
 r4Mg8OA4USyOcfDuhjQcXUHSx+f4gvFFF3Hwobk6ELo5v7rnzEli1HZb5rIbAHEJJGeeWwowZ
 9t8BJ+bWDVGSsynVjyh1XmPVGBFWjwyHzxlJAT7wvEStMTHLqCTxUdMtq9absYp7lPC0MsbmD
 0pz9cx4zwctZ4JylZPv3YcA0NvQcU8CsfhQXqWeOhpe+C2v4DuVPKfZXAdMJIbE4WnIX7ra8b
 aTy4BfwiwwmF/bduE4B6CW0ZboxUbJe/RgIxgea4I9C8vh/vX/WgS3SljlCnT5DArQkynvDFV
 eJtylnIoBD2vf/QSy/JUlJiZBelCCpnVzh4CJFMzu3Z9+qEIHLW3b4vREoOJrTrhjsn90oQ0Q
 k+QxUfS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 6 Jul 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Of course, at that point I will have to look through those 7 patches
> > again, if only to verify that yes, they are still the same.
> 
> That is something the patch author must help the reviewer with, no?
> 
> Have uncontroversial stuff early in the series, concentrate on
> stabilizing them before moving on to shiny new toys, then mark them
> "unchanged since the last round" after three dashes when sending a
> reroll to update later parts of the series that are in flux.  After
> a few rounds, it may become apparent to reviewers that these early
> parts can stand on their own merit as a separate series, on top of
> which the remaining patches can build as a separate (sub)topic, at
> which time we may have two or more topics, among which the early one
> that has become stable may already be 'next'.

Okay, I give up. I tried to show you that I thought that Alban's
partitioning made sense on its own, that they could (and should) stabilize
independently, even if they technically build on one another. In fact, it
was I who suggested to keep them in bite-sized patch series. And you
simply disagree from your maintaining point of view, and I violently
disagree with your decision from the reviewer's point of view.

In the end, you win.
Dscho
