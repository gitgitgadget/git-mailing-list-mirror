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
	by dcvr.yhbt.net (Postfix) with ESMTP id 197541F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 10:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfJ2KAz (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 06:00:55 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:36049 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfJ2KAy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 06:00:54 -0400
Received: by mail-wr1-f52.google.com with SMTP id w18so12932826wrt.3
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 03:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xXawFyU7upXqvr/vbNOTWiN1EjDFS8qw9umHTjSIxS0=;
        b=OIERy2immGmj7l3nrj81nAfixMZcIzxIC3d2ZssEnSc+XfBJsUd3BtNg7x6acKajL+
         KkFyvGGShFPxewOrzxmNnwBv54TFS5fntuhzLlBA8slURde5xrXZUL1t7lwIriS7Z34C
         ortVMZeSR08qFG2KhucNtQeU5h3gVkcqVidRYRuu82kN1pr0hk16K6sSmdvwIdA7eQ73
         32qEDcp44wwXl0IH9jCGr0EF4WgoJ08u6QuOTIjBYZUFPb00q14xlRjdGeJsUm7JuqId
         qW16mwi1tx0afeS6PFmFWw4mniOtscWmzyLf4JTlxQYmg536T+5XnxGonGPOJTjLjb8V
         Yx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xXawFyU7upXqvr/vbNOTWiN1EjDFS8qw9umHTjSIxS0=;
        b=Ww1Yre38C3cKiofacgwT4SSwaOw5Fiy6PXrmc7QGelJIhQTxvymFJVbB9hIJrUUIW7
         YjoYMCjOvvcWXKbl5iwv4tH8TuACn4Kct6DmC2Oa9p1ur6pfm3MB5uj9/ojLTeQ0S1OB
         xGVlZCIZrID0JLe/RBUHVUugUZc2t90BIEotKWFot0i1irhXOehJbo1jtg7No6F7JGO6
         0tg5HWyuqiGewgqiORkv4ZXg7HTQrs0iQTPz++nRc7LvXMAZIoBoPdQoO8jgxdEh3I3+
         cJ4H/Dsq+IbqaMf6TaGLH08MFLEdAOBXfjQUMPgUD1KmAD6h8WQ+3YZ8MotqhBX5v8hU
         Di0Q==
X-Gm-Message-State: APjAAAWYEofDGxyEa/urUyDmPPfKITEMBE3ba5MNkCXEzvZsojaXVVEZ
        VML+qJnxBADGG1lBttNhMUxiFF5Y
X-Google-Smtp-Source: APXvYqx5xx224VsFQd8I0M9gAt9LLLsjn7Uhv81XhFLHTwp/9wk7iAZ8iIb3gtn/YCeEXXeA4vuMUQ==
X-Received: by 2002:adf:e850:: with SMTP id d16mr18275837wrn.251.1572343251963;
        Tue, 29 Oct 2019 03:00:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p13sm2362804wma.41.2019.10.29.03.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 03:00:51 -0700 (PDT)
Message-Id: <4302bdd13fcd5e6108c54c983397b0fa4949e2fa.1572343246.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.git.1572343246.gitgitgadget@gmail.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Oct 2019 10:00:41 +0000
Subject: [PATCH 05/10] sha1-array: move doc to sha1-array.h
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
 sha1-array.h                              | 80 ++++++++++++++++++++
 2 files changed, 80 insertions(+), 90 deletions(-)
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

