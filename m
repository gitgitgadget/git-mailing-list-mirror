Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0EF71F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752978AbeDJM3t (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:29:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:60757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752956AbeDJM3r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:29:47 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LlVZv-1eWGGq1bOh-00bK1t; Tue, 10 Apr 2018 14:29:39 +0200
Date:   Tue, 10 Apr 2018 14:29:38 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v6 03/15] git-rebase--interactive: clarify arguments
In-Reply-To: <cover.1523362469.git.johannes.schindelin@gmx.de>
Message-ID: <087d6dc07f3d90911631d18c32e95219403bf423.1523362469.git.johannes.schindelin@gmx.de>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iWaO8PDTls3S7IENp3/EmS3asUiFSNF23jx5udcT9+9Ku6Cx0Vq
 1IGnnwR0SoUz+innQ45GUu9Y6YSS3YTpCYISrgyZwHFIPAjKubs/BiCAg+FsbH/oDOFhJgV
 41wtUZ0sSlQ1TFjWM0CewOMDxijNn9Wrr/BlLpxIl4fv1izb0xO1LOG1ZI4Fqp7jSq7kXvO
 bWtuZGlNO7Y2JLcMHhZYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uZ/Q6rXJzJQ=:owVzHLI73EgxKVOmqcKIs0
 REJr60YtRUE1VLih+x0fJQkQJPCAd6/hRv6WXsWrQucYsTi3U1FcBRw02WciD9ByI5ULhenp6
 TF9nJoYeKzDc4sCRjK/pJEYq7I0KT8TsLj5o6HMiGgbDQ4WkhrvHtAp3WIDaSTRF1zr9JyEwr
 eYu/QwO9m46A+XvCW+Sp7dc1+4v5TRLquypMML+w1G6J6eMYDX+SZ+zX8JFC9nHgy07KVFvsx
 HmD3v/6LJymcNNkMinBuStM/CZv8Lg2EYVTiYTzntqIILs+1FmBKOlyaUCes9ZoPzkRmtk49g
 unxkrfolTr8HPoIinDt4RfxTwZ0/pe9H8G/GdmzN5QYdfZWBG0DyyIr6h++6C4oE+Wjr+l+6C
 HBMLQKeS3xquBJeyQcoUEk7BTdpNCts7daTYVESVjnnJvBfK+SFJ2aYDyk34oa1lytPyKeCQK
 plBgtGk4v9Wd2MvSlnoWp8brAxVzwC0QtxHkLcbRH7mVPGouJ6Okvb8wpPhdQe/VHkeU7X66F
 ObR1Rs8fG/fDU8SM9sORitZSHZl+IZEL3jvKxIRgii/MibgNSQTtLpVrgpultKntLwVfStWjY
 pvo30yiRGy41RiFpX22QXF4MKuhLpJsWQfUuq0zLIJWi/ASrFL/imWVKqUISPMR+YFBrcQWY8
 SodmaD5i6GglwKM6IP99sbiXYjVv5aXY2zkgcFcCeTdHHRMNEFcXIT+ORat+Ug5PrX2TEvKtw
 801R55/4CUirUYBhXGtT43TQC1vUGnkBSHwchR0VyttfAOTwc/P0XkVxka/3uqMfBdx0EIAhy
 YIkMHi9a3JUJm0Of9nobTdkYXuq40G5XfNp1Vcvcb4ZB+77WuM=
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
index 50323fc2735..e1b865f43f2 100644
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
2.17.0.windows.1.4.g7e4058d72e3


