Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F0631FA14
	for <e@80x24.org>; Mon, 17 Apr 2017 09:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753530AbdDQJ5O (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 05:57:14 -0400
Received: from mout.web.de ([212.227.15.4]:49480 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbdDQJ5L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 05:57:11 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MOSAP-1cuoc31HFt-005sOI; Mon, 17
 Apr 2017 11:56:58 +0200
Subject: Re: What's cooking in git.git (Apr 2017, #02; Sun, 16)
To:     Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twopensource.com>
References: <xmqqmvbfij92.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Message-ID: <e6f869b1-09c2-88eb-d79d-b0dc2090a632@web.de>
Date:   Mon, 17 Apr 2017 11:56:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <xmqqmvbfij92.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:NTWZMwTXbxhNPTtN1TLg2RzD5UCOfZui/HDXdhHwHyf+QX06sdf
 ToIiK8yxHx7qaPp+ZuDCDulCzddGXytY6urnSXwSaoc9QfXuiOragCljqTsTI08LLbfSdoQ
 E1/CFnH2GHHrW2vpSavWe6sIZ1uicbmPnzSNWIvwZaAP5aQXu5dyc09Srn1+lm0f6ZCJCfJ
 IWNP3syUM4F7RHTlkFH6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PNARcPCTQUk=:3wqxsXhpuKVvZniZmCmFXo
 CJ1ikJIDOXKfwhNpJuSf/t7oJR1J4WcFvMxFTpo+SL+UKtobsRa5PMj9HPxTlRh53BUPZai8b
 2SwqvV2rF7TSbAwb9laJXW/1/G9zmXp3cPS/KwvHP1sTjUORBt7tD9h3OkZeRvtWldI9zUcMP
 Bx1eUVF4+8xn8yNHUjtvlw9a9sUJ/JSLxPKvS2iYX+iu/yL5C60iYPsNHS3pimZOxw+lbFuVe
 BRYRHOazP0Ey1hYFy3JQOc1xulLZumEF+6TqWZM+s41XG6Jet9wL5CDy1rrgyrLvlh9bWrBcM
 +taqS9AHwi2djn9B+xzYzGGKx9vFwKPZBV3dPpmgF5u2am2bqtnRiL+M1D/e+9+XDNjrTPC3W
 MePG8eiK03w5Cmq6RKOPU6x1DtxYOZaLcU4lIjNeiyS9ZK2px2ZVCUAQv46rly5gPnWEdV41F
 0XDfReWI/IFi7P/j0iUfEnN6YqlrP5E96SDWi+Z+jx/Dg4wttnMEYBiBwcP9KFN9nL78Nu2IV
 AxxlQR4qCM2lys4G6iwZBqdQzt67WYYZXu20ODEdUrIVeFW3t4HWGYFnFxrTi3V3f7vaVTihA
 Ne8Qo9Bzf9PTCVqnZFOtjO5baTbtLuAvqY9UFsUWAWLZUQvX07Yb4A2t/UsdD8KyHuUZdNgbP
 IuDMMRwLKG3yuXaM/QSoaj06yEIsjMvr4eayQye/axGbV8/n09XK1K2iixbqpqRE5M63s9DdJ
 ygzT9qLv/3LD2ZV2zQJezI9xxgfdowF0a7NRZEe08XU7PGd0sIBYwH/1zfVekRjwqF3YuaYep
 0CCDnDI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.04.2017 um 09:30 schrieb Junio C Hamano:
> * dt/xgethostname-nul-termination (2017-04-13) 1 commit
>   - xgethostname: handle long hostnames
> 
>   gethostname(2) may not NUL terminate the buffer if hostname does
>   not fit; unfortunately there is no easy way to see if our buffer
>   was too small, but at least this will make sure we will not end up
>   using garbage past the end of the buffer.
> 
>   Will merge to 'next'.

[Sorry for repeating, but I didn't see a direct reply.]

If a host name doesn't fit then the buffer is too small.  Let's make it
big enough, reducing the number of magic constants and avoiding silent
truncation all at the same time.  Patch for that:

-- >8 --
Subject: [PATCH] use HOST_NAME_MAX to size buffers for gethostname(2)

POSIX limits the length of host names to HOST_NAME_MAX.  Export the
fallback definition from daemon.c and use this constant to make all
buffers used with gethostname(2) big enough for any possible result
and a terminating NUL.

Inspired-by: David Turner <dturner@twopensource.com> 
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/gc.c           | 2 +-
 builtin/receive-pack.c | 2 +-
 daemon.c               | 4 ----
 fetch-pack.c           | 2 +-
 git-compat-util.h      | 4 ++++
 ident.c                | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 2daede7820..1fca84c19d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -232,7 +232,7 @@ static int need_to_gc(void)
 static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 {
 	static struct lock_file lock;
-	char my_host[128];
+	char my_host[HOST_NAME_MAX + 1];
 	struct strbuf sb = STRBUF_INIT;
 	struct stat st;
 	uintmax_t pid;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7020278081..dbbc7d03dc 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1698,7 +1698,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (status)
 			return "unpack-objects abnormal exit";
 	} else {
-		char hostname[256];
+		char hostname[HOST_NAME_MAX + 1];
 
 		argv_array_pushl(&child.args, "index-pack", "--stdin", NULL);
 		push_header_arg(&child.args, &hdr);
diff --git a/daemon.c b/daemon.c
index f70d27b826..ac7181a483 100644
--- a/daemon.c
+++ b/daemon.c
@@ -4,10 +4,6 @@
 #include "strbuf.h"
 #include "string-list.h"
 
-#ifndef HOST_NAME_MAX
-#define HOST_NAME_MAX 256
-#endif
-
 #ifdef NO_INITGROUPS
 #define initgroups(x, y) (0) /* nothing */
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index d07d85ce30..055f568775 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -802,7 +802,7 @@ static int get_pack(struct fetch_pack_args *args,
 		if (args->use_thin_pack)
 			argv_array_push(&cmd.args, "--fix-thin");
 		if (args->lock_pack || unpack_limit) {
-			char hostname[256];
+			char hostname[HOST_NAME_MAX + 1];
 			if (gethostname(hostname, sizeof(hostname)))
 				xsnprintf(hostname, sizeof(hostname), "localhost");
 			argv_array_pushf(&cmd.args,
diff --git a/git-compat-util.h b/git-compat-util.h
index 8a4a3f85e7..46f3abe401 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -884,6 +884,10 @@ static inline size_t xsize_t(off_t len)
 __attribute__((format (printf, 3, 4)))
 extern int xsnprintf(char *dst, size_t max, const char *fmt, ...);
 
+#ifndef HOST_NAME_MAX
+#define HOST_NAME_MAX 256
+#endif
+
 /* in ctype.c, for kwset users */
 extern const unsigned char tolower_trans_tbl[256];
 
diff --git a/ident.c b/ident.c
index c0364fe3a1..556851cf94 100644
--- a/ident.c
+++ b/ident.c
@@ -120,7 +120,7 @@ static int canonical_name(const char *host, struct strbuf *out)
 
 static void add_domainname(struct strbuf *out, int *is_bogus)
 {
-	char buf[1024];
+	char buf[HOST_NAME_MAX + 1];
 
 	if (gethostname(buf, sizeof(buf))) {
 		warning_errno("cannot get host name");
-- 
2.12.2
