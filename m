From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 9/9] gitweb: add alt text to avatar img
Date: Sat, 27 Jun 2009 14:05:05 +0200
Message-ID: <1246104305-15191-10-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-6-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-7-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-8-git-send-email-giuseppe.bilotta@gmail.com>
 <1246104305-15191-9-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 27 14:06:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKWfm-0007Dq-F5
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 14:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbZF0MFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 08:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754125AbZF0MFf
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 08:05:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:31643 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590AbZF0MFS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 08:05:18 -0400
Received: by fg-out-1718.google.com with SMTP id e12so183147fga.17
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 05:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4GY8mr01BoOH67hvK4fpETsGtki60LXws8ZbGrhDpOA=;
        b=EWntIe1aeJSN8P0EdPFOJzjopVy1jHVY8FCeOJEWs4ypvm+9dGV0VMhYcjhVJ8EXRr
         kd3MDZiPAKsSQZ5ODNpZ/RftuZi+uzgjt/Gr5o198Z0SWx4j6nWq3lcN7TLzfP9gvFyd
         T6AxpNhaqgu72OdGDBctDpyQ1UCvo3oBgxTB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y+1nDZ7BsJdTSHsBgbatVjYos/Ce5qY8nbZUC4Yc9VgHelL5AZwbvl0Zd4K61c3rJT
         n+KR7AWMXlXwGmFz0t1x7hHTpAuLGQQaPct8uqIBeLT2IsTgpGxYbL8oW0V1CimHpi08
         5rBVqx0yA5MTXoFAXjLMiEBJbw4tY3fMD0EX0=
Received: by 10.86.25.17 with SMTP id 17mr397995fgy.73.1246104321401;
        Sat, 27 Jun 2009 05:05:21 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-10-227.clienti.tiscali.it [94.37.10.227])
        by mx.google.com with ESMTPS id l19sm8498810fgb.21.2009.06.27.05.05.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 05:05:20 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1246104305-15191-9-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122361>

The alt text, set to the avatar provider (i.e. image type), is more
friendly than the img url in some text-only browsers.
---
 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e2638cb..dc6049a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1578,6 +1578,7 @@ sub git_get_avatar {
 		       "<img width=\"$size\" " .
 		            "class=\"avatar\" " .
 		            "src=\"$url\" " .
+			    "alt=\"$git_avatar\" " .
 		       "/>" . $post_white;
 	} else {
 		return "";
-- 
1.6.3.rc1.192.gdbfcb
