From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 16/16] Documentation/user-manual.txt: use a lowercase "usage:" string
Date: Sat, 23 Feb 2013 16:50:24 -0800
Message-ID: <1361667024-49776-17-git-send-email-davvid@gmail.com>
References: <1361667024-49776-1-git-send-email-davvid@gmail.com>
 <1361667024-49776-2-git-send-email-davvid@gmail.com>
 <1361667024-49776-3-git-send-email-davvid@gmail.com>
 <1361667024-49776-4-git-send-email-davvid@gmail.com>
 <1361667024-49776-5-git-send-email-davvid@gmail.com>
 <1361667024-49776-6-git-send-email-davvid@gmail.com>
 <1361667024-49776-7-git-send-email-davvid@gmail.com>
 <1361667024-49776-8-git-send-email-davvid@gmail.com>
 <1361667024-49776-9-git-send-email-davvid@gmail.com>
 <1361667024-49776-10-git-send-email-davvid@gmail.com>
 <1361667024-49776-11-git-send-email-davvid@gmail.com>
 <1361667024-49776-12-git-send-email-davvid@gmail.com>
 <1361667024-49776-13-git-send-email-davvid@gmail.com>
 <1361667024-49776-14-git-send-email-davvid@gmail.com>
 <1361667024-49776-15-git-send-email-davvid@gmail.com>
 <1361667024-49776-16-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:51:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9Pog-0000c0-O3
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159Ab3BXAvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:51:22 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:46695 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759474Ab3BXAvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:51:15 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so1056483pbc.24
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=toYuiOEaIEigL+7WiPdNRO3CwAK1Tu/TNSUMKDoXX6E=;
        b=gNs99wRU3rzdPWNM/WEVRpS0LaqBkEbKeERMcgTn79WzClRdO1LoxLKRo7fb9bXsEs
         YoYfhHHl5qZCL7MdOcL0jWjhLXaS24AHEz/FJIUXrjFvQQYaSnR5YFLiwVFuhnUIeIRh
         O1mcK1zgYWjKSyJub+aU9gPiK96N1TXbsIpocyivGkoJZPV6Fyz8N7lroUR0E9a3cqws
         7v7pDAX1HO8RFH6BtTeTRHelwiUmQnps8PM58BgAfwEph8sUpyNf2dzi4okWwv2Y+VuT
         /cTjUB78tGfsfjSNyJ3oZXkIgqvMFTcaRK84tnCRx7XdwzM83P5BVfsb+5aXXIE1GdGn
         /d4w==
X-Received: by 10.68.25.138 with SMTP id c10mr10809549pbg.133.1361667075306;
        Sat, 23 Feb 2013 16:51:15 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPS id a4sm8190345paw.21.2013.02.23.16.51.12
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:51:14 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361667024-49776-16-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216973>

Make the usage string in the example script consistent with Git.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/user-manual.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 5f36f81..35a279a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2337,7 +2337,7 @@ origin)
 	fi
 	;;
 *)
-	echo "Usage: $0 origin|test|release" 1>&2
+	echo "usage: $0 origin|test|release" 1>&2
 	exit 1
 	;;
 esac
@@ -2351,7 +2351,7 @@ pname=$0
 
 usage()
 {
-	echo "Usage: $pname branch test|release" 1>&2
+	echo "usage: $pname branch test|release" 1>&2
 	exit 1
 }
 
-- 
1.8.2.rc0.263.g20d9441
