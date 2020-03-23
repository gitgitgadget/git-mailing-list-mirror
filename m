Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4D6C4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 14:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F512076E
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 14:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QVZNMAyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgCWOLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 10:11:52 -0400
Received: from mout.gmx.net ([212.227.15.19]:56465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbgCWOLw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 10:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584972710;
        bh=VUXYJd2cQQlipEtYwI0j25+tE2LYo+ON0jGNJTZLt44=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QVZNMAyQRc6Q9HdCPIf2YbpW5PR4A7lfHIW+6EYs+iyG2fGhZDICOUC3jgyP14G5N
         sQXTjnU5oQMrXWc1pcdrD+MeEkmnZoPgQhVYz23ezgVbkbgDAO0MKsWxLWu/6QJgFD
         Y/UAnTnXua+wGjHNrz9PEEy3lwxVnoVCVRYl4Ih0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.215.97]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MfpOd-1jj8v90kK9-00gGJJ; Mon, 23 Mar 2020 15:11:50 +0100
Date:   Mon, 23 Mar 2020 15:11:50 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 6/8] t7063: drop non-POSIX argument "-ls" from
 find(1)
In-Reply-To: <59e3f73784b2a3bd9ccec87412e6178411c3708e.1584838148.git.congdanhqx@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2003231509150.46@tvgsbejvaqbjf.bet>
References: <cover.1584838148.git.congdanhqx@gmail.com> <59e3f73784b2a3bd9ccec87412e6178411c3708e.1584838148.git.congdanhqx@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1152249423-1584972711=:46"
X-Provags-ID: V03:K1:Zsj+wrlr284BCooOsgN8CqMSpfAn7Wb3WtynhlaL/3U4VfvYyjH
 IESBlBc7Iets2K7feEkq7EzWDZEmuHXHY/rRtZ42MsWVgQ4KeJ7HTicR9M/mysZuPguSNqz
 epB5+G407wiD/+KauoIXD+Lg1yHniYMoPD2dT56yPqiaFEjI/5AOR6ALVwzWVkh28/Jl4iR
 s/Fg37/bvVC2lQWG+NpkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M1Xw8rv+454=:+pSqgyCe+OzDrueCLU4Vw/
 vJkZ3T0rc32OQwz/vYdzX11U26WvvFEzS+XEtsWnCIZuhruzKVMuZ7JGBdNU9T1DVgu5cWakV
 79v/+5ngy2bxK+6duaza3MCnv7CWEHhm5Z8GxNpIB/RjKBAlb4HDmVUYYSCUm8QztQAJwvpJE
 eXsdaUo/i5QuVa78Z2A5hr7l4LSqqrCVn5Lg1SuvljPS/4MDc7G9X8J/yV9DUm4RLX8q/ZqP5
 O7xoXwyXxb18bevi9tj6RIKCYx1BDdxgUxRM8v6Dyu1HvogZTgLuySIhA+ELsUVbZfXe5bw97
 N48QNmfI/fK9mZF2cvFyzIrZrRuse9hLrngLYTBSosEPuRYQ4nmHbTmfkJCGJTJQpN/KgZDMQ
 CjmxPKy7lYMSWdDy+yRiCoc+V5OKzBg0vp+KlqWXMGVuQ7/lGbOsSfv4AfZoNiGhQ/rqe60Wp
 V0v6txACk/7qgCTEV4+RUgZaG4fCJH68APkCTr/C0xAzntF/QjDZdRaJpWHpsSBglMCVHQkAQ
 HjMB1pemPUdTJOwpSmrvK7seugF4z2gKMIHqLC0xgj+OF7i76IkPasbYXwTVoeGvQ/JGcS2Ds
 r6vLEwOmuUmstW484wsfOGwZom/pKVGFVJE+J+NH6NDSc0w+3P3j1oLA00qAlnHFQDZHmTCSP
 H7Lj4XCc1s6QnLZONl4VbqnZTk8E8Z0w6NeCSvtUxAjE12y+48QFMxNdqNLWgWJQtkuMr5tke
 m1ks7LAK6uecKwZQEtG4Weya9h3hnVCctoht1l2Gssw3SGqmtSw5gsYGEtKEqSpbgpd4oymc6
 9wwt4fFR4kQOHJqH+Dhoid+u1bBjRzkOLUm9DQul/waFGBNMuTAjImnNfJk2w8MwoGzEDegHf
 l4YfeS3iOrxMwUNLgDN60L4fkDf1AVfh08EhsnmYVVYSvGXW9EF8AAhLIenkxIg+tXyKfEfLJ
 cppjJrOjRm2RMXUa16tlnPMyR4w7cYFbJjUdQ34x28SI5aY/xHgEhGlzlrmJVqIu3pE8cZxVI
 ztecD77secsHu0YaYFRNeSQE7aeYSsBA9KFQeLW8zitpiUfHo6MtW/u2CtvtUaUENdLq2FNtM
 zGj03a9214HVOLTvcA04UeTBWBXpRuyA4cMyF40bm7k55RmPsFZsp32FszBz/ODNb2/OaQOxj
 rbYTc2BmijxnDdGhzCUO2xojCboxesDwOEDM8CN9CPgIoZAeOWDTNnuFNtsUecok4dFAGIgEn
 X++5+loe4bQVNcMHd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1152249423-1584972711=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 22 Mar 2020, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> Since commit 6b7728db81, (t7063: work around FreeBSD's lazy mtime
> update feature, 2016-08-03), we started to use ls as a trick to update
> directory's mtime.
>
> However, `-ls` flag isn't required by POSIX's find(1), and
> busybox(1) doesn't implement it.
>
> >From the original conversation, it seems like find(1) with "-type d"
> could trigger enough "lstat(2)" to ask FreeBSD update mtime.

This rationale  makes me uneasy: why did Duy add _both_ `-type d` *and*
`-ls` if the former would have been enough?

> Use only filter "-type d" for now.
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gm=
ail.com>
> ---
>  t/t7063-status-untracked-cache.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracke=
d-cache.sh
> index 190ae149cf..6791c6b95a 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -18,7 +18,7 @@ GIT_FORCE_UNTRACKED_CACHE=3Dtrue
>  export GIT_FORCE_UNTRACKED_CACHE
>
>  sync_mtime () {
> -	find . -type d -ls >/dev/null
> +	find . -type d >/dev/null

A more conservative patch would be the following:

=2D- snip --
commit 1680a64fae24b1073dbf1b844889a9953823b7a2
Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Wed Jul 19 22:13:16 2017 +0200

    t7063: when running under BusyBox, avoid unsupported find option

    BusyBox' find implementation does not understand the -ls option, so
    let's not use it when we're running inside BusyBox.

    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

diff --git a/t/t7063-status-untracked-cache.sh
b/t/t7063-status-untracked-cache.sh
index 190ae149cf3c..ab7e8b5fea01 100755
=2D-- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -18,7 +18,12 @@ GIT_FORCE_UNTRACKED_CACHE=3Dtrue
 export GIT_FORCE_UNTRACKED_CACHE

 sync_mtime () {
-       find . -type d -ls >/dev/null
+       if test_have_prereq BUSYBOX
+       then
+               find . -type d -print0 | xargs -0r ls -ld >/dev/null
+       else
+               find . -type d -ls >/dev/null
+       fi
 }

 avoid_racy() {
=2D- snap --

I have this in Git for Windows' fork, although I have to admit that there
is no CI set up to verify that this is all working as I expect it to.

Ciao,
Dscho

>  }
>
>  avoid_racy() {
> --
> 2.26.0.rc2.310.g2932bb562d
>
>
>

--8323328-1152249423-1584972711=:46--
