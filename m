Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A6B41F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 21:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbfJVVW5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 17:22:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56225 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731573AbfJVVW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 17:22:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id g24so9719419wmh.5
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9kNZQGCWw/R8JVwWnx9+nrCyvL3x70D6s0SJtPvoUJ0=;
        b=Z/r2GVZiyIqVBGFl/hZZ0sxHbH7J8J14ICsn4PokRjYluQB8y/bfp4PdiMjEvTifZO
         /eNpBzutk2TqgkuKTT1XqXKk/2Q4OZpA+oAtTOIaMbvTlzK4ryVgyRCFssDUbUgCLDja
         wOaiHJH3Q9nx+0LXZRvOSpkr+YQJy9TKagh/dPqmHs6FwZYcI5GgdrWDBqsuTAbua7lk
         An14J851xzIoAbbpp7i43+hQKqCs8ufUjcWTIfV1bsMorsFGjpzA7oFitD7O2Czi7jBO
         spe8P/lsqJZcgZRm+RmFbaWBZLR9Czefs+scaGjJB+/XWgNWFOpNZlqaY367GxI64ecS
         xrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9kNZQGCWw/R8JVwWnx9+nrCyvL3x70D6s0SJtPvoUJ0=;
        b=PctBsods+aohWQ/kWX0nSPkNiI65O+m67Ro3wX9KOINyrx2WrYW7AbGG+8jbsROXBT
         7Jc0HqFrlIaqHc7VFeNChSgq3+PQgEXOskTaJ3QTukSCM0Se0DZ9cY7v4hPG6ocZM0RA
         0s8y4u72/zL6apURcRD/UBKi7kfXrqO6phCWew9plUuG4lretaKf6Hu8T1i1he7WUrb7
         Plhq19bFFp3/IDlcBFjuFisdxR3/TPY0fLfwogrg8s9xLU+kzFy+5/WNoqd6SHx+fvGu
         nPzl/cYyEY4GGip4EYYivlb5wnSTYnEghkf/lCIG3mD9dWwU0bk83BQOxSyKACL0W61o
         YDzw==
X-Gm-Message-State: APjAAAVna5dtLThJG2HxapwIJWQdQ/y2sQRySnAeAZLvBz5ZCT53cEk4
        mxR+YnuPvxChiu4E4UprHeP6t8d7
X-Google-Smtp-Source: APXvYqzFupeHYIBftO1XkQ+UIkVM6hwUgcErbmtCxGtx/Suv7EBLzu9IOamXOtv2UE9JdAXtgP/sgQ==
X-Received: by 2002:a1c:5946:: with SMTP id n67mr4935732wmb.93.1571779373543;
        Tue, 22 Oct 2019 14:22:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7sm13316693wre.59.2019.10.22.14.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 14:22:53 -0700 (PDT)
Message-Id: <8ae78679c9066a206610465e1da91a5f575fced2.1571779371.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.390.v2.git.1571779371.gitgitgadget@gmail.com>
References: <pull.390.git.gitgitgadget@gmail.com>
        <pull.390.v2.git.1571779371.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Oct 2019 21:22:49 +0000
Subject: [PATCH v2 1/3] merge-recursive: clean up get_renamed_dir_portion()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin Johannes.Schindelin@gmx.de,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     Johannes Schindelin Johannes.Schindelin@gmx.de
                        ^                           ^-missing end of address
                 \-extraneous tokens in address
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Dscho noted a few things making this function hard to follow.
Restructure it a bit and add comments to make it easier to follow.  The
restructurings include:

  * There was a special case if-check at the end of the function
    checking whether someone just renamed a file within its original
    directory, meaning that there could be no directory rename involved.
    That check was slightly convoluted; it could be done in a more
    straightforward fashion earlier in the function, and can be done
    more cheaply too (no call to strncmp).

  * The conditions for advancing end_of_old and end_of_new before
    calling strchr were both confusing and unnecessary.  If either
    points at a '/', then they need to be advanced in order to find the
    next '/'.  If either doesn't point at a '/', then advancing them one
    char before calling strchr() doesn't hurt.  So, just rip out the
    if conditions and advance both before calling strchr().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 60 ++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 22a12cfeba..f80e48f623 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1943,8 +1943,8 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 				    char **old_dir, char **new_dir)
 {
 	char *end_of_old, *end_of_new;
-	int old_len, new_len;
 
+	/* Default return values: NULL, meaning no rename */
 	*old_dir = NULL;
 	*new_dir = NULL;
 
@@ -1955,43 +1955,55 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 	 *    "a/b/c/d" was renamed to "a/b/some/thing/else"
 	 * so, for this example, this function returns "a/b/c/d" in
 	 * *old_dir and "a/b/some/thing/else" in *new_dir.
-	 *
-	 * Also, if the basename of the file changed, we don't care.  We
-	 * want to know which portion of the directory, if any, changed.
+	 */
+
+	/*
+	 * If the basename of the file changed, we don't care.  We want
+	 * to know which portion of the directory, if any, changed.
 	 */
 	end_of_old = strrchr(old_path, '/');
 	end_of_new = strrchr(new_path, '/');
-
 	if (end_of_old == NULL || end_of_new == NULL)
-		return;
+		return; /* We haven't modified *old_dir or *new_dir yet. */
+
+	/* Find the first non-matching character traversing backwards */
 	while (*--end_of_new == *--end_of_old &&
 	       end_of_old != old_path &&
 	       end_of_new != new_path)
 		; /* Do nothing; all in the while loop */
+
 	/*
-	 * We've found the first non-matching character in the directory
-	 * paths.  That means the current directory we were comparing
-	 * represents the rename.  Move end_of_old and end_of_new back
-	 * to the full directory name.
+	 * If both got back to the beginning of their strings, then the
+	 * directory didn't change at all, only the basename did.
 	 */
-	if (*end_of_old == '/')
-		end_of_old++;
-	if (*end_of_old != '/')
-		end_of_new++;
-	end_of_old = strchr(end_of_old, '/');
-	end_of_new = strchr(end_of_new, '/');
+	if (end_of_old == old_path && end_of_new == new_path &&
+	    *end_of_old == *end_of_new)
+		return; /* We haven't modified *old_dir or *new_dir yet. */
 
 	/*
-	 * It may have been the case that old_path and new_path were the same
-	 * directory all along.  Don't claim a rename if they're the same.
+	 * We've found the first non-matching character in the directory
+	 * paths.  That means the current characters we were looking at
+	 * were part of the first non-matching subdir name going back from
+	 * the end of the strings.  Get the whole name by advancing both
+	 * end_of_old and end_of_new to the NEXT '/' character.  That will
+	 * represent the entire directory rename.
+	 *
+	 * The reason for the increment is cases like
+	 *    a/b/star/foo/whatever.c -> a/b/tar/foo/random.c
+	 * After dropping the basename and going back to the first
+	 * non-matching character, we're now comparing:
+	 *    a/b/s          and         a/b/
+	 * and we want to be comparing:
+	 *    a/b/star/      and         a/b/tar/
+	 * but without the pre-increment, the one on the right would stay
+	 * a/b/.
 	 */
-	old_len = end_of_old - old_path;
-	new_len = end_of_new - new_path;
+	end_of_old = strchr(++end_of_old, '/');
+	end_of_new = strchr(++end_of_new, '/');
 
-	if (old_len != new_len || strncmp(old_path, new_path, old_len)) {
-		*old_dir = xstrndup(old_path, old_len);
-		*new_dir = xstrndup(new_path, new_len);
-	}
+	/* Copy the old and new directories into *old_dir and *new_dir. */
+	*old_dir = xstrndup(old_path, end_of_old - old_path);
+	*new_dir = xstrndup(new_path, end_of_new - new_path);
 }
 
 static void remove_hashmap_entries(struct hashmap *dir_renames,
-- 
gitgitgadget

