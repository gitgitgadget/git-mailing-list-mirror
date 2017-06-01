Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3D1F2027C
	for <e@80x24.org>; Thu,  1 Jun 2017 11:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbdFALQM (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 07:16:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:59020 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751505AbdFALQL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 07:16:11 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSuYT-1dNheM2i3B-00Rpur; Thu, 01
 Jun 2017 13:15:59 +0200
Date:   Thu, 1 Jun 2017 13:15:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH 1/2] format-patch: have progress option while generating
 patches
In-Reply-To: <20170531220100.t27w3w642sn33h7s@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1706011312510.3610@virtualbox>
References: <20170531150427.7820-1-kewillf@microsoft.com> <20170531150427.7820-2-kewillf@microsoft.com> <20170531220100.t27w3w642sn33h7s@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Wj+fMka0NUkCTrri+CHArOY8hYfKg/6RF051HaeH6l0KUeFFLSh
 ye8xQc0tmgJCyWt1PovQT5e5vijw/9e0lRcQckpDzeDfd0vC6G6w54O/sDRFrqPHEologdh
 RK11V+6Q8wVBTUakl+zFwo0okCxBsAzzVAvAkz2joEQ+dn+zDPRG/2IrTdxDS4jQDD/MtrQ
 D4+13R/G/l33YReXmRpmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Squ+E/nJ5RU=:68+es3HvlwAZJwCxBwpZt3
 xGXB5WelZTNJjy2ea+dq/Pr8I5DCz8c7MIYxZFt0TtbodtZavUbtlVgvN+EaP4bk06nZOjDcm
 R6hDO6rKW4zglLkfYlyUjA93eNotrqYGtppkhFDIEecVMDt7zcxx8wwwPWttcXNgDBwxMf65y
 yI/HxJRSJU8WZBxFQFyqU+b23DgU/Nxr/lw8+BdhUkF7hN3Kh2GxyPQsdB4M6nhsE2q+WmH8q
 pifCNxwSeN/5PvPDP7bz0u9ZiMwkr7/dDioZuuZkAt+nZVDwVnGJgr1zJFHlgtsQd/atwU373
 f/wsGImPGkmRYUFSzmPO4/JgOXbbxX4dtcxjIqn77Uqo9U+5z3tfFOQxxgN+anH/+Yflrdx5A
 mXpkvhQ+ElYvmIxNnqCDfwJZqDUx6yDKF7Yd1iiIoOGEzOOs6OdQGGU92rDe/5alrn0Bq7ADW
 dskXoODqnYjHSjC5Xzy7CuIldqtoPK/QFxaCmHxcU3nTWCGVHPB+QbGjMRkYkrzsaAiT9ojZq
 FhMiw+06hliIlbuBmYVe8Nj35F66+mJq+4OlSEO5rz/1lhag7RtT1Apn9pj/mzcKBKuRcO71i
 KCYzpEkKYVSMhC+EypOMp3lEQ4mN/Fth6itCQtVAPB6yfWCzf201ewYSp7bsNDyfqsCTKKHGr
 p53OuuDo6A8WCRZVIJSh9w7rOG5esJgozsGPCSXcbnI7R7phLckbYYvJGMsUsMrhAo8X5x2Yd
 /YXq18TRnEd1EULSxPBDeGWd09hIDHNls+Y0mnWB6wqK3ZJU2Q6JokL4kQkhmYdIs+PL8MyX+
 MBpVYoO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 31 May 2017, Jeff King wrote:

> I'm generally in favor of progress meters, though it does seem a little
> funny to me that we'd need one on format-patch.

When working with huge repositories with a large number of branches, it is
all too easy to pick the wrong branch to rebase to. In that case, it can
take a long time for the `git rebase` call to even generate the mbox.

Kevin's patch is a visual indication when this is happening.

Instead of being puzzled by `git rebase` "hanging", the user will now see
that (.../21957) patch is generated and will have a chance to say "wait a
minute, *that* many patches? I think I meant a different branch".

And since format-patch generates the patches for `git rebase` (actually,
it generates an mbox that then has to be split again, but you get the
gist), it is format-patch that needs to output the progress.

Ciao,
dscho
