Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09631422B8
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 06:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886213; cv=none; b=Fd/BpTkb8GPwR4pRoaNPXVO6ujlv/K4noW545Ks8lKerA07LI585NhwQd8BSqNU4itdtafHxPqAc3ZvvVsiH/GlPfGW7powO9Z2ZubiTP+lz3Ifxz1HDpRI6K25Wfjn/DCdvwHNOnf5LaVoVEP+3wnckoKmZOymEajX6UhiFPso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886213; c=relaxed/simple;
	bh=DC8yKQtUwKnxRFknOQ/k4wwWYpXDfXqI4tnHYCu92N0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CD2vrnsXCnsYbhdPxNc0x0iAu5UByggbXaCw4qVYGuctfASOmz6EumSsypIDtHs0J/jiLxST0qX3FPzkyjRLtnBfDCABUBU0ZpcIlIk5wagMPuOEB7ZkQBrbkORC0rHZDuAghsqj0rkMNrBJYTR/emDrqIhLUZS2KHB3aXAP6nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=YkgcuQ2g; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="YkgcuQ2g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728886206; x=1729491006;
	i=johannes.schindelin@gmx.de;
	bh=J6Vx1brBPzztvq2cpiXuHCrv65bJJDGo1qCd94n1bSY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YkgcuQ2gSKZQE7iZ9Gao2D7TdjqysjeFua+n8rEroXMxQnvdjwdp0elQ3kOnEL3x
	 kRQdSNwkTDVCZTWCqDQfCHykRcr4S/jwaxL1WTuOvpItoHhBXToSr2ghELmMRDm0W
	 JsWADV7ziqAQIDm787uhMgT2RsDzPtfjgQYdjSlesd9WxIQ2IareztDsjc65Q8nWp
	 X0hkYwgOuS/KuWBOPykISsaygVcwxB/6bsEN0KeUtMltepacTlN3fp2k6BQluQEM6
	 i/gkl5eA7VeMWnH26VyJz3kj31qS627iscBzNwz6opa5J/ic1i+szTbvOTpGm0ZVQ
	 X0Xd8nLW2ApzIhu9Eg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([95.90.245.139]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV63q-1tQ6sl3WOk-00WNYp; Mon, 14
 Oct 2024 08:10:05 +0200
Date: Mon, 14 Oct 2024 08:10:05 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ed Reel <edreel@gmail.com>
cc: git@vger.kernel.org
Subject: Re: Bug report
In-Reply-To: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>
Message-ID: <f7910f55-1a77-dec8-7aa2-36688d59c215@gmx.de>
References: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1657831193-1728886206=:87"
X-Provags-ID: V03:K1:7bozg9yse7qPD2bH1lZmxhZ+xuyOwE3KdxCkvLRBdq9FSbY7a+7
 CbLxYlfkXkKMy+MJ7YpryU/leR9REHhOYh2EbhBkHkb6Z6MxOo2vxnottu9pNScnPfG7c4j
 tQpgyE6fo6k9uJwMXSLSHw+5wlrIC39p9KRDjbymGDWH/V2aqnn/rcvbpojU+DFfO1UDA0W
 iq0lnKO3uwD2Ue1wdG+1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zjutfxiGihI=;hW6SSIrTlrIivnOEq4DtRjJYCqx
 dewFZV4yso6mYzl5lUtE1TwdLB9erveyYCiR7JQzVmF3lZRDywz2WQi9sz5Xaya0rsovHNkiF
 swQmo32a9rl5fyJhW/vC+o6uguZaoSVJ05JBE2ikHGMJhLS+Qg7JAiAg34j8j51eiC7UYKAqj
 vEatIDNop2O9yvxEn0bVemSzXrSSBbDKFgpPccHaLAcTSQZAI/90kzVn9lAOvDOrOi2u4geDT
 TabfaGeULQmTufAJ3FXPn5+urA5icXcbrezeZF4ST4zO/hub3RzPyNMutKTVnSf6jXnP743Al
 grZFjliOWvl2saOvnlyfnLNB9lVcc0579Cv2nlvER2Jlu0DPRVH4Ix15SobyEww7DtYP9wD65
 DOuXnBWre7fAJ8s8zqoM3tnTAaOXcOWisRbyNqwQd3Lx001pJQ8Z1FZDzhV+rIjSjfbQ01scs
 89q1axHo/ZgFvXUhRrmyEBwKfoVgoKXKLthWHsb6HkTA2etJsGVz7ENs1f3DOB4m5kd8XWJWK
 TrtifG8TVU1lMazqc3f7kw31VIliY1nhfjmWCsHo6iXx4R+Bnl78xEJYzInZDGs5r731W3IWR
 hhWAln8DadW2C33tdQzK3bfkbheIEyiFjnbpvmYs1o872kU+x6xdmaLNdP39+6S6yJ03KRXwC
 smC15rGsqVbcoZLPFiwVClRZ9LJxqf3tFjCII+Snikfg5TlcKr82N8Yx+WB5ESj9wY6Yb8UpX
 LyU9krezPJ5i1MFctoDWxR4sVJ3vfN7fxmyT7BvP9up673u9NT+YkaFaBoDl7P2hUhZVBC795
 N8LhoLZaP5orUl8TfqT0VUgg==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1657831193-1728886206=:87
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ed,

On Tue, 8 Oct 2024, Ed Reel wrote:

> See attachment...

You will find that Git mailing list readers typically frown upon having to
deal with text that was stuffed into an attachment, because it is much
harder to quote that plain text in the mail body. Maybe next time just
paste it into the mail body?

> What did you do before the bug happened? (Steps to reproduce your issue)
> Attempt to build with cmake

But which branch and/or commit?

> What did you expect to happen? (Expected behavior)
> Successful build

> What happened instead? (Actual behavior)
> Unsuccessful build

> What's different between what you expected and what actually happened?
> [5*10/162] Building C object CMakeFiles/unit-tests-lib.dir/usr/local/tmp=
/crew/git.20241009021715.dir/t/unit-tests/strvec.c.o
> FAILED: CMakeFiles/unit-tests-lib.dir/usr/local/tmp/crew/git.20241009021=
715.dir/t/unit-tests/strvec.c.o
> /usr/local/bin/cc -DBINDIR=3D\"bin\" -DDEFAULT_GIT_TEMPLATE_DIR=3D\"shar=
e/git-core/templates\" -DDEFAULT_HELP_FORMAT=3D\"html\" -DETC_GITATTRIBUTE=
S=3D\"etc/gitattributes\" -DETC_GITCONFIG=3D\"etc/gitconfig\" -DFALLBACK_R=
UNTIME_PREFIX=3D\"/home/chronos\" -DFREAD_READS_DIRECTORIES -DGIT_BUILT_FR=
OM_COMMIT=3D\"\" -DGIT_EXEC_PATH=3D\"libexec/git-core\" -DGIT_HOST_CPU=3D\=
"x86_64\" -DGIT_HTML_PATH=3D\"share/doc/git-doc\" -DGIT_INFO_PATH=3D\"shar=
e/info\" -DGIT_LOCALE_PATH=3D\"share/locale\" -DGIT_MAN_PATH=3D\"share/man=
\" -DGIT_USER_AGENT=3D\"git/2.47.0.GIT\" -DGIT_VERSION=3D\"2.47.0.GIT\" -D=
HAVE_ALLOCA_H -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_DEV_TTY -=
DHAVE_GETDELIM -DHAVE_PATHS_H -DHAVE_STRINGS_H -DHAVE_SYSINFO -DINTERNAL_Q=
SORT -DNO_OPENSSL -DNO_STRLCPY -DPAGER_ENV=3D"\"LESS=3DFRX LV=3D-c\"" -DPR=
OCFS_EXECUTABLE_PATH=3D\"/proc/self/exe\" -DRUNTIME_PREFIX -DSHA1DC_CUSTOM=
_INCLUDE_SHA1_C=3D\"git-compat-util.h\" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_=
C=3D\"git-compat-util.h\" -DSHA1DC_INIT_SAFE_HASH_DEFAULT=3D0 -DSHA1DC_NO_=
STANDARD_INCLUDES -DSHA1_DC -DSHA256_BLK -DSUPPORTS_SIMPLE_IPC -DUSE_CURL_=
FOR_IMAP_SEND -DUSE_LIBPCRE2 -I/usr/local/tmp/crew/git.20241009021715.dir/=
contrib/buildsystems/../.. -I/usr/local/tmp/crew/git.20241009021715.dir/co=
ntrib/buildsystems/builddir -I/usr/local/tmp/crew/git.20241009021715.dir/c=
ontrib/buildsystems/../../t/unit-tests -O2 -pipe -ffat-lto-objects -fPIC  =
 -flto=3Dauto -O3 -DNDEBUG -flto=3Dauto -fno-fat-lto-objects -MD -MT CMake=
Files/unit-tests-lib.dir/usr/local/tmp/crew/git.20241009021715.dir/t/unit-=
tests/strvec.c.o -MF CMakeFiles/unit-tests-lib.dir/usr/local/tmp/crew/git.=
20241009021715.dir/t/unit-tests/strvec.c.o.d -o CMakeFiles/unit-tests-lib.=
dir/usr/local/tmp/crew/git.20241009021715.dir/t/unit-tests/strvec.c.o -c /=
usr/local/tmp/crew/git.20241009021715.dir/t/unit-tests/strvec.c
> In file included from /usr/local/tmp/crew/git.20241009021715.dir/t/unit-=
tests/strvec.c:1:
> /usr/local/tmp/crew/git.20241009021715.dir/t/unit-tests/unit-test.h:3:10=
: fatal error: clar-decls.h: No such file or directory
>     3 | #include "clar-decls.h"
>       |          ^~~~~~~~~~~~~~
> compilation terminated.
> [14*1/162] Linking C executable git
> In function =E2=80=98strbuf_add=E2=80=99,
>     inlined from =E2=80=98strbuf_addstr=E2=80=99 at /usr/local/tmp/crew/=
git.20241009021715.dir/contrib/buildsystems/../../strbuf.h:310:2,

The path starting with `/usr/` suggests that this is not Windows. And
further below, the information from a working Git suggests that you try to
build this on Linux.

At the moment, the CMake definition very much targets Windows, not any
other platform, because it provides the only convenient way to build Git
in Visual Studio without having to jump through substantial hoops.

Since you seem on a Unix-ish platform, why not try the `make`-based build,
which is how the Git maintainer builds the project?

Ciao,
Johannes

>     inlined from =E2=80=98verify_one_pack=E2=80=99 at /usr/local/tmp/cre=
w/git.20241009021715.dir/builtin/verify-pack.c:40:3,
>     inlined from =E2=80=98cmd_verify_pack=E2=80=99 at /usr/local/tmp/cre=
w/git.20241009021715.dir/builtin/verify-pack.c:90:7:
> /usr/local/tmp/crew/git.20241009021715.dir/strbuf.c:312:9: warning: =E2=
=80=98memcpy=E2=80=99 writing 5 bytes into a region of size 1 overflows th=
e destination [-Wstringop-overflow=3D]
>   312 |         memcpy(sb->buf + sb->len, data, len);
>       |         ^
> /usr/local/tmp/crew/git.20241009021715.dir/strbuf.c: In function =E2=80=
=98cmd_verify_pack=E2=80=99:
> /usr/local/tmp/crew/git.20241009021715.dir/strbuf.c:65:6: note: destinat=
ion object =E2=80=98strbuf_slopbuf=E2=80=99 of size 1
>    65 | char strbuf_slopbuf[1];
>       |      ^
> In function =E2=80=98strbuf_release=E2=80=99,
>     inlined from =E2=80=98strbuf_release=E2=80=99 at /usr/local/tmp/crew=
/git.20241009021715.dir/strbuf.c:75:6,
>     inlined from =E2=80=98bundle_uri_parse_line=E2=80=99 at /usr/local/t=
mp/crew/git.20241009021715.dir/bundle-uri.c:939:2,
>     inlined from =E2=80=98get_remote_bundle_uri=E2=80=99 at /usr/local/t=
mp/crew/git.20241009021715.dir/connect.c:527:8,
>     inlined from =E2=80=98get_bundle_uri=E2=80=99 at /usr/local/tmp/crew=
/git.20241009021715.dir/transport.c:406:9:
> /usr/local/tmp/crew/git.20241009021715.dir/strbuf.c:78:17: warning: =E2=
=80=98free=E2=80=99 called on unallocated object =E2=80=98strbuf_slopbuf=
=E2=80=99 [-Wfree-nonheap-object]
>    78 |                 free(sb->buf);
>       |                 ^
> /usr/local/tmp/crew/git.20241009021715.dir/strbuf.c: In function =E2=80=
=98get_bundle_uri=E2=80=99:
> /usr/local/tmp/crew/git.20241009021715.dir/strbuf.c:65:6: note: declared=
 here
>    65 | char strbuf_slopbuf[1];
>       |      ^
> ninja: build stopped: subcommand failed.
> There was a build error.

> [System Info]
> git version:
> git version 2.46.1.GIT
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> libcurl: 8.10.0
> zlib: 1.3.1
> uname: Linux 6.4.0-1mx-ahs-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.4.4-1~m=
x23+1 (2023-07-26) x86_64
> compiler info: gnuc: 14.2
> libc info: glibc: 2.27
> $SHELL (typically, interactive shell): /bin/bash

--8323328-1657831193-1728886206=:87--
