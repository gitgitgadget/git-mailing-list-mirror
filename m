Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5361F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 21:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfKQVFK (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 16:05:10 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:35003 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfKQVFK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 16:05:10 -0500
Received: by mail-wm1-f47.google.com with SMTP id 8so16584949wmo.0
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 13:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iRvzqtmL1dYexd8wCBWkeRx0V9T+hV0iCcpE5uXRCAA=;
        b=QZUsusiJt1UtljXjcBW617BZErmo5G0OsgPAqLf+9k9lHPKyaL9QIshmGfy/Cqxkq+
         wgEmmYVGpCybhX/+5dNx+2DqeQ/RE8UDByKjHwCZa6eFmBXaMJMD1YrPPfxFfgB2NVEz
         RQXpgvgdHPfyvkMf+uZRAfiDfJjTGWMP6xiL31rwN3r8atpDMzmvtK1hR97HdvQ2q3bE
         em4zGYzETm6brtf/T1g78boCF7uV1TTZuA+cdADVySPsEmLcvFUI3KTPTbZZUnskH9nd
         NBi+ss+Cm2f+h6jyVhJmQgC1IrjYpy1kVn8lHjwvCN7QgqRiDUT/6vcDyBZVf9naEUAa
         Em5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iRvzqtmL1dYexd8wCBWkeRx0V9T+hV0iCcpE5uXRCAA=;
        b=s19n/lTvK/sDaGLZnOiIOsWI1zlS8hTOh0FSEOy0cryPivflHPHkUZtv7t+HsAsdnH
         JIX4ipFZ9KDRJjzayN/KMK0xL89VpQC6h8HWU6qAc69buPaZ6YuDHJh0HJhR0hDnDU1j
         3tng8yzqzaqrYpvOybsLScUGPR+1ai5zv2+uLqrCKBYwPPtMDLUdw+H2II7zaX5Shvrk
         T7V7pqEw+hhrM+J/3nVVDVaO486FetZxEC9q7ht819Wnv61dwiyn/vl7Y5DsvkSakVC3
         StKVvaBpLV+OgRQAXo8JMefR12Z8zroRvWHfDG4s2dEhO9wC66xVta8B2z2rB7txGUUU
         uV5Q==
X-Gm-Message-State: APjAAAXz1i61whsUoRGqosL4lPdwnIJkEbstsn9Ug2cNsJMvhYrzjsrh
        lNjFzkXCrBP50y2AD/oegqhISZH5
X-Google-Smtp-Source: APXvYqx7zHEi+ifF+YEPoiufTpORkzmYAELoLmshl9PxM2+bgnzXZfSMk+RQOsEqCZe++U7rdmO98w==
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr26093156wmg.117.1574024706278;
        Sun, 17 Nov 2019 13:05:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k14sm21285118wrw.46.2019.11.17.13.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 13:05:05 -0800 (PST)
Message-Id: <a76a2e2244a01e1802aa5eda0aaeaf082c33ace8.1574024700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
References: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
        <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 21:04:44 +0000
Subject: [PATCH v5 05/21] sha1-array: move doc to sha1-array.h
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

