Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463E020954
	for <e@80x24.org>; Fri,  8 Dec 2017 05:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbdLHFtm (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 00:49:42 -0500
Received: from mout.web.de ([212.227.15.3]:49608 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752386AbdLHFtk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 00:49:40 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MTPjb-1eWptA1Pjb-00SSPy; Fri, 08
 Dec 2017 06:49:35 +0100
Date:   Fri, 8 Dec 2017 06:49:34 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2017, #02; Thu, 7)
Message-ID: <20171208054934.GA17893@tor.lan>
References: <xmqqfu8me7ot.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfu8me7ot.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:rW2ohiPIk878n9yITSlk7FRlEyj7INQ9rqvDTfaMS5otz0UgfVt
 UorWoYw78frIttXYy7COu28UscMFmnSven4AxUfNsEJIrG5JQyFKEwVCqzjuIvyngTHiK0b
 PjXFb9SLnzx2lwZJPtri4oFS+kIbEL3cUdJ6tpHXEB4O1eDqUsADdU+IvtoAbxWBrvS4CFN
 QQ+NjxuRFH4Q18gTsJvRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VPB5dk/YURM=:L+VXRcB2MKjCvSx6AfRmcd
 uR1mBr/VL7jCKqJHc54fjsdDugnK2nsT4aw71w1AfddSLV2uZe3tInJ9KzBs+vPg7qigY104M
 O0GzTjFIRwSYXuuZ06/p6Re36mcIZcGQQzRWRsJTdY/e+guckfltTJQ9EYso/jDyi1eARd4U4
 9RXpmyPfgPHOT5woZyUYa1x0YeINYwJUG7zLQ/y9c23Vs5g38XgkohB+TBClne/snobnZs3pr
 8y9i7YuvQxj3opytxWgUIAr3x+gya0WjE0dKOuUvHlFF/T7IF0PdLUpCgdNVwReCOBkNl9Gch
 uzm8LeYycDbgIkM9QvQehvKyHTInc+K4/G0VEx9sa3l7anC1ItkveA77+njkQy4682r6jtNSM
 5x7/T08dd+0NDrO2E1ktjfpdhC1nBkwxSAh6I4ozY6nUQtqjth5scNKAh5CS1sdUbZY0SEX2J
 jpJ28nodr7fEUoRDepcWKUUK/WBZ2AgVzRAYGabApCX2bKivqIFBltEShUZ5laldEwuNcxifg
 ic34wR5myrz5cxFJOgdyfUtbkcOxG7+Coisa5+T7cUUrIdWxik/E8Suj2dsJTojQicBZ1geza
 kKJog0WwOTrkZ/kIwP6OiJQvZRzRDZq8yalB8nGj0b+MBaDBNgu/vZ968dx88YlDadR3Z6mDg
 Qhcu6bLjiR1VTSXOQQpcRLS6QdxJitIbYPjmY+0Ila/i6OWYIuetA5qAWJpV5TvWhEPGvUTI6
 CYbilmY4ZkgTXUuh64Xj0bcg5qr30+/DLkFi9UY1n19t93g6LXYVWWuBA76mZc4OOZMvGCBOi
 cbWnamTPpFkqUPCKaNjUUA9/IAB6g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * tb/check-crlf-for-safe-crlf (2017-11-27) 1 commit
>   (merged to 'next' on 2017-12-05 at 7adaa1fe01)
>  + convert: tighten the safe autocrlf handling
> 
>  The "safe crlf" check incorrectly triggered for contents that does
>  not use CRLF as line endings, which has been corrected.
> 
>  Broken on Windows???
>  cf. <DA960DCE-0635-47CF-B3C4-8133021799F1@gmail.com>

Yes, broken on Windows. A fix is coming the next days.
