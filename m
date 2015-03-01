From: Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCHv2] Add hint interactive cleaning
Date: Sun,  1 Mar 2015 12:58:25 +0100
Message-ID: <1425211105-18873-1-git-send-email-jn.avila@free.fr>
References: <1425137944-13667-1-git-send-email-jn.avila@free.fr>
Cc: Jean-Noel Avila <jn.avila@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 12:58:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YS2WL-0008IB-Jd
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 12:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbbCAL6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 06:58:36 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6]:61972 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbbCAL6f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 06:58:35 -0500
X-Greylist: delayed 73100 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Mar 2015 06:58:35 EST
Received: from localhost.localdomain (unknown [82.239.31.145])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 2803C822A4;
	Sun,  1 Mar 2015 12:58:09 +0100 (CET)
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1425137944-13667-1-git-send-email-jn.avila@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264557>

For translators, specify that a  y/N reply is needed.

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 builtin/clean.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 7e7fdcf..98c103f 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -754,7 +754,8 @@ static int ask_each_cmd(void)
 		/* Ctrl-D should stop removing files */
 		if (!eof) {
 			qname = quote_path_relative(item->string, NULL, &buf);
-			printf(_("remove %s? "), qname);
+			/* TRANSLATORS: Make sure to keep [y/N] as is */
+			printf(_("Remove %s [y/N]? "), qname);
 			if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
 				strbuf_trim(&confirm);
 			} else {
-- 
2.3.0
