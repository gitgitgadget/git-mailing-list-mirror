From: Peter Eisentraut <peter@eisentraut.org>
Subject: [PATCH] git-commit-tree(1): correct description of defaults
Date: Thu, 10 Jan 2013 07:29:58 -0500
Message-ID: <1357820998.10754.6.camel@vanquo.pezone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 10 13:36:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtHND-0000FU-Jg
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 13:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab3AJMgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 07:36:24 -0500
Received: from eisentraut.org ([85.214.91.16]:39215 "EHLO gattler.pezone.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753002Ab3AJMgX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 07:36:23 -0500
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jan 2013 07:36:23 EST
Received: from [192.168.1.15] (pool-108-52-108-60.phlapa.fios.verizon.net [108.52.108.60])
	by gattler.pezone.net (Postfix) with ESMTPSA id E49F25A83EB;
	Thu, 10 Jan 2013 12:29:59 +0000 (UTC)
X-Mailer: Evolution 3.4.4-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213141>

The old phrasing indicated that the EMAIL environment variable takes
precedence over the user.email configuration setting, but it is the
other way around.

Signed-off-by: Peter Eisentraut <peter@eisentraut.org>
---
 Documentation/git-commit-tree.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 6d5a04c..a221169 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -72,13 +72,13 @@ if set:
 	GIT_COMMITTER_NAME
 	GIT_COMMITTER_EMAIL
 	GIT_COMMITTER_DATE
-	EMAIL
 
 (nb "<", ">" and "\n"s are stripped)
 
 In case (some of) these environment variables are not set, the information
 is taken from the configuration items user.name and user.email, or, if not
-present, system user name and the hostname used for outgoing mail (taken
+present, the environment variable EMAIL, or, if that is not set,
+system user name and the hostname used for outgoing mail (taken
 from `/etc/mailname` and falling back to the fully qualified hostname when
 that file does not exist).
 
-- 
1.7.10.4
