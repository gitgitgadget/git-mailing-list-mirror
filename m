From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 4/5] Documentation: Add gitweb config variables to git-config(1)
Date: Sun, 16 Oct 2011 13:07:34 +0200
Message-ID: <1318763255-23495-5-git-send-email-jnareb@gmail.com>
References: <1318763255-23495-1-git-send-email-jnareb@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sun Oct 16 13:15:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFOgW-0005pk-6w
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 13:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543Ab1JPLPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 07:15:09 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56218 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab1JPLPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 07:15:09 -0400
Received: by eye27 with SMTP id 27so2216070eye.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 04:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=x1azV52PC3866H19pfmsTVJQVsVq/QFaLRCYimhowKY=;
        b=HlDE+o+pc/8Ym8hiitK0hFZ1RPuHSxMWmEcjGtvdNFjGnVCmg9OrA8fFfmbYA9OMKy
         0pKKt2tySJoJvCACvOecb1xMfRBIHpvuLYN5bTejZDLB2DYpnrP3BIUPnrkMl5D9UYmT
         LI69Jfxm8cTOF/NetDfkFpCUVII9FZsCi9sZY=
Received: by 10.223.7.18 with SMTP id b18mr17032247fab.31.1318763707545;
        Sun, 16 Oct 2011 04:15:07 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl. [83.8.119.25])
        by mx.google.com with ESMTPS id x22sm16468798faa.5.2011.10.16.04.15.05
        (version=SSLv3 cipher=OTHER);
        Sun, 16 Oct 2011 04:15:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1318763255-23495-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183709>

Add a list of gitweb config variables to git-config(1) manpage, just
linking to gitweb(1) or gitweb.conf(5).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Unchanged from previous version.

 Documentation/config.txt |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 03296b7..b30c7e6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1071,6 +1071,23 @@ All gitcvs variables except for 'gitcvs.usecrlfattr' and
 is one of "ext" and "pserver") to make them apply only for the given
 access method.
 
+gitweb.category::
+gitweb.description::
+gitweb.owner::
+gitweb.url::
+	See linkgit:gitweb[1] for description.
+
+gitweb.avatar::
+gitweb.blame::
+gitweb.grep::
+gitweb.highlight::
+gitweb.patches::
+gitweb.pickaxe::
+gitweb.remote_heads::
+gitweb.showsizes::
+gitweb.snapshot::
+	See linkgit:gitweb.conf[5] for description.
+
 grep.lineNumber::
 	If set to true, enable '-n' option by default.
 
-- 
1.7.6
