Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 329EF1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeGUIlq (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:41:46 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:38809 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeGUIlq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:41:46 -0400
Received: by mail-lj1-f179.google.com with SMTP id p6-v6so12886563ljc.5
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XPeuFC1z0dbWgeXysEkM4MZw2g6xAy837A3dNwjHWMU=;
        b=jIX9WQnxC8LqgEifW5Xyj9vSNGGG3J07XavQ7815HqeREA72vjTJF2M6e0qVjj6mq6
         q77mysjjiXpddQsvqcHbAjKnVcShmFuD+UgEf8wnzAVN99cQ/kPijCgBSIdUfJNtZG5l
         YRyuy5tV8bEqm1XTjQA3maDc/XHpyi2+MqmuauKV539Uhbzqjp/7VyBn4XF76K3SZrXS
         3eiCDdut/xi1eKw8EaNvuhJDRudNVotIzKTyLXTzsg/Axz3WTViWr2hEDwKo3XcRjIrw
         DSH/14mLYrFcgsmGnWoriAa27ZmHJd8qvESsS2/LlIu9l8OGUy25Xs+uG3UXPjJY2RLx
         7/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPeuFC1z0dbWgeXysEkM4MZw2g6xAy837A3dNwjHWMU=;
        b=eS81U2ffSkpLuEikZcamVB904uKb1WehGXMzCbskhJzYP6XVDpuAiMMPEXlIblpGSM
         +UjqBS7uuSwtv18Q2VhK6etKbLV23tILULCoDJSi2NJ+0XOQkkNYjjSi+h42q1ubWpM5
         bYcgfyxIu7RJu1sHU7riyR/RdCj1RWAUN834UT5xp9yN1XLgLlATdQOivn7NSydoE/C8
         0ZJsjBahvo1L/TiJjFMmsgK1/jw9/aLe5uHHugdhRb07Fr9x9nUODNrNNjRnAuDXZ8fO
         2M9zKUiJDsVCr1bwJBslloZokvnClrXOMkRZEIbJlOmeOS8PiiJN7MbUAuQIPojq/q0F
         1zuA==
X-Gm-Message-State: AOUpUlHnG3d5AYHJ+MQLlzd26cwpU5WHmESfSgLVet+92DzL+6ndRYFW
        UX501Wt7/d1+k2Tb0OeOdgM=
X-Google-Smtp-Source: AAOMgpcQQCgpmLo3M/6Mhse5XPXn0qGP22vvutvpTEYvo8CD/VRnt91GIZivxEvboP3zRFh2XpYXBg==
X-Received: by 2002:a2e:10ca:: with SMTP id 71-v6mr3690080ljq.59.1532159395447;
        Sat, 21 Jul 2018 00:49:55 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm759898lji.96.2018.07.21.00.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 00:49:54 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com
Subject: [PATCH v3 00/23] Mark more strings for translation
Date:   Sat, 21 Jul 2018 09:49:18 +0200
Message-Id: <20180721074941.14632-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180718161101.19765-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 fixes up some other things that Junio spotted. branch-diff 

diff --git a/builtin/config.c b/builtin/config.c
index 3c26df6c48..5761a2c4ac 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -626,7 +626,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			 * location; error out even if XDG_CONFIG_HOME
 			 * is set and points at a sane location.
 			 */
-			die(_("$HOME is not set"));
+			die(_("$HOME not set"));
 
 		if (access_or_warn(user_config, R_OK, 0) &&
 		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6b778b0a82..37d63f6721 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -148,8 +148,13 @@ static void *get_delta(struct object_entry *entry)
 		    oid_to_hex(&DELTA(entry)->idx.oid));
 	delta_buf = diff_delta(base_buf, base_size,
 			       buf, size, &delta_size, 0);
+	/*
+	 * We succesfully computed this delta once but dropped it for
+	 * memory reasons. Something is very wrong if this time we
+	 * recompute and create a different delta.
+	 */
 	if (!delta_buf || delta_size != DELTA_SIZE(entry))
-		die(_("delta size changed"));
+		BUG("delta size changed");
 	free(buf);
 	free(base_buf);
 	return delta_buf;
diff --git a/builtin/replace.c b/builtin/replace.c
index c77b325aa1..e879ace277 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -456,10 +456,10 @@ static int create_graft(int argc, const char **argv, int force, int gentle)
 		return -1;
 	}
 
-	if (remove_signature(&buf))
-		warning(_("the original commit '%s' has a gpg signature.\n"
-			  "The signature will be removed in the replacement commit!"),
-			old_ref);
+	if (remove_signature(&buf)) {
+		warning(_("the original commit '%s' has a gpg signature"), old_ref);
+		warning(_("the signature will be removed in the replacement commit!"));
+	}
 
 	if (check_mergetags(commit, argc, argv)) {
 		strbuf_release(&buf);
diff --git a/config.c b/config.c
index 58d076e833..736b9f23f7 100644
--- a/config.c
+++ b/config.c
@@ -1409,11 +1409,11 @@ static int git_default_push_config(const char *var, const char *value)
 			push_default = PUSH_DEFAULT_UPSTREAM;
 		else if (!strcmp(value, "current"))
 			push_default = PUSH_DEFAULT_CURRENT;
-		else
-			return error(_("malformed value for %s: %s\n"
-				       "Must be one of nothing, matching, simple, "
-				       "upstream or current."),
-				     var, value);
+		else {
+			error(_("malformed value for %s: %s"), var, value);
+			return error(_("must be one of nothing, matching, simple, "
+				       "upstream or current"));
+		}
 		return 0;
 	}
 
diff --git a/connect.c b/connect.c
index 70b97cfef6..94547e5056 100644
--- a/connect.c
+++ b/connect.c
@@ -641,11 +641,9 @@ static int git_tcp_connect_sock(char *host, int flags)
 	if (gai)
 		die(_("unable to look up %s (port %s) (%s)"), host, port, gai_strerror(gai));
 
-	if (flags & CONNECT_VERBOSE) {
+	if (flags & CONNECT_VERBOSE)
 		/* TRANSLATORS: this is the end of "Looking up %s ... " */
-		fprintf_ln(stderr, _("done."));
-		fprintf(stderr, _("Connecting to %s (port %s) ... "), host, port);
-	}
+		fprintf(stderr, _("done.\nConnecting to %s (port %s) ... "), host, port);
 
 	for (ai0 = ai; ai; ai = ai->ai_next, cnt++) {
 		sockfd = socket(ai->ai_family,
@@ -714,11 +712,9 @@ static int git_tcp_connect_sock(char *host, int flags)
 		nport = se->s_port;
 	}
 
-	if (flags & CONNECT_VERBOSE) {
+	if (flags & CONNECT_VERBOSE)
 		/* TRANSLATORS: this is the end of "Looking up %s ... " */
-		fprintf_ln(stderr, _("done."));
-		fprintf(stderr, _("Connecting to %s (port %s) ... "), host, port);
-	}
+		fprintf(stderr, _("done.\nConnecting to %s (port %s) ... "), host, port);
 
 	for (cnt = 0, ap = he->h_addr_list; *ap; ap++, cnt++) {
 		memset(&sa, 0, sizeof sa);

Nguyễn Thái Ngọc Duy (23):
  Update messages in preparation for i18n
  archive-tar.c: mark more strings for translation
  archive-zip.c: mark more strings for translation
  builtin/config.c: mark more strings for translation
  builtin/grep.c: mark strings for translation
  builtin/pack-objects.c: mark more strings for translation
  builtin/replace.c: mark more strings for translation
  commit-graph.c: mark more strings for translation
  config.c: mark more strings for translation
  connect.c: mark more strings for translation
  convert.c: mark more strings for translation
  dir.c: mark more strings for translation
  environment.c: mark more strings for translation
  exec-cmd.c: mark more strings for translation
  object.c: mark more strings for translation
  pkt-line.c: mark more strings for translation
  refs.c: mark more strings for translation
  refspec.c: mark more strings for translation
  replace-object.c: mark more strings for translation
  sequencer.c: mark more strings for translation
  sha1-file.c: mark more strings for translation
  transport.c: mark more strings for translation
  transport-helper.c: mark more strings for translation

 archive-tar.c                         |  12 +--
 archive-zip.c                         |  14 ++--
 builtin/blame.c                       |   2 +-
 builtin/checkout.c                    |   4 +-
 builtin/commit.c                      |   6 +-
 builtin/config.c                      |  50 +++++------
 builtin/fast-export.c                 |  42 +++++-----
 builtin/fmt-merge-msg.c               |   2 +-
 builtin/grep.c                        |  12 +--
 builtin/log.c                         |   6 +-
 builtin/merge.c                       |   2 +-
 builtin/pack-objects.c                | 115 ++++++++++++++------------
 builtin/replace.c                     |  84 +++++++++----------
 builtin/rm.c                          |   2 +-
 commit-graph.c                        |  20 ++---
 config.c                              |  72 ++++++++--------
 connect.c                             |  77 ++++++++---------
 convert.c                             |  42 +++++-----
 diff.c                                |   4 +-
 dir.c                                 |   8 +-
 environment.c                         |   4 +-
 exec-cmd.c                            |   2 +-
 object.c                              |  10 +--
 pkt-line.c                            |  26 +++---
 reflog-walk.c                         |   4 +-
 refs.c                                |  40 ++++-----
 refspec.c                             |   2 +-
 replace-object.c                      |   6 +-
 sequencer.c                           |  28 ++++---
 sha1-file.c                           | 110 ++++++++++++------------
 t/t0021-conversion.sh                 |   2 +-
 t/t1305-config-include.sh             |   2 +-
 t/t1308-config-set.sh                 |   2 +-
 t/t1400-update-ref.sh                 |  20 ++---
 t/t1404-update-ref-errors.sh          |   4 +-
 t/t1450-fsck.sh                       |   2 +-
 t/t3005-ls-files-relative.sh          |   8 +-
 t/t3210-pack-refs.sh                  |   2 +-
 t/t3310-notes-merge-manual-resolve.sh |   6 +-
 t/t5500-fetch-pack.sh                 |   2 +-
 t/t5505-remote.sh                     |   2 +-
 t/t5570-git-daemon.sh                 |   6 +-
 t/t5801-remote-helpers.sh             |   8 +-
 t/t7063-status-untracked-cache.sh     |   2 +-
 t/t7400-submodule-basic.sh            |   2 +-
 transport-helper.c                    |  89 ++++++++++----------
 transport.c                           |  18 ++--
 47 files changed, 502 insertions(+), 483 deletions(-)

-- 
2.18.0.656.gda699b98b3

