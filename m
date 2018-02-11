Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DE4C1F404
	for <e@80x24.org>; Sun, 11 Feb 2018 00:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752983AbeBKAKX (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 19:10:23 -0500
Received: from mout.gmx.net ([212.227.15.15]:47241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752973AbeBKAKW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 19:10:22 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0LnxQO-1fD8Ht3KQK-00fwpb; Sun, 11 Feb 2018 01:10:13 +0100
Date:   Sun, 11 Feb 2018 01:10:13 +0100 (STD)
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
Subject: [PATCH v3 03/12] git-rebase--interactive: clarify arguments
In-Reply-To: <cover.1518307771.git.johannes.schindelin@gmx.de>
Message-ID: <84bd8e667e2b5d9934854d390ae6ad6ce258987c.1518307771.git.johannes.schindelin@gmx.de>
References: <cover.1517266437.git.johannes.schindelin@gmx.de> <cover.1518307771.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:oOhOWJEC1UfMm4i8RYuFRQD3fkI1j6oGe0OnvsSxqpaF+Rm+rq5
 HPZF5UAH63m8PQaLcMQ+99Npg/Oe5bTOdLEXIsfMdHy7DkzJ9Oj0GpXZvRQ44FEwCoJKGSS
 2SLOJenAwSPg1nxuepnSZ9O1EhH7iG7Ka7wd6dyQBayy0EL1KzI3/Xhc9RFCkPafRODKt1b
 vnjop4Y0UHBp9zQlGI3zQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ptgAvqYOP9Y=:fk+SMzM2fjP8LDH34OSsvy
 hUpG4teLs+/b69Epsd/i5b0kSIPdie7JEwBVBD86d6ozHPzPuCIEtr/ELzTnAOd2H2jR7A9UK
 sn0ufF9uJ3eloReVuHRsoMALNRLtPcSeBFinKdlZc3r7n0zDGb31ZhSkRntN9Ie7bvlKHcbwn
 zJ0jFoQqi/zZb38Fwd5CY7Zgvr+4opOIMqbH8ZDWMijGP7BGvHje2+A6XPB4FfQ3bmMycg9cM
 llLLiQ1pcZls2K/p1dRqI2mKeE29YnAD7jtCV633xuLR8E969Gj4YNhiBpsNiQDh5qGf0Re4+
 QqcqDpsRg0FXpc3ugC+23JsKYn6gxU7Pk4rcw6QYjwdgtUH73n0gzmT6GWlRSRTGcKsIcy08o
 6qHwaLMVcfYKa9gVRFbxH2L84k2OB2sxYaWSQB9b+yKngD1QOGxvvODZo1LhiCaR4scoF1+Vk
 VIhhT1wZnAaQsuiBevdf7tTHnpK/66XVRDncfiYO4VuTqKXIVHgoP3UHMSoWTWS92IIduWgEA
 fg2bAypuAa2r5HUyIsW2zIMxTx9Od4OU+MpQRvooikKFktDbdz0EJ5M5CygHpj25NE9Xahe8E
 zCDeBuszDMUiIPVW7670zpc2vDmwhutBUIs/WeTDRO1AXWn16nAw07gn6j2OSu+rLUx7oBkPX
 xu20MShXL+VLJTIgIuCXUuGQ/bniDxRANho4vfwyY7Uv/RvSWluxm1WPMueRmCBsG1T+iRq9p
 spq11G+gbdc+8xI/14RePQ+fNy/RrDR7ptWQd7n3/v1EbOZ7SQBvG2oxR7XZSh/KyVET7rliz
 yEGMEwHZGAd40srFl4ZRmRY3AQMlHBAFKrKkn9/cVIoSlCT97s=
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


