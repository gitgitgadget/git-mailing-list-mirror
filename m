Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 839D41F404
	for <e@80x24.org>; Thu, 19 Apr 2018 12:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752385AbeDSMUh (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 08:20:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:33291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751953AbeDSMUg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 08:20:36 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFLmC-1fEh0J3R7k-00EPfu; Thu, 19
 Apr 2018 14:20:27 +0200
Date:   Thu, 19 Apr 2018 14:20:11 +0200 (DST)
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
Subject: [PATCH v7 05/17] git-rebase--interactive: clarify arguments
In-Reply-To: <cover.1524139900.git.johannes.schindelin@gmx.de>
Message-ID: <b071b84a4cd4d3f3017a6568ffaab0bd19bf16d2.1524139900.git.johannes.schindelin@gmx.de>
References: <cover.1523362469.git.johannes.schindelin@gmx.de> <cover.1524139900.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PmDJKzF79lCyKQ6mD86b0gsQrIiiQ1/xwJy/PRaakCPm1DS8sLE
 c2SXz0pwDGPGEY4QHZaqcO/KSONMqQuF+KmjzwOZO8OX9WBTFywXe1oDwJRwMxi+sxgcQWi
 vhfllb2X5XrVQ/E8MGJGMfWqXPo/4h5BtiY8wxKzzGX6MZpzN2Q99gGSpCyKimKl/GjMiwk
 aME52E6qb2MQCWut85nXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VYrM3HAbUQk=:j5y4fF2V6uNOhAgRUd8c/B
 tP/v2O2AOPIxuSCCjZIGtfFt388XD4CHWlgTHohWFNG2y3QuRLnK9KNySkWscPLTF+LkOVk0N
 /K/mC3YhNZg+jroaw8ld/ACKlHy6gKFy7PfmE/ZRENdSTVsqKrI2RpqFqagp2N5O5Hdgkg4fe
 /jntW1nwoZEf6pUlg7o8fXES8kdHZWDjapyGWVAvieykmBXJiWmW1EEckYRAmODvSGgvf3nKQ
 3ePzrr8hIDGTvy14nFO1KOAKb8Q12uzR25IvVAGXug5BlutjOuVP/QL2J4Dvs3hqakkQvrJn+
 B44WmFKlxmDofkaYBI6UScacZOxfaLXF3Q/WrxcLayB+3/3wo8LokujIHI4ojdpxNXilrdUuN
 y4dsehtqBmlgLO9f9c+ksQRTWPUKlJAJ3a098z2lua9kGMdwepxyOiP8ipSA53SG6D77fJm9t
 gqES9HSvvcpPXYTuggQBJXsXcluiZ5cKtmXnUT+9XPAN62mTscbqekYzWMHtWHHfgFOQbnO12
 Lnw0xRFEkMV7jvVg5l/7n0zWkmLW1lm+VjIv2dgBJbmQN55ygVMEUhY+AC6aTAhKtAgheh9EI
 k53qRL+oB1q+G2mTf3L5Brhld/oSuhR+JicRdd0BtU+QqlO/idbt3eNvrXc5TsGf/2X5dgL/l
 zUZHxsO/JZ7jQZb0mKXVILapLBdpwWq/qwGOemY7zwqJVKUHnuINFAFPhN3ZH8TsgMTpBJgPU
 7OtLXGb4yWTxnNc4Uv4ISU+z7M/dUBWJtmn8I5r7TkJW/Fa88gd9S+3AT7opHJtDn9dtTcIzX
 hjDFfb4R08Vd/CdC95w9upnFsa0H8PJPsMGaWwCDAxK08RcOys=
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


