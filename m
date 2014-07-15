From: =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>
Subject: [PATCH] .gitignore: Add git-verify-commit
Date: Tue, 15 Jul 2014 15:40:24 +0200
Message-ID: <1405431624-18903-1-git-send-email-sunny@sunbase.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 15 15:46:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X733l-0008IE-F2
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 15:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbaGONqS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jul 2014 09:46:18 -0400
Received: from smtp.domeneshop.no ([194.63.252.54]:55751 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbaGONqR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 09:46:17 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jul 2014 09:46:16 EDT
Received: from sunbase.org ([178.79.142.16]:49811 helo=linode.members.linode.com)
	by smtp.domeneshop.no with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <sunny@sunbase.org>)
	id 1X72yU-0005SC-Fy; Tue, 15 Jul 2014 15:40:54 +0200
X-Mailer: git-send-email 2.0.1.563.g66f467c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253560>

builtin/verify-commit.c was added in commit d07b00b ("verify-commit:
scriptable commit signature verification", 2014-06-23), update
=2Egitignore to ignore the generated file.

Signed-off-by: =C3=98yvind A. Holm <sunny@sunbase.org>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 42294e5..edb1dcf 100644
--- a/.gitignore
+++ b/.gitignore
@@ -165,6 +165,7 @@
 /git-upload-archive
 /git-upload-pack
 /git-var
+/git-verify-commit
 /git-verify-pack
 /git-verify-tag
 /git-web--browse
--=20
2.0.1.563.g66f467c
