From: =?UTF-8?q?Mattias=20Andr=C3=A9e?= <maandree@operamail.com>
Subject: [PATCH] CET is only one hour ahead of UTC
Date: Fri, 16 Aug 2013 12:54:11 +0200
Message-ID: <1376650451-2440-1-git-send-email-maandree@operamail.com>
References: <1376649800-442-1-git-send-email-maandree@operamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Mattias=20Andr=C3=A9e?= <maandree@operamail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 16 12:54:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAHfj-0005Hs-5B
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 12:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177Ab3HPKyT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 06:54:19 -0400
Received: from smtp-3.sys.kth.se ([130.237.48.192]:54410 "EHLO
	smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab3HPKyS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 06:54:18 -0400
Received: from mailscan-3.sys.kth.se (mailscan-3.sys.kth.se [130.237.48.170])
	by smtp-3.sys.kth.se (Postfix) with ESMTP id C23D7235E;
	Fri, 16 Aug 2013 12:54:17 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at kth.se
Received: from smtp-3.sys.kth.se ([130.237.48.192])
	by mailscan-3.sys.kth.se (mailscan-3.sys.kth.se [130.237.48.170]) (amavisd-new, port 10024)
	with LMTP id 4TK3L8uBZLdW; Fri, 16 Aug 2013 12:54:13 +0200 (CEST)
X-KTH-Auth: maandree [193.150.208.92]
X-KTH-mail-from: maandree@member.fsf.org
Received: from localhost.localdomain (c193-150-208-92.bredband.comhem.se [193.150.208.92])
	by smtp-3.sys.kth.se (Postfix) with ESMTPSA id 7F7B1216;
	Fri, 16 Aug 2013 12:54:13 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1376649800-442-1-git-send-email-maandree@operamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232418>

Signed-off-by: Mattias Andr=C3=A9e <maandree@operamail.com>
---
 man1/git-commit-tree.1 | 6 +++---
 man1/git-commit.1      | 6 +++---
 man1/git-tag.1         | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/man1/git-commit-tree.1 b/man1/git-commit-tree.1
index 2014cc3..1bef965 100644
--- a/man1/git-commit-tree.1
+++ b/man1/git-commit-tree.1
@@ -148,14 +148,14 @@ It is
 <unix timestamp>
 is the number of seconds since the UNIX epoch\&.
 <timezone offset>
-is a positive or negative offset from UTC\&. For example CET (which is=
 2 hours ahead UTC) is
-+0200\&.
+is a positive or negative offset from UTC\&. For example CET (which is=
 1 hour ahead UTC) is
++0100\&.
 .RE
 .PP
 RFC 2822
 .RS 4
 The standard email format as described by RFC 2822, for example
-Thu, 07 Apr 2005 22:13:13 +0200\&.
+Thu, 07 Apr 2005 22:13:13 +0100\&.
 .RE
 .PP
 ISO 8601
diff --git a/man1/git-commit.1 b/man1/git-commit.1
index 7d80bbd..c61ffaf 100644
--- a/man1/git-commit.1
+++ b/man1/git-commit.1
@@ -481,14 +481,14 @@ It is
 <unix timestamp>
 is the number of seconds since the UNIX epoch\&.
 <timezone offset>
-is a positive or negative offset from UTC\&. For example CET (which is=
 2 hours ahead UTC) is
-+0200\&.
+is a positive or negative offset from UTC\&. For example CET (which is=
 1 hour ahead UTC) is
++0100\&.
 .RE
 .PP
 RFC 2822
 .RS 4
 The standard email format as described by RFC 2822, for example
-Thu, 07 Apr 2005 22:13:13 +0200\&.
+Thu, 07 Apr 2005 22:13:13 +0100\&.
 .RE
 .PP
 ISO 8601
diff --git a/man1/git-tag.1 b/man1/git-tag.1
index c6d9be5..f6be47b 100644
--- a/man1/git-tag.1
+++ b/man1/git-tag.1
@@ -337,14 +337,14 @@ It is
 <unix timestamp>
 is the number of seconds since the UNIX epoch\&.
 <timezone offset>
-is a positive or negative offset from UTC\&. For example CET (which is=
 2 hours ahead UTC) is
-+0200\&.
+is a positive or negative offset from UTC\&. For example CET (which is=
 1 hour ahead UTC) is
++0100\&.
 .RE
 .PP
 RFC 2822
 .RS 4
 The standard email format as described by RFC 2822, for example
-Thu, 07 Apr 2005 22:13:13 +0200\&.
+Thu, 07 Apr 2005 22:13:13 +0100\&.
 .RE
 .PP
 ISO 8601
--=20
1.8.3.4
