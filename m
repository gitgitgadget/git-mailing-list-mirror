From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH] git-prompt: Document GIT_PS1_DESCRIBE_STYLE
Date: Tue, 11 Dec 2012 18:20:24 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1212111815580.1093@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 00:25:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiZCs-0005lt-5W
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 00:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177Ab2LKXZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 18:25:29 -0500
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:47288 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754278Ab2LKXZ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2012 18:25:28 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Dec 2012 18:25:28 EST
X-AuditID: 12074424-b7fe06d0000008f0-5c-50c7bfbb5ac3
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 6E.8F.02288.BBFB7C05; Tue, 11 Dec 2012 18:20:27 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id qBBNKQFl028056;
	Tue, 11 Dec 2012 18:20:26 -0500
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id qBBNKOTG008837
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 11 Dec 2012 18:20:26 -0500 (EST)
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixCmqrLt7//EAg+un2C26rnQzWTT0XmF2
	YPK4eEnZ4/MmuQCmKC6blNSczLLUIn27BK6Mfc0XGQv6OSs+nNnC2MC4gr2LkZNDQsBE4nTH
	cmYIW0ziwr31bCC2kMA+RolbvUldjFxA9gZGiSnLulkhnD1MErf27mMBqWIR0JbY8u82I4jN
	JqAmMXfDZLCpIkD2xLZDYDXMAuISm5a/YQKxhQVsJA6ufAIW5xVwkGh5+J4VxBYV0JXYe+gM
	O0RcUOLkzCdQvVoSy6dvY5nAyDcLSWoWktQCRqZVjLIpuVW6uYmZOcWpybrFyYl5ealFuuZ6
	uZkleqkppZsYQcHF7qKyg7H5kNIhRgEORiUe3grVYwFCrIllxZW5hxglOZiURHnN9x0PEOJL
	yk+pzEgszogvKs1JLT7EKMHBrCTCu3IrUI43JbGyKrUoHyYlzcGiJM57PeWmv5BAemJJanZq
	akFqEUxWhoNDSYL32l6gRsGi1PTUirTMnBKENBMHJ8hwHqDhT0AW8xYXJOYWZ6ZD5E8xKkqJ
	874GSQiAJDJK8+B6YdH/ilEc6BVh3ucgVTzAxAHX/QpoMBPQ4DXfj4EMLklESEk1MBaWhyTb
	8gf3LN8Rv/vN/W7RxPe/f20+ZPtYr191xyqvK7sYZq4Sc496dDBOOZRFoj/hfoC27kW2I2Id
	l/WuVssXBLlUbeZa3ibz9Pw0W+MmxrpUK1sneZkDHldYu6zN0txPTNdz5D2nGVzqN/X3nwn/
	P2ptzbVj/2XytClck/kUl0VKXq+FEktxRqKhFnNRcSIAwww3ctkCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211316>

GIT_PS1_DESCRIBE_STYLE was introduced in v1.6.3.2~35.  Document it in the 
header comments.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 contrib/completion/git-prompt.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index bf20491..5ab488c 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -49,6 +49,15 @@
 # find one, or @{upstream} otherwise.  Once you have set
 # GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
 # setting the bash.showUpstream config variable.
+#
+# If you would like to see more information about the identity of
+# commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE
+# to one of these values:
+#
+#     contains      relative to newer annotated tag (v1.6.3.2~35)
+#     branch        relative to newer tag or branch (master~4)
+#     describe      relative to older annotated tag (v1.6.3.1-13-gdd42c2f)
+#     default       exactly matching tag
 
 # __gitdir accepts 0 or 1 arguments (i.e., location)
 # returns location of .git repo
-- 
1.8.0
