Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A03B1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 11:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeDULTE (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 07:19:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:58381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751868AbeDULTD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 07:19:03 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIzGn-1f7Mdf0aYz-002XD3; Sat, 21
 Apr 2018 13:18:58 +0200
Date:   Sat, 21 Apr 2018 13:18:42 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>,
        Dan Jacques <dnj@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] Avoid multiple PREFIX definitions
In-Reply-To: <cover.1524309209.git.johannes.schindelin@gmx.de>
Message-ID: <nycvar.QRO.7.76.6.1804211316370.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524211375.git.johannes.schindelin@gmx.de> <cover.1524309209.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dlr2zDAv6O6yJ8uHZdNVaeEINMKdeoaAOjW7kWtdoM8smbw4oMp
 F+Zs8Sy90NIyC7neN3uVtafyUnuGB3+z0xfOLYg+/KijLBOOQy+aOKvprLg/DvtnvqV8XKV
 70xhD85FgxcM8GkS97mpGvR8K8NeTRnKpaxPx+TWwf8fWTszUCWy2OXXp+FWs71BrTOZhTm
 lKDNXecr9OvQE0vTSZstQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TwT3S2j+gg4=:HecObuwwvZZCCcyQMAJz5T
 dkfKHsIyVmnateu5BlRf4HazCrQIYYUF0DnAC9BoK5lcyAGVi+4BgOmAdFuAJGC19au/RNkOW
 KCDRhtlH3M2jcqY1uwETeYpC1ql/I4YJvfASgU/bZGkOah/vs0xIeWyRbavg8QkhqXzLeh7ts
 mgih0F32a2BDVw8XmJZ+Vgm2Je6sQCxzhCIwA3Xtku5oI6r8SH36LFCPhZih+pEUsKA4/3roT
 /DEE18n2SsbB9vgari0CKI2sgn/DlDWA7Sfy6HhyyRIMUTz0uEpEqf7UxoosBcv1nZA2Dc7db
 OOFjoOB9oxtmsUtHoriYsFx9XsZS9Z09jt2VncVRcGRKNk+W4+0eG4UFSQwM9N3vntG6/mv7i
 6xjCNab6jopQT+/lUCftO7iuo7JwPwIMHAC8U+T4qinCNp3yjqepVlOgL6+jvKsqvxSiV47+n
 MXMRBCC8q0gBynHR6urW1+jGMjstahVhkCFEMK7DujwarbFv5ICutm8sa0gRonhraM4ho6x3r
 PtHUcdV8Poqp1r77v46Qoffsq2fvM9yRPZMi2+HQ9IwLF6KqAgqVONZWn1B86UeCyGlLhwvS8
 vQu9UltTRxPpu5cRxPvO6RjddQ3Bd0jL72xUiH08kLcPNdszJnC0fAOdZDC69O1UDhwBRce3f
 c6ZcT7wRXiyW45ZMG8yOk37NodR4HCh0VG1RP7XProaQ9+Z31LI3HhLcxEiHerzJn54seTRv6
 s7apAuH5JUuo8HZ3NwvmB9+bAwm/IPWVPRsMxgicV4o00HgFXlptI6ZFdRWLNQrOosKhgzYQM
 QrcFwsVtyYPTo9tqLCbp4LHTxQduuvNbHLnBNoTXzPqVVNFGQ4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

The short and sweet PREFIX can be confused when used in many places.

Rename both usages to better describe their purpose. EXEC_CMD_PREFIX is
used in full to disambiguate it from the nearby GIT_EXEC_PATH.

The PREFIX in sideband.c, while nominally independant of the exec_cmd
PREFIX, does reside within libgit[1], so the definitions would clash
when taken together with a PREFIX given on the command line for use by
exec_cmd.c.

Noticed when compiling Git for Windows using MSVC/Visual Studio [1] which
reports the conflict beteeen the command line definition and the
definition in sideband.c within the libgit project.

[1] the libgit functions are brought into a single sub-project
within the Visual Studio construction script provided in contrib,
and hence uses a single command for both exec_cmd.c and sideband.c.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile   |  2 +-
 exec-cmd.c |  4 ++--
 sideband.c | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 111e93d3bea..49cec672242 100644
--- a/Makefile
+++ b/Makefile
@@ -2271,7 +2271,7 @@ exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 	'-DGIT_LOCALE_PATH="$(localedir_relative_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
-	'-DPREFIX="$(prefix_SQ)"'
+	'-DFALLBACK_RUNTIME_PREFIX="$(prefix_SQ)"'
 
 builtin/init-db.sp builtin/init-db.s builtin/init-db.o: GIT-PREFIX
 builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
diff --git a/exec-cmd.c b/exec-cmd.c
index 3b0a039083a..02d31ee8971 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -48,7 +48,7 @@ static const char *system_prefix(void)
 	    !(prefix = strip_path_suffix(executable_dirname, GIT_EXEC_PATH)) &&
 	    !(prefix = strip_path_suffix(executable_dirname, BINDIR)) &&
 	    !(prefix = strip_path_suffix(executable_dirname, "git"))) {
-		prefix = PREFIX;
+		prefix = FALLBACK_RUNTIME_PREFIX;
 		trace_printf("RUNTIME_PREFIX requested, "
 				"but prefix computation failed.  "
 				"Using static fallback '%s'.\n", prefix);
@@ -243,7 +243,7 @@ void git_resolve_executable_dir(const char *argv0)
  */
 static const char *system_prefix(void)
 {
-	return PREFIX;
+	return FALLBACK_RUNTIME_PREFIX;
 }
 
 /*
diff --git a/sideband.c b/sideband.c
index 6d7f943e438..325bf0e974a 100644
--- a/sideband.c
+++ b/sideband.c
@@ -13,7 +13,7 @@
  * the remote died unexpectedly.  A flush() concludes the stream.
  */
 
-#define PREFIX "remote: "
+#define DISPLAY_PREFIX "remote: "
 
 #define ANSI_SUFFIX "\033[K"
 #define DUMB_SUFFIX "        "
@@ -49,7 +49,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 		switch (band) {
 		case 3:
 			strbuf_addf(&outbuf, "%s%s%s", outbuf.len ? "\n" : "",
-				    PREFIX, buf + 1);
+				    DISPLAY_PREFIX, buf + 1);
 			retval = SIDEBAND_REMOTE_ERROR;
 			break;
 		case 2:
@@ -67,7 +67,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 				int linelen = brk - b;
 
 				if (!outbuf.len)
-					strbuf_addstr(&outbuf, PREFIX);
+					strbuf_addstr(&outbuf, DISPLAY_PREFIX);
 				if (linelen > 0) {
 					strbuf_addf(&outbuf, "%.*s%s%c",
 						    linelen, b, suffix, *brk);
@@ -81,8 +81,8 @@ int recv_sideband(const char *me, int in_stream, int out)
 			}
 
 			if (*b)
-				strbuf_addf(&outbuf, "%s%s",
-					    outbuf.len ? "" : PREFIX, b);
+				strbuf_addf(&outbuf, "%s%s", outbuf.len ?
+					    "" : DISPLAY_PREFIX, b);
 			break;
 		case 1:
 			write_or_die(out, buf + 1, len);
-- 
2.17.0.windows.1.15.gaa56ade3205
