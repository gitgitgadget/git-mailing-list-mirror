Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 768E31F731
	for <e@80x24.org>; Sat, 10 Aug 2019 20:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfHJU1y (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 16:27:54 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43979 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfHJU1y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 16:27:54 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so10030962qkd.10
        for <git@vger.kernel.org>; Sat, 10 Aug 2019 13:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NLBOZqqXta6iLuZNW8agpwsuwtaAjq+P13p4+vwbQxQ=;
        b=S5hrTYSv0UEliwxcHkCpKfh2fgyf3ZTTUb+PQVSebPmUhKXPYiEMhfJlNgwQGciyYx
         uPdnQJoHt4K1yjlohpS//5YX+jewwXQU4uYhlFCiE/d04R5LNBWvgL0c1cZGZ1Wfz97P
         1O8fQi1P1v5iNBQQX4bSjH82mvTgj4y0bQtJmIf0NSkMiYIEx9ItQcuJe9E2zaq38SQx
         4xvhWxRMP5zz8ZZKGTyPystcnjxNWEk0uolOxxHDAZ3IioG1WKsGN71Fia9YIDVqzS0u
         UV0V0JQYqY4wJXMH178x/zdenhO3FNkMk+Li5b2radKthOvD0apbbD1igd5xPSXt+1dC
         cq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NLBOZqqXta6iLuZNW8agpwsuwtaAjq+P13p4+vwbQxQ=;
        b=kzAHCtyHgrSvnekCBFLHcrgGt+lozdmleltYoYV7bf3i0355IOP/pbWwYrHFsTz8HF
         0ErCa4zyN0pEHlzCfF5yd1xfCkl5eNtzdBkS9/EFYIWtnJ2/Z4Vapoq0ndGloHePI+Bc
         W9edpK6v4G19+8howJJHuhh5Xx/kmVylciVc37+f0pncMzNKZTC15/G9peSaRQ1VkGKY
         9CNazkWmvrOGFwgOq1dLVXbVg9kPARRDci7kyWrlaDbzsUed/cLb+fpZdxfWxPrB2+44
         blS6cSeV65KFluzvEPsKWGmmME2uo/XpOUhNA/lNdcwmDNLs8WnOHqx7vbnWcg7TPHJX
         itdA==
X-Gm-Message-State: APjAAAXi/JriKPyAC9PN7IADHN82gF0mrKp3tb3/kXSvGeOPYEvKmIfn
        U1Jg4zKB75wNivlq3Gz1w71s1tW6TNE=
X-Google-Smtp-Source: APXvYqzv4aYoRQDT0KIoYw00R/iwLpuqyPbc9XX49+F9P2z2jtHkrYcv8PSMFpSHH17AuS8ih/XS/A==
X-Received: by 2002:a37:4e4c:: with SMTP id c73mr23791348qkb.309.1565468872837;
        Sat, 10 Aug 2019 13:27:52 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u1sm54384295qth.21.2019.08.10.13.27.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 13:27:52 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <stefanbeller@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH 1/4] object-store: add lock to read_object_file_extended()
Date:   Sat, 10 Aug 2019 17:27:27 -0300
Message-Id: <052de4c139bf4962182e6cb8f4aa315aa6130124.1565468806.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1565468806.git.matheus.bernardino@usp.br>
References: <cover.1565468806.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow read_object_file_extended() to be called by multiple threads
protecting it with a lock. The lock usage can be toggled with
enable_obj_read_lock() and disable_obj_read_lock().

Probably there are many spots in read_object_file_extended()'s call
chain that could be executed unlocked (and thus, in parallel). But, for
now, we are only interested in allowing parallel access to zlib
inflation. This is one of the sections where object reading spends most
of the time and it's already thread-safe. So, to take advantage of that,
the lock is released when entering it and re-acquired right after. We
may refine the lock to also exploit other possible parallel spots in the
future, but threaded zlib inflation should already give great speedups.

Note that add_delta_base_cache() was also modified to skip adding
already present entries to the cache. This wasn't possible before, but
now it is since phase I and phase III of unpack_entry() may execute
concurrently.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 object-store.h |  4 ++++
 packfile.c     |  7 ++++++
 sha1-file.c    | 61 +++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/object-store.h b/object-store.h
index 7f7b3cdd80..cfc9484995 100644
--- a/object-store.h
+++ b/object-store.h
@@ -159,6 +159,10 @@ const char *loose_object_path(struct repository *r, struct strbuf *buf,
 void *map_loose_object(struct repository *r, const struct object_id *oid,
 		       unsigned long *size);
 
+void enable_obj_read_lock(void);
+void disable_obj_read_lock(void);
+void obj_read_lock(void);
+void obj_read_unlock(void);
 void *read_object_file_extended(struct repository *r,
 				const struct object_id *oid,
 				enum object_type *type,
diff --git a/packfile.c b/packfile.c
index fc43a6c52c..de93dc50e2 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1115,7 +1115,9 @@ unsigned long get_size_from_delta(struct packed_git *p,
 	do {
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
+		obj_read_unlock();
 		st = git_inflate(&stream, Z_FINISH);
+		obj_read_lock();
 		curpos += stream.next_in - in;
 	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
 		 stream.total_out < sizeof(delta_head));
@@ -1468,6 +1470,9 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	struct delta_base_cache_entry *ent = xmalloc(sizeof(*ent));
 	struct list_head *lru, *tmp;
 
+	if (get_delta_base_cache_entry(p, base_offset))
+		return;
+
 	delta_base_cached += base_size;
 
 	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
@@ -1597,7 +1602,9 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	do {
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
+		obj_read_unlock();
 		st = git_inflate(&stream, Z_FINISH);
+		obj_read_lock();
 		if (!stream.avail_out)
 			break; /* the payload is larger than it should be */
 		curpos += stream.next_in - in;
diff --git a/sha1-file.c b/sha1-file.c
index 84fd02f107..f5ff51aedb 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1560,16 +1560,54 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 	return 0;
 }
 
+static pthread_mutex_t obj_read_mutex;
+static int obj_read_use_lock = 0;
+
+/*
+ * Enabling the object read lock allows multiple threads to safely call the
+ * following functions in parallel: repo_read_object_file(), read_object_file()
+ * and read_object_file_extended().
+ */
+void enable_obj_read_lock(void)
+{
+	if (obj_read_use_lock)
+		return;
+
+	obj_read_use_lock = 1;
+	pthread_mutex_init(&obj_read_mutex, NULL);
+}
+
+void disable_obj_read_lock(void)
+{
+	if (!obj_read_use_lock)
+		return;
+
+	obj_read_use_lock = 0;
+	pthread_mutex_destroy(&obj_read_mutex);
+}
+
+void obj_read_lock(void)
+{
+	if(obj_read_use_lock)
+		pthread_mutex_lock(&obj_read_mutex);
+}
+
+void obj_read_unlock(void)
+{
+	if(obj_read_use_lock)
+		pthread_mutex_unlock(&obj_read_mutex);
+}
+
 /*
  * This function dies on corrupt objects; the callers who want to
  * deal with them should arrange to call read_object() and give error
  * messages themselves.
  */
-void *read_object_file_extended(struct repository *r,
-				const struct object_id *oid,
-				enum object_type *type,
-				unsigned long *size,
-				int lookup_replace)
+static void *do_read_object_file_extended(struct repository *r,
+					  const struct object_id *oid,
+					  enum object_type *type,
+					  unsigned long *size,
+					  int lookup_replace)
 {
 	void *data;
 	const struct packed_git *p;
@@ -1602,6 +1640,19 @@ void *read_object_file_extended(struct repository *r,
 	return NULL;
 }
 
+void *read_object_file_extended(struct repository *r,
+				const struct object_id *oid,
+				enum object_type *type,
+				unsigned long *size,
+				int lookup_replace)
+{
+	void *data;
+	obj_read_lock();
+	data = do_read_object_file_extended(r, oid, type, size, lookup_replace);
+	obj_read_unlock();
+	return data;
+}
+
 void *read_object_with_reference(struct repository *r,
 				 const struct object_id *oid,
 				 const char *required_type_name,
-- 
2.22.0

