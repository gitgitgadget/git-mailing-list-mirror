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
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A471F454
	for <e@80x24.org>; Tue,  5 Nov 2019 17:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390415AbfKERHs (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 12:07:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37626 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390380AbfKERHr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 12:07:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id q130so83938wme.2
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 09:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nKJb+DppGQs/TP6qP+SpjUq++9QyhHJS9c1xDYvI6U4=;
        b=mgGkQId9VoYBUenBVM3DeV+pdpqvT291ykXrlMNl+zgFrn0JkXN9fIJjYALhH8sUI6
         DM6tUbV4LiySWz6bd7Lpos6cv9Lho8j10UEbItjYGbNRtIuVJWMqS8Dqz7I87ClSttHn
         K0Ze9l7N2SiQQxW5MkUFJqMQy+SMWGm/0jOYmvJKF8glida2td3dfBodkjoHKB8TNwnJ
         6bDZfTCnv9K3ldDk7uiQ4swkVXwF94o7LzgcLDQo7vqNNSquYXCGkUq8RiAtArO2uQtl
         b0vTXHSebv+coOSlQvP4XEkQLWVjvGh4rYyRpC/06zovx74VFwzFmp8xHQIa84qPqvyA
         fL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nKJb+DppGQs/TP6qP+SpjUq++9QyhHJS9c1xDYvI6U4=;
        b=NujKwmzEInaIYZ0xbvTdZKlXDsmcZ+m6uEkI26z/7lXLXMwuz9RLyEYNK1fBrNIupx
         5My/f9f6DpD8kyulkwSYgUS4rjj9S47lAOQAvJfhHrQh87zwBpy2dPP4C/EUUK1NVJte
         1+nfPZsLNazxD6zOk4vyGVbAe9/AwBIWySjWlbw8TJMZox8rDn3FKZKljvN5ul8qMV+S
         sl3k4w6jZ4G/qy6iefySh6sivdVZEGiywZuzl19UQa+1z9h1T7iUu2rQoeEQ8hU9Nx78
         2OoiN3fhRdnaaU6i1DDDmqekCxr2D4b9kxDARFt1vgh5JAkSco26PLVP1cWObA+gffG+
         KRrg==
X-Gm-Message-State: APjAAAXmxvyr2mGGsRgcJbLcW/pWce4jYMMiZGBifHP18dLNDMOcO27g
        d4IwfWwWmEBMhqyvNOs5BKxuwY0n
X-Google-Smtp-Source: APXvYqzCJPvfbVwxPuw6bHhsXCr31BhF9TRoy1VTVIpMcUyIS1B8RlYigOj5v7krhgEQTDmxVeKqyg==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr20091wmd.176.1572973663541;
        Tue, 05 Nov 2019 09:07:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d20sm34590790wra.4.2019.11.05.09.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 09:07:43 -0800 (PST)
Message-Id: <126faae60f67232bc214e3ee369e24922a881360.1572973653.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
References: <pull.418.git.1571790574.gitgitgadget@gmail.com>
        <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 17:07:30 +0000
Subject: [PATCH v2 11/11] Fix spelling errors in
 no-longer-updated-from-upstream modules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We have several modules originally taken from some upstream source,
and which as far as I can tell we no longer update from the upstream
anymore.  As such, I have not submitted these spelling fixes to any
external projects but just include them directly here.

Reported-by: Jens Schleusener <Jens.Schleusener@fossies.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 compat/nedmalloc/malloc.c.h                     | 6 +++---
 compat/obstack.h                                | 2 +-
 compat/regex/regcomp.c                          | 2 +-
 compat/regex/regex.h                            | 2 +-
 compat/regex/regex_internal.c                   | 2 +-
 compat/regex/regexec.c                          | 4 ++--
 contrib/mw-to-git/.perlcriticrc                 | 2 +-
 contrib/mw-to-git/git-remote-mediawiki.perl     | 2 +-
 contrib/mw-to-git/t/install-wiki/db_install.php | 2 +-
 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh    | 2 +-
 contrib/mw-to-git/t/test-gitmw-lib.sh           | 2 +-
 11 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index 9134349590..814845d4b3 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -1564,7 +1564,7 @@ static FORCEINLINE void* win32direct_mmap(size_t size) {
   return (ptr != 0)? ptr: MFAIL;
 }
 
-/* This function supports releasing coalesed segments */
+/* This function supports releasing coalesced segments */
 static FORCEINLINE int win32munmap(void* ptr, size_t size) {
   MEMORY_BASIC_INFORMATION minfo;
   char* cptr = (char*)ptr;
@@ -1655,7 +1655,7 @@ static FORCEINLINE int win32munmap(void* ptr, size_t size) {
     #define CALL_MREMAP(addr, osz, nsz, mv)     MFAIL
 #endif /* HAVE_MMAP && HAVE_MREMAP */
 
-/* mstate bit set if continguous morecore disabled or failed */
+/* mstate bit set if contiguous morecore disabled or failed */
 #define USE_NONCONTIGUOUS_BIT (4U)
 
 /* segment bit set in create_mspace_with_base */
@@ -2485,7 +2485,7 @@ typedef struct malloc_segment* msegmentptr;
 
   Trim support
     Fields holding the amount of unused topmost memory that should trigger
-    timming, and a counter to force periodic scanning to release unused
+    timing, and a counter to force periodic scanning to release unused
     non-topmost segments.
 
   Locking
diff --git a/compat/obstack.h b/compat/obstack.h
index ae36ed6a66..01e7c81840 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -79,7 +79,7 @@ change its address during its lifetime.
 When the chars burst over a chunk boundary, we allocate a larger
 chunk, and then copy the partly formed object from the end of the old
 chunk to the beginning of the new larger chunk.  We then carry on
-accreting characters to the end of the object as we normally would.
+accrediting characters to the end of the object as we normally would.
 
 A special macro is provided to add a single char at a time to a
 growing object.  This allows the use of register variables, which
diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index c0d838834a..d1bc09e49b 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -3462,7 +3462,7 @@ build_equiv_class (bitset_t sbcset, const unsigned char *name)
 	/* This isn't a valid character.  */
 	return REG_ECOLLATE;
 
-      /* Build single byte matcing table for this equivalence class.  */
+      /* Build single byte matching table for this equivalence class.  */
       char_buf[1] = (unsigned char) '\0';
       len = weights[idx1 & 0xffffff];
       for (ch = 0; ch < SBC_MAX; ++ch)
diff --git a/compat/regex/regex.h b/compat/regex/regex.h
index 4d81358a83..08a2609663 100644
--- a/compat/regex/regex.h
+++ b/compat/regex/regex.h
@@ -322,7 +322,7 @@ typedef enum
   /* POSIX regcomp return error codes.  (In the order listed in the
      standard.)  */
   REG_BADPAT,		/* Invalid pattern.  */
-  REG_ECOLLATE,		/* Inalid collating element.  */
+  REG_ECOLLATE,		/* Invalid collating element.  */
   REG_ECTYPE,		/* Invalid character class name.  */
   REG_EESCAPE,		/* Trailing backslash.  */
   REG_ESUBREG,		/* Invalid back reference.  */
diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
index 59bf151336..ec51cf3446 100644
--- a/compat/regex/regex_internal.c
+++ b/compat/regex/regex_internal.c
@@ -1616,7 +1616,7 @@ free_state (re_dfastate_t *state)
   re_free (state);
 }
 
-/* Create the new state which is independ of contexts.
+/* Create the new state which is independent of contexts.
    Return the new state if succeeded, otherwise return NULL.  */
 
 static re_dfastate_t *
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index 1b5d89fd5e..49358ae475 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -2420,7 +2420,7 @@ find_recover_state (reg_errcode_t *err, re_match_context_t *mctx)
 /* From the node set CUR_NODES, pick up the nodes whose types are
    OP_OPEN_SUBEXP and which have corresponding back references in the regular
    expression. And register them to use them later for evaluating the
-   correspoding back references.  */
+   corresponding back references.  */
 
 static reg_errcode_t
 internal_function
@@ -3347,7 +3347,7 @@ build_trtable (const re_dfa_t *dfa, re_dfastate_t *state)
   dests_node = dests_alloc->dests_node;
   dests_ch = dests_alloc->dests_ch;
 
-  /* Initialize transiton table.  */
+  /* Initialize transition table.  */
   state->word_trtable = state->trtable = NULL;
 
   /* At first, group all nodes belonging to `state' into several
diff --git a/contrib/mw-to-git/.perlcriticrc b/contrib/mw-to-git/.perlcriticrc
index 158958d363..b7333267ad 100644
--- a/contrib/mw-to-git/.perlcriticrc
+++ b/contrib/mw-to-git/.perlcriticrc
@@ -14,7 +14,7 @@
 
 # This rule states that each system call should have its return value checked
 # The problem is that it includes the print call. Checking every print call's
-# return value would be harmful to the code readabilty.
+# return value would be harmful to the code readability.
 # This configuration keeps all default function but print.
 [InputOutput::RequireCheckedSyscalls]
 functions = open say close
diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index af9cbc9d0f..d8ff2e69c4 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -79,7 +79,7 @@
 $export_media = !($export_media eq 'false');
 
 my $wiki_login = run_git("config --get remote.${remotename}.mwLogin");
-# Note: mwPassword is discourraged. Use the credential system instead.
+# Note: mwPassword is discouraged. Use the credential system instead.
 my $wiki_passwd = run_git("config --get remote.${remotename}.mwPassword");
 my $wiki_domain = run_git("config --get remote.${remotename}.mwDomain");
 chomp($wiki_login);
diff --git a/contrib/mw-to-git/t/install-wiki/db_install.php b/contrib/mw-to-git/t/install-wiki/db_install.php
index 0f3f4e018a..b033849800 100644
--- a/contrib/mw-to-git/t/install-wiki/db_install.php
+++ b/contrib/mw-to-git/t/install-wiki/db_install.php
@@ -24,7 +24,7 @@ $url = 'http://localhost:'.$port.'/wiki/mw-config/index.php';
 $db_dir = urlencode($tmp);
 $tmp_cookie = tempnam($tmp, "COOKIE_");
 /*
- * Fetchs a page with cURL.
+ * Fetches a page with cURL.
  */
 function get($page_name = "") {
 	$curl = curl_init();
diff --git a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
index cfbfe7ddf6..9106833578 100755
--- a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
+++ b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
@@ -143,7 +143,7 @@ test_expect_success 'Git clone works with one specific page cloned ' '
 test_expect_success 'Git clone works with multiple specific page cloned ' '
 	wiki_reset &&
 	wiki_editpage foo "I will be there" false &&
-	wiki_editpage bar "I will not disapear" false &&
+	wiki_editpage bar "I will not disappear" false &&
 	wiki_editpage namnam "I be erased" false &&
 	wiki_editpage nyancat "nyan nyan nyan you will not erase me" false &&
 	wiki_delete_page namnam &&
diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/t/test-gitmw-lib.sh
index 6546294f15..3948a00282 100755
--- a/contrib/mw-to-git/t/test-gitmw-lib.sh
+++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
@@ -279,7 +279,7 @@ start_lighttpd () {
 	"$LIGHTTPD_DIR"/lighttpd -f "$WEB"/lighttpd.conf
 
 	if test $? -ne 0 ; then
-		echo "Could not execute http deamon lighttpd"
+		echo "Could not execute http daemon lighttpd"
 		exit 1
 	fi
 }
-- 
gitgitgadget
