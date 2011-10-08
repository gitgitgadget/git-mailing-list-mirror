From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 5/6] Documentation: Add gitweb config variables to git-config(1)
Date: Sat,  8 Oct 2011 20:32:02 +0200
Message-ID: <1318098723-12813-6-git-send-email-jnareb@gmail.com>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sat Oct 08 20:35:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCbkE-0008CF-Pz
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 20:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580Ab1JHSfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 14:35:25 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58345 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab1JHSfX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 14:35:23 -0400
Received: by eye27 with SMTP id 27so448796eye.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Q1u50ICt2hbzxAcCVvXAfxDDP2zsYmEIJEFZQg29aCk=;
        b=CRkdj3o6R6IgQ1AQYuJnvNDdptycXnvca6B23WpZJpJJ8m9HcdDOfoi8npUOmZAOE3
         MY9yJexKoUbo91bMz6yKiJcZqArpMrMCtTjf6C9KiM8aDwMbFyqPdn7pAwpuxjGYf0tx
         UbnABpQNCHG80joCaBWtUG0CRO4iyTYtXAPL4=
Received: by 10.223.65.3 with SMTP id g3mr20421100fai.25.1318098922602;
        Sat, 08 Oct 2011 11:35:22 -0700 (PDT)
Received: from localhost.localdomain (abrz200.neoplus.adsl.tpnet.pl. [83.8.119.200])
        by mx.google.com with ESMTPS id m26sm20180604fac.6.2011.10.08.11.35.20
        (version=SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 11:35:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1318098723-12813-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183171>

Add a list of gitweb config variables to git-config(1) manpage, just
linking to gitweb(1) or gitweb.conf(5).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is new in this series.

BTW. there was a patch from Thomas Rast, which you can see e.g. in
't/doc-config-extraction' branch in my repositories:

  http://repo.or.cz/w/git/jnareb-git.git
  https://github.com/jnareb/git

which made git generate such thing automatically.

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
