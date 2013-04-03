From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH] git-tag(1): we tag HEAD by default
Date: Wed, 3 Apr 2013 16:27:14 +0200
Message-ID: <137ebfa428b16497287c55e552372df1087f1588.1364999181.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 03 16:27:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNOfE-00049v-Hc
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 16:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758495Ab3DCO1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 10:27:19 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:16976 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755761Ab3DCO1S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 10:27:18 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 3 Apr
 2013 16:27:12 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 3 Apr
 2013 16:27:14 +0200
X-Mailer: git-send-email 1.8.2.548.g7173465
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219936>

The <commit>|<object> argument is actually not explained anywhere
(except implicitly in the description of an unannotated tag).  Write a
little explanation, in particular to cover the default.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

Prompted by a question on IRC about the default value.  Do we actually
read our own docs? ;-)

 Documentation/git-tag.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index e3032c4..697df50 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -126,6 +126,11 @@ This option is only applicable when listing tags without annotation lines.
 	linkgit:git-check-ref-format[1].  Some of these checks
 	may restrict the characters allowed in a tag name.
 
+<commit>, <object>::
+	The object that the new tag will refer to, usually a commit.
+	Defaults to HEAD.
+
+
 CONFIGURATION
 -------------
 By default, 'git tag' in sign-with-default mode (-s) will use your
-- 
1.8.2.548.g7173465
