From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 1/3] t/lib-cvs.sh: allow cvsps version 3.x.
Date: Thu, 10 Jan 2013 22:27:17 -0600
Message-ID: <1357878439-27500-2-git-send-email-chris@rorvick.com>
References: <1357878439-27500-1-git-send-email-chris@rorvick.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 05:29:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtWEg-0004ot-4l
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 05:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab3AKE2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 23:28:35 -0500
Received: from mail-ia0-f169.google.com ([209.85.210.169]:55432 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422Ab3AKE2e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 23:28:34 -0500
Received: by mail-ia0-f169.google.com with SMTP id r4so1226117iaj.28
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 20:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=n/JGENYW4KbqnThhSelKAGOA/1flHBpLA1e7C4x8MGE=;
        b=dIyz2Gr0fwZaAef1EIZW8leaCh11b4/onZMt0rudfsJ9fdusMxCUBtP7sYYvEtZZPW
         mLHetxyTPR/Fawxj31D+P2dXHGdZz/S13RH6nMhFE6cST97330ncRrQoFkPhm34wyeag
         55L55CAWH0tCS3ZEzYS2X+/SFrdp6r72JKR5pNv+gIld2Yp1BL2ACqJ3rw0nSU+gqaRO
         8nwX+/K7vJFrkaOJmoY6YPPKEWQbudWTUwLBlMFXkZGQ+ckZ4w8RyEW2KMzPt3ksYBIt
         nYCYtVyCqsF+dVokRcdTYUeEFeVKM9C5xxkt7eK1FNSC6FeqGe+GMjl/fLKMEev+OX6S
         XTlw==
X-Received: by 10.50.13.138 with SMTP id h10mr7923395igc.55.1357878514161;
        Thu, 10 Jan 2013 20:28:34 -0800 (PST)
Received: from marlin.localdomain ([70.131.98.170])
        by mx.google.com with ESMTPS id s20sm3793135igs.10.2013.01.10.20.28.32
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 20:28:33 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.g220e17a
In-Reply-To: <1357878439-27500-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213176>

---
 t/lib-cvs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
index 44263ad..b55e861 100644
--- a/t/lib-cvs.sh
+++ b/t/lib-cvs.sh
@@ -15,7 +15,7 @@ export CVS
 
 cvsps_version=`cvsps -h 2>&1 | sed -ne 's/cvsps version //p'`
 case "$cvsps_version" in
-2.1 | 2.2*)
+2.1 | 2.2* | 3.*)
 	;;
 '')
 	skip_all='skipping cvsimport tests, cvsps not found'
-- 
1.8.1.1.g220e17a
