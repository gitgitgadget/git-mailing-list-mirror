From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] Documentation/git-send-email: Add "Use gmail as the smtp server"
Date: Sat, 24 Apr 2010 15:34:02 +0800
Message-ID: <1272094442-26485-1-git-send-email-pkufranky@gmail.com>
Cc: Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 24 09:35:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5Zts-0004Si-GA
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 09:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177Ab0DXHfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 03:35:30 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48831 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab0DXHfS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 03:35:18 -0400
Received: by pvg4 with SMTP id 4so107211pvg.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 00:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Idg3rVDAB6/2nRjulYW4juoFqAukH1XLHzLIU/eW4RI=;
        b=pXs4wD4kGqreYeK68SRnPnvtNrIcd31NtJMdLEexJosNgowhTzzxuxyvACuTUDEoY3
         iPqt96qb+FHXiaCddUxLZYSbs8NfbtARhthVXw588j8t9od1frBWn2RmYInVp0T3sgUq
         eQa2aQtg0m72Vcc4N4uCn1VYoaaKnUyW6apg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CLTLpx7ESdD0tcoK7fRDm/SQZmdxwlhUUjQwKoU7tunJGfzQMUE4+XjKba75Y+6uU4
         FYnj53haqVkRIjhciVCq8Krg5z/zr2UbGwbayFG9rUkW5IpgYxANtW2FGCKjKpwAm9xV
         iKvBaOoXHQDaE/I7EwqhwN38NvQeoEBTE3RHA=
Received: by 10.142.59.13 with SMTP id h13mr668580wfa.168.1272094204842;
        Sat, 24 Apr 2010 00:30:04 -0700 (PDT)
Received: from localhost.localdomain ([123.114.41.177])
        by mx.google.com with ESMTPS id 21sm1867078pzk.8.2010.04.24.00.30.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 00:30:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc2.265.g8743f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145659>

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 Documentation/git-send-email.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index ced35b2..3dfdc7c 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -300,6 +300,21 @@ sendemail.confirm::
 	in the previous section for the meaning of these values.
 
 
+Use gmail as the smtp server
+----------------------------
+
+Add the following section to the config file:
+
+	[sendemail]
+		smtpencryption = tls
+		smtpserver = smtp.gmail.com
+		smtpuser = yourname@gmail.com
+		smtpserverport = 587
+
+Note: the following perl modules are required
+      Net::SMTP::SSL, MIME::Base64 and Authen::SASL
+
+
 Author
 ------
 Written by Ryan Anderson <ryan@michonline.com>
-- 
1.7.1.rc2.265.g8743f
