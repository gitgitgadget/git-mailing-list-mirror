Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91AF1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 14:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeC2Oyh (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 10:54:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:53107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751182AbeC2Oye (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 10:54:34 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWT8s-1f4BK80pmE-00XcuX; Thu, 29
 Mar 2018 16:54:30 +0200
Date:   Thu, 29 Mar 2018 16:54:29 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Daniel Jacques <dnj@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] Add Windows support to the new RUNTIME_PREFIX
 design
In-Reply-To: <xmqqa7us86pi.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803291637050.5026@qfpub.tvgsbejvaqbjf.bet>
References: <20180325205120.17730-1-dnj@google.com> <nycvar.QRO.7.76.6.1803262331040.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAD1RUU8jNudjCXN=-mucogmSFj2xqyYqyk-dfADhjceLsmBE2g@mail.gmail.com> <nycvar.QRO.7.76.6.1803271752190.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CAD1RUU9XK837mdRwicMwM5qVApzz8o2e4Eg=B0LH3SRtLqG9WQ@mail.gmail.com> <xmqqa7us86pi.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:T1o8+6mVg3UeRSkbTOxOwJhHZKd7FXmpqlshBYPBbdBB6zwZ2oZ
 KZITSbzEYQPw/KkG0SDyxwsHLY758636vCkGIOlTnpv9Gizdr9mKv8SjwYdf6J96BI6ODxd
 FFr9aV/OANroIS+3IxCudjr/L5paxDcKj164WuKx7/mQnUMfMbFJ7N1/GkV2SsDeuGHYO41
 ZfOvq+e+8Edf972UbNxIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jODdPt5VM0w=:xIUbN7BBiu0+K2OtRI8uOV
 W8lwezWjbjSu3kyHE6HpCzHCzkpMI7U6EVk0CvSUqrwbGCNMRqC5PHF223Y8U4J5GNn+AxoIJ
 YhC+8BarIjzSLyUC/fJvJt3HA7JBsJ4n8dBqJLeAlKxVdUklQAQC2ZgC2yvSO/3zMa8UM1ZYu
 hG9HqNsNgqrMymISJ9yekMyEn30y04N18xCFLdqXXHPRaXta50NyASAvVitFYCM99nOQiqIoY
 1CXb/SkHQGTHCdlAxG/pUtcHQxQxohGHKFv9YBbkJEWCBd0IsEuvlPyLlpri0ODYsZUlpak8V
 KidgYI4WZp4OwuXB+yIpPAU3OrSJABvNlWoaRV/jkikrwlyqL+Z6hJo63hVfzCoO0/TtXb5uc
 /dEYiXvyXUY8hKN6yRg8FFsqzviN78HU4mGIsYX4pK93G50neLAfB0yARw5xDV2tcqKXD2kAG
 iX1ZnjVNUnCcFX0wNMNnhoXUa1/c+0ypiCp0YTa2XAvxoHs8lnRK3dw3FUw4G+a+16nTUVAyz
 6iBpf7+uypJywzFfgGnAhc+5lMLaO+hImHK2nIWya2Iw1rohF7PunKC4JaclP8ffxabklvFd4
 j/mhXDEl2CupO/v/gOMg5v/w7+10cU/OXbT6nrke3bvFO74wX4+ZuelrHI78lj83YTWK2VGHD
 wzZwGQkmiX5z5UlnNxR505J2XBjK7CyCbTa02mYKpzsezEuciJOfDyVlVy0+kID2vfBfcl1hu
 dgChle+HJud73SH1uegL6ITDHNW5KNGFahrA0a+YSXv4fTC0832HtJTMgSikutrA5bSB4+cOH
 FbNfTLqRnuGNY0f7hscMGaq2uKO+iZV5c8P6fKq6LZChhjZ0qqyJKXfZ0/1A9LRoAvK6pkW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 28 Mar 2018, Junio C Hamano wrote:

> Daniel Jacques <dnj@google.com> writes:
> 
> > A simple grep suggests that the current test suite doesn't seem to have any
> > RUNTIME_PREFIX-specific tests. When I've been running the test suites, I've
> > been doing it with a "config.mak" file that explicitly enables
> > RUNTIME_PREFIX to get the runtime prefix code tested against the standard
> > Git testing suites.
> >
> > From a Git maintainer's perspective, would such a test be a prerequisite
> > for landing this patch series, or is this a good candidate for follow-up
> > work to improve our testing coverage?
> 
> It would be a nice-to-have follow-up, I would say, but as you two
> seem to be working well together and it shouldn't be too involved to
> have the minimum test that makes sure the version of "git" being
> tested thinks things should be where we think they should be, with
> something like...
> 
> 	test_expect_success RUNTIME_PREFIX 'runtime-prefix basics' '
> 		(
> 			# maybe others
> 			safe_unset GIT_EXEC_PATH &&
> 			git --exec-path >actual

That will only work when the directory into which git (or git.exe) was
compiled is called "bin" or "git" (or "git-core" in a "libexec"
directory), because this is the sanity check we have to determine that Git
is installed into a sensible location where we *can* assume that
libexec/git-core/ is the corresponding location of the support
executables/scripts.

I initially thought that we could somehow do this:

-- snip --
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 2b3c5092a19..3040f0dae49 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "string-list.h"
+#include "exec_cmd.h"
 
 /*
  * A "string_list_each_func_t" function that normalizes an entry from
@@ -270,6 +271,25 @@ int cmd_main(int argc, const char **argv)
 	if (argc == 2 && !strcmp(argv[1], "dirname"))
 		return test_function(dirname_data, posix_dirname,
argv[1]);
 
+	if (argc == 3 && !strcmp(argv[1], "runtime-prefix")) {
+#ifndef RUNTIME_PREFIX
+		warning("RUNTIME_PREFIX support not compiled in;
skipping");
+		return 0;
+#else
+		char *path;
+
+		git_resolve_executable_dir(argv[2]);
+		path = system_path("");
+
+		if (!starts_with(argv[2], path))
+			return error("unexpected prefix: '%s'", path);
+
+		puts(path);
+
+		return 0;
+#endif
+	}
+
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
```

but this simply won't work, as the main idea of
`git_resolve_executable_dir()` is to use the executable path whenever
possible, instead of the passed-in parameter.

And since we usually work via the bin-wrappers, we cannot even add a
sanity check that Git was cloned into a directory called "git"...

So... I think we have to leave this out of the patch series, unless
somebody comes up with an idea neither Dan nor I has thought about to test
this reliably *without* copying the Git executable (which would, as I
mentioned, break testing when .dll files need to be present in the same
directory as git.exe).

Ciao,
Dscho


