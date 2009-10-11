From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] user-manual: simplify the user configuration
Date: Sun, 11 Oct 2009 23:43:06 +0300
Message-ID: <1255293786-17293-3-git-send-email-felipe.contreras@gmail.com>
References: <1255293786-17293-1-git-send-email-felipe.contreras@gmail.com>
 <1255293786-17293-2-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 22:49:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx5Lw-0001qp-SK
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 22:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbZJKUoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 16:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbZJKUoA
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 16:44:00 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:58587 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbZJKUn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 16:43:59 -0400
Received: by fxm27 with SMTP id 27so8432991fxm.17
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 13:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CWeNhrEOO4/esYJOSuBGkqULnySEglhAcNUG/xs4oj8=;
        b=T8MxIbeCvO8LIpbP0+I5VVELW658fgxH57xLq7TcIgNx+sZ9DzbzSYY5kd12YP0JXo
         3cEkpRZxmjTaqEODCqPTpVIOh5w8eDb32JuW5qtaCx9Dh9OFduxDM6DaZYOvjjaK/UU6
         aFQzhQNiJu8YNcc09YUMj22ofDNheQ9ItYmLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Lj9mOOBEEgn55tmMetS3HUTeizK6qpfYPvyqV5OtGDeYnlhvyBBjWGJ/vUMtjapeKM
         SHTA7+1h4bAB+r/ZvVC1RGf65kC4c3+U+Bs3sFzYTIY2MlyINW8j/HRuOc5XhrMFGH9H
         PQl21eWCAdXX0K6tntq3CDQAtT4esNzzktRng=
Received: by 10.86.203.35 with SMTP id a35mr4604605fgg.44.1255293802753;
        Sun, 11 Oct 2009 13:43:22 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 12sm2554659fgg.21.2009.10.11.13.43.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 13:43:22 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.4.g31fc3
In-Reply-To: <1255293786-17293-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129956>

This is shorter, avoids the burder to think about the format of the
configuration file, and most guides out there prefer this form.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index ff2563a..bab64f8 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1008,13 +1008,11 @@ Telling git your name
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
1.6.5.4.g31fc3
