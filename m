Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94E7C1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 10:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeDUKcj (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 06:32:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:47431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752748AbeDUKci (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 06:32:38 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXUmw-1exH203LXy-00WWXS; Sat, 21
 Apr 2018 12:32:30 +0200
Date:   Sat, 21 Apr 2018 12:32:14 +0200 (DST)
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
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v8 05/16] git-rebase--interactive: clarify arguments
In-Reply-To: <cover.1524306546.git.johannes.schindelin@gmx.de>
Message-ID: <b071b84a4cd4d3f3017a6568ffaab0bd19bf16d2.1524306546.git.johannes.schindelin@gmx.de>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jB7T1h3ecrmckGAg+MM8n9NzrKv3+waJY7CuqpZNuAVN2cAyjdT
 JlxdGW7bmSO1ifjdsH1GtkE2Pd0RvLc7RSoWCKktNRtBvnwxuQ4yjGJgVR09rfj1He0Y0Di
 Ygiy7u4W8WzDSefRIYCnLcmsdRoPCnR5IC8AXeM5QrqDPsMjkgFODHKh6EodY4ewaZwFceG
 K615lNkLcz+IgvkD6KCZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a3PCjI69X4I=:nMQDTri/jvUIe+UERxfLvY
 7ePpsSH+CSK9pmwNeHGprE1NUw+YYFJkCa6rIz0DSQDV8f2lZdUOOp+Zz27wPLkwACNP/crsD
 plSLC8XLBOIR/1pHihT/uavq4qGV1Irajisk7ZGHB8Zxh81Nf1MjeCTU27VPT3EI+KN5wcQHq
 D6E3Yo/xFonkSAnyWXBlU3GbdRGJNr2XnCkC1tMyyZCKI3sCiQsrbgQgk+GxW2SFqNlecPa3U
 ivdWdBtw4kxMUy3lMHlRlAw/cNFbOvIoyJP9CBZt6A6nqAPAPChqJ+Mpahr7xfv3Id6ETQwRT
 uLdnaM0qusKVHLM6St9xIa9dcP/m2b/d/q/GYsA72gX7fSUNkXxE/Ak71G0MdJqNKLEvEwerY
 wRsfsC57NYg/3Xb2h1WhtuG+v5raVrqVhEsWoDhWnwuYvbynCS7imfi7iE/aApXStsZQaYqhA
 K+VxAjVLyNH4LtX+3xLbO3fcONj2OhEa3Md/VUQDXk9zvX95pDgtN9z8OdGI818bBBS3jeC0D
 IjNrxNlD/Rl2WJfKJ+Bp4NM6t6kfRDips1TYkw1/9lmbnd4PvhoVhL1epVMKm6OAP3cXpm/wm
 pkKB4KO0Crk1aIBEefrte6MoI3fvB3PdPcXznVrA59cJn1FyMBAmWamGhwJdE+CwlEXBNjZXL
 2tENoJEtoWou20bX52NHjsZtNJbTrh4JZgPTa1jhiezDGcM/yzQk9ozY7anXNRbnIcei+DuNA
 2js8UorzKc35WTl5oCbqRRCgciNCVM2cIXFtjaNvv+9Cx8zI6PX1oRkZaJ2R28l+bg/MmBszg
 1+KdESASM1BCjaq5cltEaGPQdGiCiovdkHLENQ5TikogOd5fGY=
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
2.17.0.windows.1.15.gaa56ade3205


