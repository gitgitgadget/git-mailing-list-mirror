From: Pascal Obry <pascal@obry.net>
Subject: [PATCH v3 2/3] Remove @smtp_host_parts variable as not used.
Date: Sun,  5 Sep 2010 19:48:59 +0200
Message-ID: <1283708940-2172-3-git-send-email-pascal@obry.net>
References: <1283708940-2172-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 19:48:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsJKe-0005FF-2S
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 19:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112Ab0IERsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 13:48:39 -0400
Received: from smtp19.orange.fr ([80.12.242.19]:28098 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752873Ab0IERsh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 13:48:37 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1928.orange.fr (SMTP Server) with ESMTP id BA8A520003F2;
	Sun,  5 Sep 2010 19:48:36 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1928.orange.fr (SMTP Server) with ESMTP id AD3B12000494;
	Sun,  5 Sep 2010 19:48:36 +0200 (CEST)
Received: from localhost (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
	by mwinf1928.orange.fr (SMTP Server) with ESMTP id 7A18220003F2;
	Sun,  5 Sep 2010 19:48:36 +0200 (CEST)
X-ME-UUID: 20100905174836500.7A18220003F2@mwinf1928.orange.fr
X-Mailer: git-send-email 1.7.2.3.316.ga4c47
In-Reply-To: <1283708940-2172-1-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155468>

---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 0063606..39cb5af 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -189,7 +189,7 @@ sub do_edit {
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
-my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts, $smtp_domain);
+my ($identity, $aliasfiletype, @alias_files, $smtp_domain);
 my ($validate, $confirm);
 my (@suppress_cc);
 my ($auto_8bit_encoding);
-- 
1.7.2.3.316.ga4c47
