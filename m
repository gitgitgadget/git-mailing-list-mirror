From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 2/2] post-receive-email: deprecate script in favor of git-multimail
Date: Sun, 14 Jul 2013 10:09:03 +0200
Message-ID: <1373789343-3189-3-git-send-email-mhagger@alum.mit.edu>
References: <1373789343-3189-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Chris Hiestand <chrishiestand@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michiel Holtkamp <git@elfstone.nl>,
	=?UTF-8?q?Stefan=20N=C3=A4we?= <stefan.naewe@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 10:10:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHOE-0001fn-R3
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697Ab3GNIKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 04:10:36 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:56125 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751621Ab3GNIJ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jul 2013 04:09:57 -0400
X-AuditID: 1207440c-b7f016d000005997-20-51e25cd47d0e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 33.96.22935.4DC52E15; Sun, 14 Jul 2013 04:09:56 -0400 (EDT)
Received: from michael.fritz.box (p4FDD4B13.dip0.t-ipconnect.de [79.221.75.19])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r6E89Jwm013667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Jul 2013 04:09:54 -0400
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1373789343-3189-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqHsl5lGgwdeTuharZj5mt1j77A6T
	xbWTi1ks9nZ3slp0XelmsmjovcJsceP8LlaLtzeXMFpc+rye1aLxSZHF7RXzmS3en/3P7MDj
	8ff9ByaPc3sXsnjsnHWX3WPil+OsHmcfPWD2uHhJ2ePzJjmPA5cfswVwRHHbJCWWlAVnpufp
	2yVwZ6x69Yix4AFfxZbmR+wNjBN4uhg5OSQETCQutxxnhrDFJC7cW8/WxcjFISRwmVGiZfJe
	FgjnPJPE5Zk/2EGq2AR0JRb1NDOB2CICahIT2w6BFTELrGWRmHvgECtIQlggTGLpreVgDSwC
	qhIfp3wEs3kFnCUW71nBBrFOQWLZl7VgqzkFXCQWXr4PZgsB1dy4vJV1AiPvAkaGVYxyiTml
	ubq5iZk5xanJusXJiXl5qUW6hnq5mSV6qSmlmxghgcuzg/HbOplDjAIcjEo8vBf2PwwUYk0s
	K67MPcQoycGkJMq7P/RRoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3mXKQDnelMTKqtSifJiU
	NAeLkjiv6hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRvdRRQo2BRanpqRVpmTglCmomDE0RwgWzg
	AdpQAlLIW1yQmFucmQ5RdIpRUUqc9wxIQgAkkVGaBzcAlmJeMYoD/SPMmxINVMUDTE9w3a+A
	BjMBDb696j7I4JJEhJRUA6MIz1HO7/e+JEpNWTfnupPo9QDbKI5ZN3+mnbKv0Lo+ZfG0f1JS
	+dPWFXB7bNOLsDNsq5zIJ7r2hT4LR8qE0s3br97qvqe1v9hDMzDBZWN9mOZ9YdXY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230311>

Add a notice to the top of post-receive-email explaining that the
script is no longer under active development and pointing the user to
git-multimail.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
If you think this is premature or the wording is too strong; feel free
to change or omit this patch.  I think it's fine, but then I might be
biased...

 contrib/hooks/post-receive-email | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 0e5b72d..23d7783 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -2,10 +2,19 @@
 #
 # Copyright (c) 2007 Andy Parkins
 #
-# An example hook script to mail out commit update information.  This hook
-# sends emails listing new revisions to the repository introduced by the
-# change being reported.  The rule is that (for branch updates) each commit
-# will appear on one email and one email only.
+# An example hook script to mail out commit update information.
+#
+# ***NOTICE***: This script is no longer under active development.  It
+# has been superseded by git-multimail, which is more capable and
+# configurable and is largely backwards-compatible with this script;
+# please see "contrib/hooks/multimail/".  For instructions on how to
+# migrate from post-receive-email to git-multimail, please see
+# "README.migrate-from-post-receive-email" in that directory.
+#
+# This hook sends emails listing new revisions to the repository
+# introduced by the change being reported.  The rule is that (for
+# branch updates) each commit will appear on one email and one email
+# only.
 #
 # This hook is stored in the contrib/hooks directory.  Your distribution
 # will have put this somewhere standard.  You should make this script
-- 
1.8.3.2
