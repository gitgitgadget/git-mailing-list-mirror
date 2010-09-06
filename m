From: Pascal Obry <pascal@obry.net>
Subject: [PATCH v4 2/3] Remove @smtp_host_parts variable as not used.
Date: Mon,  6 Sep 2010 19:38:02 +0200
Message-ID: <1283794683-2796-3-git-send-email-pascal@obry.net>
References: <1283794683-2796-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 19:38:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osfdu-0003lx-OO
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 19:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336Ab0IFRhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 13:37:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36298 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab0IFRhq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 13:37:46 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so3214915wyf.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 10:37:45 -0700 (PDT)
Received: by 10.227.154.9 with SMTP id m9mr1742994wbw.219.1283794665479;
        Mon, 06 Sep 2010 10:37:45 -0700 (PDT)
Received: from localhost (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
        by mx.google.com with ESMTPS id e31sm4838901wbe.23.2010.09.06.10.37.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 10:37:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc0
In-Reply-To: <1283794683-2796-1-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155588>

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
1.7.3.rc0
