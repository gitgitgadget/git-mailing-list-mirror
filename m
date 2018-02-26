Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E775A1F404
	for <e@80x24.org>; Mon, 26 Feb 2018 21:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeBZV3d (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 16:29:33 -0500
Received: from mout.gmx.net ([212.227.15.18]:33459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751511AbeBZV3a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 16:29:30 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LxgM7-1egGIZ2iM7-017Eq1; Mon, 26
 Feb 2018 22:29:24 +0100
Date:   Mon, 26 Feb 2018 22:29:23 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 03/12] git-rebase--interactive: clarify arguments
In-Reply-To: <cover.1519680483.git.johannes.schindelin@gmx.de>
Message-ID: <157d36ec8954e33ddc5670548b66ca58025d81ad.1519680483.git.johannes.schindelin@gmx.de>
References: <cover.1518307771.git.johannes.schindelin@gmx.de> <cover.1519680483.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BNd4uknO3wI525WM6g6Qxr14bQa1x/+baOV2YGUWU3YsaMLzUhj
 6a+aylM13AFueF8LCxHCHx9T8By59yZL35iSjVWx6M6BRTamKCu+bqGQTQtaxBNwF8vsNJ+
 OGXIodBMhNab7tgEaS1TFATJf8uIKE7+efzBvA9EBVrodd85RZ08xgkpKgTIWfH4vusTbjl
 igpIFdwAv2IB+tBy3nmKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t5bfTLePzWw=:VczStFph7NntHzrUklTs56
 n1FJo638JC16oHHwc/8Q3be+79g0oUyypCBSWASsU70y0TDi4WtOmZEmXLwkpK1bpGx0QUtFt
 PGKX5NOn6RjoMpAP3LRZckpaCIuQ3PbAabwBm+3R/O5BKdrlr3aEah8wA8Hg4dy1UpbQTQacV
 qe9SsgNkgWS3ShSU0B3GbvL4/50ryW2x1SnHiNeN5PiXHrtnAoBHE6gFfLLLv/JNH4pWZEyjS
 RWB4m45dvbFAKeaGIG/3r0j22xtzc52L1kpyOMZ08zDmD3hGLbsnxh8rpBRrN/THlAA1t6D52
 SIrhtTwOCmazH//RJSTdkT3gAMIoKGJDjkZp3ZTJGsqcmXjkTj+nQl4Rns23dl5gcGjqemXiY
 CaEkY5UUqPKjt+p54V4RxFG+lL/ELPtlODjqBDGBWXoslzOBWl0797cMEqOPBRlVKkwqcWjoD
 6aOR7/tzsAaOmS49Nz6DKZkS8O254cw1TgiwJacNQikzVgPwfkuF0LkWi+OlFU9AJVLMwkFDu
 M3J9AN7pqUlZirKq/QcHxc6QnqZpHZ9p8JD9OOoPDslSk6r0YiKqDbX9Dtwr112beYvA5auHb
 5pPgNEMXNj9hZicb6aoCRl8kiS4P+mlXquJUrpjiHiWCyi5MLrCZmTplJkBRzeOrhxFcvYg8T
 6/gp0ZZFRRIqa4SkurJEFRNqGrbYP7I2DoXpI9p4HJ65k1MaTD+qw2LGDKuGyv6LlJPstplH+
 r9DU35TlmghFHBwMOAHQniODkkxdwGTFkLZ98gqGt9SfB5jHAXBaBW04hBvQaiO7wL1ym9YzA
 SumkfTHh1XiDLq2fY8ILRw7rwPoJCXD4AFPygAnfywLki+qvqPmF7zcUMkO6PXTkJaN6kQ/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <stefanbeller@gmail.com>

Up to now each command took a commit as its first argument and ignored
the rest of the line (usually the subject of the commit)

Now that we are about to introduce commands that take different
arguments, clarify each command by giving the argument list.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 81c5b428757..a2659fea982 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -155,13 +155,13 @@ reschedule_last_action () {
 append_todo_help () {
 	gettext "
 Commands:
-p, pick = use commit
-r, reword = use commit, but edit the commit message
-e, edit = use commit, but stop for amending
-s, squash = use commit, but meld into previous commit
-f, fixup = like \"squash\", but discard this commit's log message
-x, exec = run command (the rest of the line) using shell
-d, drop = remove commit
+p, pick <commit> = use commit
+r, reword <commit> = use commit, but edit the commit message
+e, edit <commit> = use commit, but stop for amending
+s, squash <commit> = use commit, but meld into previous commit
+f, fixup <commit> = like \"squash\", but discard this commit's log message
+x, exec <commit> = run command (the rest of the line) using shell
+d, drop <commit> = remove commit
 
 These lines can be re-ordered; they are executed from top to bottom.
 " | git stripspace --comment-lines >>"$todo"
-- 
2.16.1.windows.4


