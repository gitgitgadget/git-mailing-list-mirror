Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE1FC4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 21:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiKTVYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 16:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKTVYK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 16:24:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BDE1FCE9
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 13:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668979444; bh=0UL+v5e/l1/bQCUAhOZn3OzcYHRJiMEEcEYU0fEeM9s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MpmNm/nhh9r7gDjjszF39exMCR14xn0ExTlGnqrKU89yszKFd+pLTPdUzQ0Qob0Sk
         2oEZZawgkTQGnGrjn5sQ9aHIfetZbF8Sgf64qasXd04cexluiQK8dum7xsGtIb8s5p
         vpHu5O6bp0sIHZYUJqO4NDgHaWYll3esmpHbtxo7geCe+1+f5ms8FiU5ZmvgFrSuhX
         TGBgqh5k64EMLs8bEZnlHQfYrrF7rnVieqzSmEJ4IZGJ3O6wpIODxsJY5JPiqAsi4l
         oXP/iMeThznyz7tBgPnBzdVxGVuBOGoCqGJTcGIq7iGu8mRJmC9PDJt56515xags/y
         Fv0c6MFLdOJ0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.29.212.27] ([89.1.212.70]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysRu-1p9QWn3h10-00w0Kj; Sun, 20
 Nov 2022 22:24:03 +0100
Date:   Sun, 20 Nov 2022 22:24:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #04; Fri, 18)
In-Reply-To: <35abf6a0-982c-42d3-78c8-0298b53e6faa@dunelm.org.uk>
Message-ID: <on4s271q-21s5-onsp-ss70-863nr403760p@tzk.qr>
References: <Y3g95OYdwzq2OP3z@nand.local> <35abf6a0-982c-42d3-78c8-0298b53e6faa@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-998750652-1668979444=:189"
X-Provags-ID: V03:K1:J4VkGKYpb1xEqJVlfT7idqMwKiRI09PGtjQNpGW4mO7BtCkEcbE
 YdzYJr46uZAFndMD5044xm+mbY55xkLXF9AjgsQW/E1TyxWPFbBGEQVVeDqnlVAz2tduOt2
 3WZwbtxxf4IAQmMyUEABUA2k4+qYBc6CzcSyemty178ig4arOmy2a9Dd3HvwRmQ5lC1xi9I
 obg8jTi8AsmfQ/2QiG4JA==
UI-OutboundReport: notjunk:1;M01:P0:7hzzX6lr22M=;tJvXPGgBFPmFs4tjZGR6QFi3gQK
 fauum6qzzyu8jOUvronfPYRCMvGTiMZPyPo5UDzBpqC7tBfRKGlM8Ft6N0z45ZGiiJaZR312M
 7gP1S1R7xwcL2bSWimOIIoIAzOhpS3teHSlYZ4vhwcbkgbJL6vsWkvgGhwbSq7/8EoqYO2ddq
 m4enY1YRqOzzrkuCinAILwXg4s4JJZs308DJ5r5TVyr3QHTaS9YJrmxg4QZ/jk244Au84Hg7c
 0batGae3lE01YAsRjRnu1w7qArGt9Cf7fej1sewyJCzUtPPplbm7MTmXj3Yt6BdOLArxrfhqQ
 KpeGCKTnLh6eFH37T2s92hTuifFhyla2r0PoZCJj+AqH2RqtwHhG2WQaCIUvMoOsxhNCJD+9P
 NCGAO5X4RrMVTtmVsnDnd6GNQMz4F4OebcAu0kFJNCvPZUQJPNKumowrWIFBIK66gJRQAt1Be
 0u/PKrsQXv/doH8J162CDZ49drTuN5ZG91KUnaRN2vh0R67gwcePHStiG78jE1ahLSsX43Nz5
 FSPLewwmceLYTYU6mataSNCMn1yyawAIxluS7UZXiDFhmJfv1Ml5Elrfds5/e8NgYhP+72lfW
 Ee6HR+/sxg1jC5d+ElmQ/+ANa5uJr6V3P3weJ51xlUQf5roD9hdZ7W4TgfmMMjNzgmsJEkE8v
 9Nbr85EsuQR3VNHZGJxC/SSw6VDB35fidEoghi3inU2vtOy7Sdz5yCxFMLXWS2foCUy8KRBjO
 wfasam9GLQGK7x2pjiYA8ApbbV8l4trWlvQfXnhzdBv5Y5Fg5J43FBYjTaLKlTKR4NtCwIpBi
 5GrKW/b7XS5waf199ESBiLblyxInZGvOc6Uy9UAB7nDPtx4kNTiQDVwzmMYXUouhq+HH3QYaq
 XI33gOo/QI22SeeFUOWc1GYpSjKCekYlgaym9QB/NKqnE7Y4JrsqDnlXnSDsPOgNdMvk13ZrM
 kiJ7GQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-998750652-1668979444=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Phillip & Taylor,

On Sun, 20 Nov 2022, Phillip Wood wrote:

> Hi Taylor
>
> On 19/11/2022 02:22, Taylor Blau wrote:
> > * ab/various-leak-fixes (2022-11-08) 18 commits
> >   (merged to 'next' on 2022-11-18 at 8828bb7161)
> >   + built-ins: use free() not UNLEAK() if trivial, rm dead code
> >   + revert: fix parse_options_concat() leak
> >   + cherry-pick: free "struct replay_opts" members
> >   + rebase: don't leak on "--abort"
> >   + connected.c: free the "struct packed_git"
> >   + sequencer.c: fix "opts->strategy" leak in read_strategy_opts()
> >   + ls-files: fix a --with-tree memory leak
> >   + revision API: call graph_clear() in release_revisions()
> >   + unpack-file: fix ancient leak in create_temp_file()
> >   + built-ins & libs & helpers: add/move destructors, fix leaks
> >   + dir.c: free "ident" and "exclude_per_dir" in "struct untracked_cac=
he"
> >   + read-cache.c: clear and free "sparse_checkout_patterns"
> >   + commit: discard partial cache before (re-)reading it
> >   + {reset,merge}: call discard_index() before returning
> >   + tests: mark tests as passing with SANITIZE=3Dleak
> >   + Merge branch 'pw/rebase-no-reflog-action' into ab/various-leak-fix=
es
> >   + rebase: stop exporting GIT_REFLOG_ACTION
> >   + sequencer: stop exporting GIT_REFLOG_ACTION
> >   (this branch is used by ab/merge-index-prep.)
> >
> >   Various leak fixes.
> >
> >   Will merge to 'master'.
> >   source: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.co=
m>
>
> Below pw/rabse-no-reflog-action is marked for cooking in next but it wil=
l be
> merged to master if you merge this series to master.

Not only that. `ab/various-leak-fixes` still merges an older iteration:

=2D- snip --
$ git range-diff ttaylorr/ab/various-leak-fixes~15^2...ttaylorr/pw/rebase-=
no-reflog-action
1:  d6f756b0d66f ! 1:  d188a60d7228 sequencer: stop exporting GIT_REFLOG_A=
CTION
    @@ Commit message
         pass the reflog action around in a variable and use it to set
         GIT_REFLOG_ACTION in the child environment when running "git comm=
it".

    +    Within the sequencer GIT_REFLOG_ACTION is no longer set and is on=
ly read
    +    by sequencer_reflog_action(). It is still set by rebase before ca=
lling
    +    the sequencer, that will be addressed in the next commit. cherry-=
pick
    +    and revert are unaffected as they do not set GIT_REFLOG_ACTION be=
fore
    +    calling the sequencer.
    +
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    +    Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## sequencer.c ##
2:  be0a662f863c ! 2:  0e34efb31d89 rebase: stop exporting GIT_REFLOG_ACTI=
ON
    @@ Commit message
         reflog_action.

         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    +    Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## builtin/rebase.c ##
=2D- snap --

And that superseded iteration of `pw/rebase-no-reflog-action` _did_ hit
`next`.

Ciao,
Dscho

>
> Best Wishes
>
> Phillip
>
> > * pw/rebase-no-reflog-action (2022-11-09) 2 commits
> >   (merged to 'next' on 2022-11-14 at 790dadc8d3)
> >   + rebase: stop exporting GIT_REFLOG_ACTION
> >   + sequencer: stop exporting GIT_REFLOG_ACTION
> >   (this branch is used by ab/merge-index-prep.)
> >
> >   Avoid setting GIT_REFLOG_ACTION to improve readability of the
> >   sequencer internals.
> >
> >   Will cook in 'next'.
> >   source:
> >   <31df037eafede799c2ef27df66c6da309b719b1b.1668003719.git.gitgitgadge=
t@gmail.com>
>
>

--8323328-998750652-1668979444=:189--
