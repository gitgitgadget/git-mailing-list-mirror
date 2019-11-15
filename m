Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16EBF1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 09:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfKOJxz (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 04:53:55 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:41158 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfKOJxz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 04:53:55 -0500
Received: by mail-wr1-f50.google.com with SMTP id b18so8786805wrj.8
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 01:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iRvzqtmL1dYexd8wCBWkeRx0V9T+hV0iCcpE5uXRCAA=;
        b=bbWpgoZNAt/l9JU48m7WUQE41MTIq1POElQ8xcoSC8r4VeANcIo/I2mkWRVnYCF70s
         wLTIrugLaS/EL8DreqWmdLDA/5FzgYbt8i6BfqmkXhf9AqSMEfqwYV8y+pxbC1H4piGe
         bdsEs2rkMefdQqDME8qlOuoI0SKJlQMzoW/TYIDGm5HLzKP349bz8ij1m4czXvwPYeHm
         jvEheGBNcEcrC1/T2bBcFMPNifBp+JCYnRJU+P0Xf+yTLpvd+uZ5NxRTsJAPZgU8dm2i
         jY2S8zFspN2ibRIOWhmP6epF6zrD4dIlOsiy7CVX+ecEW4Lkfcg6qE1ChXdwcfWsURf4
         3a1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iRvzqtmL1dYexd8wCBWkeRx0V9T+hV0iCcpE5uXRCAA=;
        b=TiwtsFhsV/umbGUvNrQ29hmJdJfDvNltV4FkW4jSUR8Giz0zSb7zPoCXHHkB+y2Wvz
         4BLyJPryFcjQpI8GOOFZrknxKU5YQpga51ZVa0uEnm0dk5MHDpPvxDw7s9ukl/MsDv2I
         cXtdGj2FGuSOcFL+7vpc8kk8cBjM3zyJPq52Xla9K4/kddVNMOmAbuE++o3tsR7GM8nO
         fyk5V/fST8G2DpDA5EUjONpajP9wZKSpZ/cPSjVv6nvhglxjr4Z8gLTAPHQq1gDoJ7OZ
         LoKIoT9tSqWB4HyRxYsQ817ZLCYO8How8W3uxxk7jl6F1lsmfa0ok6uX9YgdTSPHwWU7
         8XbA==
X-Gm-Message-State: APjAAAWMIUR1806h4Wu29+OF2P85AM3i3dUk7CMIhconX+/u0qOLvxCT
        BFIi11FOIBXEPpITj6fARzTNerXC
X-Google-Smtp-Source: APXvYqxEWpjKh+pt2yKDZ78R4g+hn/bQgfQt/7BEO5H95O25we/aoPmLArp6PJ7xN/Bo2u4x2uoGRA==
X-Received: by 2002:a5d:4649:: with SMTP id j9mr6291986wrs.248.1573811632396;
        Fri, 15 Nov 2019 01:53:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1sm11053079wrp.29.2019.11.15.01.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:53:52 -0800 (PST)
Message-Id: <a76a2e2244a01e1802aa5eda0aaeaf082c33ace8.1573811626.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
References: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
        <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 09:53:30 +0000
Subject: [PATCH v4 05/21] sha1-array: move doc to sha1-array.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Move the documentation from Documentation/technical/api-oid-array.txt to
sha1-array.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Also documentation/technical/api-oid-array.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/technical/api-oid-array.txt | 90 -----------------------
 sha1-array.c                              |  2 +-
 sha1-array.h                              | 80 ++++++++++++++++++++
 3 files changed, 81 insertions(+), 91 deletions(-)
 delete mode 100644 Documentation/technical/api-oid-array.txt

diff --git a/Documentation/technical/api-oid-array.txt b/Documentation/technical/api-oid-array.txt
deleted file mode 100644
index c97428c2c3..0000000000
--- a/Documentation/technical/api-oid-array.txt
+++ /dev/null
@@ -1,90 +0,0 @@
-oid-array API
-==============
-
-The oid-array API provides storage and manipulation of sets of object
-identifiers. The emphasis is on storage and processing efficiency,
-making them suitable for large lists. Note that the ordering of items is
-not preserved over some operations.
-
-Data Structures
----------------
-
-`struct oid_array`::
-
-	A single array of object IDs. This should be initialized by
-	assignment from `OID_ARRAY_INIT`.  The `oid` member contains
-	the actual data. The `nr` member contains the number of items in
-	the set.  The `alloc` and `sorted` members are used internally,
-	and should not be needed by API callers.
-
-Functions
----------
-
-`oid_array_append`::
-	Add an item to the set. The object ID will be placed at the end of
-	the array (but note that some operations below may lose this
-	ordering).
-
-`oid_array_lookup`::
-	Perform a binary search of the array for a specific object ID.
-	If found, returns the offset (in number of elements) of the
-	object ID. If not found, returns a negative integer. If the array
-	is not sorted, this function has the side effect of sorting it.
-
-`oid_array_clear`::
-	Free all memory associated with the array and return it to the
-	initial, empty state.
-
-`oid_array_for_each`::
-	Iterate over each element of the list, executing the callback
-	function for each one. Does not sort the list, so any custom
-	hash order is retained. If the callback returns a non-zero
-	value, the iteration ends immediately and the callback's
-	return is propagated; otherwise, 0 is returned.
-
-`oid_array_for_each_unique`::
-	Iterate over each unique element of the list in sorted order,
-	but otherwise behave like `oid_array_for_each`. If the array
-	is not sorted, this function has the side effect of sorting
-	it.
-
-`oid_array_filter`::
-	Apply the callback function `want` to each entry in the array,
-	retaining only the entries for which the function returns true.
-	Preserve the order of the entries that are retained.
-
-Examples
---------
-
------------------------------------------
-int print_callback(const struct object_id *oid,
-		    void *data)
-{
-	printf("%s\n", oid_to_hex(oid));
-	return 0; /* always continue */
-}
-
-void some_func(void)
-{
-	struct sha1_array hashes = OID_ARRAY_INIT;
-	struct object_id oid;
-
-	/* Read objects into our set */
-	while (read_object_from_stdin(oid.hash))
-		oid_array_append(&hashes, &oid);
-
-	/* Check if some objects are in our set */
-	while (read_object_from_stdin(oid.hash)) {
-		if (oid_array_lookup(&hashes, &oid) >= 0)
-			printf("it's in there!\n");
-
-	/*
-	 * Print the unique set of objects. We could also have
-	 * avoided adding duplicate objects in the first place,
-	 * but we would end up re-sorting the array repeatedly.
-	 * Instead, this will sort once and then skip duplicates
-	 * in linear time.
-	 */
-	oid_array_for_each_unique(&hashes, print_callback, NULL);
-}
------------------------------------------
diff --git a/sha1-array.c b/sha1-array.c
index d922e94e3f..3eeadfede9 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -48,7 +48,7 @@ int oid_array_for_each(struct oid_array *array,
 {
 	int i;
 
-	/* No oid_array_sort() here! See the api-oid-array.txt docs! */
+	/* No oid_array_sort() here! See sha1-array.h */
 
 	for (i = 0; i < array->nr; i++) {
 		int ret = fn(array->oid + i, data);
diff --git a/sha1-array.h b/sha1-array.h
index 55d016c4bf..dc1bca9c9a 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -1,6 +1,52 @@
 #ifndef SHA1_ARRAY_H
 #define SHA1_ARRAY_H
 
+/**
+ * The API provides storage and manipulation of sets of object identifiers.
+ * The emphasis is on storage and processing efficiency, making them suitable
+ * for large lists. Note that the ordering of items is not preserved over some
+ * operations.
+ *
+ * Examples
+ * --------
+ * -----------------------------------------
+ * int print_callback(const struct object_id *oid,
+ * 		    void *data)
+ * {
+ * 	printf("%s\n", oid_to_hex(oid));
+ * 	return 0; // always continue
+ * }
+ *
+ * void some_func(void)
+ * {
+ *     struct sha1_array hashes = OID_ARRAY_INIT;
+ *     struct object_id oid;
+ *
+ *     // Read objects into our set
+ *     while (read_object_from_stdin(oid.hash))
+ *         oid_array_append(&hashes, &oid);
+ *
+ *     // Check if some objects are in our set
+ *     while (read_object_from_stdin(oid.hash)) {
+ *         if (oid_array_lookup(&hashes, &oid) >= 0)
+ *             printf("it's in there!\n");
+ *
+ *          // Print the unique set of objects. We could also have
+ *          // avoided adding duplicate objects in the first place,
+ *          // but we would end up re-sorting the array repeatedly.
+ *          // Instead, this will sort once and then skip duplicates
+ *          // in linear time.
+ *
+ *         oid_array_for_each_unique(&hashes, print_callback, NULL);
+ *     }
+ */
+
+/**
+ * A single array of object IDs. This should be initialized by assignment from
+ * `OID_ARRAY_INIT`. The `oid` member contains the actual data. The `nr` member
+ * contains the number of items in the set. The `alloc` and `sorted` members
+ * are used internally, and should not be needed by API callers.
+ */
 struct oid_array {
 	struct object_id *oid;
 	int nr;
@@ -10,18 +56,52 @@ struct oid_array {
 
 #define OID_ARRAY_INIT { NULL, 0, 0, 0 }
 
+/**
+ * Add an item to the set. The object ID will be placed at the end of the array
+ * (but note that some operations below may lose this ordering).
+ */
 void oid_array_append(struct oid_array *array, const struct object_id *oid);
+
+/**
+ * Perform a binary search of the array for a specific object ID. If found,
+ * returns the offset (in number of elements) of the object ID. If not found,
+ * returns a negative integer. If the array is not sorted, this function has
+ * the side effect of sorting it.
+ */
 int oid_array_lookup(struct oid_array *array, const struct object_id *oid);
+
+/**
+ * Free all memory associated with the array and return it to the initial,
+ * empty state.
+ */
 void oid_array_clear(struct oid_array *array);
 
 typedef int (*for_each_oid_fn)(const struct object_id *oid,
 			       void *data);
+/**
+ * Iterate over each element of the list, executing the callback function for
+ * each one. Does not sort the list, so any custom hash order is retained.
+ * If the callback returns a non-zero value, the iteration ends immediately
+ * and the callback's return is propagated; otherwise, 0 is returned.
+ */
 int oid_array_for_each(struct oid_array *array,
 		       for_each_oid_fn fn,
 		       void *data);
+
+/**
+ * Iterate over each unique element of the list in sorted order, but otherwise
+ * behave like `oid_array_for_each`. If the array is not sorted, this function
+ * has the side effect of sorting it.
+ */
 int oid_array_for_each_unique(struct oid_array *array,
 			      for_each_oid_fn fn,
 			      void *data);
+
+/**
+ * Apply the callback function `want` to each entry in the array, retaining
+ * only the entries for which the function returns true. Preserve the order
+ * of the entries that are retained.
+ */
 void oid_array_filter(struct oid_array *array,
 		      for_each_oid_fn want,
 		      void *cbdata);
-- 
gitgitgadget

