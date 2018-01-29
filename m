Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C9B1FAE2
	for <e@80x24.org>; Mon, 29 Jan 2018 22:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbeA2Wyq (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:54:46 -0500
Received: from mout.gmx.net ([212.227.15.18]:60285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751529AbeA2Wyp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:54:45 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MTCDO-1eEH4S2ruI-00SBVB; Mon, 29 Jan 2018 23:54:38 +0100
Date:   Mon, 29 Jan 2018 23:54:37 +0100 (STD)
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
Subject: [PATCH v2 01/10] git-rebase--interactive: clarify arguments
In-Reply-To: <cover.1517266437.git.johannes.schindelin@gmx.de>
Message-ID: <474e71f85c613d3c5fe38acd505fa23960afd36b.1517266437.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <cover.1517266437.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:J8vvjHSkatc1iyfKQpsp8b9sq5Qu1aUSbBPfFJhWpWeQOK9iqaH
 UmEYSs5JsxL49B8laqegVJASXj5i0Rpop25P3pasDObXb6GZ4EJvm2ukFNMii6wySVf4e0a
 bdzfYqlA+jt703+eqS5H09u+jbpLV9jM3Vvz8ovgI/0zD8DNQxZArYNGgZs4zmaO6MvRnkV
 OQ3ZmwC2CLANbHtP3gSRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JeK3Dz3QpnU=:e+jNljtGgh7EM1cdnsPMF3
 eVo+fGx7SbK/GgsImGw0OoTQpp7Mbn8bDmZ8CUly6JcqcmPn5ym5EO8S5i9eHFDOeCeIc4OXc
 yZ1sNsyiwriCbisIKYRyUQK4qls2LQbOZW8xYzp9s6nI6DWIMuacujYXWaMl9/smwHH56Ydkl
 Cw0hWjz+uEK+4tMmamRFU1QM1mJzonwlLN6W+C2O0/zwDuxQZLEeSnr0ABYu2oq509utick8j
 g+Q1PAjegxjFqJompVAksBSv4sn7kWgE0ex5GEXoaApJtNUXlU5yeW6RdjhKfIpp+9LlqpBKt
 wDpfx4tMN2EhwXQrMgd3RCr9dATN5x241yW8fbtfcoeWzGMcygZT9Ag1IneNuH00OUjBGBu2k
 4fNVKWOuxa3NElJeNaeufejLCVkR/PKjownFrVufTKNqED13Gh4tfesGmr4xqkkw0X0b2OKGo
 BptMqmr1eYcW5JmuD85bjsGZM+BS+BuksBDtQDPsyBz647SUak/GNOraAXyvNkGxGg+EbxCuM
 NJfJ57ubGI5ECkLdHHYiEM50T7CgPBefvXqbJAGNKil8PM6uYgPW+g+otqm+IM+FjidMq7nze
 /o0rYRyI9sGO8lz4ZQwLcFcWFGgJjGPEe5j3z3OVuAOgIztIdAP+O8JR139GkT50TIiqaXw/b
 wkK+CskSvYY6A3BIgj/IwURhlhW9fBaspK2cmre/tBsTyz3+/0fWUg2Pi9Es/kze88/KqBLr9
 g/rO4FlcJ02pjO4UT2TwwD7atXJPGaldrTHhLqlLsRfWSddoVvj3AMHDtlB7mgPOa9PqwtzuU
 GmZogajAa+7zvE3vFWq+2xeIaeg/A8VedZveQywODGl3oFzPCTOJWPtP1r0CbabOEvSEVsI
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
index d47bd29593a..fcedece1860 100644
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
2.16.1.windows.1


