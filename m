From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH] Gitweb: ignore build file
Date: Sun, 25 Apr 2010 22:17:05 +0200
Message-ID: <1272226625-22628-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	Mark Rada <marada@uwaterloo.co>,
	"Git List" <git@vger.kernel.org>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 25 22:17:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O68Gq-0002vl-HJ
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 22:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016Ab0DYURe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 16:17:34 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:19839 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab0DYURd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 16:17:33 -0400
Received: by ey-out-2122.google.com with SMTP id d26so1017736eyd.19
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=S4GwSOnUZzxzi+d49d8chggNi8l6fQjWIvWBHc1R3SI=;
        b=O9UPfntjm9xNV/IP6fdIFEacI8BVebK0I8Z31c4Q99vBH6ZpRL0f5aUPygsYVbVJEk
         aDUTY/Mf5Tn0phqt69hqV0DRZbLD3YZX/lOMJ/qkZF+ZAks93U1qF6y9rio9/XePOVAm
         PjuS+C0R9y20V6AZrAAMLr2kxsvP0XOO+111A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XUbONh1y7oX7wywxBoIRQeYtvalb3fWatrvtLBEuZ2gY0ISVyw/pm1RHl93s0WVMoX
         0dNCCwqQX08eolqtxjP98ppZaeITGQPSoMGILovbXiwwAOPWEeOtw1/FtsO2frAfJwWd
         WrKhE5IRbWNaaY2VGV3i6GTcCTel2Of77OR80=
Received: by 10.213.54.144 with SMTP id q16mr1292444ebg.68.1272226651725;
        Sun, 25 Apr 2010 13:17:31 -0700 (PDT)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 16sm1689120ewy.7.2010.04.25.13.17.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 13:17:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.6.ga2e26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145764>

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Seems like this was forgotten in 8de096b6 
  ("gitweb: simplify gitweb.min.* generation and clean-up rules", Thu Apr 15)

 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 83dd1e8..14e2b6b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -156,6 +156,7 @@
 /git-write-tree
 /git-core-*/?*
 /gitk-git/gitk-wish
+/gitweb/GITWEB-BUILD-OPTIONS
 /gitweb/gitweb.cgi
 /gitweb/gitweb.min.*
 /test-chmtime
-- 
1.7.1.6.ga2e26
