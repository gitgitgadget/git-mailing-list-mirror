From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/4] user-manual: simplify the user configuration
Date: Fri,  1 May 2009 11:44:22 +0300
Message-ID: <1241167462-5984-5-git-send-email-felipe.contreras@gmail.com>
References: <1241167462-5984-1-git-send-email-felipe.contreras@gmail.com>
 <1241167462-5984-2-git-send-email-felipe.contreras@gmail.com>
 <1241167462-5984-3-git-send-email-felipe.contreras@gmail.com>
 <1241167462-5984-4-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 10:45:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzoMi-0003LM-IT
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 10:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbZEAIox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 04:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbZEAIou
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 04:44:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:4668 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbZEAIol (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 04:44:41 -0400
Received: by fg-out-1718.google.com with SMTP id d23so30873fga.17
        for <git@vger.kernel.org>; Fri, 01 May 2009 01:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=euQdEQTWbxdAwlE7C3XRaUmL6YkdHYKE7BDgtqKwu9Q=;
        b=gzRrVd5WM/NHNxGuMxzCqmQCQQMUT7hoIBbm4/pWSqiJzsrdwBSmGAuARS5OIMwHI8
         dQpAJIZSf1yb6wcVIv4sdNSi4OfJxx//qtwx+iXRJyPIvE9IJqNllT5Xacly707+vOzX
         Z64i0IeD+EiQ8Wm5gkM7R2WwTP6ULQVpPDqGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=il2UyQPAIc1Zlcf9tO6nIKloRsv1q0W48KwYgQCTl69dfKKun/agV3z5cVUiB6pvvq
         dPR1aOCApNeVIet0urRQKYCTxPiKYeCUNi7mNkQSi32GzhVinvwotwghRW2wShrPz2O8
         qjaN8MRaol7vnEvJTuiGEi7pQ4tQufiVN6GHs=
Received: by 10.86.31.18 with SMTP id e18mr2642972fge.72.1241167481405;
        Fri, 01 May 2009 01:44:41 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id l19sm420422fgb.2.2009.05.01.01.44.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 May 2009 01:44:40 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc3.13.g195b.dirty
In-Reply-To: <1241167462-5984-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118063>

This is shorter, avoids the burder to think about the format of the
configuration file, and git config is already used in other places in
the manual.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d466199..6262c6c 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1008,13 +1008,11 @@ Telling git your name
 ---------------------
 
 Before creating any commits, you should introduce yourself to git.  The
-easiest way to do so is to make sure the following lines appear in a
-file named `.gitconfig` in your home directory:
+easiest way is to use the linkgit:git-config[1] command:
 
 ------------------------------------------------
-[user]
-	name = Your Name Comes Here
-	email = you@yourdomain.example.com
+$ git config --global user.name "Your Name Comes Here"
+$ git config --global user.email you@yourdomain.example.com
 ------------------------------------------------
 
 (See the '"CONFIGURATION FILE"' section of linkgit:git-config[1] for
-- 
1.6.3.rc3.13.g195b.dirty
