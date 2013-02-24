From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 03/16] git-relink: use a lowercase "usage:" string
Date: Sat, 23 Feb 2013 16:50:11 -0800
Message-ID: <1361667024-49776-4-git-send-email-davvid@gmail.com>
References: <1361667024-49776-1-git-send-email-davvid@gmail.com>
 <1361667024-49776-2-git-send-email-davvid@gmail.com>
 <1361667024-49776-3-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:51:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9Po3-0006ND-2R
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759448Ab3BXAum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:50:42 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:47511 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759390Ab3BXAuk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:50:40 -0500
Received: by mail-da0-f51.google.com with SMTP id n15so935908dad.10
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=SrfhXySQKW/PcHalBNDeHSDttEk12OmXMfyWYn9nYTA=;
        b=nAI4tX18qUZ5bS6a5ZT0mPSmBasJa9oAcA1jMAJfiLLYUloI0otu1Z/oBngcFNqlxc
         cIphroJ3p5xwt/i/2/yCGBOkb+2Hxivb73O+sLYoEHVIbHuBi5pftijmIwnLqpbuncP9
         b0mKhbS63yQQpz5GVeGc7G9eox82ozFHa0xQkGF45sSSLWiDaW4lleT1PHukoUcOqvxy
         UEP2ewHLE7w/rg9T4k8Ja+hQRnlbe+5bpK5k3wtc+2+HlHwMIW10vy3L0TsElbMEW9VQ
         jO57DjP7sZ2etf06hnASbyc6BMzt+8/xEs1MW1zL2qdpY5FCeRoJK0mtNkXHSNVpzeEv
         a+8Q==
X-Received: by 10.66.149.228 with SMTP id ud4mr11574339pab.123.1361667040300;
        Sat, 23 Feb 2013 16:50:40 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPS id a4sm8190345paw.21.2013.02.23.16.50.37
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:50:39 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361667024-49776-3-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216958>

Make the usage string consistent with Git.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-relink.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-relink.perl b/git-relink.perl
index f29285c..236a352 100755
--- a/git-relink.perl
+++ b/git-relink.perl
@@ -163,7 +163,7 @@ sub link_two_files($$) {
 
 
 sub usage() {
-	print("Usage: git relink [--safe] <dir>... <master_dir> \n");
+	print("usage: git relink [--safe] <dir>... <master_dir> \n");
 	print("All directories should contain a .git/objects/ subdirectory.\n");
 	print("Options\n");
 	print("\t--safe\t" .
-- 
1.8.2.rc0.263.g20d9441
