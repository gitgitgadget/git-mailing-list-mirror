From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix not marking signoff lines in "log" view
Date: Sat, 24 Mar 2007 20:59:13 +0100
Message-ID: <1174766353345-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 24 20:56:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVCLo-0000KF-2A
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 20:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbXCXT4Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 15:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932833AbXCXT4Q
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 15:56:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:18770 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932403AbXCXT4P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 15:56:15 -0400
Received: by nf-out-0910.google.com with SMTP id o25so2448516nfa
        for <git@vger.kernel.org>; Sat, 24 Mar 2007 12:56:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=J3SBk1Jivq6aYYaFfdBRpHC8XtBj3YP/m3qfpCKFSatxQpbXNB8I5MQ3YFY5liTtPWMlFM/SDXxhb0e7eYb/ixa25Wpj4nc7hGkAN/kKuGT6zXWpmDrjXyr1HJBtAivva6qMTm9mPcAzpuTklufORZWv1TT8zdCoFRfhlKEpvYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=pAlqLprrsmfqvxy0Aqp+IFmjWRn/jMR5V8CGNGENc5DukEYQiAusOnyLoYFZ/CbjX3ZnzjtqDr9uBowIpCZb7BVZ5Igx1E0may+jHrT8+jF7qXqOWbRTP0gj7ksEiv3TXPE+AhKQvPJIX6HBMfdjGgNogaQoTy3iXWYCrRWhfwk=
Received: by 10.82.167.5 with SMTP id p5mr9900679bue.1174766174308;
        Sat, 24 Mar 2007 12:56:14 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id e8sm21128824muf.2007.03.24.12.56.11;
        Sat, 24 Mar 2007 12:56:12 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l2OJxE1L006413;
	Sat, 24 Mar 2007 20:59:15 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l2OJxDav006412;
	Sat, 24 Mar 2007 20:59:13 +0100
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43012>

The CSS selector for signoff lines style was too strict: in the "log"
view the commit message is not encompassed in container "page_body"
div.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.css |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 7177c6e..5e40292 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -107,7 +107,7 @@ span.age {
 	font-style: italic;
 }
 
-div.page_body span.signoff {
+span.signoff {
 	color: #888888;
 }
 
-- 
1.5.0.5
