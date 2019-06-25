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
	by dcvr.yhbt.net (Postfix) with ESMTP id A98001F461
	for <e@80x24.org>; Tue, 25 Jun 2019 10:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfFYKLb (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 06:11:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36782 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfFYKL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 06:11:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so26354499edq.3
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 03:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sIee3jvzarAXThJpOI5auz7CsbmfSGLzPDeYhLRewjI=;
        b=L2bWO5EwI1ddzDwmkSZH66fb6ILF1mrnnsOsM8OBSlJTd5w1RgzD3cX79Ai5/ykEbx
         zRT0ce0IYN2K3PhYVdE6GmFq+E+JFtJoUgs3n2hQwKjouMI85luqDqPfuQersG6qkG6E
         HaUd3BSAHkJ9k2trExA05q0Xs83Xb8wNTCZcb7+r+U2nWKdDEECKRi5x/SHG91hxMP03
         nAA2+PIG/uGYeXnNVUp1JYyEECLORKo7C7p6nf+4XetJbWR2tqo2UAVrhPmxQAhb2Qs4
         ZdnxKtIZb2lFT0xr16mNzj36fo+5zUtUsZwDvX0bMJzGtOUgaAynofPnlDJkNfggpHiW
         yX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sIee3jvzarAXThJpOI5auz7CsbmfSGLzPDeYhLRewjI=;
        b=okQqNsIrgWNpM/tdtPjTnrsBXjAmQC97dR0kUPSMoNdi06N1O+VRC4Qw2N3spSpdGe
         baxmbc+pznBfBBu/3WlNgdJWs42+byCJD6g+cCGOb1QYK44dpuUx/bB7ZAwChH3DZ5wl
         IUmsEV7C6a5ttwzF7Tko1wqrK3u4e9edIcLNw59qJ6O2Sp1w2dJxNwoEgYTWv6PzG9fR
         bvVHjcubRyFODYXl+bNQdwJxuFy8MmXLWo7QLCFe8OtsX7tKMcBe/pFFyvnsEnzdUENe
         7oxeDnta8+o6ouV996n3vwlk0td0LgS4E7/3Kf5goNMXcJImnwYO94rH+gI/oZbK8Jx3
         edkw==
X-Gm-Message-State: APjAAAV4wx+yw4WDBr4vTr9TjcAgjE3m5Qy1FAw1met6nc5Z9X1vkXW5
        NqmkgB4E/uuUtDhgJeN/gkjs39cM
X-Google-Smtp-Source: APXvYqxnxFzq/OxB2CPAyanxHl71BdDGEObKcY2pLD6J/b2RTJHyc3j1Al3xfviwAkdVv9yBd0C0cQ==
X-Received: by 2002:a50:fd0c:: with SMTP id i12mr81716360eds.55.1561457486934;
        Tue, 25 Jun 2019 03:11:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11sm2356992ejx.24.2019.06.25.03.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 03:11:26 -0700 (PDT)
Date:   Tue, 25 Jun 2019 03:11:26 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 10:11:23 GMT
Message-Id: <af4b823caac84899b5ac71da61af5ec00f88bb2f.1561457483.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.275.git.gitgitgadget@gmail.com>
References: <pull.275.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] status: do not report errors in sequencer/todo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

commit 4a72486de9 ("fix cherry-pick/revert status after commit",
2019-04-16) used parse_insn_line() to parse the first line of the todo
list to check if it was a pick or revert. However if the todo list is
left over from an old cherry-pick or revert and references a commit that
no longer exists then parse_insn_line() prints an error message which is
confusing for users [1]. Instead parse just the command name so that the
user is alerted to the presence of stale sequencer state by status
reporting that a cherry-pick or revert is in progress.

Note that we should not be leaving stale sequencer state lying around
(or at least not as often) after commit b07d9bfd17 ("commit/reset: try
to clean up sequencer state", 2019-04-16). However the user may still
have stale state that predates that commit.

Also avoid printing an error message if for some reason the user has a
file called `sequencer` in $GIT_DIR.

[1] https://public-inbox.org/git/3bc58c33-4268-4e7c-bf1a-fe349b3cb037@www.fastmail.com/

Reported-by: Espen Antonsen <espen@inspired.no>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c            | 24 ++++++++----------------
 t/t7512-status-help.sh | 16 ++++++++++++++++
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 793f86bf9a..f8eab1697e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2177,34 +2177,26 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 
 int sequencer_get_last_command(struct repository *r, enum replay_action *action)
 {
-	struct todo_item item;
-	char *eol;
-	const char *todo_file;
+	const char *todo_file, *bol;
 	struct strbuf buf = STRBUF_INIT;
-	int ret = -1;
+	int ret = 0;
 
 	todo_file = git_path_todo_file();
 	if (strbuf_read_file(&buf, todo_file, 0) < 0) {
-		if (errno == ENOENT)
+		if (errno == ENOENT || errno == ENOTDIR)
 			return -1;
 		else
 			return error_errno("unable to open '%s'", todo_file);
 	}
-	eol = strchrnul(buf.buf, '\n');
-	if (buf.buf != eol && eol[-1] == '\r')
-		eol--; /* strip Carriage Return */
-	if (parse_insn_line(r, &item, buf.buf, buf.buf, eol))
-		goto fail;
-	if (item.command == TODO_PICK)
+	bol = buf.buf + strspn(buf.buf, " \t\r\n");
+	if (is_command(TODO_PICK, &bol) && (*bol == ' ' || *bol == '\t'))
 		*action = REPLAY_PICK;
-	else if (item.command == TODO_REVERT)
+	else if (is_command(TODO_REVERT, &bol) &&
+		 (*bol == ' ' || *bol == '\t'))
 		*action = REPLAY_REVERT;
 	else
-		goto fail;
-
-	ret = 0;
+		ret = -1;
 
- fail:
 	strbuf_release(&buf);
 
 	return ret;
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index c1eb72555d..3c9308709a 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -798,6 +798,22 @@ EOF
 	test_i18ncmp expected actual
 '
 
+test_expect_success 'status shows cherry-pick with invalid oid' '
+	mkdir .git/sequencer &&
+	test_write_lines "pick invalid-oid" >.git/sequencer/todo &&
+	git status --untracked-files=no >actual 2>err &&
+	git cherry-pick --quit &&
+	test_must_be_empty err &&
+	test_i18ncmp expected actual
+'
+
+test_expect_success 'status does not show error if .git/sequencer is a file' '
+	test_when_finished "rm .git/sequencer" &&
+	test_write_lines hello >.git/sequencer &&
+	git status --untracked-files=no 2>err &&
+	test_must_be_empty err
+'
+
 test_expect_success 'status showing detached at and from a tag' '
 	test_commit atag tagging &&
 	git checkout atag &&
-- 
gitgitgadget
