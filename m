Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52701F424
	for <e@80x24.org>; Wed, 25 Apr 2018 12:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753611AbeDYM24 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 08:28:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:60541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753205AbeDYM2y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 08:28:54 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lb5Tp-1eVuAZ40z3-00kjlM; Wed, 25 Apr 2018 14:28:47 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v9 05/17] git-rebase--interactive: clarify arguments
Date:   Wed, 25 Apr 2018 14:28:45 +0200
Message-Id: <32ec29cc643fbe3809e7dd603adc64c26c9280e6.1524659287.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524659287.git.johannes.schindelin@gmx.de>
References: <cover.1524306546.git.johannes.schindelin@gmx.de> <cover.1524659287.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:Uzh1FSfoH81O6V40frzLrUK4jGCNlog23a8RbuDRnFM8OWIPjg3
 fdcj6oXoMkX7YmNeu6JXvv/pE4/h5uZ8rTNOM7JmNgi52Ln9pGyPY2+lcgjgLg5wtzRsWne
 tWndVCtHxOgf+TgOHNehTEnoh69hBtnvRfmR5DTjVmhfT0yjLykxDKgfk1sUoa44cQr2sLW
 7eFmH/Hzv69z1OW/xL5+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/XdTwxICRxc=:9dYRhe+SVLIu8M0FVZxNZs
 XWMdNpJrioyKzNyYZy77xdMwIg/gUR/4hiV+PkIWuR3opNvYJPJnNmVgLH9tIGazr926TYJia
 KLTZfs3sX+dKwqbbUM4OWF23geIoNhUogkZoyCOJfSK6iSXIhBvnC4YPrYQ9s27rwrwfPzT+c
 po19pAVyLB0WIilnahVwOs0gT8Fb9a1eMd9enSg+g4ZiBcjUhplZpCwBzDihxc43rZK39k6Y5
 SMUFUK2g8WUt4UryuMsKbIBfTt5Xm7sGAKc7U0Y7wJYF9JaHrIE8sDsGy1G3liiClNvqz10f5
 S9LNw989phiqRyLP9ZreoJz9pb9wRkPbJtIimEz9QtfiVCFPOnW8fiGC/seCKc/U9Bi+1vzFa
 6PPugy5CFsQ7BfJGSJmbkT3JFVIm/bQ+5FmJbbYKA08mFOIie1JGydH/mlKzcHCIbLwN41t52
 0YB54MoN4K6M8tNUBPNTtK3pzFObjya89vo9jkfO7BpUUPneEA0/f9Zso+sf+ctX4zsM3Z1PM
 x8+lgavwbfjLEQRMtRdoXbchMQdMz+9LCf7CDZwqeehIXMScuduIM1J0tolpPbez2iRukvFfd
 TkINIDeD5JNw6TMZQBC7Bzymb8Oll1NcXhH210MBls/Zi+EjiWxvHNNlEWfuIQcYgRbuO4q10
 Am3U7/wKEsRMODVM37seQ/F5jj9TTdNQOzqxS44VnKxy/GohOPZLIZB9qGI8bK1VIOGOzh8x2
 +zgHWSd86sezd1TC0kGG6B64phHyNxXP7HDCvybiS/q586a0TR8NjV5y2jN8HFBDjTtJDS3iv
 DzgftcKU1oVRjFjqVH2e244piDGrG5feP7X/weCThQEKITEzKc/K6vlmFxUon8iuRc1tpoM
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
index 9947e6265fe..a60df2ee5a0 100644
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
2.17.0.windows.1.33.gfcbb1fa0445


