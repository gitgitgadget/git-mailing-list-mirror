Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B25C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 13:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D7060F5A
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 13:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhKBNmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 09:42:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:40111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhKBNmF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 09:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635860369;
        bh=1u5aGNPHRncTXMBFkCK8GUztD7zd7ICHiJ9iY8UuHeI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HQ5snHg13xlUAeF+du2vnVaw89YmMBu/0fiqDoar2aCPbV43kgHFN3/800b2TDhuY
         XNqhHKOoIvk9Y1o8MDEPnHZHMMEVFOWKvPailuzX7JcxDWhyqm2dpP/1L87kQG64oN
         Uy+t0VLteRVaa2Mrwd7wIXk003vzCQcGv1vYbCDY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([213.196.213.29]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f5T-1mlSeM0msx-004CaV; Tue, 02
 Nov 2021 14:39:29 +0100
Date:   Tue, 2 Nov 2021 14:39:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin: add git-default-branch command
In-Reply-To: <20211030140112.834650-1-thomas@t-8ch.de>
Message-ID: <nycvar.QRO.7.76.6.2111021433010.56@tvgsbejvaqbjf.bet>
References: <20211030140112.834650-1-thomas@t-8ch.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-456161043-1635860369=:56"
X-Provags-ID: V03:K1:wckouwVQt2pcmYJu9l8+4upO52cCZTLwIWjHd5mSCbBK0R5BoGu
 6MjcFgG4lm3BcyZaGiGM47A+0i+gIBopHfZECyUj1B3OFfDYULhbdpECaur7NSn242XIin8
 AYYaEfCR2qXN2y/OUZNNZsUuY3Rhit9vj7qRg5DcnW/HyfOxz7rCb50q7R8wXS5vB4SB4cN
 oiLW4P635ZZkZ5X/ITDDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7CQVu5Eqt+0=:bwoR9h+RtlagEgYrms6waN
 Z41uZn6yGeX7OMbJSGnJIZhjsnt8sGThPDaBayxoZOhe0lclfDWiC3Y0QQeMKMtrT6bt7+bCK
 DIQ6EZ42dKoJTAiHg+S2O+owsHQVyr1DVy4Fp2Ps2bdMFgoYSsivJKZQ6LavjPTYgZ3zX0xVe
 nUusjZuyPKVp17kr1B+PTFeSZtd4tygzlBBF94HZEmNZdsVI7892bbkAimWEyp3vZZ/qN5r6h
 GX9LZ0X29EXgMegaDVQEuTd+fl+aC5xFiS5QtPKYpwzfJWjj1mY+TERNZ/iKROPrgUq9AxWzv
 +aXnuwtnra+lzu3x052wZq5u87vJxQmjPc+KgjudO392MjX8Gr6fWvSsDyBDVJjwmS03oROHm
 iPE6dhnRA6IlxBsQOka3EucuAhYNTvp/mSgLg0sDJH7xslZjYRj2ZzQI4NNuy60W7JCct1n+Q
 7Pdk2V80RZj+i8gVfyXe6KXbTMphwmF6BP+9anfTZHIFCSCpn4+oA+2babF+cZwl9a6vhjkU/
 cbnQpWiLqmhjdrG6z7nqnbg09aKCCyZOay5/U/ERqyFnz0HIk0JNNSTIlqPVWiJVqIcDItI8i
 gr/oqdmw4gW1I+DAP3KG0Rd+PjL+q01bO4BKsZH7KYg8QZKQkVXNlj2UbPy9ouZng9NLMl1yf
 UBD61A3fRwvuoUWlzvbymwXYgCgDwJeF9VRidGds9NZQ8ALqvN/ZFF2vq6lMzAFeyDhO/Hcvd
 LIGTpH19jdGZbmcLa7UxXWUEuvQ+sqv5s7IQWxZHakC/B1ijLQc48pEhH9WIY7ybHLHCIosiU
 1ba4Z4Dm75qclfHfVPkvq7MtmHtx/XfX0fQNdO9+IwzDrP4GUwb178cUgHEzuVBL7O/NJFnVw
 4cuijMzKKpnbrLAzhqCm94rXAe+UifTOCAopm1Fz4vHF+zk0pTQbKAwGJoR+cVCchSAQeloU5
 4pN+E0t0KOgue78By3DwymhcrrcZ+5smkt3wmro3nxXbRthHsEXayCX4dleljo3srtk1Db4dv
 AgjwlR0hyHN4qBn8vgFWekVplJ0/xz/3Btd6yN+4pBgxd95ggG3YVr0DtrnmJyl0Ys7tIPiRS
 Qt3/6S3w/Sh1Qg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-456161043-1635860369=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Sat, 30 Oct 2021, Thomas Wei=C3=9Fschuh wrote:

> Introduce command `default-branch` which allows to retrieve the branch
> that will be used by git-init.
>
> Currently this command is equivalent to
> 	git config init.defaultbranch || 'master'
>
> This however will break if at one point the default branch is changed as
> indicated by `default_branch_name_advice` in `refs.c`.

I am very sympathetic to the motivation for your patch, I have had to
resort to an ugly hack in Git for Windows' script that generates the
installer: the script creates a throw-away repository _just_ to determine
said branch name.

>
> By providing this command ahead of time users of git can make their
> code forward-compatible.

It is probably overkill to introduce a whole new command for just this
single purpose.

But we do have prior art in Git how to display similar information: `git
var -l` will list e.g. `GIT_PAGER`, even if it is not configured
explicitly.

Something like this should be a good start along those lines:

=2D- snip --
diff --git a/builtin/var.c b/builtin/var.c
index 6c6f46b4aea..937c63939d9 100644
=2D-- a/builtin/var.c
+++ b/builtin/var.c
@@ -5,6 +5,7 @@
  */
 #include "builtin.h"
 #include "config.h"
+#include "refs.h"

 static const char var_usage[] =3D "git var (-l | <variable>)";

@@ -27,6 +28,16 @@ static const char *pager(int flag)
 	return pgm;
 }

+static const char *default_branch(int flag)
+{
+	const char *name =3D repo_default_branch_name(the_repository, 1);
+
+	if (!name)
+		BUG("could not determine the default branch name");
+
+	return name;
+}
+
 struct git_var {
 	const char *name;
 	const char *(*read)(int);
@@ -36,6 +47,7 @@ static struct git_var git_vars[] =3D {
 	{ "GIT_AUTHOR_IDENT",   git_author_info },
 	{ "GIT_EDITOR", editor },
 	{ "GIT_PAGER", pager },
+	{ "GIT_DEFAULT_BRANCH", default_branch },
 	{ "", NULL },
 };

=2D- snap --

Thanks,
Johannes

--8323328-456161043-1635860369=:56--
