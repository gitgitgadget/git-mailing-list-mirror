From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [RFC 6/8] test of utf_locallinks
Date: Wed, 13 May 2009 00:50:29 +0200
Message-ID: <1242168631-30753-7-git-send-email-robin.rosenberg@dewire.com>
References: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-3-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-4-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-5-git-send-email-robin.rosenberg@dewire.com>
 <1242168631-30753-6-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 00:51:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M40ox-0000ir-W2
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 00:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbZELWuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 18:50:55 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbZELWux
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 18:50:53 -0400
Received: from mail.dewire.com ([83.140.172.130]:19405 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752395AbZELWuv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 18:50:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9174B145A58E;
	Wed, 13 May 2009 00:50:51 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bJ5PmvVMmDZk; Wed, 13 May 2009 00:50:50 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id 5A947145A591;
	Wed, 13 May 2009 00:50:35 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <1242168631-30753-6-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118967>

---
 t/t4004-diff-rename-symlink.sh |    2 +-
 t/t4011-diff-symlink.sh        |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-symli=
nk.sh
index 663096e..b70d4ae 100755
--- a/t/t4004-diff-rename-symlink.sh
+++ b/t/t4004-diff-rename-symlink.sh
@@ -41,7 +41,7 @@ new file mode 120000
 --- /dev/null
 +++ "b/b\366zbar"
 @@ -0,0 +1 @@
-+xzzzy=C3=B6
++xzzzy=F6
 \ No newline at end of file
 diff --git "a/fr\366tz" "b/nitf\366l"
 similarity index 100%
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 0ee622f..b9a0cbf 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -16,7 +16,7 @@ index 0000000..7c465af
 --- /dev/null
 +++ "b/fr\366tz"
 @@ -0,0 +1 @@
-+x=C3=BCzz=C3=BC
++x=FCzz=FC
 \ No newline at end of file
 EOF
=20
@@ -42,7 +42,7 @@ index 7c465af..0000000
 --- "a/fr\366tz"
 +++ /dev/null
 @@ -1 +0,0 @@
--x=C3=BCzz=C3=BC
+-x=FCzz=FC
 \ No newline at end of file
 EOF
=20
@@ -69,9 +69,9 @@ index 7c465af..df1db54 120000
 --- "a/fr\366tz"
 +++ "b/fr\366tz"
 @@ -1 +1 @@
--x=C3=BCzz=C3=BC
+-x=FCzz=FC
 \ No newline at end of file
-+=C3=BCx=C3=BCuz
++=FCx=FCuz
 \ No newline at end of file
 EOF
=20
--=20
1.6.3.dirty
