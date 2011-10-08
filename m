From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 4/6] Documentation: Link to gitweb(1) and gitweb.conf(5) in other manpages
Date: Sat,  8 Oct 2011 20:32:01 +0200
Message-ID: <1318098723-12813-5-git-send-email-jnareb@gmail.com>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sat Oct 08 20:35:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCbkE-0008CF-9a
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 20:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab1JHSfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 14:35:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43294 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab1JHSfT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 14:35:19 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so6342991bkb.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ReFAfxlME5jMiy0mS/p8+ZqJp04S+Trxj4v4NnNofEo=;
        b=wdAIeaTXln2gcWY1RuUCF3xFLXjiDngfOxNXNw7vEUn0fXqipi9Ktz4T3F5PR6kQ/z
         lOmIxQVVb2sR2SY9qtbipU7+3YP2ZCm/SPaz6XYJXCz9ZuJdn7094cPqhwAFCRkUO5Ag
         orcnzhpmstj6QOzJJR9COMYAcMn6hAVU49afg=
Received: by 10.223.75.137 with SMTP id y9mr19810875faj.14.1318098918769;
        Sat, 08 Oct 2011 11:35:18 -0700 (PDT)
Received: from localhost.localdomain (abrz200.neoplus.adsl.tpnet.pl. [83.8.119.200])
        by mx.google.com with ESMTPS id m26sm20180604fac.6.2011.10.08.11.35.17
        (version=SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 11:35:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1318098723-12813-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183170>

Add link to gitweb(1) in "SEE ALSO" section of git-instaweb(1) manpage,
and "Ancillary Commands" section of git(1) manpage (the latter by the
way of command-list.txt file).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is new in this series.

BTW. why command-list.txt uses not only spaces to separate and align,
but also tabs, and mixtures of tabs and spaces???

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
