From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH] Documentation: Mention comment syntax in gitattributes.txt
Date: Wed,  3 Dec 2014 12:11:13 +0100
Message-ID: <1417605073-8114-1-git-send-email-sojkam1@fel.cvut.cz>
Cc: Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 12:11:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw7qL-0008M1-9F
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 12:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbaLCLLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 06:11:33 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:33914 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbaLCLLc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 06:11:32 -0500
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 1A79B3CFE98
	for <git@vger.kernel.org>; Wed,  3 Dec 2014 12:11:31 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id pgyXHtqbz4cf for <git@vger.kernel.org>;
	Wed,  3 Dec 2014 12:11:26 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id DF2BA5CCE5D
	for <git@vger.kernel.org>; Wed,  3 Dec 2014 12:11:26 +0100 (CET)
Received: from wsh by steelpick.2x.cz with local (Exim 4.84)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1Xw7q9-00027W-Cz; Wed, 03 Dec 2014 12:11:25 +0100
X-Mailer: git-send-email 2.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260643>

gitattributes documentation does not specify how to include comments in
gitattribute files. According to parse_attr_line() in attr.c, # can be
used to start a comment. This patch add this to the documentation.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 Documentation/gitattributes.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index c892ffa..0a61a71 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -16,10 +16,16 @@ DESCRIPTION
 A `gitattributes` file is a simple text file that gives
 `attributes` to pathnames.
 
-Each line in `gitattributes` file is of form:
+Lines in `gitattributes` have one of the following forms:
 
+- A blank line can serve as a separator for readability.
+
+- A line starting with # serves as a comment.
+
+- An attribute specification line:
++
 	pattern	attr1 attr2 ...
-
++
 That is, a pattern followed by an attributes list,
 separated by whitespaces.  When the pattern matches the
 path in question, the attributes listed on the line are given to
-- 
2.1.3
