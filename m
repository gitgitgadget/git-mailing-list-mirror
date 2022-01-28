Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58945C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 17:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350392AbiA1RBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 12:01:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:33961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239133AbiA1RBC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 12:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643389257;
        bh=6SDl4MAqsS1tC9JkjDxpM6ziQ+75FB/jqln3u8UHAsY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jSR7oyP//FyH1cHVW8ClngQMQedN+ZQTN8lzr/nYVUtAo4YHpx3yW19BJylEcCzdq
         OqTRHK8FHQHz0tin07bWvZJ4PyPqEKnVItyoi+rQbKzkbQC6guOhBIePrz0yuSVOu6
         XzdpXUuo0c+Sl00OGT8lUPi3OKsDVkXxrVVVZKmo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.213.181]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvLB-1mmJ6D48cn-00Rtlh; Fri, 28
 Jan 2022 18:00:57 +0100
Date:   Fri, 28 Jan 2022 18:00:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/12] RFC: In-core git merge-tree ("Server side
 merges")
In-Reply-To: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201281759120.347@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1428331732-1643389257=:347"
X-Provags-ID: V03:K1:/HgPDihf4oG8lUJlIxNF+9tdluxn99a4cl7/9G7QTsftYmZ8xYp
 MCWE5ZDcTiYyQKnoFfIbdD0PfkWeaRAJHeAm1GB+/6CcEwfmXe0w4jrUMjdWnt5AV8mItM8
 r1xsN8HrP5NokQ1pXd1YaiB7qywQBjvqkRJASCp5DQQSCbyZbHdPTtaIpi5OC4FI4T5Co8S
 C4pAgUK709MLgtn/d+RNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KfkzC3dWy9s=:8eg8WuxqWo3CfRvdZjB9mF
 5GOk+49W3/vGdHgUsPDBsKVi1l7GpLdoCxNiKyMfJ56K1eILR++fGAB8Cc8zfs9CH68jRU1o9
 /2DV2j5NtNP9t5O6b+SnjOCE6HTH46kq5h8nai/HasyuHL1Pw5pEH9IoGfYNtNJuJSPj9HO4q
 /qOmS8rp9dBmManF8L5fU71wYb8eBXDAf+X4aPJd3bSsf602eYSFJKPbdzbf/eHYKDk6nk40n
 a7GUm7tmO/NOChg/T7IaPv5+kAm260rGKsEPHXn1Do33WSMl2u2KMr9yAwA/jX2EcdLQ1TvNI
 kbZVFUfF45u8Oee9GXMYYIb3KAT/Of//Maq8UPylHyvEwJOvvyXR4RS8iAZ8cINOPvR/JYCKH
 oHdhshg/GrCO7gG5jzvzGKzUa23QZ7nVBhrgxW9l2btelAJsoFYOM1mCOg8eB52+qM6QbOEMG
 b5DUEBXczkMvytfI8n5IYX+q0c+CvNwOK5DrvqXEdcTWJpPlDWvrwePKKfMDVXVaqwUMrDprM
 ffr+hz5giqrX0K8SPAX0/ahDQP3p5GylY0KL6ycydVUMn61jnSfqYVYJvm95UbmuBluY84Ds5
 8TEBWJ4Zfg9BxTvIJXqnynbMc/lKYDiDkVkSqSde/dlxmlAi6ZJ+fLmww71t7FwprhOCPLums
 JfzonWoNfkzePPhNmHGMbNwnhtRm723kYviKRJ2IT39XGdfCITTNbVTSVSO9ga7zYr+AOSELj
 dKvZZ1evpK8qywSS7PX3dKubu6TuQ4zsGKLEPtwLeAIF80OQ3bfM6VOyh1167gvCkQXr1wnF6
 xcyXE70AS5l+zRlu8FJEv+NgoHFQGBPEuSnPgn7cabeNcj0a/1VukVkCUIG9PMiR8V5HUL/uU
 MUHWQDJhFg72KNUUhqT15Cgg9qakIkA8k0EbuyBdajzbZRHNipQLGHvocM3zLohY7lgKogn85
 LfXQowFWMv4fKacnjvqJMHaStReRNdi3gDyeXlRHmbFR7+xpw372u9gqzZngJoAxq1u0DYMoB
 F5t4k/UaQh/305FO6UBSg9t3eAG5+4rtFehwUVvGcl1WfefBGIu7K2hLGWdmOAIiNITZoVvox
 DLGzBOSg6onNAY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1428331732-1643389257=:347
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Elijah,

On Sat, 22 Jan 2022, Elijah Newren via GitGitGadget wrote:

> Note1: Depends on en/remerge-diff (but no need to pick it up; it's still
> RFC).

For reasons, I will have to backport this on top of v2.33.1 ;-)

> =3D=3D Updates Log =3D=3D
>
> Updates since v2 (thanks to Christian, Dscho, Ramsay, and Ren=C3=A9 for
> suggestions and comments on v2):
>
>  * Significant changes to output format:
>    * Flags no longer take a filename for additional output; they write t=
o
>      stdout instead.
>    * More information included by default when there are conflicts (no n=
eed
>      to request it with additional flags, instead flags can be used to
>      suppress it).
>    * Provide (mode, oid, stage, file) tuples -- i.e. ls-files -u style o=
f
>      information -- when there are conflicts. Add a flag to only list
>      conflicted files if that's preferred.
>  * Much more thorough manual for git-merge-tree.txt
>  * Renamed option from --real to --write-tree
>  * Accept an optional --trivial-merge option to get old style merge-tree
>    behavior
>  * Allow both --write-tree and --trivial-merge to be omitted since we ca=
n
>    deduce which from number of arguments
>  * Document exit code when the merge cannot be run (so we can distinguis=
h
>    other error cases from conflicts)
>  * testcase cleanups: test_tick, early skip of test when using recursive
>    backend, variable renames, etc.
>  * various minor code cleanups
>  * Add a new --allow-unrelated-histories option (with same meaning as th=
e
>    one used in git merge)
>  * Rebased on top of en/remerge-diff to avoid a small conflict

I am really happy with the way this patch series is going, and hope to be
a lot more active on it in the near future.

I've read through the current iteration and left a few suggestions,
nothing major.

Thank you so much for your outstanding work!
Dscho

--8323328-1428331732-1643389257=:347--
