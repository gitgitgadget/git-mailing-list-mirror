From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 2/7] Documentation/replace: state that objects must be of
 the same type
Date: Fri, 06 Sep 2013 07:10:54 +0200
Message-ID: <20130906051100.6657.88471.chriscool@tuxfamily.org>
References: <20130906050702.6657.25651.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 07:12:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHoL2-0005Eb-Of
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 07:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783Ab3IFFL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 01:11:57 -0400
Received: from [194.158.98.14] ([194.158.98.14]:38043 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750771Ab3IFFLz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 01:11:55 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 5477070;
	Fri,  6 Sep 2013 07:11:34 +0200 (CEST)
X-git-sha1: 7e26b7577647ac64041ee2d2bf09b78358063d85 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130906050702.6657.25651.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234022>

A previous patch ensures that both the replaced and the replacement
objects passed to git replace must be of the same type, except if
-f option is used.

While at it state that there is no other restriction on both objects.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index e0b4057..d198006 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -20,8 +20,13 @@ The name of the 'replace' reference is the SHA-1 of the object that is
 replaced. The content of the 'replace' reference is the SHA-1 of the
 replacement object.
 
+The replaced object and the replacement object must be of the same type.
+This restriction can be bypassed using `-f`.
+
 Unless `-f` is given, the 'replace' reference must not yet exist.
 
+There is no other restriction on the replaced and replacement objects.
+
 Replacement references will be used by default by all Git commands
 except those doing reachability traversal (prune, pack transfer and
 fsck).
@@ -69,9 +74,7 @@ go back to a replaced commit will move the branch to the replacement
 commit instead of the replaced commit.
 
 There may be other problems when using 'git rev-list' related to
-pending objects. And of course things may break if an object of one
-type is replaced by an object of another type (for example a blob
-replaced by a commit).
+pending objects.
 
 SEE ALSO
 --------
-- 
1.8.4.rc1.28.ge2684af
