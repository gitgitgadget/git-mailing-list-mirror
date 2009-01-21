From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] user-manual: Simplify the user configuration.
Date: Wed, 21 Jan 2009 21:04:10 +0200
Message-ID: <1232564650-3701-1-git-send-email-felipe.contreras@gmail.com>
References: <200901211955.47362.markus.heidelberg@web.de>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 20:06:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPiOS-0008Ms-7J
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 20:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbZAUTEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 14:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbZAUTEP
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 14:04:15 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:39294 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbZAUTEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 14:04:14 -0500
Received: by fxm13 with SMTP id 13so763894fxm.13
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 11:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=N3LeSjaVuHAVZrXPMuiF5rpTLDZGgDc9yCSny2AYAyI=;
        b=VJGcBokl1Z2AxGa/rj0sMBgKJRMxqYvLjCBQjET5ug+FM5Sb5S2ACMTcXQ5iZ0PhGK
         fA9YnpiqKZ0i9Xo3jRP219UhtkllU+cgLKEeIWl/6fEPFCeG2qL+Pc8OYBypjb17Ii7l
         JX3EDSUW07v6leTOxZrKrFDi0NxUba5zWeX/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RxtJ2OiSBFbtibV1lknBwawqEmERKxeIzTTBp1HgQBi90WwSGBIB6rUWel4MUTQ+qq
         oVszHO9F847XOCi1SpzA+D6RY/mDEA3grMlKE/Ll/W3+K8yNxXYedJMNOVp8cVtScMhi
         ozlup3a2wZPkxhFLZ88EmOonOIxCp6MEem97U=
Received: by 10.223.119.5 with SMTP id x5mr398985faq.40.1232564652850;
        Wed, 21 Jan 2009 11:04:12 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id p9sm15019055fkb.1.2009.01.21.11.04.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jan 2009 11:04:12 -0800 (PST)
X-Mailer: git-send-email 1.6.1
In-Reply-To: <200901211955.47362.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106643>

This is shorter, avoids the burder to think about the format of the
configuration file, and git config is already used in other places in
the manual.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 19f571a..c8a1b7b 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -981,13 +981,11 @@ Telling git your name
 ---------------------
 
 Before creating any commits, you should introduce yourself to git.  The
-easiest way to do so is to make sure the following lines appear in a
-file named .gitconfig in your home directory:
+easiest way is to use the linkgit:git-config[1] command:
 
 ------------------------------------------------
-[user]
-	name = Your Name Comes Here
-	email = you@yourdomain.example.com
+$ git config --global user.name "Your Name Comes Here"
+$ git config --global user.email you@yourdomain.example.com
 ------------------------------------------------
 
 (See the "CONFIGURATION FILE" section of linkgit:git-config[1] for
-- 
1.6.1
