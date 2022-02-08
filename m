Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926BDC433FE
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 13:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243250AbiBHNPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376594AbiBHNMb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 08:12:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7ACC03FECE
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 05:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644325943;
        bh=+w1cS9XTW7dsU61BspVIPNUNiYDY5VmEhvlU0ALp8c4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d+CUht9vOESWzziXMKP4OBlXTmaqgTgQG87ZUs1E0Q7xdqa5i2c1KZ0heAx4n9YMo
         UONt79n1TO6zNBMC5pYNxKt0/ns/kyXKYqXEcHJC2MGyIQzcEsbOqNjvxKv/LEXrPU
         tkH5R1CA8mU5G0OZdsJqHIs+Xp7OfQGS099eN/3I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.212.206]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3HU-1nWnQF19Gy-00FRTF; Tue, 08
 Feb 2022 14:12:23 +0100
Date:   Tue, 8 Feb 2022 14:12:21 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/6] archive: optionally add "virtual" files
In-Reply-To: <xmqqbkzigspr.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2202081406520.347@tvgsbejvaqbjf.bet>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com> <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com> <49ff3c1f2b32b16df2b4216aa016d715b6de46bc.1644187146.git.gitgitgadget@gmail.com> <d1e333b6-3ec1-8569-6ea9-4abd3dee1947@web.de>
 <xmqqbkzigspr.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-136162339-1644325943=:347"
X-Provags-ID: V03:K1:XbyXF6YgPYBuVwRj7F6PZ+sK01xQFaVtrrwW9JfJQWJfbTZvbWE
 e5dmDQLq8j+C/RjxgLxd/t8FduoemDOY42i/mWyk0ZPYu/aH+VHe1e9HY3P/YUAfy6u1y5z
 0YvAidmkcfdySq2tOCGr7icxcF32S12/rh7Qs4zf6jOCMpDJQvYZnr3WsBTXBbOuz5VFRKc
 DB2Ffdnv98m+k/UU+Ohvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H8YRbTTZnjU=:cVr0qhsHnyrXXvy2Ul/lcj
 25YykDDORQtK/4yG+Bsf9vMus1AjLnx/V4Mva75wsN0GXAN9mcTV3Z8/iruvqj3Ve58XJEEFf
 qm+785BJt0zntghMFnp1OLN7YAuv2EvzSLJgzAxllkqHr2vIxnsnILHt8Wk1kEFTDTefaNqzb
 C8gi/3nHAdWYhNIZ/K7loUDeAxAEwWctJvuePCJ0Gcgrpef4w9myOZR0/HxmRvbK8nHpYwG8U
 sAZcWlOzecXS12o17xEtj0efW5ugQKMzcAz1sJBzo5b6Aiu54X8LJ7yKv0ZV+H1OWY6tNwqRz
 zGlViD2TVnV5SEjxb+lFALwknM5rY0er8jq512DUOrkgx+kO9Zi+Kn3gUJxyXHdnODECzPt2J
 DvroidbCkKDI3h4sViJltuJrfmMOPFj+9uq3XsQ8i0b/K3p3NNlDuux1dPTX+XsBkz0WmMr8r
 kWzfwwlvpKRKGJ/7esxQtb47Xu1nvkBxFlCbi6jmIQnd63K+TQoLhlOLB93EpTTMLtPuWbhf3
 OBKw/ZO1ypnV70cSzvz6bMMQAewkuo5WdSAzy4vgLiy5Mg2MsOjrXK1BMKIzTHJDyV5XWdube
 JJJSHvrYpfQhji5UvTWaPM3zwj6PXA9Tu8PhorNY0K6oUK4qF7Z0w7BC3DFpr7zYw5MhcErof
 D6gZJeoXWcsCd9HQSMgRL7Scptg7QcBjJVkQ7S4Wil5ZLGnMAL3KvfNduwN0J/7Amcss9sD2c
 lkH/i4zLcKHYuGcqh0/+b0sQNBPVUe3D/w+fLvp2PaJXIwzTmitiTQ9YE9aG+Cg4U3jJ+KX3r
 OIVDQOxEr+nSvz0lCicljmBM/ZgxcU8J6tfoTsBjMWjXEndQmFFA0lzZrIPdxEqiyqTBs1i9c
 miKGR2vXm/fJ51TZnSQePu2M3IAEkQz6JmLn6hamsFPlN6jqC1JIv/D5JiUeLEOPYLJuxnhuI
 mH/+H7md2GLc01X5v0m8RtWwe4HDcCuR7NgdhFWrwRq/lDUtyU04xapi8R/O7KlGcIQ4x1Vpq
 NTmoPML5JstrQCaFzyY6Wf/urEzhTMS/BwwWwh6shjerjcOJhCMj4MfWZoU8L0CnL9198TshP
 uBLGPqLPEh8lkQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-136162339-1644325943=:347
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 7 Feb 2022, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
> > We could use that option in Git's own Makefile to add the file named
> > "version", which contains $GIT_VERSION.  Hmm, but it also contains a
> > terminating newline, which would be a bit tricky (but not impossible) =
to
> > add.  Would it make sense to add one automatically if it's missing (e.=
g.
> > with strbuf_complete_line)?  Not sure.
>
> I do not think it is a good UI to give raw file content from the
> command line, which will be usable only for trivial, even single
> liner files, and forces people to learn two parallel option, one
> for trivial ones and the other for contents with meaningful size.

Nevertheless, it is still the most elegant way that I can think of to
generate a diagnostic `.zip` file without messing up the very things that
are to be diagnosed: the repository and the worktree.

> "--add-blob=3D<path>:<blob-object-name>" may be another option, useful
> when you have done "hash-object -w" already, and can be used to add
> single-liner, or an entire novel.

This would mess with the repository. Granted, it is unlikely that adding a
tiny blob will all of a sudden work around a bug that the user wanted to
report, but less big mutations have been known to subtly change a bug's
manifested symptoms.

So I really do not want to do that, not in `scalar diagnose.

> In any case, "--add-file=3D<file>", which we already have, would be
> more appropriate feature to use to record our "version" file, so
> there is no need to change our Makefile for it.

Same here. It is bad enough that `scalar diagnose` has to create a
directory in the current enlistment. Let's not make the situation even
worse.

The most elegant solution would have been that streaming `--add-file` mode
suggested by Ren=C3=A9, I think, but that's too involved to implement just=
 to
benefit `scalar diagnose`. It's not like we can simply stream the contents
via `stdin`, as there are more than one "virtual" file we need to add to
that `.zip` file.

Ciao,
Dscho

--8323328-136162339-1644325943=:347--
