Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55051C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3967C610CB
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 11:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhJUL6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 07:58:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:43335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230463AbhJUL6c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 07:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634817375;
        bh=qLsYtbCTwYAlK94fffm6PVVwzbA9hEnvn5JRdgXCt8I=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To;
        b=ZXDtkLW6PgANQjDw32I/fvWDAozRgyrwaVybzHTb4KqOW+2JjDLYcygGhE8R7pN8a
         wUBVVcwCJtufI1US2sbbh6w3hTRS1CQwWY2Vt+lRmWDy82vxzK2kogRbQ7K8JfHEng
         2Du75eYB8+Owwut/PtJdJIZP20eMay7WQffRIL+U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.3.1] ([89.1.213.179]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Mj-1nD8c00fK7-00aFy6 for
 <git@vger.kernel.org>; Thu, 21 Oct 2021 13:56:15 +0200
Date:   Thu, 21 Oct 2021 13:56:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: [Summit topic] Submodules and how to make them worth using
In-Reply-To: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2110211148060.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1295399320-1634816381=:56"
Content-ID: <nycvar.QRO.7.76.6.2110211356110.56@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:knzyycXhxaPWh3gUpjt7hY5iXIojhxr5Lqw/iW2jLgvDWU35o2a
 4LGGmuu+hx3Z714so8+CxguhULMmFldPclz2r/qObEyoBqxPa6uQk/Dd/8t4TSd9D8b/I/C
 Kv8gog5Va9kgHy2lTz40uR/hpDzuZ7jPJ81RcAzxomQ9gz6ffv/fZkF00XqONLQ7xXjJFAA
 FALIUNVBfjNYPlTyJPLsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GX4UH+9r3CM=:1OMWfpIsih/Zbce2Xk+YTQ
 UQqrV2/XAc1Bb0m4/hqQ8Qg2vmxX3EAT7j/Nr2tnOpX5nRW/hYZB5ZKgXa+fj9IokbbDsbNEU
 LD4BxRf1SOas60fRFFuKVoiAyoU2vg1+QTke7O59sFN84hAIbdnFqwkAj80HPoIsiq+zDtLzJ
 5AN7VpqIxVfM9DNAga6jgfovhMIIHySJxYUo65zrj2/54ZXGhaKVtEgUMSWC21ouAL+K0kuDa
 PvsuIhPJ+1170Wl2WBr0lQvnYK/wzs9lqCMRLZbCZOcyxRiNH4+9lmdVL49y/OnyrSoV+xgdC
 LNfM0zVjmJmJxfs9krXXbF28TJGyLE5bY2qdltsi0MmW08Zh4SwdyukXA5XND/8zP2uGvL8L1
 +EUa8whoT3gKp6TIqV8oEr+kYFag3Sb4qyv5EIz65YxRbnbFgOZWnWzW9HC4/0vXJKly8abtV
 biG76nNwSs5glJFVrphj8V56UAyWtaGEd60r2R8St7k9UsmU/QB6HumhCn0SoeODPqy77mCG6
 65AOQn2fzt7O2b1PJU26oGbLHzK4wQOhsk+UrrxWVu+j1WO/MYYewN4joVeLVFGoU1v3B+Vbg
 4zAS+oxJ0eMP7LMT9CLapktVlllAimVgBwNVUL+dXNKhV8lDsLOp4uEBW046j5MpSOVaOoMDM
 TJfSJVaoPvlwORF4GZH0Of9x9rHuGOsN9j1rVKTfxQG0HNxxj/8VxrSYv3lGwj73Ooe2A+8sk
 P1vuOZcbIqNgNGwN16x33YqUu+/2MGmwEshng4y5T6k0UaQbmRsoP6oubM90mEmCtJ2i+nOkE
 yUp9HDL+HqY4OCSaegCXAtMB0ZfIkCJpIw1xvcM7V3GX02+9cpC+uqkmFIF+eGnq8jRpT+C/b
 2CtgS7KJzrdpASqHO2SwnhxVhYOBLPBYs5dfBt7knwG/A0l2rgh6bUtPuwutuZ21NEfJavofw
 IogqZo1rA5KHkuFpGw9aLc9O642V+2mQhxQEVd39+bM3ypW5yvSlBwxtgX9b6vjso8O85sC8J
 cIlK3RRWNKZcqvdarlY8VCxKlXDs+xkFR0q7cuzYcuSbJCZhFP65OC4D/I3eaVnM80p8v63BF
 5Ar0mFeEjXq6wc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1295399320-1634816381=:56
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2110211356111.56@tvgsbejvaqbjf.bet>

This session was led by Emily Shaffer. Supporting cast: brian m. carlson,
Orgad Shaneh, Jonathan "jrnieder" Nieder, Jeff Hostetler, and Philip
Oakley.

Notes:

 1. https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/

    1. Internally at Google, a lot of use of =E2=80=9Crepo=E2=80=9D

    2. Isn=E2=80=99t great, but not much alternative available

    3. Submodules are also not great, let=E2=80=99s make them better

    4. Some prior work: --recurse-submodules options

       1. I can run =E2=80=9Cgit branch=E2=80=9D with and without --recurs=
e-submodules

    5. Being in recurse mode gives us a chance to be opinionated

    6. Don=E2=80=99t want to have a million options and create a lot of co=
mplexity

    7. Branches

       1. Superproject thinks =E2=80=9Cmain=E2=80=9D points to one set of =
states in submodules

       2. Submodules have =E2=80=9Cmain=E2=80=9D pointing elsewhere

       3. Which is right? The superproject is right, =E2=80=9Cgit status=
=E2=80=9D can show the
          difference

    8. Not trying to eliminate all complexity. There is some inherent
       complexity in stitching repositories together. But I want to make i=
t
       predictable

    9. For specifics, see the RFC linked to above

 2. brian: Interested in current status, what=E2=80=99s been implemented

    1. Emily: workflow git clone / git branch / git commit / git push, all
       using submodule.recurse, worked well

    2. Intern Mahi Kolla sent a patch to recurse by default once you=E2=80=
=99ve done a
       --recurse-submodules clone

    3. Ran demo for an internal team, feedback was positive

    4. Used a hacky remote helper to map =E2=80=9Cgit push=E2=80=9D to =E2=
=80=9Cgit push origin
       HEAD:refs/for/main=E2=80=9D, we have plans for not needing that :)

    5. Partial clone with submodules is close to done, is another importan=
t
       part of this

    6. Glen and Josh have done some work on branching + setting tracking i=
nfo.
       That=E2=80=99s key for making recursive push work in an intuitive w=
ay, because
       the branch you want to push to in each submodule is not always the =
same

    7. I also pushed a series storing a path in each submodule=E2=80=99s g=
it directory
       to its superproject=E2=80=99s git directory. Use that as another ph=
ase in config
       parsing, inherited-from-superproject config. That combines well wit=
h
       config-based hooks (thanks =C3=86var for the help with that)

    8. Next steps are around fast-forward merges and rebases

    9. Specifics are in the doc linked to

 3. Interaction with Gerrit

    1. Orgad: when you push to a submodule and superproject, at merge time=
 the
       submodule commit changes, what do you do in the superproject to han=
dle
       this?

    2. jrnieder: This comes up in any review flow, not just Gerrit --- ide=
ally
       you=E2=80=99d want to review the superproject and submodule changes=
 together as
       one unit. There=E2=80=99s some work happening in Gerrit on =E2=80=
=9Cmulti-change
       review=E2=80=9D.

    3. What works today: Gerrit=E2=80=99s submodule subscription feature h=
as the
       ability to update a superproject. If you have a set of submodule ch=
anges
       and a superproject change that are submitted together, then at subm=
it
       time Gerrit will rewrite the superproject change to reflect what
       happened in the submodules.

    4. In the Android workflow the superproject only contains pointers to
       submodules so we don=E2=80=99t push changes for review to the super=
project at
       all. So we handle this with submodule subscription.

    5. Emily: analogy to auto-generated merge commits

 4. Jeff Hostetler: back in 2014 Microsoft considered submodules, hit a ca=
n of
    worms

    1. Coordinating changes between submodule and superproject, this requi=
res
       server-side locks to prevent edge cases

    2. Was hard enough that we abandoned it

    3. jrnieder: we=E2=80=99re viewing submodules as not a replacement for=
 the
       monorepo, but as a separate thing for when components have an
       independent existence. Microsoft made the right choice by not using
       submodules artificially in the creation of the Windows monorepo.

 5. Jeff: do you want to support sub-sub-sub-submodules?

    1. Emily: we ruled that out.

    2. jrnieder: nested submodules already work well in Git, we=E2=80=99re=
 not breaking
       that

       1. Philip Oakley: good; if that changes, please make docs + config =
clear
          about it

    3. As a matter of project hygiene, we encourage people to put their
       submodules in the top-level directly. That way, you know what code
       you=E2=80=99re pulling in.

    4. That said, there are unusual use cases e.g. around a build that pul=
ls
       together multiple versions of the full Android codebase. So we actu=
ally
       do take advantage of nested submodules for those niche cases

 6. Please read the design doc, and expect lotsa patches over the next 3-6
    months

--8323328-1295399320-1634816381=:56--
