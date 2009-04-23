From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/8] config.txt: add missing format.{subjectprefix,cc,attach} variables
Date: Thu, 23 Apr 2009 02:37:56 -0700
Message-ID: <1240479482-31366-3-git-send-email-bebarino@gmail.com>
References: <1240479482-31366-1-git-send-email-bebarino@gmail.com>
 <1240479482-31366-2-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 11:39:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwvPK-0000xq-6p
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 11:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbZDWJiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 05:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753767AbZDWJiR
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 05:38:17 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:50129 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753AbZDWJiO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 05:38:14 -0400
Received: by wa-out-1112.google.com with SMTP id j5so217429wah.21
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 02:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=aGrgV47b3paRczzaElS718/h7T+CirmZS73BBfMRocY=;
        b=x1OZsdvzjBvzz+WMR43qsjgLIk7cckQpcKN9q/8zOji+wkuB1rea1/+HDgnsKl+8YT
         6b7RZ3dLGVZlK/l7hFxh5zf2FOa0FHGcJKrA2hxJ1iaUMXn3+U4uEswmoYNCiJ9U0G4n
         gxGcan81uavOzKqbEvndCbZqlN42Fx+AemZ6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=U+CIHhwnRwtgFhUvXf2IXs3v60TjPDZO1ApJ4eMLiEDu6v/WZi5T/BybomCZh/UZJ+
         1WNfWBn+vKL7I85mEmuX3BTXAv23Q8RR3yWTc9IbmqC5ZK/z8aAapjOzTDUBU7XstPS+
         yjxIDRbXwk54vP96lXW7rfdVL1CKAul55FJDM=
Received: by 10.114.130.8 with SMTP id c8mr397758wad.15.1240479493288;
        Thu, 23 Apr 2009 02:38:13 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id l30sm1496212waf.35.2009.04.23.02.38.11
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 02:38:12 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 23 Apr 2009 02:38:09 -0700
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <1240479482-31366-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117317>


Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/config.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fb7adfa..a8b68e2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -707,6 +707,13 @@ fetch.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
+format.attach::
+	Enable multipart/mixed attachments as the default for
+	'format-patch'.  The value can also be a double quoted string
+	which will enable attachments as the default and set the
+	value as the boundary.  See the --attach option in
+	linkgit:git-format-patch[1].
+
 format.numbered::
 	A boolean which can enable or disable sequence numbers in patch
 	subjects.  It defaults to "auto" which enables it only if there
@@ -718,6 +725,14 @@ format.headers::
 	Additional email headers to include in a patch to be submitted
 	by mail.  See linkgit:git-format-patch[1].
 
+format.cc::
+	Additional "Cc:" headers to include in a patch to be submitted
+	by mail.  See the --cc option in linkgit:git-format-patch[1].
+
+format.subjectprefix::
+	The default for format-patch is to output files with the '[PATCH]'
+	subject prefix. Use this variable to change that prefix.
+
 format.suffix::
 	The default for format-patch is to output files with the suffix
 	`.patch`. Use this variable to change that suffix (make sure to
-- 
1.6.2.3
