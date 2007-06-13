From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Generated spec file to be ignored is named git.spec and not git-core.spec
Date: Thu, 14 Jun 2007 01:12:20 +0200
Message-ID: <11817763401340-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 01:06:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HybvQ-00046A-SG
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 01:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698AbXFMXGt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 19:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755671AbXFMXGt
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 19:06:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:32841 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272AbXFMXGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 19:06:48 -0400
Received: by ug-out-1314.google.com with SMTP id j3so531729ugf
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 16:06:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=EEljvixrFEtTbNhtQxiTGIJLyHm7Ijmdg6BkSosOTK61RwWnTWmkW4PuV8C/JsRE5f4PTcB2cdFprZ34QYbsNdMcsdotV2w1FluMRXpC300H0TVY5AE5QcsvfS9/Wg80zrmQwJBWM8DPsEpBKPF0D//Yax91OO6Ii4Ju1u/Yglk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=seAH2V+dL1uDcQ6QvRTDOqjn5xBeDe+LMWySKyRPaODHD+MWZE/IFqreDwJpsygaRya4eX0wVwyE7BbqrECYbaRdEIhPs4TZupqEpA41HP1ax1c1Bw7R+ydRb1zDYkggCdUGiEgFRbTQGqnA7xWSgFL+nqXqCY5ZmJcXUms4H2w=
Received: by 10.82.136.4 with SMTP id j4mr2148520bud.1181776007370;
        Wed, 13 Jun 2007 16:06:47 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id 31sm5872533nfu.2007.06.13.16.06.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jun 2007 16:06:43 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l5DNCLWt001896;
	Thu, 14 Jun 2007 01:12:21 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l5DNCKqt001894;
	Thu, 14 Jun 2007 01:12:20 +0200
X-Mailer: git-send-email 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50142>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 .gitignore |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index bd49cd4..e8b060c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -157,7 +157,7 @@ common-cmds.h
 *.tar.gz
 *.dsc
 *.deb
-git-core.spec
+git.spec
 *.exe
 *.[aos]
 *.py[co]
-- 
1.5.2
