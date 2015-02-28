From: Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH] Add hint for translators for y/n reply.
Date: Sat, 28 Feb 2015 16:39:04 +0100
Message-ID: <1425137944-13667-1-git-send-email-jn.avila@free.fr>
References: <xmqq1tlfqcd8.fsf@gitster.dls.corp.google.com>
Cc: Jean-Noel Avila <jn.avila@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 16:40:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRjVA-0000Vh-DJ
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 16:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbbB1PkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2015 10:40:19 -0500
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:34104 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbbB1PkS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2015 10:40:18 -0500
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 7790777C6FC
	for <git@vger.kernel.org>; Sat, 28 Feb 2015 16:40:15 +0100 (CET)
Received: from localhost.localdomain (unknown [82.239.31.145])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 4886582298;
	Sat, 28 Feb 2015 16:39:54 +0100 (CET)
X-Mailer: git-send-email 2.3.0
In-Reply-To: <xmqq1tlfqcd8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264534>

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 builtin/clean.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/clean.c b/builtin/clean.c
index 7e7fdcf..2c98661 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -754,6 +754,9 @@ static int ask_each_cmd(void)
 		/* Ctrl-D should stop removing files */
 		if (!eof) {
 			qname = quote_path_relative(item->string, NULL, &buf);
+			/*TRANSLATORS: Make sure to include [Y] and [n] in your
+			translation. The program will only accept English input
+			at this point. */
 			printf(_("remove %s? "), qname);
 			if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
 				strbuf_trim(&confirm);
-- 
2.3.0
