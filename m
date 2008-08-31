From: =?utf-8?q?Ask=20Bj=C3=B8rn=20Hansen?= <ask@develooper.com>
Subject: [PATCH] Document sendemail.envelopesender configuration
Date: Sun, 31 Aug 2008 13:32:43 -0700
Message-ID: <1220214763-25790-1-git-send-email-ask@develooper.com>
References: <1A4402DD-03B5-4951-B8CA-DB8A8E93D8C4@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Ask=20Bj=C3=B8rn=20Hansen?= <ask@develooper.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 31 22:43:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZtlO-0001rU-Ue
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 22:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757141AbYHaUmE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Aug 2008 16:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbYHaUmD
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 16:42:03 -0400
Received: from gw.develooper.com ([64.81.84.140]:61384 "EHLO
	freja.develooper.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752120AbYHaUmD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 16:42:03 -0400
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Aug 2008 16:42:02 EDT
Received: by freja.develooper.com (Postfix, from userid 500)
	id A9D7E17D025; Sun, 31 Aug 2008 13:32:43 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.1.158.ga28da.dirty
In-Reply-To: <1A4402DD-03B5-4951-B8CA-DB8A8E93D8C4@develooper.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94508>


Signed-off-by: Ask Bj=C3=B8rn Hansen <ask@develooper.com>
---
 Documentation/git-send-email.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
index e2437f3..e3f82da 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -179,6 +179,9 @@ user is prompted for a password while the input is =
masked for privacy.
 	This is useful if your default address is not the address that is
 	subscribed to a list. If you use the sendmail binary, you must have
 	suitable privileges for the -f parameter.
+	Default is the value of the 'sendemail.envelopesender' configuration
+ 	value; if that is unspecified, choosing the envelope sender is left
+	to your MTA.
=20
 --to::
 	Specify the primary recipient of the emails generated.
--=20
1.6.0.1.158.ga28da.dirty
