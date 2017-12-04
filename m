Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBE4220954
	for <e@80x24.org>; Mon,  4 Dec 2017 14:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbdLDObp (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 09:31:45 -0500
Received: from mout.gmx.net ([212.227.15.19]:54865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754026AbdLDObo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 09:31:44 -0500
Received: from virtualbox ([95.208.58.62]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lpspj-1eyl5t2Vk7-00fhlw; Mon, 04
 Dec 2017 15:31:26 +0100
Date:   Mon, 4 Dec 2017 15:31:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        =?UTF-8?Q?=C5=81ukasz_Stelmach?= <stlman@poczta.fm>
Subject: Re: [PATCH v2] git-gui: Prevent double UTF-8 conversion
In-Reply-To: <20171202122046.6033-1-l.stelmach@samsung.com>
Message-ID: <alpine.DEB.2.21.1.1712041521330.98586@virtualbox>
References: <20171202122046.6033-1-l.stelmach@samsung.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1700032577-1512397886=:98586"
X-Provags-ID: V03:K0:mgd+3/Kontm8KApWFgm+kxfaPaiTg8Upyemy1imhjF8H7W3c74d
 w1tKd0qz1M7H5WNT7EIu0U00Vlm5ypoEcSA270UzXVtxD3Ew3e1SFfrEX8m2lRZM3kPSivP
 zV4sxpEWeXJY1qYvWS5JbjOMo4X2jm4uNXASUoXjaNs5TeutGTuqTZLNEtyyOgKCfdnZUws
 rKeDkxLepS96webKIve+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mJS57rxGjBU=:iq0OmuJ11G2YywQ469/TEh
 aHef/lhBG98IMtNwDjvM7g+udx5fEkDHKU6L7PIh/QOFT/yPByz+u78hAnWLOkN2kPeKuzgte
 e9nNko0uaVWvPhgNhPghQpSvJM7gZ6sY9PVq1fgUYSMTHym20F4p//BQZ3E25o/B08xmWQLUF
 rw5OIM3jUwitQwkKJRdRN372k/jn07pq4fVZX2cDZ8hvK5ANHZ3wNq2Tv+C6wmn/HSOYcN++z
 gV60Xn+Lg3qcBtXtxEKSwBV/V7KjLD2d3JUyFZvV7uI2OhoW69NvYv0n9Uq1BrEILJO2lP3A4
 J7uwDO+3M//Cw7PmBA9V2yviYBH3md9O4M2TocPWp04T+C4iZ6fuAhhU2FsZc6wUT7nCRak9k
 EKuD8vAgHlXZwW4lDgnZce6sRPuYJogiGu/EgGXTKC03Qo/0v8NNwAcMVexO0b66m0wtlZaSo
 ykxLJiT6yY1tWlMumTT0Mz37d08QMVeSMkWf+PZAOHqEjbT/TTEFAZJrhhEX0JYarMBxShtLy
 kSdYjSGFxKAVrOS+W/NfE0KF6onF/xjOfpoRBWRoYXfa0Qk0Yv5uoNr2fscioUk4+VTeh6S8V
 0JYKqDM2+aQwV34vRFsi1xTEr9eUTycPv9YKyymFWgGptpw3Ae/wibIuXPFPK9iV2IAr8zXqa
 q930WIvvQJcp4BgppmBtnfx6recq9rM72qSIwPIOFhOp51zBAhm7rUSUqU+/eyxTgGX9FlI+N
 ybTck0eOTfn93l0C6XXbNHf1yineBG5leK7hBu2aVu9P8R3h68KpoaSEeMlR4rMeLJyVIHOoN
 VoBm1qvzVp2LJeWmvNn+50F/p5pitvHw0sT46XklcOKUQPRiT4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1700032577-1512397886=:98586
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C5=81ukasz,

On Sat, 2 Dec 2017, =C5=81ukasz Stelmach wrote:

> Convert author's name from the UTF-8 (or any other) encoding in
> load_last_commit function the same way commit message is converted.
>=20
> Amending commits in git-gui without such conversion breaks UTF-8
> strings. For example, "\305\201ukasz" (as written by git cat-file) become=
s
> "\303\205\302\201ukasz" in an amended commit.

Okay, that makes the issue a lot clearer to me (the explicit mention of
"author's name", that is).

> diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
> index 83620b7cb..f820c24bf 100644
> --- a/git-gui/lib/commit.tcl
> +++ b/git-gui/lib/commit.tcl
> @@ -34,9 +34,7 @@ You are currently in the middle of a merge that has not=
 been fully completed.  Y
>  =09=09=09=09=09lappend parents [string range $line 7 end]
>  =09=09=09=09} elseif {[string match {encoding *} $line]} {
>  =09=09=09=09=09set enc [string tolower [string range $line 9 end]]
> -=09=09=09=09} elseif {[regexp "author (.*)\\s<(.*)>\\s(\\d.*$)" $line al=
l name email time]} {
> -=09=09=09=09=09set commit_author [list name $name email $email date $tim=
e]
> -=09=09=09=09}
> +=09=09=09=09} elseif {[regexp "author (.*)\\s<(.*)>\\s(\\d.*$)" $line al=
l name email time]} { }
>  =09=09=09}

This looks wrong, as the commit_author would now also be set if the header
was not found (mind you, this would make for an incorrect Git commit, but
the code explicitly tries to set commit_author only in the case that the
author line was found.

But we cannot set commit_author here because the encoding is read as
another header line (and in a valid commit object, the encoding line (if
any) has to be *below* the author line).

So it *has* to be this way. Maybe mention this in the commit message, to
avoid head-scratching?

However, I would still recommend to `set name ""` before the loop parsing
the header, and...

>  =09=09=09set msg [read $fd]
>  =09=09=09close $fd
> @@ -44,7 +42,9 @@ You are currently in the middle of a merge that has not=
 been fully completed.  Y
>  =09=09=09set enc [tcl_encoding $enc]
>  =09=09=09if {$enc ne {}} {
>  =09=09=09=09set msg [encoding convertfrom $enc $msg]
> +=09=09=09=09set name [encoding convertfrom $enc $name]
>  =09=09=09}
> +=09=09=09set commit_author [list name $name email $email date $time]

Guarding this assignment in an `if {$name ne ""} { ... }`, just in case.

>  =09=09=09set msg [string trim $msg]
>  =09=09} err]} {
>  =09=09error_popup [strcat [mc "Error loading commit data for amend:"] "\=
n\n$err"]

Thanks,
Johannes
--8323329-1700032577-1512397886=:98586--
