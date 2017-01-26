Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACBD71F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 14:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbdAZOwe (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 09:52:34 -0500
Received: from mout.gmx.net ([212.227.15.19]:62016 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752537AbdAZOwd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 09:52:33 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LtIZH-1cLiuT00KJ-012so5; Thu, 26
 Jan 2017 15:52:14 +0100
Date:   Thu, 26 Jan 2017 15:51:58 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 2/3] connect: rename tortoiseplink and putty variables
In-Reply-To: <cover.1485442231.git.johannes.schindelin@gmx.de>
Message-ID: <f414a890a98042f934f799ef89fe1f36e2c27d9f.1485442231.git.johannes.schindelin@gmx.de>
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de> <cover.1485442231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:y0P/td+DTal0kZpnwn1eHHLnRdR+NzvD0BmeFFcs4Rj/0ru93Z7
 wGB9DAM6uhB7XaeKraMOqhewJJOcrQPQOdrvLwG+JdU4nahcswaonORvL9NSPzRHB5Vatxg
 U3/y1wIV4cJldLUxL+KcuH1QkCgX2Z66x3exu5snRfLHiGZACOY/QHzZFXmDm4fWpyqbLet
 utXiChIFJ3Dw7dfUnX6sQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B1eG67SxxpY=:ansC1wboukp5avXMfxXlLn
 /InxkSxme9WymF9lO/V9i2f8XKwQKPFIYmvoG06fmph9cxbqJxaZJI5ithIeF2N1VlHRiyx3p
 YfBJK12ilCiEB3gNJbjti5LBlYYysYRPThaIQ+BsR1a6CEucsXlox94jxdTpQnYOw6HD3aYFZ
 BD1I3B5GV/H1ql87sWet7V3FQOdA0fCp44TvTkSCQvN7QRi8/Drp5z2xaC6/Ro1dIjXoe9n9M
 GsID42KVFhAequEBrHis8gu/LLEyyWWstXEDSu1TvgYZlLUOQfRmJi/3JzfENggnYK1ilO7mn
 oyo4aDu5xjf7RnRmuAPRyXAXVDVPoeJD5Mmyk1/OjHg2U6dPvlkYnF55BuxHHSOiRzBN6yfAO
 2FfoAAqpwoRLK3qMMKNfYJD2c/EsaI38v78tHxxL26f13HiCf/QwRyMyg/+jYPwpUKdt2BS7K
 BCx7cSGeYWU8UfCBypJewN8S1P3boNKTs0dJQfY6AxyiYmNtY8nLkFJTS0s1AJP+mH/a8mCA0
 S/ijmNkk2cxxsZmfgvOVPubY0EHo9u5+61v+q1vggzXosBwIcPTQf+05mQhcustafxlWuOboj
 3nZJALOu8GGCQ2DiQcRyDehFAkmDMoU6cno/jzvkE6StJUpTg0hVVuIs6npVFT/2rIQ17f/FP
 uuDicFduPEJ+9si9M2tEXQmavMMZki/j5VfTuC1Q+K/8Ein9YKUMGcI2Pm70J38xMKDBNha+l
 g4SAAOHs38c1y6vbGOH9OKxxJS3uccxe+kMbM4w22NTu333XqvHBa0k6Jggs+FSndvjcXQerD
 Xnz/Umc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

One of these two may have originally been named after "what exact
SSH implementation do we have" so that we can tweak the command line
options, but these days "putty=1" no longer means "We are using the
plink SSH implementation that comes with PuTTY".  It is set when we
guess that either PuTTY plink or Tortoiseplink is in use.

Rename them after what effect is desired.  The current "putty"
option is about using "-P <port>" when OpenSSH would use "-p <port>",
so rename it to port_option whose value is either 'p' or 'P".  The
other one is about passing an extra command line option "-batch",
so rename it needs_batch.

[jes: wrapped overly-long line]

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 connect.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/connect.c b/connect.c
index c81f77001b..9f750eacb6 100644
--- a/connect.c
+++ b/connect.c
@@ -769,7 +769,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
 			const char *ssh;
-			int putty = 0, tortoiseplink = 0;
+			int needs_batch = 0;
+			int port_option = 'p';
 			char *ssh_host = hostandport;
 			const char *port = NULL;
 			char *ssh_argv0 = NULL;
@@ -819,12 +820,14 @@ struct child_process *git_connect(int fd[2], const char *url,
 			if (ssh_argv0) {
 				const char *base = basename(ssh_argv0);
 
-				tortoiseplink = !strcasecmp(base, "tortoiseplink") ||
-					!strcasecmp(base, "tortoiseplink.exe");
-				putty = tortoiseplink ||
-					!strcasecmp(base, "plink") ||
-					!strcasecmp(base, "plink.exe");
-
+				if (!strcasecmp(base, "tortoiseplink") ||
+				    !strcasecmp(base, "tortoiseplink.exe")) {
+					port_option = 'P';
+					needs_batch = 1;
+				} else if (!strcasecmp(base, "plink") ||
+					   !strcasecmp(base, "plink.exe")) {
+					port_option = 'P';
+				}
 				free(ssh_argv0);
 			}
 
@@ -833,11 +836,11 @@ struct child_process *git_connect(int fd[2], const char *url,
 				argv_array_push(&conn->args, "-4");
 			else if (flags & CONNECT_IPV6)
 				argv_array_push(&conn->args, "-6");
-			if (tortoiseplink)
+			if (needs_batch)
 				argv_array_push(&conn->args, "-batch");
 			if (port) {
-				/* P is for PuTTY, p is for OpenSSH */
-				argv_array_push(&conn->args, putty ? "-P" : "-p");
+				argv_array_pushf(&conn->args,
+						 "-%c", port_option);
 				argv_array_push(&conn->args, port);
 			}
 			argv_array_push(&conn->args, ssh_host);
-- 
2.11.1.windows.prerelease.2.9.g3014b57


