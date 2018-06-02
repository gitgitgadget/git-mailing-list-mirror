Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21EF31F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeFBEdw (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:33:52 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42780 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeFBEdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:33:09 -0400
Received: by mail-lf0-f65.google.com with SMTP id v135-v6so17610460lfa.9
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/V8vaaopIiX3GjJ1UFn2K+SaC7/fjrCrZ3B2j0ytRAE=;
        b=Lkw3mIect2yol8g3WeUfjvI5wvoMmj6x5my+w8cxD3zIAmsWEcZd9XzwbHLKgP7ci7
         2uzvkv070LbTvBB/+cNLAf+5sP9NMjzSvGCcHmNmFtrNO9G5ShEf6Nky246MgMeNG/Uo
         zrgggS4U/xwhyWKmR9+l/+BEFnM4AHPgESUIkrd1tIEkLpD7ilC/h5eRaEp8G9SfJhi6
         WaZP31e9MAjJ99OUOheR5VndDnIsJz2hAirvw2loDqyPZJ8zH1QSAE19yURjrJEOvTP7
         m3V7FstvpIQodX/XL3tXihpJiqsR/KKZSa1vXHZJ4AqOTaN/WbHMPJLmB1/f3rt1r3Z9
         y3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/V8vaaopIiX3GjJ1UFn2K+SaC7/fjrCrZ3B2j0ytRAE=;
        b=fIyup3YKwRYvsAF+sej2fxthS25CAuQVoFJY+I8M6HlKL/qV2BMLOQBMBwJHvtKobn
         ZrfrOs2VzsF0eiKsi1YnZaIFmJnc1exk1fsdfrgquFcQUiImZrCyu1zIiiyADhiipYrL
         gJjLne3uAjjUK0gxgz3QHpay9nymkm5sNoIXn/EB2XGZjkpADFkW7O33VTIDIzuyRT6J
         RM+KvdCYgS4u2E2ax12gpkOZBVe5L4ofwqwMbidGHy4HF71vTbQcLfI+D2BkMGMi47kc
         IjveFBm2SE0XybNav4wqBZy6ei6KQj9KwgQlNUgT37qUTtoDY5IF/qC1Q4fBX1WscT+l
         W8oA==
X-Gm-Message-State: ALKqPwfdt8Ktk1t1mPBIgQurNIlq6UDVudzMiA6IWOhI7XxzEofjddmA
        ctvdoewWPLLfv2L0xELtmt8T0g==
X-Google-Smtp-Source: ADUXVKLKbf8YfFC0twXlGUu9ptutUbTIOhD5T+e6xHiooX6Fny2TuBbZQu27N06FmiG2bg3J2SdN9w==
X-Received: by 2002:a19:1813:: with SMTP id o19-v6mr7858090lfi.14.1527913987176;
        Fri, 01 Jun 2018 21:33:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:33:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/22] refs.c: mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:35 +0200
Message-Id: <20180602043241.9941-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.309.g77c7720784
In-Reply-To: <20180602043241.9941-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c                                | 40 +++++++++++++--------------
 t/t1400-update-ref.sh                 | 20 +++++++-------
 t/t1404-update-ref-errors.sh          |  4 +--
 t/t3210-pack-refs.sh                  |  2 +-
 t/t3310-notes-merge-manual-resolve.sh |  6 ++--
 t/t5505-remote.sh                     |  2 +-
 6 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/refs.c b/refs.c
index 0eb379f931..88b60ac1c6 100644
--- a/refs.c
+++ b/refs.c
@@ -188,7 +188,7 @@ int ref_resolves_to_object(const char *refname,
 	if (flags & REF_ISBROKEN)
 		return 0;
 	if (!has_sha1_file(oid->hash)) {
-		error("%s does not point to a valid object!", refname);
+		error(_("%s does not point to a valid object!"), refname);
 		return 0;
 	}
 	return 1;
@@ -567,9 +567,9 @@ int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
 			if (!warn_ambiguous_refs)
 				break;
 		} else if ((flag & REF_ISSYMREF) && strcmp(fullref.buf, "HEAD")) {
-			warning("ignoring dangling symref %s.", fullref.buf);
+			warning(_("ignoring dangling symref %s."), fullref.buf);
 		} else if ((flag & REF_ISBROKEN) && strchr(fullref.buf, '/')) {
-			warning("ignoring broken ref %s.", fullref.buf);
+			warning(_("ignoring broken ref %s."), fullref.buf);
 		}
 	}
 	strbuf_release(&fullref);
@@ -673,7 +673,7 @@ static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
 	fd = hold_lock_file_for_update_timeout(&lock, filename, 0,
 					       get_files_ref_lock_timeout_ms());
 	if (fd < 0) {
-		strbuf_addf(err, "could not open '%s' for writing: %s",
+		strbuf_addf(err, _("could not open '%s' for writing: %s"),
 			    filename, strerror(errno));
 		goto done;
 	}
@@ -683,18 +683,18 @@ static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
 
 		if (read_ref(pseudoref, &actual_old_oid)) {
 			if (!is_null_oid(old_oid)) {
-				strbuf_addf(err, "could not read ref '%s'",
+				strbuf_addf(err, _("could not read ref '%s'"),
 					    pseudoref);
 				rollback_lock_file(&lock);
 				goto done;
 			}
 		} else if (is_null_oid(old_oid)) {
-			strbuf_addf(err, "ref '%s' already exists",
+			strbuf_addf(err, _("ref '%s' already exists"),
 				    pseudoref);
 			rollback_lock_file(&lock);
 			goto done;
 		} else if (oidcmp(&actual_old_oid, old_oid)) {
-			strbuf_addf(err, "unexpected object ID when writing '%s'",
+			strbuf_addf(err, _("unexpected object ID when writing '%s'"),
 				    pseudoref);
 			rollback_lock_file(&lock);
 			goto done;
@@ -702,7 +702,7 @@ static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
 	}
 
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
-		strbuf_addf(err, "could not write to '%s'", filename);
+		strbuf_addf(err, _("could not write to '%s'"), filename);
 		rollback_lock_file(&lock);
 		goto done;
 	}
@@ -734,9 +734,9 @@ static int delete_pseudoref(const char *pseudoref, const struct object_id *old_o
 			return -1;
 		}
 		if (read_ref(pseudoref, &actual_old_oid))
-			die("could not read ref '%s'", pseudoref);
+			die(_("could not read ref '%s'"), pseudoref);
 		if (oidcmp(&actual_old_oid, old_oid)) {
-			error("unexpected object ID when deleting '%s'",
+			error(_("unexpected object ID when deleting '%s'"),
 			      pseudoref);
 			rollback_lock_file(&lock);
 			return -1;
@@ -871,13 +871,13 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 		if (!is_null_oid(&cb->ooid)) {
 			oidcpy(cb->oid, noid);
 			if (oidcmp(&cb->ooid, noid))
-				warning("Log for ref %s has gap after %s.",
+				warning(_("log for ref %s has gap after %s"),
 					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
 		}
 		else if (cb->date == cb->at_time)
 			oidcpy(cb->oid, noid);
 		else if (oidcmp(noid, cb->oid))
-			warning("Log for ref %s unexpectedly ended on %s.",
+			warning(_("log for ref %s unexpectedly ended on %s"),
 				cb->refname, show_date(cb->date, cb->tz,
 						       DATE_MODE(RFC2822)));
 		oidcpy(&cb->ooid, ooid);
@@ -935,7 +935,7 @@ int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, in
 		if (flags & GET_OID_QUIETLY)
 			exit(128);
 		else
-			die("Log for %s is empty.", refname);
+			die(_("log for %s is empty"), refname);
 	}
 	if (cb.found_it)
 		return 0;
@@ -1027,7 +1027,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if ((new_oid && !is_null_oid(new_oid)) ?
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
 	    !refname_is_safe(refname)) {
-		strbuf_addf(err, "refusing to update ref with bad name '%s'",
+		strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
 			    refname);
 		return -1;
 	}
@@ -1103,7 +1103,7 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 		}
 	}
 	if (ret) {
-		const char *str = "update_ref failed for ref '%s': %s";
+		const char *str = _("update_ref failed for ref '%s': %s");
 
 		switch (onerr) {
 		case UPDATE_REFS_MSG_ON_ERR:
@@ -1845,7 +1845,7 @@ int ref_update_reject_duplicates(struct string_list *refnames,
 
 		if (!cmp) {
 			strbuf_addf(err,
-				    "multiple updates for ref '%s' not allowed.",
+				    _("multiple updates for ref '%s' not allowed."),
 				    refnames->items[i].string);
 			return 1;
 		} else if (cmp > 0) {
@@ -1973,13 +1973,13 @@ int refs_verify_refname_available(struct ref_store *refs,
 			continue;
 
 		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent, &type)) {
-			strbuf_addf(err, "'%s' exists; cannot create '%s'",
+			strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
 				    dirname.buf, refname);
 			goto cleanup;
 		}
 
 		if (extras && string_list_has_string(extras, dirname.buf)) {
-			strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
+			strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
 				    refname, dirname.buf);
 			goto cleanup;
 		}
@@ -2003,7 +2003,7 @@ int refs_verify_refname_available(struct ref_store *refs,
 		    string_list_has_string(skip, iter->refname))
 			continue;
 
-		strbuf_addf(err, "'%s' exists; cannot create '%s'",
+		strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
 			    iter->refname, refname);
 		ref_iterator_abort(iter);
 		goto cleanup;
@@ -2014,7 +2014,7 @@ int refs_verify_refname_available(struct ref_store *refs,
 
 	extra_refname = find_descendant_ref(dirname.buf, extras, skip);
 	if (extra_refname)
-		strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
+		strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
 			    refname, extra_refname);
 	else
 		ret = 0;
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e1fd0f0ca8..2a0007a985 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -390,7 +390,7 @@ test_expect_success 'Query "master@{2005-05-26 23:33:01}" (middle of history wit
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{2005-05-26 23:33:01}" >o 2>e &&
 	test $B = $(cat o) &&
-	test "warning: Log for ref $m has gap after $gd." = "$(cat e)"
+	test_i18ngrep -F "warning: log for ref $m has gap after $gd" e
 '
 test_expect_success 'Query "master@{2005-05-26 23:38:00}" (middle of history)' '
 	test_when_finished "rm -f o e" &&
@@ -408,7 +408,7 @@ test_expect_success 'Query "master@{2005-05-28}" (past end of history)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{2005-05-28}" >o 2>e &&
 	test $D = $(cat o) &&
-	test "warning: Log for ref $m unexpectedly ended on $ld." = "$(cat e)"
+	test_i18ngrep -F "warning: log for ref $m unexpectedly ended on $ld" e
 '
 
 rm -f .git/$m .git/logs/$m expect
@@ -462,7 +462,7 @@ test_expect_success 'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER
 test_expect_success 'given old value for missing pseudoref, do not create' '
 	test_must_fail git update-ref PSEUDOREF $A $B 2>err &&
 	test_path_is_missing .git/PSEUDOREF &&
-	grep "could not read ref" err
+	test_i18ngrep "could not read ref" err
 '
 
 test_expect_success 'create pseudoref' '
@@ -483,7 +483,7 @@ test_expect_success 'overwrite pseudoref with correct old value' '
 test_expect_success 'do not overwrite pseudoref with wrong old value' '
 	test_must_fail git update-ref PSEUDOREF $D $E 2>err &&
 	test $C = $(cat .git/PSEUDOREF) &&
-	grep "unexpected object ID" err
+	test_i18ngrep "unexpected object ID" err
 '
 
 test_expect_success 'delete pseudoref' '
@@ -495,7 +495,7 @@ test_expect_success 'do not delete pseudoref with wrong old value' '
 	git update-ref PSEUDOREF $A &&
 	test_must_fail git update-ref -d PSEUDOREF $B 2>err &&
 	test $A = $(cat .git/PSEUDOREF) &&
-	grep "unexpected object ID" err
+	test_i18ngrep "unexpected object ID" err
 '
 
 test_expect_success 'delete pseudoref with correct old value' '
@@ -512,7 +512,7 @@ test_expect_success 'do not overwrite pseudoref with old OID zero' '
 	test_when_finished git update-ref -d PSEUDOREF &&
 	test_must_fail git update-ref PSEUDOREF $B $Z 2>err &&
 	test $A = $(cat .git/PSEUDOREF) &&
-	grep "already exists" err
+	test_i18ngrep "already exists" err
 '
 
 # Test --stdin
@@ -650,7 +650,7 @@ test_expect_success 'stdin fails with duplicate refs' '
 	create $a $m
 	EOF
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed." err
+	test_i18ngrep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed." err
 '
 
 test_expect_success 'stdin create ref works' '
@@ -1052,7 +1052,7 @@ test_expect_success 'stdin -z fails option with unknown name' '
 test_expect_success 'stdin -z fails with duplicate refs' '
 	printf $F "create $a" "$m" "create $b" "$m" "create $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed." err
+	test_i18ngrep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed." err
 '
 
 test_expect_success 'stdin -z create ref works' '
@@ -1283,7 +1283,7 @@ test_expect_success 'fails with duplicate HEAD update' '
 	update HEAD $B
 	EOF
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: multiple updates for '\''HEAD'\'' (including one via its referent .refs/heads/target1.) are not allowed" err &&
+	test_i18ngrep "fatal: multiple updates for '\''HEAD'\'' (including one via its referent .refs/heads/target1.) are not allowed" err &&
 	echo "refs/heads/target1" >expect &&
 	git symbolic-ref HEAD >actual &&
 	test_cmp expect actual &&
@@ -1300,7 +1300,7 @@ test_expect_success 'fails with duplicate ref update via symref' '
 	update refs/heads/symref2 $B
 	EOF
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: multiple updates for '\''refs/heads/target2'\'' (including one via symref .refs/heads/symref2.) are not allowed" err &&
+	test_i18ngrep "fatal: multiple updates for '\''refs/heads/target2'\'' (including one via symref .refs/heads/symref2.) are not allowed" err &&
 	echo "refs/heads/target2" >expect &&
 	git symbolic-ref refs/heads/symref2 >actual &&
 	test_cmp expect actual &&
diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 3a887b5113..2a42a589a4 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -27,7 +27,7 @@ test_update_rejected () {
 	fi &&
 	printf "create $prefix/%s $C\n" $create >input &&
 	test_must_fail git update-ref --stdin <input 2>output.err &&
-	grep -F "$error" output.err &&
+	test_i18ngrep -F "$error" output.err &&
 	git for-each-ref $prefix >actual &&
 	test_cmp unchanged actual
 }
@@ -103,7 +103,7 @@ df_test() {
 		printf "%s\n" "delete $delname" "create $addname $D"
 	fi >commands &&
 	test_must_fail git update-ref --stdin <commands 2>output.err &&
-	test_cmp expected-err output.err &&
+	test_i18ncmp expected-err output.err &&
 	printf "%s\n" "$C $delref" >expected-refs &&
 	git for-each-ref --format="%(objectname) %(refname)" $prefix/r >actual-refs &&
 	test_cmp expected-refs actual-refs
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index afa27ffe2d..7e95713f9e 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -186,7 +186,7 @@ test_expect_success 'notice d/f conflict with existing directory' '
 
 test_expect_success 'existing directory reports concrete ref' '
 	test_must_fail git branch foo 2>stderr &&
-	grep refs/heads/foo/bar/baz stderr
+	test_i18ngrep refs/heads/foo/bar/baz stderr
 '
 
 test_expect_success 'notice d/f conflict with existing ref' '
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 9c1bf6eb3d..68436eed82 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -541,9 +541,9 @@ EOF
 	test "$(git rev-parse refs/notes/y)" = "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&
 	test "$(git rev-parse refs/notes/m)" != "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&
 	# Mention refs/notes/m, and its current and expected value in output
-	grep -q "refs/notes/m" output &&
-	grep -q "$(git rev-parse refs/notes/m)" output &&
-	grep -q "$(git rev-parse NOTES_MERGE_PARTIAL^1)" output &&
+	test_i18ngrep -q "refs/notes/m" output &&
+	test_i18ngrep -q "$(git rev-parse refs/notes/m)" output &&
+	test_i18ngrep -q "$(git rev-parse NOTES_MERGE_PARTIAL^1)" output &&
 	# Verify that other notes refs has not changed (w, x, y and z)
 	verify_notes w &&
 	verify_notes x &&
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index a6c0178f3a..ca4c222743 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -876,7 +876,7 @@ test_expect_success 'remote prune to cause a dangling symref' '
 		cd eight &&
 		test_must_fail git branch nomore origin
 	) 2>err &&
-	grep "dangling symref" err
+	test_i18ngrep "dangling symref" err
 '
 
 test_expect_success 'show empty remote' '
-- 
2.18.0.rc0.309.g77c7720784

