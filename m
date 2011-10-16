From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 5/5] gitweb: Add gitweb manpages to 'gitweb' package in git.spec
Date: Sun, 16 Oct 2011 13:07:35 +0200
Message-ID: <1318763255-23495-6-git-send-email-jnareb@gmail.com>
References: <1318763255-23495-1-git-send-email-jnareb@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sun Oct 16 13:15:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFOgh-0005s9-Eg
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 13:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998Ab1JPLPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 07:15:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57214 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab1JPLPV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 07:15:21 -0400
Received: by bkbzt19 with SMTP id zt19so2280759bkb.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 04:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EN9Vdd9IE8D/Li0VWx9MrUSHKoEFTMr5xg+gazK3EHI=;
        b=wNqX+o3pfd84p6xw7w4bnRAbdN3fiaUkQu76aFjzgBeV/NLQN/n9RyQQPdvLYJx8Y7
         ZkWCfQbxj2lez/O9NebWEo0XYrZ9TDOWx0Zjccc7m4vHVRu09otvm4KaqcjjXGYAdVhI
         6YT5MqPRQWR+uE0Z18SUP4Gfr8qbHadCz/ydI=
Received: by 10.223.61.211 with SMTP id u19mr16921569fah.29.1318763720378;
        Sun, 16 Oct 2011 04:15:20 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl. [83.8.119.25])
        by mx.google.com with ESMTPS id x22sm16468798faa.5.2011.10.16.04.15.17
        (version=SSLv3 cipher=OTHER);
        Sun, 16 Oct 2011 04:15:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1318763255-23495-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183710>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Unchanged from previous version

 git.spec.in |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index 91c8462..c562c62 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -199,7 +199,11 @@ rm -rf $RPM_BUILD_ROOT
 
 %files -n gitweb
 %defattr(-,root,root)
+%doc gitweb/README gitweb/INSTALL Documentation/*gitweb*.txt
 %{_datadir}/gitweb
+%{!?_without_docs: %{_mandir}/man1/*gitweb*.1*}
+%{!?_without_docs: %{_mandir}/man5/*gitweb*.5*}
+%{!?_without_docs: %doc Documentation/*gitweb*.html }
 
 %files -n perl-Git -f perl-files
 %defattr(-,root,root)
@@ -208,6 +212,9 @@ rm -rf $RPM_BUILD_ROOT
 # No files for you!
 
 %changelog
+* Sun Sep 18 2011 Jakub Narebski <jnareb@gmail.com>
+- Add gitweb manpages to 'gitweb' subpackage
+
 * Wed Jun 30 2010 Junio C Hamano <gitster@pobox.com>
 - Add 'gitweb' subpackage.
 
-- 
1.7.6
