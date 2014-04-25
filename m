From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 14/14] completion: update 'git reset' new stage options
Date: Fri, 25 Apr 2014 13:12:47 -0500
Message-ID: <1398449567-16314-15-git-send-email-felipe.contreras@gmail.com>
References: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 20:24:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdknS-0007e8-NZ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890AbaDYSYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:24:15 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:44955 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbaDYSYN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:24:13 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so4606655oah.38
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H7Nr61BeSjqU3QtKaRKLjd7cxhphW81tzLH9E235ocw=;
        b=CoADb9RZXioPCB+Ue5T1l5EL24defOg51ibsRN1MmpOOhCup+fse4qXZRShw7KVg3I
         9U+2sTar1tqXWsOk/EIXgwp0tFUqS7mYUAtiyN2LdCJCC8VjbYKC7zh0vbiS1xCYJv5r
         TEOsxMaOrDR2+fdJQ2WJayu88gpeSILv8L5Vj7Jrazc4t4u10/AYhPPg84RXHRpXs1SP
         hdJg0skoxg83l3r9UB4Hes7T/pjdDt7/jcqBP4CISl8Hj9xz6EEDz3iOA58+mnAK0j5o
         xKfSDKmloG9sSJdDSndMvEl/7K8GiXW+XKhsVhC2MDVqU1kOlkJ1zP00cUJiogwoTJlY
         SlQw==
X-Received: by 10.182.135.228 with SMTP id pv4mr2825217obb.62.1398450252520;
        Fri, 25 Apr 2014 11:24:12 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id te6sm34756748oec.2.2014.04.25.11.24.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 11:24:11 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247087>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 52d83f2..e9b793b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2248,7 +2248,8 @@ _git_reset ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "--merge --mixed --hard --soft --patch"
+		__gitcomp "--merge --mixed --hard --soft --patch --keep --merge
+			--stage --no-stage --work --no-work"
 		return
 		;;
 	esac
-- 
1.9.2+fc1.2.gfbaae8c
