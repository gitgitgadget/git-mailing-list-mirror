From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 3/5] Documentation: Link to gitweb(1) and gitweb.conf(5) in other manpages
Date: Sun, 16 Oct 2011 13:07:33 +0200
Message-ID: <1318763255-23495-4-git-send-email-jnareb@gmail.com>
References: <1318763255-23495-1-git-send-email-jnareb@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sun Oct 16 13:12:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFOds-0004va-BK
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 13:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab1JPLM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 07:12:29 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51103 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983Ab1JPLM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 07:12:28 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt19so2277533bkb.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=D3Z2s5oj0a13LoeHb3eRBhItMuyy6LiYgCHuLHEkYB0=;
        b=bQQnUyIO5H55LuNsEOQwaq0qcGg1G//TsC8MseTvR1WcIpc+XWDFpG7kg7ki+jwtKc
         swmyTv19Q57GVLFRrgMeRvyBOk4dHqoy/3JS2d8ZNRpR/dssuE9tyToXaGDTmcHUZUem
         LcC3f3BiS+5wIndmW9f3Orh3ifB+M5Hs2prTU=
Received: by 10.223.77.71 with SMTP id f7mr17119153fak.33.1318763547657;
        Sun, 16 Oct 2011 04:12:27 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl. [83.8.119.25])
        by mx.google.com with ESMTPS id x22sm16468798faa.5.2011.10.16.04.12.25
        (version=SSLv3 cipher=OTHER);
        Sun, 16 Oct 2011 04:12:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1318763255-23495-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183707>

Add link to gitweb(1) in "SEE ALSO" section of git-instaweb(1) manpage,
and "Ancillary Commands" section of git(1) manpage (the latter by the
way of command-list.txt file).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Unchanged from previous version.

 Documentation/git-instaweb.txt |    4 ++++
 command-list.txt               |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index ea95c90..f3eef51 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -84,6 +84,10 @@ If the configuration variable 'instaweb.browser' is not set,
 'web.browser' will be used instead if it is defined. See
 linkgit:git-web{litdd}browse[1] for more information about this.
 
+SEE ALSO
+--------
+linkgit:gitweb[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/command-list.txt b/command-list.txt
index 95bf18c..a36ee9b 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -130,5 +130,6 @@ git-upload-pack                         synchelpers
 git-var                                 plumbinginterrogators
 git-verify-pack                         plumbinginterrogators
 git-verify-tag                          ancillaryinterrogators
+gitweb                                  ancillaryinterrogators
 git-whatchanged                         ancillaryinterrogators
 git-write-tree                          plumbingmanipulators
-- 
1.7.6
