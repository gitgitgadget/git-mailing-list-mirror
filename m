From: Joe Cridge <joe.cridge@me.com>
Subject: [PATCH] git-prompt.sh: Document GIT_PS1_STATESEPARATOR
Date: Wed, 10 Jun 2015 18:19:24 +0100
Message-ID: <1433956764-38130-1-git-send-email-joe.cridge@me.com>
Cc: gitster@pobox.com, rhansen@bbn.com, felipe.contreras@gmail.com,
	szeder@ira.uka.de, artagnon@gmail.com,
	Joe Cridge <joe.cridge@me.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 20:19:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2kbC-0005GE-H3
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 20:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbbFJSTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 14:19:36 -0400
Received: from st11p00im-amstp002.me.com ([17.172.80.96]:52217 "EHLO
	st11p00im-asmtp002.me.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S965253AbbFJSTa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 14:19:30 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jun 2015 14:19:30 EDT
Received: from Joes-MacBook-Pro.home
 (host109-149-223-177.range109-149.btcentralplus.com [109.149.223.177])
 by st11p00im-asmtp002.me.com
 (Oracle Communications Messaging Server 7.0.5.35.0 64bit (built Dec  4 2014))
 with ESMTPSA id <0NPQ00L4DO4E3F20@st11p00im-asmtp002.me.com> for
 git@vger.kernel.org; Wed, 10 Jun 2015 17:19:29 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.14.151,1.0.33,0.0.0000
 definitions=2015-06-10_13:2015-06-10,2015-06-10,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=48 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1412110000 definitions=main-1506100270
X-Mailer: git-send-email 2.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271336>

The environment variable GIT_PS1_STATESEPARATOR can be used to set the
separator between the branch name and the state symbols in the prompt.

At present the variable is not mentioned in the inline documentation which
makes it difficult for the casual user to identify.

Signed-off-by: Joe Cridge <joe.cridge@me.com>
---
 contrib/completion/git-prompt.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index f18aedc..366f0bc 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -66,6 +66,10 @@
 #     git           always compare HEAD to @{upstream}
 #     svn           always compare HEAD to your SVN upstream
 #
+# You can change the separator between the branch name and the above
+# state symbols by setting GIT_PS1_STATESEPARATOR. The default separator
+# is SP.
+#
 # By default, __git_ps1 will compare HEAD to your SVN upstream if it can
 # find one, or @{upstream} otherwise.  Once you have set
 # GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
-- 
2.4.2
