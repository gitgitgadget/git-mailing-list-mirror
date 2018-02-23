Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DA481F404
	for <e@80x24.org>; Fri, 23 Feb 2018 12:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbeBWMhU (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 07:37:20 -0500
Received: from mout.gmx.net ([212.227.17.22]:54977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeBWMhC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 07:37:02 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MUpI8-1fEcGZ2anU-00YBCB; Fri, 23
 Feb 2018 13:36:55 +0100
Date:   Fri, 23 Feb 2018 13:36:40 +0100 (STD)
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
Subject: [PATCH v4 03/12] git-rebase--interactive: clarify arguments
In-Reply-To: <cover.1519389319.git.johannes.schindelin@gmx.de>
Message-ID: <157d36ec8954e33ddc5670548b66ca58025d81ad.1519389319.git.johannes.schindelin@gmx.de>
References: <cover.1518307771.git.johannes.schindelin@gmx.de> <cover.1519389319.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Hx/18oJmMsc0+0wj2tUwwCWES7zMbl7bHVHlGDsh4K1EiW0xsoe
 cYXgVjOH5AqQEYlx2yGdYSoEmu+7wqwOf/iKvriIVqRrkAsKM7ZM9y5gpKduBpg5jr05hqG
 br2NGinqRf9bj/g0X1Oi0/zaLwQSmjqPg8FPE+4weUB7ExyrJVh/tUe7BDMQZVn01Jj7C5b
 IH8O2JhC1paNS91KsKBAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fnkEt7O+tH8=:g+GIc8MOqvFFF4z7f1v7/a
 GgmVIuF9psJhnJGQoP4cWXbyHSh4ZohZ2zxiKDlJ+i/X4VTSk/sxu3IwA9c9TIL+R4fQgNTP3
 kgWqsz1mVU7iPTEBEJgpjf0z2o85d2LxLGMxZUJFWxIWmdfTYxeTiutHxZKVd538ABgP8HS8y
 cdpoWkKb5gtyhXMHG9b5MdRzzrioekfonX2ZVcNI9WuiLRkEKfd6gDral6TQsISS++XvG9dH+
 bdDpDTN3Gt3VSIWL7+xHQSpmhdk41PKeap29s8C/23h6xSMUkrUExgRdh6p8TR6NPIUvIOY2x
 SP35yWqOnQBAfDD3XL8GF4QFqSRtsrwDXJBsJ+wK8it8qUodE49h1EhZrO9KueYtBQ3iWcAym
 vgY1tDPgHgZlPVNannbK5TYQL+YmrWMouCOjrXSKb50FtGEIV736Dz/06oh9Hr6WHT3yS+VId
 UwkSfeRg+HEX3HW66eOJfHRZnSLXWEGz5Fn51iYQqI0YW7a9tRHH2LUFmV9o09M5CMWl2VYT7
 5e3PV08uDuVkdBGt/8KeUZoV6PrrCQXa5btZAWOAH3uYsqfRfN0c+XPutreP0J9MkxbtEE0N9
 afskkxmPFEoXf8qA2lXlg0NF1s8lKXE+Wq2kz/8uEIb1RpDuDpwLcf4UhuzkSGfk6WBOcN+t5
 NrDdEICY2lwJtJHTJcMmuMzuFtNh5TX9fVqeOtH3IFQIuFeHxvDotgxOl3HFs4Uy9vXOKk/MD
 mxJSoqrGHKEdichGzRdkz35VMAMqZJbDqv43qDHrlwFhb3x+5vQ60JZ3T9JoiRzAh/OBTEkdh
 Up/83JLrrkk+tHPLOzD9MQOB+PDHjcul54k6s521zPGsByjGnc=
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


