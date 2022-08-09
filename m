Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61509C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 08:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbiHII7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 04:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237465AbiHII7R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 04:59:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B5422B00
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 01:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660035545;
        bh=Y7sC9QNnus/AX1uR7oy2aDdG6j8+8vmYbfvaJk11eqM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Q6nR7sR0Kcvi1EgwME244wAN/ZfeTlhWOWJccJi+cNnj673QVTFMVaVRHweF/AEW8
         tPtGNp6tpjZXvODsfRefQbpOHkSmpu4yvi4QN4o7MKoIxkmvjJ4zxT9Ww95QMPSoTk
         GG652LQ0FRbHSHSuY+L0ZCX4SODojHWRwdMJ7ARs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.31.241.252] ([89.1.214.151]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6m4-1ngl0P2TYC-00lWTy; Tue, 09
 Aug 2022 10:59:05 +0200
Date:   Tue, 9 Aug 2022 10:59:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Some improvements to safe.directory on Windows
In-Reply-To: <xmqqzggesnbh.fsf@gitster.g>
Message-ID: <2q2nos2r-9151-6s87-q173-3r738n0rp452@tzk.qr>
References: <pull.1286.git.1657700238.gitgitgadget@gmail.com> <pull.1286.v2.git.1659965270.gitgitgadget@gmail.com> <xmqqzggesnbh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+9HwE17tf75hdxI8l4NVG1ZzC2z+Qa443L7Ao8JyQKcb58yKse5
 6x+0n8NLnvtemPHlK5Os6A3P/aEowNBarCBuREqdPPDX2CEqDUFSqRsl281nzr1y59FI01i
 oFN7thapjOKHrTZgHhKGALmBYjD3oiB4VDu/E9dhWo4R3LwbjV3ST8lXirE2F9HrEhKPpFz
 yC6wyc3Jvwz3TkktBPKZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KttYS2Q/3Fo=:xlO28f3HsAI9oMloxdEXmo
 AItJ8iLnlhkJkfgTPGqWsLnKUvvO21UeLv45T3p7UBDnCUcU+4Fner2nvvVG/KnxSezwana7l
 qp5xTddEiHMyug5DSO07R8uvpHGwR+0XtccTlOry/2v1SO0MKp7+yAqGuA9gON156rp03LNj9
 QWRN2ZbkU8j8zpAaeDNQ4sGqbnLghETM77lhBv/Avk+IcoKtO64F+4+5GatYVMf+GF6kAALBw
 c5yjBdg9S796ZOHVxku/es3h7b9QC/RxjhW1KqOG42BpbgWbNxYwFGO9FgL+qArcaQfJWbKUS
 99J3yX/nkHNGquqEJHAeIh/XfYGw2RbIHRpBByN+fI1lddAU1ESS5q/jtqF00rfKGXuT8VxHC
 JsyTOUp+mqCUYIvX65lFh00VAd+3fm4Qh7a2cWQxqJvdRteFbmFuvUQ5yxTCarUP0EHICFbgY
 Vob1/X/pK3EcCJcyR9TtvxTl+M6MQ/lihps1p1h+X3dctIlBUIvtNXQypY8NPPbUakfgln1H8
 i+rXek0IZ1P2+IRnRS/L42L1Oy2QMF2SbOSRimI8B05QkTHSWTFN73u2mMWIjh7+Aoxtg7X5f
 kglM/603ai4ybMa/TX6sgRBoV4QQkIRyPNzDgIGUA121iXYd4mJGL367RwXkzWQZdRXDlbCnw
 c4p7rrKcAQ6KB0qOLtBERt66pkJwvldtUHE+n9RYhx21s8heOhvt9LgY7yEKibeHlsOVmW6Wy
 EKCkZTCuqneK/eDKrHnETqQPBd6uEpXVHbYAxmXbF5R8mAJJIno+xWmr2WumhWwbeasFV3K/u
 pnqFEPKBX0Jjd+RxgsmuYz/XnbSEtY5jpaefOj/LE4pXifB2AxYctwbgpmfUr9nqty/EUUHBa
 f7eCc+IGdXWxb1UCq2SbR3RgwMsUQ9HhGGB5yvvHF794tniXSLFf9Xvr1GVtYgJAelulo62xK
 juTLeEPFiJD0bz0UxuISNjSwgfPbPgGDScfHX/6nzOeVUqAs6tOLH/TmSR7o50eqPBDQXpmqk
 Z79b3dWTMJdFIbZlZqNQfyhONzw6jbenz87TdbipQdtujegWIIn7vsb0uEKxcN0lmfWMmZPB1
 HjvQwHjrEmkyAhtyNKaqoPFn9RSyv/aozRFj60qKDlrTm6vOBrWAJCqyA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 8 Aug 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > Due to the semantics being substantially different from Unix, the
> > safe.directory feature presents its own set of problems on Windows. On=
e
> > particular issue would have prevented it from working in GitHub Action=
s'
> > build agents, which we definitely rely on in the Git project itself. T=
his
> > was addressed via the fifth patch, which had made it (in a slightly
> > different form) already into Git for Windows v2.35.2, and they are rea=
dy to
> > be applied to core Git, too.
> >
> > The FAT32 patch came in later, and was released as part of Git for Win=
dows
> > v2.37.0, so I also have confidence that it is stable and ready to be
> > integrated into core Git, too.
> >
> > Changes since v1:
> >
> >  * Restructured the patch series.
> >  * Instead of an environment variable to turn on debugging, we now alw=
ays
> >    show the platform-dependent information together with the error mes=
sage
> >    about the dubious ownership (iff it is shown, that is), based on an=
 idea
> >    by Junio.
> >  * Rebased onto gc/bare-repo-discovery to avoid a merge conflict.
>
> I actually had to rebase it back so that we could merge it to
> 'maint' for further 2.37.x releases.

I appreciate the effort you put into it, even if it is not your
responsibility to take care of Git for Windows' releases.

The range-diff shows that you snuck in a commit message change that I
would have either not made at all (I think the original was fine) or would
have made differently (because Access Control Lists are not specific to
Windows, even if Windows is the most obvious example for this permission
model):

=2D- snip --
1:  301d94f18f5 ! 1:  d51e1dff980 setup: fix some formatting
    @@ Commit message
         the indentation before actually modifying the code.

         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>

      ## setup.c ##
     @@ setup.c: static int safe_directory_cb(const char *key, const char =
*value, void *d)
2:  8cc45e4922a ! 2:  17d3883fe9c Prepare for more detailed "dubious owner=
ship" messages
    @@ Metadata
     Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>

      ## Commit message ##
    -    Prepare for more detailed "dubious ownership" messages
    +    setup: prepare for more detailed "dubious ownership" messages

         When verifying the ownership of the Git directory, we sometimes w=
ould
         like to say a bit more about it, e.g. when using a platform-depen=
dent
    -    code path (think: Windows and the permission model that is so dif=
ferent
    +    code path (think: Windows has the permission model that is so dif=
ferent
         from Unix'), but only when it is a appropriate to actually say
         something.

    @@ Commit message

         Based-on-an-idea-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>

      ## compat/mingw.c ##
     @@ compat/mingw.c: static PSID get_current_user_sid(void)
    @@ setup.c: static enum discovery_result setup_git_directory_gently_1(=
struct strbuf
      				ret =3D GIT_DIR_DISCOVERED;
      			} else
     @@ setup.c: static enum discovery_result setup_git_directory_gently_1=
(struct strbuf *dir,
    + 		}
    +
      		if (is_git_directory(dir->buf)) {
    - 			if (get_allowed_bare_repo() =3D=3D ALLOWED_BARE_REPO_EXPLICIT)
    - 				return GIT_DIR_DISALLOWED_BARE;
     -			if (!ensure_valid_ownership(NULL, NULL, dir->buf))
     +			if (!ensure_valid_ownership(NULL, NULL, dir->buf, report))
      				return GIT_DIR_INVALID_OWNERSHIP;
3:  63494818105 ! 3:  e883e04b68b mingw: provide details about unsafe dire=
ctories' ownership
    @@ Commit message
         Let's help with that by providing more detailed information.

         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>

      ## compat/mingw.c ##
     @@
4:  7aaa6248dfe ! 4:  7c83470e64e mingw: be more informative when ownershi=
p check fails on FAT32
    @@ Commit message
         This addresses https://github.com/git-for-windows/git/issues/3886

         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>

      ## compat/mingw.c ##
     @@ compat/mingw.c: static PSID get_current_user_sid(void)
5:  fbfaff2ec21 ! 5:  3f7207e2ea9 mingw: handle a file owned by the Admini=
strators group correctly
    @@ Commit message
         Administrators Group as if it were owned by said user.

         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>

      ## compat/mingw.c ##
     @@ compat/mingw.c: int is_path_owned_by_current_sid(const char *path,=
 struct strbuf *report)
=2D- snap --

Retitling the commit message was okay, of course, using the `setup:`
prefix.

> I'll refer to the original patches in this thread when I merge the
> result to 'seen', of course, to make sure the results do match.  It
> would have been slightly less convenient if you did not do this rebase,
> but it would have allowed me to have much better confidence in the
> result that may eventually go to 'maint'.  After all, mistakes in
> resolving merge conflicts on 'seen' can be corrected before the topic
> hits 'next'.

Yes, mistakes can happen, and the more people work together the easier it
is to avoid or fix them.

> Thanks.  I do not know about the API calls mingw.c part of these
> patches make, but the overall structure looks sensible to me.

I do not think that anybody expected you to know about Win32 API calls ;-)

Ciao,
Dscho
