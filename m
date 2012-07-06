From: Max Horn <max@quendi.de>
Subject: =?UTF-8?q?=5BPATCH=201/2=5D=20Make=20=3Crefname=3E=20documentation=20more=20consistent=2E?=
Date: Fri,  6 Jul 2012 02:01:29 +0200
Message-ID: <1341532890-13829-1-git-send-email-max@quendi.de>
References: <7vpq8aqdzb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 02:01:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmvzZ-0004io-Lj
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 02:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540Ab2GFABn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jul 2012 20:01:43 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:35262 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756324Ab2GFABm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jul 2012 20:01:42 -0400
Received: from 77-22-67-26-dynip.superkabel.de ([77.22.67.26] helo=kaitain-wlan.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1SmvzQ-00007R-1b; Fri, 06 Jul 2012 02:01:40 +0200
X-Mailer: git-send-email 1.7.11.1.145.g4722b29.dirty
In-Reply-To: <7vpq8aqdzb.fsf@alter.siamese.dyndns.org>
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1341532902;82ff331b;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201079>

=46ormerly, the documentation for <refname> would occasionally say
<name> instead of <refname>. Now it uniformly uses <refname>.

Signed-off-by: Max Horn <max@quendi.de>
---
 Documentation/revisions.txt | 12 ++++++------
 1 Datei ge=C3=A4ndert, 6 Zeilen hinzugef=C3=BCgt(+), 6 Zeilen entfernt=
(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 1725661..f4f6f28 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -24,22 +24,22 @@ blobs contained in a commit.
   object referenced by 'refs/heads/master'.  If you
   happen to have both 'heads/master' and 'tags/master', you can
   explicitly say 'heads/master' to tell git which one you mean.
-  When ambiguous, a '<name>' is disambiguated by taking the
+  When ambiguous, a '<refname>' is disambiguated by taking the
   first match in the following rules:
=20
-  . If '$GIT_DIR/<name>' exists, that is what you mean (this is usuall=
y
+  . If '$GIT_DIR/<refname>' exists, that is what you mean (this is usu=
ally
     useful only for 'HEAD', 'FETCH_HEAD', 'ORIG_HEAD', 'MERGE_HEAD'
     and 'CHERRY_PICK_HEAD');
=20
-  . otherwise, 'refs/<name>' if it exists;
+  . otherwise, 'refs/<refname>' if it exists;
=20
   . otherwise, 'refs/tags/<refname>' if it exists;
=20
-  . otherwise, 'refs/heads/<name>' if it exists;
+  . otherwise, 'refs/heads/<refname>' if it exists;
=20
-  . otherwise, 'refs/remotes/<name>' if it exists;
+  . otherwise, 'refs/remotes/<refname>' if it exists;
=20
-  . otherwise, 'refs/remotes/<name>/HEAD' if it exists.
+  . otherwise, 'refs/remotes/<refname>/HEAD' if it exists.
 +
 'HEAD' names the commit on which you based the changes in the working =
tree.
 'FETCH_HEAD' records the branch which you fetched from a remote reposi=
tory
--=20
1.7.11.1.145.g4722b29.dirty
