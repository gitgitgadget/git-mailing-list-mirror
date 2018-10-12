Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 824CA1F97F
	for <e@80x24.org>; Fri, 12 Oct 2018 20:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbeJMEQ4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 00:16:56 -0400
Received: from mout.web.de ([217.72.192.78]:53445 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725743AbeJMEQz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 00:16:55 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lhev7-1foyyp3zmr-00mwTc; Fri, 12
 Oct 2018 22:42:35 +0200
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lhev7-1foyyp3zmr-00mwTc; Fri, 12
 Oct 2018 22:42:35 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     Martin Koegler <martin.koegler@chello.at>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/1] zlib.c: use size_t for size
Date:   Fri, 12 Oct 2018 22:42:29 +0200
Message-Id: <20181012204229.11890-1-tboegi@web.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05
In-Reply-To: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
References: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0qlR9KYhwFdjo+W8ymtfT9Ib3X9YkCXpdsX3qzAEBaLg6uhyF49
 ybIKVoyi9PqL7juvHud/fNKzOUo9cY5TjXEtOeRNCf+/zzPPR3MkpL91CQw+pyjPapYy4eh
 066wxAupu+kksgrtR79uFagi8DIAyjc7j2BvqcRV+/doBrzJNIZkYzsPJh2mSbGVosCEv25
 q7oEud8orkPZgbrwwyGyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PjI3+9qwibk=:2GW+KqIDS33YcTexW1Vg4L
 4eI8VYJQoFvVvWCjrfaX9kkC+/OhLhYx47q5iSazSDDEjsEcX5Qk9rvpRyTy193veAOYIaXFS
 6Wj+e091vaynaW46Zk3qCGPVQJTgv0gunV+U09aDkEXc4ioTCs758MuCP2teF9qoKmnGHxbx8
 9irZaDajf+8lcqKpnx4zqs7Z5yVQNnKoqTUnuZWKAUsCuBKuwIekzJzvzFTOmRkc+P/2uXEtb
 gkhshVdl09XmJ+1y1eYXQrp21Kb8XixmuPY1pHtKGv3IPLjPgjEQhXoy2l9NoYMQd7f44J45d
 Mt08Fb7WyaJ54dlYtVe1K7OK7VkZAFoRMtB3H0hWhVxZbyBkGFKKxFasiRVV4fvdvnUbu45y7
 z/NdSmydegAAh2TNkp0ZhMtiaCZ8RmwE7M3pusW6xeb1xdfmuN2WndJPgNBS7hMYFLG7gevHF
 oCoGL/SMDlsFVn7qaR3SfYr8oIRXOWufaALhrygKUGSSDwbBAmIQG42m01Io5OQ/bsooa7gpz
 pCF38yd2zB4WQohgQULU9tnMldEmWIkoupc/vp/N6T8fyHk5TXcg4dlQuoSzfu3oj5t0ecyyz
 ZJ0BQz4EUMZKAfJUmoLonSnWfa1/5HV7sMHBnRVPzEZQRO5BL91sG/HirPuBf8Ltjbc3JdJdd
 S0TKHh17iCsj5MOdOETIuNKbZBqzxJ6mWnQpf0diD5eEOECdVHvmce3iWYWY7vyMu0pPkibtC
 5/Vh7hrgmS8pA+yYS1dxZZx1nKRneaZlTN8UYj0YR67T69QbLCWN3FFowPNQWWdpVQ+kPEw04
 5yB5fthqlLV8nu0iwsIOzP+QG4Q0f14Gonse8ZxighkCmSHv/U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---

After doing a review, I decided to send the result as a patch.
In general, the changes from off_t to size_t seem to be not really
motivated.
But if they are, they could and should go into an own patch.
For the moment, change only "unsigned long" into size_t, thats all

 builtin/pack-objects.c |  8 ++++----
 cache.h                | 10 +++++-----
 pack-check.c           |  4 ++--
 packfile.h             |  2 +-
 wrapper.c              |  8 ++++----
 zlib.c                 |  8 ++++----
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e6316d294d..23c4cd8c77 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -269,12 +269,12 @@ static void copy_pack_data(struct hashfile *f,
 		off_t len)
 {
 	unsigned char *in;
-	unsigned long avail;
+	size_t avail;
 
 	while (len) {
 		in = use_pack(p, w_curs, offset, &avail);
 		if (avail > len)
-			avail = (unsigned long)len;
+			avail = xsize_t(len);
 		hashwrite(f, in, avail);
 		offset += avail;
 		len -= avail;
@@ -1478,8 +1478,8 @@ static void check_object(struct object_entry *entry)
 		struct pack_window *w_curs = NULL;
 		const unsigned char *base_ref = NULL;
 		struct object_entry *base_entry;
-		unsigned long used, used_0;
-		unsigned long avail;
+		size_t used, used_0;
+		size_t avail;
 		off_t ofs;
 		unsigned char *buf, c;
 		enum object_type type;
diff --git a/cache.h b/cache.h
index d508f3d4f8..fce53fe620 100644
--- a/cache.h
+++ b/cache.h
@@ -20,10 +20,10 @@
 #include <zlib.h>
 typedef struct git_zstream {
 	z_stream z;
-	unsigned long avail_in;
-	unsigned long avail_out;
-	unsigned long total_in;
-	unsigned long total_out;
+	size_t avail_in;
+	size_t avail_out;
+	size_t total_in;
+	size_t total_out;
 	unsigned char *next_in;
 	unsigned char *next_out;
 } git_zstream;
@@ -40,7 +40,7 @@ void git_deflate_end(git_zstream *);
 int git_deflate_abort(git_zstream *);
 int git_deflate_end_gently(git_zstream *);
 int git_deflate(git_zstream *, int flush);
-unsigned long git_deflate_bound(git_zstream *, unsigned long);
+size_t git_deflate_bound(git_zstream *, size_t);
 
 /* The length in bytes and in hex digits of an object name (SHA-1 value). */
 #define GIT_SHA1_RAWSZ 20
diff --git a/pack-check.c b/pack-check.c
index fa5f0ff8fa..d1e7f554ae 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -33,7 +33,7 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
 	uint32_t data_crc = crc32(0, NULL, 0);
 
 	do {
-		unsigned long avail;
+		size_t avail;
 		void *data = use_pack(p, w_curs, offset, &avail);
 		if (avail > len)
 			avail = len;
@@ -68,7 +68,7 @@ static int verify_packfile(struct packed_git *p,
 
 	the_hash_algo->init_fn(&ctx);
 	do {
-		unsigned long remaining;
+		size_t remaining;
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
 		offset += remaining;
 		if (!pack_sig_ofs)
diff --git a/packfile.h b/packfile.h
index 442625723d..e2daf63426 100644
--- a/packfile.h
+++ b/packfile.h
@@ -78,7 +78,7 @@ extern void close_pack_index(struct packed_git *);
 
 extern uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
 
-extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
+extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, size_t *);
 extern void close_pack_windows(struct packed_git *);
 extern void close_pack(struct packed_git *);
 extern void close_all_packs(struct raw_object_store *o);
diff --git a/wrapper.c b/wrapper.c
index e4fa9d84cd..1a510bd6fc 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -67,11 +67,11 @@ static void *do_xmalloc(size_t size, int gentle)
 			ret = malloc(1);
 		if (!ret) {
 			if (!gentle)
-				die("Out of memory, malloc failed (tried to allocate %lu bytes)",
-				    (unsigned long)size);
+				die("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",
+				    (uintmax_t)size);
 			else {
-				error("Out of memory, malloc failed (tried to allocate %lu bytes)",
-				      (unsigned long)size);
+				error("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",
+				      (uintmax_t)size);
 				return NULL;
 			}
 		}
diff --git a/zlib.c b/zlib.c
index d594cba3fc..197a1acc7b 100644
--- a/zlib.c
+++ b/zlib.c
@@ -29,7 +29,7 @@ static const char *zerr_to_string(int status)
  */
 /* #define ZLIB_BUF_MAX ((uInt)-1) */
 #define ZLIB_BUF_MAX ((uInt) 1024 * 1024 * 1024) /* 1GB */
-static inline uInt zlib_buf_cap(unsigned long len)
+static inline uInt zlib_buf_cap(size_t len)
 {
 	return (ZLIB_BUF_MAX < len) ? ZLIB_BUF_MAX : len;
 }
@@ -46,8 +46,8 @@ static void zlib_pre_call(git_zstream *s)
 
 static void zlib_post_call(git_zstream *s)
 {
-	unsigned long bytes_consumed;
-	unsigned long bytes_produced;
+	size_t bytes_consumed;
+	size_t bytes_produced;
 
 	bytes_consumed = s->z.next_in - s->next_in;
 	bytes_produced = s->z.next_out - s->next_out;
@@ -150,7 +150,7 @@ int git_inflate(git_zstream *strm, int flush)
 #define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
 #endif
 
-unsigned long git_deflate_bound(git_zstream *strm, unsigned long size)
+size_t git_deflate_bound(git_zstream *strm, size_t size)
 {
 	return deflateBound(&strm->z, size);
 }
-- 
2.19.0.271.gfe8321ec05

