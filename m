From: Pascal Obry <pascal@obry.net>
Subject: [PATCH v2 2/3] Remove @smtp_host_parts variable as not used.
Date: Sat,  4 Sep 2010 21:55:27 +0200
Message-ID: <1283630128-3472-3-git-send-email-pascal@obry.net>
References: <1283630128-3472-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 21:55:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oryq6-0005oe-3a
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 21:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab0IDTzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 15:55:33 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36281 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab0IDTzc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 15:55:32 -0400
Received: by wyf22 with SMTP id 22so1379240wyf.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 12:55:31 -0700 (PDT)
Received: by 10.227.142.208 with SMTP id r16mr84579wbu.140.1283630131290;
        Sat, 04 Sep 2010 12:55:31 -0700 (PDT)
Received: from localhost (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
        by mx.google.com with ESMTPS id i14sm2910604wbe.6.2010.09.04.12.55.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 12:55:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.277.gb49c4
In-Reply-To: <1283630128-3472-1-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155351>

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
1.7.2.2.277.gb49c4
