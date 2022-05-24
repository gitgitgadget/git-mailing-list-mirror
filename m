Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C8AC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 18:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbiEXSyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 14:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240460AbiEXSyV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 14:54:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F4A5717A
        for <git@vger.kernel.org>; Tue, 24 May 2022 11:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653418455;
        bh=8sAMoDsCijTCeLTIpAm175pO4TTV1Cx1Hq6wT5Hc4ns=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=B6eTTX0lEFxdm3kstwiCi/XHwSVJ5kEi5p1fmdL+IJr0pGuHGspnT8bH4cLNW5LOg
         nGgS56MIev9k8t86wiLhHqqRw0Hv2/WjZvLlqY4EUpiE7+fLdIqt/8BzUnnZh1EIfu
         6XorUktakCVaheZJHQrE/tprGBWOvz19rYWFhFTI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOiDd-1oCd9U1MKt-00QBma; Tue, 24
 May 2022 20:54:15 +0200
Date:   Tue, 24 May 2022 20:54:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Yuyi Wang via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Yuyi Wang <Strawberry_Str@hotmail.com>,
        Yuyi Wang <Strawberry_Str@hotmail.com>
Subject: Re: [PATCH] Remove (_)UNICODE def on Windows in CMakeLists.txt
In-Reply-To: <pull.1269.git.git.1653397021384.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205242046470.352@tvgsbejvaqbjf.bet>
References: <pull.1269.git.git.1653397021384.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:K2xmT5dzLz4iT/fqkY0lw8yWzbRu4D98eG/MdEDA0FAVTA46B+S
 qRNh9lLRjufolLZVrFP5zJSGEMKWWWJznzTyUULJwUstYd1c5xqCNZUFlYGVOr1LSoJ9n02
 wWGB7FLXrzGpQrXqCSPfca4s7WfhOkbnwk7GeyKF78UppLVcT9onlGiBjKU7E6wpLWge+np
 bdR6UscIfWcqnZsCfzjkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6MesF3xJ2zs=:FEpfObFyWFHjan9wMTI9Bg
 GOTWLZdrLtnX5LuO5NbNvIwqy6hB1YLPZzCs0GBBeq1Mn3TZkPRueocJkz0aQTytYFnq7Uplp
 lyi7G6VDkf+o+YW9rL0eaaxlrmWA+VkQeQYsYGw845L24/7J3QSqMolCuYPRJiKTSwfWx6pwH
 BdP6tQh1hoZs/e4Oz56LePwFCFO3XyKRP6KBjt7dwpOyEglK3xEyboh61YXgXoLePLBQXz5ND
 gkFUaJ227S4AKw1q5UqEsxvyqqsoA09E8zj9/eQUo/J0BQmX7ZPxf0wNkfhnvGKvgi2UmymPk
 muuE2RRSd5/iS66iG4hoxGBxwQTRLDHErR0PkqPOJZ/B6J0AkMV4w9Ky51hN4x1gY0V6nuX6m
 JMuPC2Z3eir1FQEgcIuxzCo3BZftPvJkNZm+6Przk/jwXFSyOb//f9VS05pdqvGViLnnadDW4
 a4tvrkP3YRfFt1QbOFd/TzBEldQCP7qrTDrxNfN7Rd0sJEXu+r489lVUL37QkfedsHVKNm5jV
 N4Ij8bmnCHaPQKSPawjigxMW/TThX8X5Pa1wOv046wkIggWH+lsWvj79uZEOKI5yVq67uaqF7
 IGmpV/IGRyltrNPUwM7w1adLWSwZyV3MNGqSIu6OpSMeirBAQozeF9nVXSuQErKU4BVKo0snT
 /4ppQLVdjILPto8IiXr0ObmpBMWNtvgrVoHmHo74JPiCfTOkgKwFobA+m8bQLvQNUjEoQUqy5
 JV0ok1+RZi1C3XSDo1p67ivA+zO7XiO+EzDrsrcrWcbH4lWYLwIEbHqyXH9tH7x2HjLsbStrC
 3XF+3GTtemibw0gf04SpnqIpibDcBuzsZiVSm6T3rMnnJ+KuyXNWcEqsCaizbfEfbWXtVj58a
 ntUx1xqPW+dnzraMf6mjsktjlo5Gy5GyzqAHdb3KyCG7hpYBrrdtt1IBkyCty++yj5miJWsLn
 nvTUT2reqwCUTloR/JxJR9MqGoT+HfYayhsj8xaKLGh9lQyL7gaoNiBRl2u1unstJ9aL6fw7V
 3DetEJgNUjNymnMhoQBVvGA0NdJNsR5Ha7TF4B1zKz68hVamo6mFcaWqCR462/0dijaRJ2kI6
 4lthSyNYfPH7gnQBT68S59Pr6YsQYKyEAOrwHE0Qlv54nNfEv2yvODMJg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 24 May 2022, Yuyi Wang via GitGitGadget wrote:

> From: Yuyi Wang <Strawberry_Str@hotmail.com>
>
> `UNICODE` and `_UNICODE` are not required when building git on Windows.
> Actually, they should not be predefined at all.
>
> There're 2 evidences that `(_)UNICODE` is supposed to be nonexist:
>
> compat/win32/trace2_win32_process_info.c:83: It uses jw_array_string
> which accepts pe32.szExeFile as const char*.
>
> t/helper/test-drop-caches.c:16: Calling to GetCurrentDirectory with
> Buffer as char*.
>
> The autotools build system never defines `UNICODE` and `_UNICODE` and
> builds on Windows well.

It _is_ true that we make a point of using the `*W()` suffix explicitly to
ensure that we use the Unicode variants of the Win32 API functions.

And it is also true that we do not explicitly define `UNICODE` in
`config.mak.uname`.

Therefore this patch is:

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Ciao,
Dscho

P.S.: Please note that the Git mailing list silently drops all mails from
@hotmail.com addresses, as far as I remember. Therefore, if you reply, it
may never reach the list.

>
> Signed-off-by: Yuyi Wang <Strawberry_Str@hotmail.com>
> ---
>     Remove (_)UNICODE def on Windows in CMakeLists.txt
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-12=
69%2FBerrysoft%2Fcmake%2Fwincompat-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1269/=
Berrysoft/cmake/wincompat-v1
> Pull-Request: https://github.com/git/git/pull/1269
>
>  contrib/buildsystems/CMakeLists.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/=
CMakeLists.txt
> index 185f56f414f..d52d973ab0d 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -260,7 +260,7 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
>  				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=3D".exe"  NO_SYMLINK_HEAD =
UNRELIABLE_FSTAT
>  				NOGDI OBJECT_CREATION_MODE=3D1 __USE_MINGW_ANSI_STDIO=3D0
>  				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MM=
AP
> -				UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRAND=
OM)
> +				HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
>  	list(APPEND compat_SOURCES
>  		compat/mingw.c
>  		compat/winansi.c
>
> base-commit: 7a3eb286977746bc09a5de7682df0e5a7085e17c
> --
> gitgitgadget
>
>
