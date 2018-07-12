Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618001F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 15:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeGLP7q (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 11:59:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:42091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbeGLP7q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 11:59:46 -0400
Received: from [192.168.0.129] ([37.201.195.126]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZxch-1fMFRz2Krv-00LkQ4; Thu, 12
 Jul 2018 17:49:32 +0200
Date:   Thu, 12 Jul 2018 17:49:16 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v2] git-rebase--merge: modernize "git-$cmd" to "git
 $cmd"
In-Reply-To: <20180627074600.32149-1-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807121743040.75@tvgsbejvaqbjf.bet>
References: <20180607050615.19598-1-newren@gmail.com> <20180627074600.32149-1-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:li07Q9kSaxUu+c1ii3zjsgdDJisVfD2oNTrvOwsKmhbZZ9sVg3u
 KOVgN+dskgBctBHr+qnK1r2rZnK9jPaTu775TLeLc5ACqqr6/tsjwbqRDbD4+m3wOsbUYsq
 tPbOt0GeiZopRSLXltZI5xZhcE9XXlDn5+OZ+PES+Rj58jRQGRKwAqq/DGOFjslR7ckX80Y
 Qqk8aDakdRcyQuYXxX98A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nmDo+gHvAMQ=:FhjyOKStVQjNbz0872VqgW
 7OiYMNxoDgt3qgerod93LnJZgoAgEoWpsrQL3ZRm8vuHKK5gItlwVlt3D1Bi5rWKDZhUnxfJv
 1viogXzZieZW5WJrSU2PCUoOVIvdwIExGyqo1w/0gOCMlNqHxlK+nPr0eHT9dNXb95hlq/ePR
 +vri/6v1E88YYAh2BzW6WEn4z3UIe7Q2/UMm1w22NQWOt9nhw9naTJ+Ip7r1uqL8yIt73Q5rJ
 RimjOQMrIkIGBdnaa5jDA7rlUrSUAWLdYHNArBYkxx2aSs8Fia6yhjDt3WzN2SLQcwXDmda/W
 +ze+1Wfa13IZhB4JzXRShixf56i6Ltk6zZS0wEkGysdrCjItnjhORz509xHFveS94cWrAwmM3
 ITvhtk1+x8Id6HShPSpdY6wnsaLdwSusDeZSJtRLIgft4VxBffYvF0UG0IM35aeNUOACebWnD
 wcRuUFIPby1MLOIuExnU9iIns4EnodlPMSe5kq6pTUWLtvERERCdHjWgmX2hAb2JL3oUZVSFm
 ybHTI2GdwJkejQQspIm6T/x1c23618PhRIUjPEkJdIgcXE/XioOdh1LjxWqDT+Q27iOORWq8Z
 DVviBglFON627yib0+2C+ZzBrQEPdgMhwjQ7rULfsdq201U1Q+1jI2caqGLyxnY9Akfe4TXPZ
 IM1cZoUCfNl55TC1CImy4ckbcAYfNLgRa+0b5GD6EjNwTuuLbtk/9kBdav4A9rdPqAoZJXLVn
 S7SJvh2AC+maKJAh7MOfYfKYofRwMMuUGxXmn3aibLB5NLsYobNfcmdmeoGVOt1sPNv4+RfMp
 4ACn6cK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 27 Jun 2018, Elijah Newren wrote:

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> 
> Changes since v1:
>   - Fixed up commit message (move below comment to below diffstat as
>     originally intended)
> 
> Long term I just want to make git-rebase--merge go away, so this patch
> will eventually be obsoleted.  But since I'm waiting for multiple
> topics to merge down before re-submitting that series, and since that
> series has some open questions as well, I figure it's worth
> (re-)submitting this simple fix in the mean time.

I carry essentially the same patch in Git for Windows for a while now
(more than a year, to be a little preciser):

https://github.com/git-for-windows/git/commit/42c6f1c943a

(but it seems that I either missed one when I wrote that commit, or I
missed when it was introduced)

There are more dashed forms in Git's code base, still, see e.g.

https://github.com/git-for-windows/git/commit/4b3fc41b117
https://github.com/git-for-windows/git/commit/c47a29c373c

I would *love* to see those go away.

FWIW I had originally also "undashed" the use of `git-receive-pack`, but
that breaks things, as the dashed form was unfortunately baked into the
protocol (which is of course a design mistake even if Linus still denies
it).

It would go a long way to help with platforms and packaging methods where
hardlinks are simply inconvenient. Because we could then finally get rid
of (almost) all those hardlinked builtins.

Ciao,
Dscho
