From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 7/7] user-manual: simplify the user configuration
Date: Sat,  4 Apr 2009 12:38:29 +0300
Message-ID: <1238837909-3060-8-git-send-email-felipe.contreras@gmail.com>
References: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-2-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-3-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-4-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-5-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-6-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-7-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 11:41:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lq2NA-00020I-7t
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 11:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756338AbZDDJjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 05:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759346AbZDDJjL
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 05:39:11 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:47067 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756338AbZDDJi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 05:38:57 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so1248812bwz.37
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 02:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=oB4cLRoHmSSfmj2/d8QAfjqwhU3oc7CfLyBJrzoMjiQ=;
        b=gR+FK6vN7Mb6wBu08/LbTZEC0rq4GX6GgQR6mATYNM/0b/q4j3lLlY0+9RwHeBuk6t
         jzmVKCKP1kWYdFs3KwOlT/9bQNk1F6PkkxpOjxaD/M/E3Lhip3PZZr5flrLecQIPUbqH
         mkcCRhKOjHzE01rAGLydNgfmehPyF74XNYlA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bla5XkHUpwkO/6XwfU4IjQ75X6kY1QLgqvIWxwQ/Ius/P0V6jtgmOTNM0hGwfVqrLh
         PslKEVX82xy16FLToqryJD8SeF6OqtKjZXNjJgVypEwaDN7Otm1gAybTCEz04TYaNNLw
         dzZ3osuvgnpdTHTz3Q1RpAEsN4DAa0k9Wgo7g=
Received: by 10.204.116.8 with SMTP id k8mr759940bkq.117.1238837935609;
        Sat, 04 Apr 2009 02:38:55 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id c28sm270124fka.6.2009.04.04.02.38.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Apr 2009 02:38:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.404.ge96f3
In-Reply-To: <1238837909-3060-7-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115577>

This is shorter, avoids the burder to think about the format of the
configuration file, and git config is already used in other places in
the manual.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index a3032c7..36568e5 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1011,13 +1011,11 @@ Telling git your name
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
1.6.2.2.404.ge96f3
