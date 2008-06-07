From: =?utf-8?q?Ask=20Bj=C3=B8rn=20Hansen?= <ask@develooper.com>
Subject: [PATCH] Allow the envelope sender to be set via configuration
Date: Sat,  7 Jun 2008 00:33:42 -0700
Message-ID: <1212824022-31991-1-git-send-email-ask@develooper.com>
Cc: =?utf-8?q?Ask=20Bj=C3=B8rn=20Hansen?= <ask@develooper.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 09:34:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4swf-00035h-2U
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 09:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046AbYFGHdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 03:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754662AbYFGHdn
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 03:33:43 -0400
Received: from gw.develooper.com ([64.81.84.140]:53521 "EHLO
	freja.develooper.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754498AbYFGHdn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 03:33:43 -0400
Received: by freja.develooper.com (Postfix, from userid 500)
	id 46C4517D034; Sat,  7 Jun 2008 00:33:42 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.rc1.23.gd2d97.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84184>

---
 git-send-email.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index a598fdc..ec69c23 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -209,6 +209,7 @@ my %config_settings = (
     "bcc" => \@bcclist,
     "aliasesfile" => \@alias_files,
     "suppresscc" => \@suppress_cc,
+    "envelopesender" => \$envelope_sender,
 );
 
 # Handle Uncouth Termination
-- 
1.5.6.rc1.23.gd2d97.dirty
