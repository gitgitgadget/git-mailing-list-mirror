Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 136D11FAE2
	for <e@80x24.org>; Wed,  7 Mar 2018 06:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751146AbeCGGqr (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 01:46:47 -0500
Received: from mout.gmx.net ([212.227.17.21]:55421 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbeCGGqm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 01:46:42 -0500
Received: from [192.168.1.106] ([88.26.243.156]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Las1k-1eQkny0Sc4-00kNO7; Wed, 07
 Mar 2018 07:46:34 +0100
Date:   Wed, 7 Mar 2018 07:46:17 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution
 (Road Clear)
In-Reply-To: <87r2oxe3o1.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uGxmphvfKQ/W40kr3Iu+7rJF9mxImh52TT6CDlOaJgIyqDlbgin
 5cIuQpOAvwZR1/iymcCsycqN/M6wjeCm0oo4tsuBrUVWqAvdU8l0oLa8j+PGEYoxmp+UBYl
 9z05ng6PhN//no6fflPKJgzLBwNlUAZtWbQe8MvF8EJbKeJJK6hV4L+MuWa2V0TDj1JjRPc
 Oz65z1j4o+4K1ZnG7hBIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cc6eZCl1Ses=:WO1YiE7qtGIaS9SSQ+53Zx
 tcV2uYhxmNE3YDzRXhl9ymlThxYlXCNQXr4617mYuNpjUDyZyqL3uhPtgRM0apDxu4kwWtOWU
 XEuud7txBMthcBGnnFzFLWjDFuyqyRXhqHcUTvhhvB+LXb/rqOzvrhRiWi7oz8RZxgBFqX9g6
 cxXtn8IdMEQCJHscS//U3avhjRqd5RmfaODaPcyU7YRIK8BwjeyazaY233WnXUoMIwl5g97qr
 TD3OKhzwgZIBMkj0Re0Xztmz70jQaJeDdcJW1Uyqmwy1He/0vb3SUraV0cV2leTdUL/rVvV3Y
 nQMMNpXGTmDEwkb10N7iCYfhu9WI1bBUOeDu9CyumwBYPLFp+mjevnRgp2lUtlfBpHsO1v/g5
 jB41XK9yBqaYY5MiF87kJyc4WC1iQANJ7+1wIHDA9iKmChkGPOp+5qNnfl3XT0iDC8BCX23yj
 Dyv2fzV2TtXNjQq6HIkmHEKMMQhseIDBPCb6eKe+Q8a2LoXkdpiJIRSOUSrbKP09rudj7t/7h
 vBYM1hGBBHFNI0l1xLMmU6WIQqBtWCHvLLjn90uD1atfmXf5iYGlSR7RTLWVAjgFGhJ9itjf/
 0oCjDOm+wt2M0SF+JMGx47L/cU2O6ZudDHh7b1brn0dPswRKPOPnfppG5Go1V+MlGkdA7sRk7
 /xcUwMMJZM0r/m4FEEmBR/+4DMPwSIZeSqNtBPP6Fn+kLYQ26DnuAeaZliRk8p8w+yaMKy5ir
 zIj+zt/IMuf80gbt5xWiA2yYWvYd+sPrFYju616auP6U16Err/d7j1Hr04y1/Cai7zKkRm/3N
 t+4z29+ILUllThSZe/HqBp0BRYTbt/rvMSRD2Opy4naD2BDufE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Tue, 6 Mar 2018, Sergey Organov wrote:

> This is v2 of my "Rebasing merges" proposal.

Didn't we settle on Phillip's "perform successive three-way merges between
the original merge commit and the new tips with the old tips as base"
strategy? It has the following advantages:

- it is *very simple* to describe

- it is *very easy* to reason about, once it is pointed out that rebases
  and merges result in the same trees.

... and BTW...

> 3. I now use "True Merge" name instead of former "Trivial Merge", to
>    avoid confusion with what Git documentation calls "trivial merge",
>    thanks to Junio C Hamano <gitster@pobox.com> for pointing this out.

"True Merge" is probably also a candidate for improvement. If what you
refer to is a "true" merge, that means all others are "untrue" merges???

Ciao,
Johannes
