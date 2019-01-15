Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E4821F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389404AbfAOTkr (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:40:47 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:38136 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbfAOTkr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:40:47 -0500
Received: by mail-pl1-f202.google.com with SMTP id 4so2253324plc.5
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 11:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fQrZtSR2ysfXRBWArswhh+utOdeCl3lzeOx/B9vvsCk=;
        b=HHcxO1OqTzSHrXAqho5KwZJ9G/88VpGFqolNe0g4eO9ChXRNnz1cTLHxIufmalcA+C
         yMT/3BXvRa00bNKczcQ5YpZcfQpZU732XfAv+wfF1Qu3V9PO2bVvgKkEMAYjAZDCjgV6
         WSA2Vh40WTq5s6TVgUIw2nO7z0CemoA2DLvvtPxRG7b48AJbELRGAFTbIJ20pakceyTr
         UdSOBEFc9l/Cl/OebvxwRgjaad658bJNA1XUfjFaAVn3oCfYGvzByFxQ395HZl5MjdBv
         x7IscaWHYpK+DLED1t8IKzSov5gJD5EOaHtSlsXmLDwj45L0aBmyBpyOKzFtndRDM/ej
         CzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fQrZtSR2ysfXRBWArswhh+utOdeCl3lzeOx/B9vvsCk=;
        b=lXSOGJWIU7e0g/9VQTqtWJslHzu+rdnr9RhSIXoKNwXph9UC7KiUuXilM59UyKNJeZ
         wURA8ejnB3gn/2UNKVDzacDq2uVl3S/HnoFsP4bA+WJ7iVc3GOmCpzGw53wQHoNLkGK1
         2KOnyYgf1TixIBLFaPoR1MEO3G+NpSVLMj0zt7np8xrZ6XjveggTiD53Xcd8TLzVL5MD
         0jDVGDnjcaq3cUgumJQzvDUhRWX7rOKRifzzfap2ygnXkESnWbDSQ8TXhwA9jgn9LmHh
         nKZF1nXJzhwXWP1yfFaFtwyPcJLyerGZpR/kfU/LVcMWH7ZLHRAyNZVcgO68BlISCQ4B
         ZdUA==
X-Gm-Message-State: AJcUukfxPw43fWIDW6664m9XqWEtSON8Oqb+hysm87EZt6mVIIB4GbXJ
        8M6vIVzOGNqaNz8byRDrA7k5NSWIWglesTN9o8U2b1SXXXAplpk8e9i6nN0Af3fwvTvTdovqOUv
        C5Ugwx+f3Hl9BPO2B0rDd+tBpdkLMQNGN7IJKY82a95qjBjguPdef6PwUssqhG91AZSsUvT+yIA
        /i
X-Google-Smtp-Source: ALg8bN4McL9r+oCdnIMDnumFGqF2jEWrupwaYbcgqbdgobm6M7wuHPLrlNWYEK6qw89X0Qe42GoXPM4KFxSl8CTGgsOz
X-Received: by 2002:a63:6c8a:: with SMTP id h132mr2001413pgc.56.1547581245610;
 Tue, 15 Jan 2019 11:40:45 -0800 (PST)
Date:   Tue, 15 Jan 2019 11:40:30 -0800
In-Reply-To: <cover.1547581039.git.jonathantanmy@google.com>
Message-Id: <ae4866adace97d96fb312df792ab1e18fc3dfa9c.1547581039.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547244620.git.jonathantanmy@google.com> <cover.1547581039.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 4/4] tests: define GIT_TEST_SIDEBAND_ALL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Define a GIT_TEST_SIDEBAND_ALL environment variable meant to be used
from tests. When set to true, this overrides uploadpack.allowsidebandall
to true, allowing the entire test suite to be run as if this
configuration is in place for all repositories.

As of this patch, all tests pass whether GIT_TEST_SIDEBAND_ALL is unset
or set to 1.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c             |  3 ++-
 t/README                 |  5 +++++
 t/lib-httpd/apache.conf  |  1 +
 t/t5537-fetch-shallow.sh |  3 ++-
 t/t5701-git-serve.sh     |  2 +-
 t/t5702-protocol-v2.sh   |  4 ++--
 upload-pack.c            | 13 ++++++++-----
 7 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index b89199891d..4618568fee 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1362,7 +1362,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
-	if (server_supports_feature("fetch", "sideband-all", 0)) {
+	if (git_env_bool("GIT_TEST_SIDEBAND_ALL", 1) &&
+	    server_supports_feature("fetch", "sideband-all", 0)) {
 		reader.use_sideband = 1;
 		reader.me = "fetch-pack";
 	}
diff --git a/t/README b/t/README
index 28711cc508..b275c883b8 100644
--- a/t/README
+++ b/t/README
@@ -358,6 +358,11 @@ GIT_TEST_MULTI_PACK_INDEX=<boolean>, when true, forces the multi-pack-
 index to be written after every 'git repack' command, and overrides the
 'core.multiPackIndex' setting to true.
 
+GIT_TEST_SIDEBAND_ALL=<boolean>, when true, overrides the
+'uploadpack.allowSidebandAll' setting to true, and when false, forces
+fetch-pack to not request sideband-all (even if the server advertises
+sideband-all).
+
 Naming Tests
 ------------
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 581c010d8f..9a6d368247 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -78,6 +78,7 @@ PassEnv GNUPGHOME
 PassEnv ASAN_OPTIONS
 PassEnv GIT_TRACE
 PassEnv GIT_CONFIG_NOSYSTEM
+PassEnv GIT_TEST_SIDEBAND_ALL
 
 SetEnvIf Git-Protocol ".*" GIT_PROTOCOL=$0
 
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 6faf17e17a..6caf628efa 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -243,7 +243,8 @@ test_expect_success 'shallow fetches check connectivity before writing shallow f
 	       "$(git -C "$REPO" rev-parse HEAD)" \
 	       "$(git -C "$REPO" rev-parse HEAD^)" \
 	       >"$HTTPD_ROOT_PATH/one-time-sed" &&
-	test_must_fail git -C client fetch --depth=1 "$HTTPD_URL/one_time_sed/repo" \
+	test_must_fail env GIT_TEST_SIDEBAND_ALL=0 git -C client \
+		fetch --depth=1 "$HTTPD_URL/one_time_sed/repo" \
 		master:a_branch &&
 
 	# Ensure that the one-time-sed script was used.
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index ae79c6bbc0..fe45bf828d 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -14,7 +14,7 @@ test_expect_success 'test capability advertisement' '
 	0000
 	EOF
 
-	git serve --advertise-capabilities >out &&
+	GIT_TEST_SIDEBAND_ALL=0 git serve --advertise-capabilities >out &&
 	test-tool pkt-line unpack <out >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 0f2b09ebb8..b491c62e3e 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -583,8 +583,8 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 	test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" git -C http_child \
 		-c protocol.version=2 \
 		fetch "$HTTPD_URL/one_time_sed/http_parent" 2> err &&
-	grep "fetch< acknowledgments" log &&
-	! grep "fetch< ready" log &&
+	grep "fetch< .*acknowledgments" log &&
+	! grep "fetch< .*ready" log &&
 	test_i18ngrep "expected no other sections to be sent after no .ready." err
 '
 
diff --git a/upload-pack.c b/upload-pack.c
index 765b7695d2..0c1feccaab 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1288,7 +1288,9 @@ static void process_args(struct packet_reader *request,
 			continue;
 		}
 
-		if (allow_sideband_all && !strcmp(arg, "sideband-all")) {
+		if ((git_env_bool("GIT_TEST_SIDEBAND_ALL", 0) ||
+		     allow_sideband_all) &&
+		    !strcmp(arg, "sideband-all")) {
 			data->writer.use_sideband = 1;
 			continue;
 		}
@@ -1521,10 +1523,11 @@ int upload_pack_advertise(struct repository *r,
 		    allow_ref_in_want)
 			strbuf_addstr(value, " ref-in-want");
 
-		if (!repo_config_get_bool(the_repository,
-					 "uploadpack.allowsidebandall",
-					 &allow_sideband_all_value) &&
-		    allow_sideband_all_value)
+		if (git_env_bool("GIT_TEST_SIDEBAND_ALL", 0) ||
+		    (!repo_config_get_bool(the_repository,
+					   "uploadpack.allowsidebandall",
+					   &allow_sideband_all_value) &&
+		     allow_sideband_all_value))
 			strbuf_addstr(value, " sideband-all");
 	}
 
-- 
2.19.0.271.gfe8321ec05.dirty

