Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC508C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D05D4611CE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhJUL61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 07:58:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:52649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230463AbhJUL6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 07:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634817368;
        bh=4ikZDTR4JcmC7tWx1/8IGuEQtxRwm+23CwJyJAP0XO8=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To;
        b=eVDR/6ThBopU86nibOdT4WiOOY67USk2gumpWzUWqXFrorIaHgLXnu/LLuucpFHDD
         soGEgN+rXs71Fi2gJB8sMM53NmrhGmy+PUnfFJqWjYXp57p/X0cvIH133CXIjSK/J4
         I4rO79pkBYXnsNd18u4elD6NCtPTOC0saTOGq5fg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.3.1] ([89.1.213.179]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDysg-1mVrBM0zbw-009xnI for
 <git@vger.kernel.org>; Thu, 21 Oct 2021 13:56:08 +0200
Date:   Thu, 21 Oct 2021 13:56:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: [Summit topic] Server-side merge/rebase: needs and wants?
In-Reply-To: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2110211147490.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1937593683-1634816207=:56"
Content-ID: <nycvar.QRO.7.76.6.2110211356020.56@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:dm504eGL5/KAyMyNPq3xYLYrKSWYB6eiwfalbUfHTqCmw3srWaP
 L9mfWcVfbRnEIQNCCbwf9or7mj4ig88QBgofAzi3E4IVy8XKrOtsnxhUJVCxXf3rma2uPDx
 04COKvbeVKy9UPA4gj1GwiOWrQrbV8Rh7+6ouHANz+rHSsRatY0N5uOeyZ/DhJbfrOtZ2sr
 HXfHy767LkJHK49Ob/3xQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SwQWg5uW+mA=:N4146iNzJ548nM+G+80lIk
 X/l/onUYC+gnQlUpucquYCo/5i/OVMLZkGipgqcqq8J+Eh4IPGLai/KbQJvY+elRqRTKdwWig
 6Nua3KnaKuyevOf4g4zcrHflNGdft1NZdbgFWMGGW+0AtNsYMb4Ug+7JGzIzpREeU/q0qcTfH
 LZLahP18s9UMoi2ZxzojyJNBEQg2EbrJUnzxNy01Eb6bOzzySl6FMfxprk4V1A/QxLB/KU0Dx
 EQtvphzCypk1d35673WXBacvEBjdahUspeNIU6d9zWCzdtVi8jbX6yju8qfgfOsSLSPy22uM4
 d2KNFrI6r1qdLZzI/9Jk8k18565dMlBO73VlJZP4smMnwmSgQ0lmpYn6OJ1qguOncEXxt+Ir4
 HxWdozygDFZlsmLjMqXV27GfbL1yvjrz88shrYvZFG1q0dnV0pAb5xorgeBXZenURauTfGhgo
 k1yNSbjdIkOaLv0lc2x3beHJ0TXYcCow7dGVnRLsqFZnjJw/7eFtFOOVx1LxiMmVbVx0hI8Y0
 VlTiZf8ctD06Et9N0k+rPiiqpRz7CQZPjRS33BT0RtD4502oJb+nCjKAX31dWYcymje18EPcV
 h4JKixY8JEpRXNTZyvhDyqSkaMq/+UxbgUj/cIarBRsMZc7GbU0N4jg5ZGvvfsLCvjrZpngve
 pz7KxdJn6JUB0E/WGV758fwA2G0fCouLSk4XIk7R9cBet2PJeL4q9gIH+gUfOh2NTQdJcr7GP
 Zmx6Z9DikCwzO5rM55H6796a2YFSB/+5AtIxMubZhobL7JBxIDHqp4Q0CgIhnxV1CF5/AC+Si
 +DkmjXHTG2QLJoQzRP9UwJ0xsrA9Fo4Imdp4ewoXtjv2EYXQExEaSIHCYjtyJaKMjPrsZ6fMp
 oEz+yI8FvLhn2UEgqD4qXfo8w2xtlAt1Y6ZwGlWByVMxIMrSb8z0wcjQ9LazIUUWQKdaXe+wE
 879eLfwFuiKjv+FxUzWUPFQHjOPcUYZ9kmOCJ23f2+q5mCji4MGzAzpBuPzJmvvEYvuEsU7Bk
 NccVbDTy/j3Qq89YeM9pi5P2xP9cDn1fp7gsgBr0tlNcR7Py2LhRswa8563tWah013DGPVcwV
 UiuFD8NnLnDrFI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1937593683-1634816207=:56
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2110211356021.56@tvgsbejvaqbjf.bet>

This session was led by Elijah Newren. Supporting cast: Christian Couder,
Jonathan "jrnieder" Nieder, brian m. carlson, Toon Claes, Orgad Shaneh,
Johannes "Dscho" Schindelin, Derrick Stolee, Philip Oakley, Jeff "Peff"
King, CB Bailey, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, and Phillip Wood.

Notes:

 1.  https://github.com/git/git/pull/1114

 2.  Not about exposing merge over Git protocol, but about providing plumb=
ing
     for a server to use to run a merge

 3.  Not only merge/rebase, but also cherry-pick, revert

 4.  merge-ORT makes things a bit better, as it doesn=E2=80=99t have some =
of the
     problems of the recursive algorithm.

 5.  The challenge is not necessarily the technical challenges, but the UX=
 for
     server tools that live =E2=80=9Cabove=E2=80=9D the git executable.

     1. What kind of output is needed? Machine-readable error messages?

     2. What Git objects must be created: a tree? A commit?

     3. How to handle, report, and store conflicts? Index is not typically
        available on the server.

 6.  Use case?

     1.  Currently servers use libgit2 to do these algorithms instead of g=
it
         itself.

     2.  What would it take for us to move the servers off of libgit2 and =
onto
         Git?

     3.  This would help with a lot of compatibility issues (sha-256, new =
data
         formats)

     4.  Server cares about the exit code to record the success of the
         operation, including some details around which conflicts happened=
.

     5.  MUST NOT WRITE A REF in-process (because of replication), so must=
 be
         at a deep plumbing level.

     6.  How to restart the merge once a user has submitted conflict
         resolutions?

     7.  Christian: GitLab also uses libgit2, would like to use C Git. Wan=
t to
         not need a worktree for scratch space.

     8.  jrnieder: Write tree with conflict markers and report the conflic=
t
         (just a boolean), at least as an optional mode (JGit does this an=
d
         Gerrit relies on it)

         1. Including when merging binary files, rename conflicts, etc whe=
re
            there=E2=80=99s no place to put the conflict markers

     9.  brian: fail-fast mode. Present that a conflict happens very quick=
ly,
         allow conflict marker computation to be done later, upon user req=
uest
         or as a background job.

     10. Toon: GitLab would love to use merge ORT, and collaborate on it

     11. Orgad: In case you do have conflicts, does a mergetool-style fron=
tend
         want the three competing versions?

 7.  Dscho: there=E2=80=99s a little-used =E2=80=9Cgit merge-tree=E2=80=9D=
 plumbing command

     1. jrnieder: it=E2=80=99s a low-level doesn=E2=80=99t-resolve-conflic=
ts thing, but nothing
        forces us to keep it that way. Intriguing idea

 8.  Difference between rebase and cherry-pick not all that big, apart fro=
m
     looking at HEAD (which does not make sense on the server-side)

 9.  --onto already strains the concept of the rebase, should maybe not be
     implicit.

 10. Stolee: Think about future extensibility: e.g., servers might want to
     support --autosquash

 11. It would be nice to rebase multiple, interconnected branches at the s=
ame
     time. But how to specify that?

 12. Dscho: I have this problem quite often with my many stacked patch ser=
ies

 13. I use --recreate-merges (uses =E2=80=9Clabel=E2=80=9D command), creat=
e refs along the way

 14. Philip: I also rebase with merges and then run a script after the fac=
t to
     update refs

 15. Peff: I do something lower-tech. When I have branches depending on ea=
ch
     other, I set the upstream config. By doing rebases in the right order=
, the
     right thing happens.

 16. CB: This feature sounds really exciting, often develops parallel,
     semi-independent changes that only come together in an octopus merge =
at
     the end

 17. Jonathan: Newcomers sometimes put commits that don=E2=80=99t belong t=
ogether on
     the same branch; I wish there were a smooth way for them to just =E2=
=80=9Cdrag
     over=E2=80=9D a commit, which we don=E2=80=99t currently have because=
 it involves multiple
     branches. Cheering you on.

 18. cherry-pick in the middle of an interrupted rebase

 19. If we unify them, then this gets messy

 20. Dscho: I=E2=80=99m a strong proponent of being able to cherry-pick wh=
ile you=E2=80=99re
     rebasing. But I=E2=80=99m also missing the ability to do an interacti=
ve rebase in
     the middle of an interactive rebase. I implemented a nested interacti=
ve
     rebase in the tooling for Git for Windows, which works by prepending =
the
     current interactive rebase=E2=80=99s todo

 21. Peff: That works in that context, but is not fully generic (no way to
     --abort / --quit). Would want a stack of operations. I have a command
     called =E2=80=9Cgit continue=E2=80=9D that continues whatever operati=
on is in progress.

 22. Once we have every high-level operation pushing / popping like this, =
that
     kind of thing becomes possible.

 23. Toon: I have that too, also =E2=80=9Cgit abort=E2=80=9D

 24. CB: =E2=80=9Cgit abort =E2=80=9D is slightly terrifying, we started w=
ith git shell and now
     we have git forth :)

 25. Dscho: could standardize on the git-rebase-todo script and add suppor=
t for
     other operations, tricky bit would be how to implemented nested comma=
nds
     in an abortable fashion

 26. =C3=86var: would be nice if these are pushable/sharable

 27. Is rebase the right top-level command?

 28. Phillip Wood: for refactoring history, would like a different abstrac=
tion
     from rebase

 29. I have a script that does that which works well

 30. jrnieder: https://github.com/arxanas/git-branchless has some non reba=
se
     based history manipulation helpers as well, can be useful for inspira=
tion

 31. Elijah: I=E2=80=99m thinking of a =E2=80=9Cgit replay=E2=80=9D comman=
d

--8323328-1937593683-1634816207=:56--
