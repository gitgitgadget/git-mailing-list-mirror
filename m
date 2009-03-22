From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 8/8] user-manual: simplify the user configuration
Date: Sun, 22 Mar 2009 20:05:21 +0200
Message-ID: <1237745121-6325-9-git-send-email-felipe.contreras@gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-4-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-5-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-6-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-7-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-8-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 19:08:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlS5i-0000xY-2H
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 19:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbZCVSGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 14:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755292AbZCVSGB
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 14:06:01 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:64244 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453AbZCVSFz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 14:05:55 -0400
Received: by mail-fx0-f158.google.com with SMTP id 2so1504733fxm.37
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VdDWrDQeDg6lI27bJGB8odDDJIpI2O/oEbkXXsLHFcU=;
        b=wxM4iVrg0jAqoUbHp5nbV8xkRuS0BLBqhp//dGQpJnHDou/HFrhiUrD9mWa0fY2vUq
         S1xroaXKR89u5itWCMa4Q2+TqEfobFPQ0wiFNTbre/O2qYd63nifCBDv4O/mdyfUzh5n
         rMx9gb3vK6CmwhUHtMYvRvA+WfcJxpPlEEh44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WyKj0BBUQZR1ktZBFci+MNzGN7DzBAspVv4H7f3Q1sAOU4YpVG1ZRVineJ3V54vZUK
         TCphKM1cMzLv2zcxmrYFvIYN406qhxAlDR5cmlOStvBKZxu6zr57pVt2ttJlHvu9MMe9
         Bj36DkyEOPeLm++4+GwRmwr6ghLJuck+WC7Vg=
Received: by 10.223.113.199 with SMTP id b7mr5236728faq.82.1237745153855;
        Sun, 22 Mar 2009 11:05:53 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 12sm7665338fks.5.2009.03.22.11.05.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Mar 2009 11:05:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.352.gae594
In-Reply-To: <1237745121-6325-8-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114161>

This is shorter, avoids the burder to think about the format of the
configuration file, and git config is already used in other places in
the manual.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index b7678aa..c6ed940 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1015,13 +1015,11 @@ Telling git your name
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
1.6.2.1.352.gae594
