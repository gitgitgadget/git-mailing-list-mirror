From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: fix whitespace in config_to_multi (indent with tab)
Date: Thu, 20 Dec 2007 10:48:09 +0100
Message-ID: <1198144089-2983-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 10:48:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5I1D-0005Fd-Hd
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 10:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639AbXLTJsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 04:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756153AbXLTJsU
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 04:48:20 -0500
Received: from mu-out-0910.google.com ([209.85.134.189]:13729 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000AbXLTJsT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 04:48:19 -0500
Received: by mu-out-0910.google.com with SMTP id i10so4839932mue.5
        for <git@vger.kernel.org>; Thu, 20 Dec 2007 01:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=uM5TPZj+Lg0gA8+Prd0VxSmVEGUUXLvsCsTYAkaDdJ8=;
        b=wqZFwTwd7kGdTAi+OGtmCF19rW31hXG4xdo/RSsR2ld7bP3mtl8zlUAyk0KF4gqOseJFDrx2lnHSjQm9AHeD8u2w/RyuBMtjvGr9fUgvmqxDiMUuw/HOy/0IN6psE+bcrprvg9DK8Ek3NshoTpHaEloPp7Snh0QZOTbS/ESRO3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=W83535DUt61oXxOmN7XFOy0ULYdFaNICeNEiVMCMRqvxpadAcUvlncg72pkX7UR3fP3/ZLrTFfQOrz34s7qnk6gSIAvCKKDrdBDbDuPyjk3Zu1OXzuu66lCx5nd/uOUWX6bBot6yojQ9/2KMQwa8LhsUILd0wsft8z+DwCqICVo=
Received: by 10.86.33.10 with SMTP id g10mr9955453fgg.8.1198144097109;
        Thu, 20 Dec 2007 01:48:17 -0800 (PST)
Received: from roke.D-201 ( [83.8.192.140])
        by mx.google.com with ESMTPS id e11sm3093769fga.2007.12.20.01.48.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Dec 2007 01:48:16 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBK9mBN8002999;
	Thu, 20 Dec 2007 10:48:12 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id lBK9mAmD002998;
	Thu, 20 Dec 2007 10:48:10 +0100
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68986>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I'm very sorry for sending whitespace-mangled patch in first place.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 28bb8c3..6256641 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1511,7 +1511,7 @@ sub config_to_int {
 sub config_to_multi {
 	my $val = shift;
 
-       return ref($val) ? $val : (defined($val) ? [ $val ] : []);
+	return ref($val) ? $val : (defined($val) ? [ $val ] : []);
 }
 
 sub git_get_project_config {
-- 
1.5.3.7
