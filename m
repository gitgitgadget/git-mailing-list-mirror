Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E159202C1
	for <e@80x24.org>; Fri, 10 Mar 2017 00:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753892AbdCJAPN (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 19:15:13 -0500
Received: from mout.web.de ([212.227.17.12]:64719 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753488AbdCJAPM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 19:15:12 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MfYrH-1cbLLy1BTn-00P2qA; Fri, 10
 Mar 2017 01:14:29 +0100
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
To:     Jeff King <peff@peff.net>, Vegard Nossum <vegard.nossum@oracle.com>
References: <CFA1C4B4-0FDA-424D-87A4-EEE1F9BB3712@gmail.com>
 <xmqqinnrd098.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703030315580.3767@virtualbox>
 <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com>
 <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
 <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
 <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
 <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
 <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
 <282895e1-d9eb-2368-a8e7-8085ad9b17ed@oracle.com>
 <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        allan.x.xavier@oracle.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c553da50-e5ca-d064-e75c-46e5a5042935@web.de>
Date:   Fri, 10 Mar 2017 01:14:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ftrroQNu46/TubcIb1kRn1gXH5okLxOeYPjkEz8HbPXo9pfEbqN
 A+JynodErm0doH45Q7ZGzf/ruzxBkXQR52cRtSdypYCYuVouUso4NNVKksXxGvn8DjVgDjM
 xKoZJbHLyx9iuFs1mv8+sHrHsIVLtA1izt1Q/TN0vC6osWzU/AdNHzfRVpqH0+NRJc56MN4
 5awwaZOw0yguNyp329T6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IVxUfNL03vE=:wDeYhJw8YGxn0PMBv6ODzO
 PeeKDEyCp/OeMiPK0lm11oqNua99ZdJ+LFTZ68ea8F3XQ+9yU/wxvhhc8bRmtdR7cJuyvihqf
 6E3C3kHaEgDQV4uqUAuMl/1aKsy01MdHlwxP6CoS2KqadRdHqu2L8X7W1vSFY6hKNWADFFP8P
 8NUpYrxXDCk3jvXYAgxiqnefMMNTOXJUg619y8yy3TdG7XMNIoBJDDNa2hm9DJdk/LWkXjoZk
 j8b0zS6zjIs9Rnalzxsbl7EpjBvakcPbxUSMeod0+6cAWWdfMd5MvXg8fkF+zfyJj1XfnQhUS
 28zaioXpzrqiSXFP/G1/UUDSDeAb+hrOyWuauI5NDvnXBuMmygxQObXLJL376GnN02ojJc3sy
 2vVr5iWr4QkwjDvrE/yM/yzYO4yR3WnnglGzt2A21f3ZD7kQ+Ttd6C9s1dYi+BMSBopW3U1sj
 Xarhwj8S9SiJjg9chb3tgCqkrBKn5Ujcd2QzQ4RaZ34//xEYDOqFrTEloiDS4BMl9iuvOld+Y
 BoWllbQ5T5ctOXUyIJb0/+UgJLgeU449prTMEB2YqkT8TbXtyji9e9Uce6j8e3h1tTg9PiMsx
 MMF8UmEvnvmWZbOMThv7G13qzOn3HDvgfa71cxumqQrR/o82zpwVsqgKWX36xLePF45byL6Aj
 OQ5XnG2XPc4Cgg+8uslW/53XkPnF+B6AKyPm5vPcPlnXDB6E0jTzlj+aRF2ypbeaz0TFDptDU
 /YslUvnH3zzAcPW/NsARxxXrFAoLxJ7q7C5Q2qJqg23xV2J5kC/t72I1/golTbQkr7uQuaEeA
 wUSN3Xr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.03.2017 um 12:36 schrieb Jeff King:
> I grepped for 'memcpy.*sizeof' and found one other case that's not a
> bug, but is questionable.
> 
> Of the "good" cases, I think most of them could be converted into
> something more obviously-correct, which would make auditing easier. The
> three main cases I saw were:

>   2. Ones which just copy a single object, like:
> 
>        memcpy(&dst, &src, sizeof(dst));
> 
>      Perhaps we should be using struct assignment like:
> 
>        dst = src;
> 
>      here. It's safer and it should give the compiler more room to
>      optimize. The only downside is that if you have pointers, it is
>      easy to write "dst = src" when you meant "*dst = *src".

Compilers can usually inline memcpy(3) calls, but assignments are
shorter and more pleasing to the eye, and we get a type check for
free.  How about this?

-- >8 --
Subject: [PATCH] cocci: use assignment operator to copy structs

Add a semantic patch for converting memcpy(3) calls targeting
addresses of variables (i.e., variables preceded by &) -- which are
basically always structs -- to simple assignments, and apply it to
the current tree.  The resulting code is shorter, simpler and its
type safety is checked by the compiler.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/log.c                 |  2 +-
 contrib/coccinelle/copy.cocci | 31 +++++++++++++++++++++++++++++++
 convert.c                     |  2 +-
 credential-cache--daemon.c    |  2 +-
 daemon.c                      |  2 +-
 line-log.c                    |  2 +-
 revision.c                    |  2 +-
 7 files changed, 37 insertions(+), 6 deletions(-)
 create mode 100644 contrib/coccinelle/copy.cocci

diff --git a/builtin/log.c b/builtin/log.c
index 55d20cc2d8..23bb9a9e76 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1030,7 +1030,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	if (!origin)
 		return;
 
-	memcpy(&opts, &rev->diffopt, sizeof(opts));
+	opts = rev->diffopt;
 	opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 
 	diff_setup_done(&opts);
diff --git a/contrib/coccinelle/copy.cocci b/contrib/coccinelle/copy.cocci
new file mode 100644
index 0000000000..f0d883932a
--- /dev/null
+++ b/contrib/coccinelle/copy.cocci
@@ -0,0 +1,31 @@
+@@
+type T;
+T dst;
+T src;
+@@
+(
+- memcpy(&dst, &src, sizeof(dst));
++ dst = src;
+|
+- memcpy(&dst, &src, sizeof(src));
++ dst = src;
+|
+- memcpy(&dst, &src, sizeof(T));
++ dst = src;
+)
+
+@@
+type T;
+T dst;
+T *src;
+@@
+(
+- memcpy(&dst, src, sizeof(dst));
++ dst = *src;
+|
+- memcpy(&dst, src, sizeof(*src));
++ dst = *src;
+|
+- memcpy(&dst, src, sizeof(T));
++ dst = *src;
+)
diff --git a/convert.c b/convert.c
index 8d652bf27c..4bae12be6b 100644
--- a/convert.c
+++ b/convert.c
@@ -290,7 +290,7 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 	if ((checksafe == SAFE_CRLF_WARN ||
 	    (checksafe == SAFE_CRLF_FAIL)) && len) {
 		struct text_stat new_stats;
-		memcpy(&new_stats, &stats, sizeof(new_stats));
+		new_stats = stats;
 		/* simulate "git add" */
 		if (convert_crlf_into_lf) {
 			new_stats.lonelf += new_stats.crlf;
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 46c5937526..798cf33c3a 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -22,7 +22,7 @@ static void cache_credential(struct credential *c, int timeout)
 	e = &entries[entries_nr++];
 
 	/* take ownership of pointers */
-	memcpy(&e->item, c, sizeof(*c));
+	e->item = *c;
 	memset(c, 0, sizeof(*c));
 	e->expiration = time(NULL) + timeout;
 }
diff --git a/daemon.c b/daemon.c
index 473e6b6b63..f891398aad 100644
--- a/daemon.c
+++ b/daemon.c
@@ -785,7 +785,7 @@ static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_
 
 	newborn = xcalloc(1, sizeof(*newborn));
 	live_children++;
-	memcpy(&newborn->cld, cld, sizeof(*cld));
+	newborn->cld = *cld;
 	memcpy(&newborn->address, addr, addrlen);
 	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
 		if (!addrcmp(&(*cradle)->address, &newborn->address))
diff --git a/line-log.c b/line-log.c
index 65f3558b3b..64f141e200 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1093,7 +1093,7 @@ static int process_all_files(struct line_log_data **range_out,
 				rg = rg->next;
 			assert(rg);
 			rg->pair = diff_filepair_dup(queue->queue[i]);
-			memcpy(&rg->diff, pairdiff, sizeof(struct diff_ranges));
+			rg->diff = *pairdiff;
 		}
 		free(pairdiff);
 	}
diff --git a/revision.c b/revision.c
index b37dbec378..289977c796 100644
--- a/revision.c
+++ b/revision.c
@@ -2738,7 +2738,7 @@ int prepare_revision_walk(struct rev_info *revs)
 	struct object_array old_pending;
 	struct commit_list **next = &revs->commits;
 
-	memcpy(&old_pending, &revs->pending, sizeof(old_pending));
+	old_pending = revs->pending;
 	revs->pending.nr = 0;
 	revs->pending.alloc = 0;
 	revs->pending.objects = NULL;
-- 
2.12.0
