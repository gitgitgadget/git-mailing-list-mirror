From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/2] user-manual: simplify the user configuration
Date: Sat, 24 Oct 2009 12:44:49 +0300
Message-ID: <1256377489-16719-3-git-send-email-felipe.contreras@gmail.com>
References: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 24 11:45:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1dBc-0004ka-Cn
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 11:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbZJXJpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 05:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbZJXJpI
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 05:45:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:64087 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbZJXJpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 05:45:06 -0400
Received: by fg-out-1718.google.com with SMTP id d23so532718fga.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XGezqTu6pzEyJobJekYuM6UDAHjRLXzJ5End8J30ODI=;
        b=uCJvh4STUFRJqD9FUMSuQpUvYYNRrenjYupoklKDM7RXGvc/NviR673N1ic8Z+8vGq
         uyWc3fYzpYdWTSvbhCopUM6/MedtHLXHJMY2NWK5OdaMZE95+YBxhfAmddrzhe9KrWvs
         o0MYpd8DA54a927aqMQsxdYQfuLyePTdk9LaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AwygyMqBB8RwuPXZAouomWYR7GxH2Pr1mLTe6UVqozAUyw33CjFx/13hOKMQkQnE2r
         yGa9AuD5nnflAn+AgguIY9WV3gBp5KQ5dLFmpHXcmXuBY3jYmcq7qquKC7V2Ib1ncI+7
         EOKTyfqFXDuxo5XBOLxl8pD0d5cr/ejgBoxtE=
Received: by 10.86.242.15 with SMTP id p15mr1155809fgh.14.1256377511095;
        Sat, 24 Oct 2009 02:45:11 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id d6sm2379229fga.5.2009.10.24.02.45.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Oct 2009 02:45:10 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.1
In-Reply-To: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131152>

This is shorter, avoids the burder to think about the format of the
configuration file, and git config is already used in other places in
the manual.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 3fcbc36..a0a75af 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1010,13 +1010,11 @@ Telling git your name
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
1.6.5.1
