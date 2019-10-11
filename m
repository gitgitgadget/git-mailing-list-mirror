Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3011F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 19:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfJKTNA (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 15:13:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36508 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbfJKTNA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 15:13:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id j11so4890019plk.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 12:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j2vDLA6P28N7ytTiJQz9UksIOypCpFIR+azTvp/rjsE=;
        b=tOef7HbqCyxdJULrRsaNDyLwN4ylNd4Xf8ayBeDtyqiyF4eAMznIFlnAmFrKPOBBsf
         Dpa9bjEsz8Vq8GPdAO8UguoppFMTZCdAms/Nv86/f1k38ITTdTk+8Nx2RtM9+Zdj2irp
         SZgeMT7RwR0FvlB1rwZtkbEv6B/M2JH4eZN+ciIJ3zRItREwr1PaWtenykgUqGvlS8xU
         J6UA3TUB/NOJKAwJlC9gzHmZ8ydDrKCLDDnrONm3bCwung94ZLa6PnAES3TjNVvZj1jh
         DqnfRuJp1ZAW5YNf+BCKDySbNOZ5+J8TnVundOeyFbDoD24XsI5M+RGEEP3VOoqM7n1G
         IQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j2vDLA6P28N7ytTiJQz9UksIOypCpFIR+azTvp/rjsE=;
        b=OLA9g/qEm/F8oB997kOfMfnzDu6SgXlJNrIUISwDlctAzX19TKvu6fcKQsZ7aHdZgT
         m7DFRcR1Rg6KVJ0dVE/0nLnLAIN878QXSqK+FHUzHC15QUIKqw78FpQhKhgjKJXFj01H
         1zG9TDCWJYvxkkYn63GDnTB7Cenk4ocEWGvDRuMAXAKs6KrfwMhhgZKNGFQdW+oNJy4L
         6p7XcvGDm8lXc5PLzMOwLKh4nuJeGUK4t7GNqxREE0QWR5EiSXVInT5ui/kwSq0jBzJA
         FYsAJmEgNOlhw/IrhoLL1SCPj4yXFmE7efk8+pjM4XVRs29wig1lyQnxT6pwtebHkSXI
         WGWg==
X-Gm-Message-State: APjAAAXHBr8x4xkKYD+f1C7C4gfp/AeNRdZWKi+4cmyizgeLggQcvl/q
        k3WP5BSvggKDpZ5ua4cst4s5WtTe
X-Google-Smtp-Source: APXvYqxNRQU4QArNhkETlm4TYQ/oA7Ojbni32N1qGk3Um8ERbJmRN72HV0o3M/HuyfoV4Ep6eiMQZA==
X-Received: by 2002:a17:902:74c3:: with SMTP id f3mr16843348plt.212.1570821178980;
        Fri, 11 Oct 2019 12:12:58 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id y36sm8790246pgk.66.2019.10.11.12.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 12:12:58 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:12:56 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 3/3] format-patch: teach --cover-from-description option
Message-ID: <9b8c3dcb539054ba483fc34c6ff509e4ca73517c.1570821015.git.liu.denton@gmail.com>
References: <cover.1566285151.git.liu.denton@gmail.com>
 <cover.1570821015.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570821015.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, when format-patch generated a cover letter, only the body would
be populated with a branch's description while the subject would be
populated with placeholder text. However, users may want to have the
subject of their cover letter automatically populated in the same way.

Teach format-patch to accept the `--cover-from-description` option and
corresponding `format.coverFromDescription` config, allowing users to
populate different parts of the cover letter (including the subject
now).

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/format.txt    |   6 +
 Documentation/git-format-patch.txt |  22 ++++
 builtin/log.c                      |  84 ++++++++++----
 t/t4014-format-patch.sh            | 172 +++++++++++++++++++++++++++++
 4 files changed, 263 insertions(+), 21 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index cb629fa769..735dfcf827 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -36,6 +36,12 @@ format.subjectPrefix::
 	The default for format-patch is to output files with the '[PATCH]'
 	subject prefix. Use this variable to change that prefix.
 
+format.coverFromDescription::
+	The default mode for format-patch to determine which parts of
+	the cover letter will be populated using the branch's
+	description. See the `--cover-from-description` option in
+	linkgit:git-format-patch[1].
+
 format.signature::
 	The default for format-patch is to output a signature containing
 	the Git version number. Use this variable to change that default.
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 0ac56f4b70..86114e4c22 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -19,6 +19,7 @@ SYNOPSIS
 		   [--start-number <n>] [--numbered-files]
 		   [--in-reply-to=<message id>] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream]
+		   [--cover-from-description=<mode>]
 		   [--rfc] [--subject-prefix=<subject prefix>]
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
@@ -171,6 +172,26 @@ will want to ensure that threading is disabled for `git send-email`.
 	patches being generated, and any patch that matches is
 	ignored.
 
+--cover-from-description=<mode>::
+	Controls which parts of the cover letter will be automatically
+	populated using the branch's description.
++
+If `<mode>` is `message` or `default`, the cover letter subject will be
+populated with placeholder text. The body of the cover letter will be
+populated with the branch's description.
++
+If `<mode>` is `subject`, the beginning of the branch description (up to
+the first blank line) will populate the cover letter subject. The
+remainder of the description will populate the body of the cover
+letter.
++
+If `<mode>` is `auto`, if the beginning of the branch description (up to
+the first line) is greater than 100 characters then the mode will be
+`message`, otherwise `subject` will be used.
++
+If `<mode>` is `none`, both the cover letter subject and body will be
+populated with placeholder text.
+
 --subject-prefix=<subject prefix>::
 	Instead of the standard '[PATCH]' prefix in the subject
 	line, instead use '[<subject prefix>]'. This
@@ -347,6 +368,7 @@ with configuration variables.
 	signOff = true
 	outputDirectory = <directory>
 	coverLetter = auto
+	inferCoverSubject = true
 ------------
 
 
diff --git a/builtin/log.c b/builtin/log.c
index f06f5d586b..0cc8b59991 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -37,6 +37,7 @@
 #include "range-diff.h"
 
 #define MAIL_DEFAULT_WRAP 72
+#define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -777,6 +778,13 @@ enum thread_level {
 	THREAD_DEEP
 };
 
+enum cover_from_description {
+	COVER_FROM_NONE,
+	COVER_FROM_MESSAGE,
+	COVER_FROM_SUBJECT,
+	COVER_FROM_AUTO
+};
+
 static enum thread_level thread;
 static int do_signoff;
 static int base_auto;
@@ -785,6 +793,23 @@ static const char *signature = git_version_string;
 static const char *signature_file;
 static enum cover_setting config_cover_letter;
 static const char *config_output_directory;
+static enum cover_from_description cover_from_description_mode = COVER_FROM_MESSAGE;
+
+static enum cover_from_description parse_cover_from_description(const char *arg)
+{
+	if (!arg || !strcmp(arg, "default"))
+		return COVER_FROM_MESSAGE;
+	else if (!strcmp(arg, "none"))
+		return COVER_FROM_NONE;
+	else if (!strcmp(arg, "message"))
+		return COVER_FROM_MESSAGE;
+	else if (!strcmp(arg, "subject"))
+		return COVER_FROM_SUBJECT;
+	else if (!strcmp(arg, "auto"))
+		return COVER_FROM_AUTO;
+	else
+		die(_("%s: invalid cover from description mode"), arg);
+}
 
 static int git_format_config(const char *var, const char *value, void *cb)
 {
@@ -891,6 +916,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		}
 		return 0;
 	}
+	if (!strcmp(var, "format.coverfromdescription")) {
+		cover_from_description_mode = parse_cover_from_description(value);
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -997,20 +1026,6 @@ static void print_signature(FILE *file)
 	putc('\n', file);
 }
 
-static void add_branch_description(struct strbuf *buf, const char *branch_name)
-{
-	struct strbuf desc = STRBUF_INIT;
-	if (!branch_name || !*branch_name)
-		return;
-	read_branch_desc(&desc, branch_name);
-	if (desc.len) {
-		strbuf_addch(buf, '\n');
-		strbuf_addbuf(buf, &desc);
-		strbuf_addch(buf, '\n');
-	}
-	strbuf_release(&desc);
-}
-
 static char *find_branch_name(struct rev_info *rev)
 {
 	int i, positive = -1;
@@ -1061,13 +1076,16 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      struct commit *origin,
 			      int nr, struct commit **list,
 			      const char *branch_name,
+			      enum cover_from_description cover_from_description_mode,
 			      int quiet)
 {
 	const char *committer;
-	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
-	const char *msg;
+	const char *subject = "*** SUBJECT HERE ***";
+	const char *body = "*** BLURB HERE ***";
 	struct shortlog log;
 	struct strbuf sb = STRBUF_INIT;
+	struct strbuf description_sb = STRBUF_INIT;
+	struct strbuf subject_sb = STRBUF_INIT;
 	int i;
 	const char *encoding = "UTF-8";
 	int need_8bit_cte = 0;
@@ -1095,17 +1113,34 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	if (!branch_name)
 		branch_name = find_branch_name(rev);
 
-	msg = body;
+	if (branch_name && *branch_name)
+		read_branch_desc(&description_sb, branch_name);
+
+	if (cover_from_description_mode != COVER_FROM_NONE && description_sb.len) {
+		if (cover_from_description_mode == COVER_FROM_SUBJECT ||
+				cover_from_description_mode == COVER_FROM_AUTO)
+			body = format_subject(&subject_sb, description_sb.buf, " ");
+
+		if (cover_from_description_mode == COVER_FROM_MESSAGE ||
+				(cover_from_description_mode == COVER_FROM_AUTO &&
+				 subject_sb.len > COVER_FROM_AUTO_MAX_SUBJECT_LEN))
+			body = description_sb.buf;
+		else
+			subject = subject_sb.buf;
+	}
+
 	pp.fmt = CMIT_FMT_EMAIL;
 	pp.date_mode.type = DATE_RFC2822;
 	pp.rev = rev;
 	pp.print_email_subject = 1;
 	pp_user_info(&pp, NULL, &sb, committer, encoding);
-	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
-	pp_remainder(&pp, &msg, &sb, 0);
-	add_branch_description(&sb, branch_name);
+	pp_title_line(&pp, &subject, &sb, encoding, need_8bit_cte);
+	pp_remainder(&pp, &body, &sb, 0);
+	strbuf_addch(&sb, '\n');
 	fprintf(rev->diffopt.file, "%s\n", sb.buf);
 
+	strbuf_release(&description_sb);
+	strbuf_release(&subject_sb);
 	strbuf_release(&sb);
 
 	shortlog_init(&log);
@@ -1545,6 +1580,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int use_patch_format = 0;
 	int quiet = 0;
 	int reroll_count = -1;
+	char *cover_from_description_arg = NULL;
 	char *branch_name = NULL;
 	char *base_commit = NULL;
 	struct base_tree_info bases;
@@ -1581,6 +1617,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "rfc", &rev, NULL,
 			    N_("Use [RFC PATCH] instead of [PATCH]"),
 			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, rfc_callback },
+		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
+			    N_("cover-from-description-mode"),
+			    N_("generate parts of a cover letter based on a branch's description")),
 		{ OPTION_CALLBACK, 0, "subject-prefix", &rev, N_("prefix"),
 			    N_("Use [<prefix>] instead of [PATCH]"),
 			    PARSE_OPT_NONEG, subject_prefix_callback },
@@ -1672,6 +1711,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	if (cover_from_description_arg)
+		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
+
 	if (0 < reroll_count) {
 		struct strbuf sprefix = STRBUF_INIT;
 		strbuf_addf(&sprefix, "%s v%d",
@@ -1920,7 +1962,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, use_stdout,
-				  origin, nr, list, branch_name, quiet);
+				  origin, nr, list, branch_name, cover_from_description_mode, quiet);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(rev.diffopt.file);
 		total++;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 72b09896cf..88db01308a 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1517,6 +1517,178 @@ test_expect_success 'format patch ignores color.ui' '
 	test_cmp expect actual
 '
 
+test_expect_success 'cover letter with invalid --cover-from-description and config' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	test_must_fail git format-patch --cover-letter --cover-from-description garbage master &&
+	test_config format.coverFromDescription garbage &&
+	test_must_fail git format-patch --cover-letter master
+'
+
+test_expect_success 'cover letter with format.coverFromDescription = default' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	test_config format.coverFromDescription default &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter master >actual &&
+	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with --cover-from-description default' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter --cover-from-description default master >actual &&
+	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with format.coverFromDescription = none' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	test_config format.coverFromDescription none &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter master >actual &&
+	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	! grep "^config subject$" actual &&
+	! grep "^body$" actual
+'
+
+test_expect_success 'cover letter with --cover-from-description none' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter --cover-from-description none master >actual &&
+	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	! grep "^config subject$" actual &&
+	! grep "^body$" actual
+'
+
+test_expect_success 'cover letter with format.coverFromDescription = message' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	test_config format.coverFromDescription message &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter master >actual &&
+	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with --cover-from-description message' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter --cover-from-description message master >actual &&
+	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with format.coverFromDescription = subject' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	test_config format.coverFromDescription subject &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter master >actual &&
+	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	! grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with --cover-from-description subject' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter --cover-from-description subject master >actual &&
+	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	! grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with format.coverFromDescription = auto (short subject line)' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	test_config format.coverFromDescription auto &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter master >actual &&
+	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	! grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with --cover-from-description auto (short subject line)' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter --cover-from-description auto master >actual &&
+	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	! grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with format.coverFromDescription = auto (long subject line)' '
+	test_config branch.rebuild-1.description "this is a really long first line and it is over 100 characters long which is the threshold for long subjects
+
+body" &&
+	test_config format.coverFromDescription auto &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter master >actual &&
+	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	grep "^this is a really long first line and it is over 100 characters long which is the threshold for long subjects$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with --cover-from-description auto (long subject line)' '
+	test_config branch.rebuild-1.description "this is a really long first line and it is over 100 characters long which is the threshold for long subjects
+
+body" &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter --cover-from-description auto master >actual &&
+	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	grep "^this is a really long first line and it is over 100 characters long which is the threshold for long subjects$" actual &&
+	grep "^body$" actual
+'
+
+test_expect_success 'cover letter with command-line --cover-from-description overrides config' '
+	test_config branch.rebuild-1.description "config subject
+
+body" &&
+	test_config format.coverFromDescription none &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter --cover-from-description subject master >actual &&
+	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
+	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	! grep "^config subject$" actual &&
+	grep "^body$" actual
+'
+
 test_expect_success 'cover letter using branch description (1)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
-- 
2.23.0.17.g7cce04acd6.dirty

