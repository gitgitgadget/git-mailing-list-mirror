Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAE32207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 10:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031146AbdDTKLQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 06:11:16 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33008 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030738AbdDTKLO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 06:11:14 -0400
Received: by mail-io0-f193.google.com with SMTP id k87so14518487ioi.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 03:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/RaNGnPKMoa5EOrxibKBFfwDyIhWrn8bj/JCiorurjA=;
        b=uW/akwhjPMTVfzJLtDN4j8L/y1AxEII/GNaP5vN4AeEAyiBjpUejDIUFFOWFTcTvfZ
         Y6xUmB47FpAlggMc1NzuSaBJ9pY5n8Zy9+ZmUaBc6ZiA4VmvR1+Ts23WtjzprV0a3Mcq
         zAvXkbQyH4piv/gDftX0lHtN2yAD0dtFn4psCHSASRzlimM91CiZ95l5NHzCp/ZBSv2o
         heEbWg/v9I0Ze7YHQn81o7d1M+lmnJ+1+b5C2nSC25wrweHxStreEj2s4B7LulCHbMXA
         z6hL0IR/zC5vG7vhpX/ZaEF+fG3cNqKD1JeqLooH9Cpz5+2QNlxjMTUsiIGvoytAOvVn
         9cMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/RaNGnPKMoa5EOrxibKBFfwDyIhWrn8bj/JCiorurjA=;
        b=rZo00fp3qGmU1QKa+C4s8CIhgZIyCqFrePnedQR9kRV+q4BlPBtTc56SGjRCkqGhab
         9WliTng4Lny6KuyRXgz0+XMPb6sGa10wUZjATEMNdKI8JFju+QKMOu51q6iPf91bszi4
         Dad7ceD3xO5itl6TVBi6rcP6IUDQhk03wQho5UcbKsazIgnYQ6BzrQb28pRdBL/RT9OH
         ywb0VBCDelr7IIeZDc4ryuB/mBU3cqjEF8bEDT3UwxLA5jMjUAMPKOAVQ/RvjrAyNPFK
         nQbUHqh231adqQZ0w3eaYYR7Yi97xe3Fs7irqOPgqiLIul5O/xoijXqmi1VbzWNXVbbM
         oVsA==
X-Gm-Message-State: AN3rC/5hOSk4fWSBRuqNhoSbE6gHNBcfuYx0G9I+rvRFkMODFvlTRivg
        Mc+za6yL8I7nMg==
X-Received: by 10.99.126.23 with SMTP id z23mr2483954pgc.63.1492683073319;
        Thu, 20 Apr 2017 03:11:13 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id g75sm9536799pfg.82.2017.04.20.03.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 03:11:12 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 17:11:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/6] nd/worktree-move update
Date:   Thu, 20 Apr 2017 17:10:18 +0700
Message-Id: <20170420101024.7593-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This

 - squashes in Johannes' fix (that's already on jch/nd/worktree-move)
 - fixes the compile problem on latest master (because prefix_filename
   takes one argument less)
 - fixes the test failure because real_path() is called twice (the
   first one hidden in read_gitfile_gently) but the output is not
   duplicated.

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 74fc8578fc..b5afba1646 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -561,9 +561,7 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	if (ac != 2)
 		usage_with_options(worktree_usage, options);
 
-	strbuf_addstr(&dst, prefix_filename(prefix,
-					    strlen(prefix),
-					    av[1]));
+	strbuf_addstr(&dst, prefix_filename(prefix, av[1]));
 	if (is_directory(dst.buf))
 		/*
 		 * keep going, dst will be appended after we get the
diff --git a/worktree.c b/worktree.c
index 85bf481cec..c695dcf982 100644
--- a/worktree.c
+++ b/worktree.c
@@ -311,8 +311,8 @@ static int report(int quiet, const char *fmt, ...)
 int validate_worktree(const struct worktree *wt, int quiet)
 {
 	struct strbuf sb = STRBUF_INIT;
-	const char *path;
-	int err;
+	char *path;
+	int err, ret;
 
 	if (is_main_worktree(wt)) {
 		/*
@@ -344,14 +344,17 @@ int validate_worktree(const struct worktree *wt, int quiet)
 		return report(quiet, _("'%s/.git' does not exist"), wt->path);
 	}
 
-	path = read_gitfile_gently(sb.buf, &err);
+	path = xstrdup_or_null(read_gitfile_gently(sb.buf, &err));
 	strbuf_release(&sb);
 	if (!path)
 		return report(quiet, _("'%s/.git' is not a .git file, error code %d"),
 			      wt->path, err);
 
-	if (fspathcmp(path, real_path(git_common_path("worktrees/%s", wt->id))))
-		return report(quiet, _("'%s' does not point back to"),
+	ret = fspathcmp(path, real_path(git_common_path("worktrees/%s", wt->id)));
+	free(path);
+
+	if (ret)
+		return report(quiet, _("'%s' does not point back to '%s'"),
 			      wt->path, git_common_path("worktrees/%s", wt->id));
 
 	return 0;

Nguyễn Thái Ngọc Duy (6):
  worktree.c: add validate_worktree()
  worktree.c: add update_worktree_location()
  worktree move: new command
  worktree move: accept destination as directory
  worktree move: refuse to move worktrees with submodules
  worktree remove: new command

 Documentation/git-worktree.txt         |  28 +++---
 builtin/worktree.c                     | 160 +++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |   5 +-
 t/t2028-worktree-move.sh               |  57 ++++++++++++
 worktree.c                             |  87 ++++++++++++++++++
 worktree.h                             |  11 +++
 6 files changed, 337 insertions(+), 11 deletions(-)

-- 
2.11.0.157.gd943d85

