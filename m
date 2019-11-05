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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F0BC1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 17:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390348AbfKERHm (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 12:07:42 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:50231 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388177AbfKERHl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 12:07:41 -0500
Received: by mail-wm1-f50.google.com with SMTP id 11so106436wmk.0
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 09:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cghIAECVa7UHcNV2CAM+pPVRuC28dQFDn7U/NiCrpN8=;
        b=NEzpkZ5l3nqYCNzOeMOZcYygmEPDcH6m9/WkZMWAjazjlQgQkmShX7aaPdxofGpz4l
         e/Ums+pweRXd5lLmIfDfPDThH1m9PABDD+XRVihnImsDBk8uld1P19X5w9ulHkCBiURe
         SFIzUXn1bU5H0CSumNk+/blHNFu/ej46quDeMB0a3NWPxExtiI9h1T0qYixDTH78L7iT
         gODGJjQgsB5gMMJnNfk5wP7fQOcLvpfRJuL7su0ftez3Uz8PPzhTR3c2dd1GaX+GMEWq
         NZ2TvLKf6sKiGETDIjsfkL6sPTXtcVY7URBrtDBuSBhhsha724+uvpMc8iklGZwRqFX6
         GYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cghIAECVa7UHcNV2CAM+pPVRuC28dQFDn7U/NiCrpN8=;
        b=Eqk6Sce1/QRp1/f2wwyUZKjF1UrrgKm3bsB2XTLq5jUNMt7NTK6bKdlrJ2Bwckw/fU
         nFriRbdlR+AsTpve80VxI1yn8Bn2YqM+dy/mp3SAaZu99dIUEKjCCAKi8crFmi26PQyy
         4ORFASFPTR2ZQaMrRgqr6pgOBrt/sws17HvjXfZ1CVweo5bNqE6OBuX0S5rOotpduJRf
         eAl1K3GL0U4dGUUSZS0yhUWhqD0MWQkL2sI/yU14+9Q8Io8ZxnVcbxqacAuujFumobmi
         cDXg4jYUhBYi0DVG7pVUGP9WjokHmOAExT2KAEf8g88ohEoJrvP4gSoK6sFQR6osczyA
         twQg==
X-Gm-Message-State: APjAAAUID/8DZRUBOY7bWQHvbFB+HezWOu4zZbLisbXeFDH7ERFxjSBt
        NzTq7zUIh9UStHfTqXg13VfHXQSb
X-Google-Smtp-Source: APXvYqyLFWdhNYjT9KTmOiI3MGBAFlL2yYlCZHj7b0PQdl4CWnNx5NA4SNUd7Fi4DbgXCvTfOUJK8g==
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr17184wme.1.1572973658250;
        Tue, 05 Nov 2019 09:07:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 16sm446396wmf.0.2019.11.05.09.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 09:07:37 -0800 (PST)
Message-Id: <3f2f8e9a70024db0820c3eba080f2e0db93841ec.1572973651.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
References: <pull.418.git.1571790574.gitgitgadget@gmail.com>
        <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 17:07:23 +0000
Subject: [PATCH v2 04/11] Fix spelling errors in code comments
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

Reported-by: Jens Schleusener <Jens.Schleusener@fossies.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 apply.c                                |  4 ++--
 builtin/fetch.c                        |  2 +-
 builtin/gc.c                           |  4 ++--
 builtin/pack-objects.c                 |  2 +-
 commit-graph.c                         |  2 +-
 commit.h                               |  2 +-
 compat/mingw.h                         |  2 +-
 compat/vcbuild/find_vs_env.bat         |  2 +-
 configure.ac                           |  2 +-
 contrib/coccinelle/commit.cocci        |  2 +-
 contrib/completion/git-completion.bash |  4 ++--
 contrib/hooks/post-receive-email       |  2 +-
 convert.c                              |  2 +-
 daemon.c                               |  4 ++--
 diff.c                                 |  4 ++--
 dir.c                                  |  2 +-
 git-send-email.perl                    |  2 +-
 gitweb/gitweb.perl                     | 18 +++++++++---------
 hashmap.c                              |  2 +-
 hashmap.h                              |  2 +-
 name-hash.c                            |  2 +-
 parse-options.c                        |  2 +-
 range-diff.h                           |  2 +-
 read-cache.c                           |  2 +-
 refs/refs-internal.h                   |  2 +-
 repository.c                           |  4 ++--
 repository.h                           |  2 +-
 rerere.c                               |  2 +-
 sequencer.c                            |  6 +++---
 server-info.c                          |  2 +-
 string-list.h                          |  2 +-
 trace2/tr2_sid.c                       |  2 +-
 unpack-trees.c                         |  4 ++--
 url.c                                  |  2 +-
 xdiff-interface.h                      |  2 +-
 35 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/apply.c b/apply.c
index f8a046a6a5..bd80eefad0 100644
--- a/apply.c
+++ b/apply.c
@@ -4183,8 +4183,8 @@ static void show_rename_copy(struct patch *p)
 		old_name = slash_old + 1;
 		new_name = slash_new + 1;
 	}
-	/* p->old_name thru old_name is the common prefix, and old_name and new_name
-	 * through the end of names are renames
+	/* p->old_name through old_name is the common prefix, and old_name and
+	 * new_name through the end of names are renames
 	 */
 	if (old_name != p->old_name)
 		printf(" %s %.*s{%s => %s} (%d%%)\n", renamecopy,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index d597fa5be0..93d378c72f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1400,7 +1400,7 @@ static int do_fetch(struct transport *transport,
 
 		/*
 		 * We're setting the upstream configuration for the
-		 * current branch. The relevent upstream is the
+		 * current branch. The relevant upstream is the
 		 * fetched branch that is meant to be merged with the
 		 * current one, i.e. the one fetched to FETCH_HEAD.
 		 *
diff --git a/builtin/gc.c b/builtin/gc.c
index fadb45489f..3f76bf4aa7 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -458,7 +458,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 /*
  * Returns 0 if there was no previous error and gc can proceed, 1 if
  * gc should not proceed due to an error in the last run. Prints a
- * message and returns -1 if an error occured while reading gc.log
+ * message and returns -1 if an error occurred while reading gc.log
  */
 static int report_last_gc_error(void)
 {
@@ -601,7 +601,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		if (detach_auto) {
 			int ret = report_last_gc_error();
 			if (ret < 0)
-				/* an I/O error occured, already reported */
+				/* an I/O error occurred, already reported */
 				exit(128);
 			if (ret == 1)
 				/* Last gc --auto failed. Skip this one. */
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5876583220..393c20a2d7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -163,7 +163,7 @@ static void *get_delta(struct object_entry *entry)
 	delta_buf = diff_delta(base_buf, base_size,
 			       buf, size, &delta_size, 0);
 	/*
-	 * We succesfully computed this delta once but dropped it for
+	 * We successfully computed this delta once but dropped it for
 	 * memory reasons. Something is very wrong if this time we
 	 * recompute and create a different delta.
 	 */
diff --git a/commit-graph.c b/commit-graph.c
index 0aea7b2ae5..3eb9bcdc8e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -464,7 +464,7 @@ static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
 /*
  * Return 1 if commit_graph is non-NULL, and 0 otherwise.
  *
- * On the first invocation, this function attemps to load the commit
+ * On the first invocation, this function attempts to load the commit
  * graph if the_repository is configured to have one.
  */
 static int prepare_commit_graph(struct repository *r)
diff --git a/commit.h b/commit.h
index f5295ca7f3..221cdaa34b 100644
--- a/commit.h
+++ b/commit.h
@@ -132,7 +132,7 @@ const void *repo_get_commit_buffer(struct repository *r,
 #endif
 
 /*
- * Tell the commit subsytem that we are done with a particular commit buffer.
+ * Tell the commit subsystem that we are done with a particular commit buffer.
  * The commit and buffer should be the input and return value, respectively,
  * from an earlier call to get_commit_buffer.  The buffer may or may not be
  * freed by this call; callers should not access the memory afterwards.
diff --git a/compat/mingw.h b/compat/mingw.h
index 9ad204c57c..1a46334399 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -558,7 +558,7 @@ int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen);
 
 /*
  * A critical section used in the implementation of the spawn
- * functions (mingw_spawnv[p]e()) and waitpid(). Intialised in
+ * functions (mingw_spawnv[p]e()) and waitpid(). Initialised in
  * the replacement main() macro below.
  */
 extern CRITICAL_SECTION pinfo_cs;
diff --git a/compat/vcbuild/find_vs_env.bat b/compat/vcbuild/find_vs_env.bat
index 40194dd230..b35d264c0e 100644
--- a/compat/vcbuild/find_vs_env.bat
+++ b/compat/vcbuild/find_vs_env.bat
@@ -18,7 +18,7 @@ REM and MAKE, we must blend these two different worlds.  This script
 REM attempts to do that.
 REM ================================================================
 REM This BAT file starts in a plain (non-developer) command prompt,
-REM searches for the "best" commmand prompt setup script, installs
+REM searches for the "best" command prompt setup script, installs
 REM it into the current CMD process, and exports the various MSVC
 REM environment variables for use by MAKE.
 REM
diff --git a/configure.ac b/configure.ac
index a43b476402..4d32d5e432 100644
--- a/configure.ac
+++ b/configure.ac
@@ -85,7 +85,7 @@ AC_DEFUN([GIT_PARSE_WITH],
 
 # GIT_PARSE_WITH_SET_MAKE_VAR(WITHNAME, VAR, HELP_TEXT)
 # -----------------------------------------------------
-# Set VAR to the value specied by --with-WITHNAME.
+# Set VAR to the value specified by --with-WITHNAME.
 # No verification of arguments is performed, but warnings are issued
 # if either 'yes' or 'no' is specified.
 # HELP_TEXT is presented when --help is called.
diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
index d03453341e..778e4704f6 100644
--- a/contrib/coccinelle/commit.cocci
+++ b/contrib/coccinelle/commit.cocci
@@ -20,7 +20,7 @@ expression s;
 + set_commit_tree(c, s)
   ...>}
 
-// These excluded functions must access c->maybe_tree direcly.
+// These excluded functions must access c->maybe_tree directly.
 // Note that if c->maybe_tree is written somewhere outside of these
 // functions, then the recommended transformation will be bogus with
 // repo_get_commit_tree() on the LHS.
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 00fbe6c03d..47c551091f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -550,7 +550,7 @@ __git_index_files ()
 						 esc_idx, 1)
 			} else if (esc == "n") {
 				# Uh-oh, a newline character.
-				# We cant reliably put a pathname
+				# We cannot reliably put a pathname
 				# containing a newline into COMPREPLY,
 				# and the newline would create a mess.
 				# Skip this path.
@@ -565,7 +565,7 @@ __git_index_files ()
 			}
 		}
 		# Drop closing double quote, if there is one.
-		# (There isnt any if this is a directory, as it was
+		# (There is not any if this is a directory, as it was
 		# already stripped with the trailing path components.)
 		if (substr(p, length(p), 1) == "\"")
 			out = out substr(p, 1, length(p) - 1)
diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 8747b84334..ff565eb3d8 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -329,7 +329,7 @@ generate_update_branch_email()
 	#
 	#  git rev-parse --not --all | grep -v $(git rev-parse $refname)
 	#
-	# Get's us to something pretty safe (apart from the small time
+	# Gets us to something pretty safe (apart from the small time
 	# between refname being read, and git rev-parse running - for that,
 	# I give up)
 	#
diff --git a/convert.c b/convert.c
index 25ac525d5f..8f670085fd 100644
--- a/convert.c
+++ b/convert.c
@@ -418,7 +418,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	if (!dst) {
 		/*
 		 * We could add the blob "as-is" to Git. However, on checkout
-		 * we would try to reencode to the original encoding. This
+		 * we would try to re-encode to the original encoding. This
 		 * would fail and we would leave the user with a messed-up
 		 * working tree. Let's try to avoid this by screaming loud.
 		 */
diff --git a/daemon.c b/daemon.c
index 9d2e0d20ef..fd669ed3b4 100644
--- a/daemon.c
+++ b/daemon.c
@@ -598,7 +598,7 @@ static void canonicalize_client(struct strbuf *out, const char *in)
  * Read the host as supplied by the client connection.
  *
  * Returns a pointer to the character after the NUL byte terminating the host
- * arguemnt, or 'extra_args' if there is no host arguemnt.
+ * argument, or 'extra_args' if there is no host argument.
  */
 static char *parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
 {
@@ -652,7 +652,7 @@ static void parse_extra_args(struct hostinfo *hi, struct argv_array *env,
 		 * service that will be run.
 		 *
 		 * If there ends up being a particular arg in the future that
-		 * git-daemon needs to parse specificly (like the 'host' arg)
+		 * git-daemon needs to parse specifically (like the 'host' arg)
 		 * then it can be parsed here and not added to 'git_protocol'.
 		 */
 		if (*arg) {
diff --git a/diff.c b/diff.c
index afe4400a60..087213466e 100644
--- a/diff.c
+++ b/diff.c
@@ -2551,7 +2551,7 @@ static int scale_linear(int it, int width, int max_change)
 	/*
 	 * make sure that at least one '-' or '+' is printed if
 	 * there is any change to this path. The easiest way is to
-	 * scale linearly as if the alloted width is one column shorter
+	 * scale linearly as if the allotted width is one column shorter
 	 * than it is, and then add 1 to the result.
 	 */
 	return 1 + (it * (width - 1) / max_change);
@@ -3196,7 +3196,7 @@ static int is_conflict_marker(const char *line, int marker_size, unsigned long l
 	for (cnt = 1; cnt < marker_size; cnt++)
 		if (line[cnt] != firstchar)
 			return 0;
-	/* line[1] thru line[marker_size-1] are same as firstchar */
+	/* line[1] through line[marker_size-1] are same as firstchar */
 	if (len < marker_size + 1 || !isspace(line[marker_size]))
 		return 0;
 	return 1;
diff --git a/dir.c b/dir.c
index 61f559f980..9047373f6b 100644
--- a/dir.c
+++ b/dir.c
@@ -2489,7 +2489,7 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 				 * wanted anyway
 				 */
 				continue;
-			/* fall thru */
+			/* fall through */
 		} else if (S_ISDIR(st.st_mode)) {
 			if (!remove_dir_recurse(path, flag, &kept_down))
 				continue; /* happy */
diff --git a/git-send-email.perl b/git-send-email.perl
index 5f92c89c1c..dc95656f75 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1228,7 +1228,7 @@ sub process_address_list {
 # domain name that corresponds the IP address in the HELO/EHLO
 # handshake. This is used to verify the connection and prevent
 # spammers from trying to hide their identity. If the DNS and IP don't
-# match, the receiveing MTA may deny the connection.
+# match, the receiving MTA may deny the connection.
 #
 # Here is a deny example of Net::SMTP with the default "localhost.localdomain"
 #
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7fef19fe59..3d063e2155 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1657,15 +1657,15 @@ sub quot_cec {
 	my $cntrl = shift;
 	my %opts = @_;
 	my %es = ( # character escape codes, aka escape sequences
-		"\t" => '\t',   # tab            (HT)
-		"\n" => '\n',   # line feed      (LF)
-		"\r" => '\r',   # carrige return (CR)
-		"\f" => '\f',   # form feed      (FF)
-		"\b" => '\b',   # backspace      (BS)
-		"\a" => '\a',   # alarm (bell)   (BEL)
-		"\e" => '\e',   # escape         (ESC)
-		"\013" => '\v', # vertical tab   (VT)
-		"\000" => '\0', # nul character  (NUL)
+		"\t" => '\t',   # tab             (HT)
+		"\n" => '\n',   # line feed       (LF)
+		"\r" => '\r',   # carriage return (CR)
+		"\f" => '\f',   # form feed       (FF)
+		"\b" => '\b',   # backspace       (BS)
+		"\a" => '\a',   # alarm (bell)    (BEL)
+		"\e" => '\e',   # escape          (ESC)
+		"\013" => '\v', # vertical tab    (VT)
+		"\000" => '\0', # nul character   (NUL)
 	);
 	my $chr = ( (exists $es{$cntrl})
 		    ? $es{$cntrl}
diff --git a/hashmap.c b/hashmap.c
index 39c13110bc..09813e1a46 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -51,7 +51,7 @@ unsigned int memihash(const void *buf, size_t len)
 }
 
 /*
- * Incoporate another chunk of data into a memihash
+ * Incorporate another chunk of data into a memihash
  * computation.
  */
 unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len)
diff --git a/hashmap.h b/hashmap.h
index bd2701549f..4e03c3ebde 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -502,7 +502,7 @@ static inline void hashmap_disable_item_counting(struct hashmap *map)
 }
 
 /*
- * Re-enable item couting when adding/removing items.
+ * Re-enable item counting when adding/removing items.
  * If counting is currently disabled, it will force count them.
  * It WILL NOT automatically rehash them.
  */
diff --git a/name-hash.c b/name-hash.c
index ceb1d7bd6f..d4fa6ba15f 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -138,7 +138,7 @@ static int lazy_nr_dir_threads;
 
 /*
  * Set a minimum number of cache_entries that we will handle per
- * thread and use that to decide how many threads to run (upto
+ * thread and use that to decide how many threads to run (up to
  * the number on the system).
  *
  * For guidance setting the lower per-thread bound, see:
diff --git a/parse-options.c b/parse-options.c
index b42f54d48b..60fae3ad21 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -623,7 +623,7 @@ static int show_gitcomp(const struct option *opts)
  * Scan and may produce a new option[] array, which should be used
  * instead of the original 'options'.
  *
- * Right now this is only used to preprocess and substitue
+ * Right now this is only used to preprocess and substitute
  * OPTION_ALIAS.
  */
 static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
diff --git a/range-diff.h b/range-diff.h
index 08a50b6e98..77347a9f88 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -6,7 +6,7 @@
 #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
 
 /*
- * Compare series of commmits in RANGE1 and RANGE2, and emit to the
+ * Compare series of commits in RANGE1 and RANGE2, and emit to the
  * standard output.  NULL can be passed to DIFFOPT to use the built-in
  * default.
  */
diff --git a/read-cache.c b/read-cache.c
index 133f790fa4..06744287a1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1790,7 +1790,7 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 		const unsigned char *cp = (const unsigned char *)name;
 		size_t strip_len, previous_len;
 
-		/* If we're at the begining of a block, ignore the previous name */
+		/* If we're at the beginning of a block, ignore the previous name */
 		strip_len = decode_varint(&cp);
 		if (previous_ce) {
 			previous_len = previous_ce->ce_namelen;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f2d8c0123a..ff2436c0fb 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -262,7 +262,7 @@ int refs_rename_ref_available(struct ref_store *refs,
  * after calling ref_iterator_advance() again or calling
  * ref_iterator_abort(), you must make a copy. When the iteration has
  * been exhausted, ref_iterator_advance() releases any resources
- * assocated with the iteration, frees the ref_iterator object, and
+ * associated with the iteration, frees the ref_iterator object, and
  * returns ITER_DONE. If you want to abort the iteration early, call
  * ref_iterator_abort(), which also frees the ref_iterator object and
  * any associated resources. If there was an internal error advancing
diff --git a/repository.c b/repository.c
index 682c239fe3..a4174ddb06 100644
--- a/repository.c
+++ b/repository.c
@@ -200,9 +200,9 @@ int repo_submodule_init(struct repository *subrepo,
 
 	if (repo_init(subrepo, gitdir.buf, worktree.buf)) {
 		/*
-		 * If initilization fails then it may be due to the submodule
+		 * If initialization fails then it may be due to the submodule
 		 * not being populated in the superproject's worktree.  Instead
-		 * we can try to initilize the submodule by finding it's gitdir
+		 * we can try to initialize the submodule by finding it's gitdir
 		 * in the superproject's 'modules' directory.  In this case the
 		 * submodule would not have a worktree.
 		 */
diff --git a/repository.h b/repository.h
index fe42197813..040057dea6 100644
--- a/repository.h
+++ b/repository.h
@@ -172,7 +172,7 @@ void repo_clear(struct repository *repo);
  * be allocated if needed.
  *
  * Return the number of index entries in the populated index or a value less
- * than zero if an error occured.  If the repository's index has already been
+ * than zero if an error occurred.  If the repository's index has already been
  * populated then the number of entries will simply be returned.
  */
 int repo_read_index(struct repository *repo);
diff --git a/rerere.c b/rerere.c
index 3e51fdfe58..9281131a9f 100644
--- a/rerere.c
+++ b/rerere.c
@@ -431,7 +431,7 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
  * and NUL concatenated together.
  *
  * Return 1 if conflict hunks are found, 0 if there are no conflict
- * hunks and -1 if an error occured.
+ * hunks and -1 if an error occurred.
  */
 static int handle_path(unsigned char *hash, struct rerere_io *io, int marker_size)
 {
diff --git a/sequencer.c b/sequencer.c
index 9d5964fd81..93e54a0497 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -131,7 +131,7 @@ static GIT_PATH_FUNC(rebase_path_rewritten_pending,
 	"rebase-merge/rewritten-pending")
 
 /*
- * The path of the file containig the OID of the "squash onto" commit, i.e.
+ * The path of the file containing the OID of the "squash onto" commit, i.e.
  * the dummy commit used for `reset [new root]`.
  */
 static GIT_PATH_FUNC(rebase_path_squash_onto, "rebase-merge/squash-onto")
@@ -4644,7 +4644,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 				label_oid(oid, "branch-point", &state);
 		}
 
-		/* Add HEAD as implict "tip of branch" */
+		/* Add HEAD as implicit "tip of branch" */
 		if (!iter->next)
 			tips_tail = &commit_list_insert(iter->item,
 							tips_tail)->next;
@@ -4826,7 +4826,7 @@ void todo_list_add_exec_commands(struct todo_list *todo_list,
 	 * are considered part of the pick, so we insert the commands *after*
 	 * those chains if there are any.
 	 *
-	 * As we insert the exec commands immediatly after rearranging
+	 * As we insert the exec commands immediately after rearranging
 	 * any fixups and before the user edits the list, a fixup chain
 	 * can never contain comments (any comments are empty picks that
 	 * have been commented out because the user did not specify
diff --git a/server-info.c b/server-info.c
index 4d8199b1d9..bae2cdfd51 100644
--- a/server-info.c
+++ b/server-info.c
@@ -93,7 +93,7 @@ static int update_info_file(char *path,
 		uic.old_fp = fopen_or_warn(path, "r");
 
 	/*
-	 * uic_printf will compare incremental comparison aginst old_fp
+	 * uic_printf will compare incremental comparison against old_fp
 	 * and mark uic as stale if needed
 	 */
 	ret = generate(&uic);
diff --git a/string-list.h b/string-list.h
index f964399949..7bb0ad07e6 100644
--- a/string-list.h
+++ b/string-list.h
@@ -179,7 +179,7 @@ void string_list_remove(struct string_list *list, const char *string,
 
 /**
  * Check if the given string is part of a sorted list. If it is part of the list,
- * return the coresponding string_list_item, NULL otherwise.
+ * return the corresponding string_list_item, NULL otherwise.
  */
 struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
 
diff --git a/trace2/tr2_sid.c b/trace2/tr2_sid.c
index 6948fd4108..dc6e75ef13 100644
--- a/trace2/tr2_sid.c
+++ b/trace2/tr2_sid.c
@@ -19,7 +19,7 @@ static int tr2sid_nr_git_parents;
  *    "H<first_8_chars_of_sha1_of_hostname>"
  *    "Localhost" when no hostname.
  *
- * where <process> is a 9 character string containing the least signifcant
+ * where <process> is a 9 character string containing the least significant
  * 32 bits in the process-id.
  *    "P<pid>"
  * (This is an abribrary choice.  On most systems pid_t is a 32 bit value,
diff --git a/unpack-trees.c b/unpack-trees.c
index 8ba2dc3267..2f3cee596e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -275,9 +275,9 @@ static int check_submodule_move_head(const struct cache_entry *ce,
 }
 
 /*
- * Preform the loading of the repository's gitmodules file.  This function is
+ * Perform the loading of the repository's gitmodules file.  This function is
  * used by 'check_update()' to perform loading of the gitmodules file in two
- * differnt situations:
+ * different situations:
  * (1) before removing entries from the working tree if the gitmodules file has
  *     been marked for removal.  This situation is specified by 'state' == NULL.
  * (2) before checking out entries to the working tree if the gitmodules file
diff --git a/url.c b/url.c
index e34e5e7517..e04bd60b6b 100644
--- a/url.c
+++ b/url.c
@@ -5,7 +5,7 @@ int is_urlschemechar(int first_flag, int ch)
 {
 	/*
 	 * The set of valid URL schemes, as per STD66 (RFC3986) is
-	 * '[A-Za-z][A-Za-z0-9+.-]*'. But use sightly looser check
+	 * '[A-Za-z][A-Za-z0-9+.-]*'. But use slightly looser check
 	 * of '[A-Za-z0-9][A-Za-z0-9+.-]*' because earlier version
 	 * of check used '[A-Za-z0-9]+' so not to break any remote
 	 * helpers.
diff --git a/xdiff-interface.h b/xdiff-interface.h
index ede4246bbd..93df26900c 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -44,7 +44,7 @@ void discard_hunk_line(void *priv,
  * Compare the strings l1 with l2 which are of size s1 and s2 respectively.
  * Returns 1 if the strings are deemed equal, 0 otherwise.
  * The `flags` given as XDF_WHITESPACE_FLAGS determine how white spaces
- * are treated for the comparision.
+ * are treated for the comparison.
  */
 int xdiff_compare_lines(const char *l1, long s1,
 			const char *l2, long s2, long flags);
-- 
gitgitgadget

