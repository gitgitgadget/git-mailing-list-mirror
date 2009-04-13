From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3 04/13] Docs: send-email: --smtp-server-port can take symbolic ports
Date: Mon, 13 Apr 2009 13:23:48 -0500
Message-ID: <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:31:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtQvQ-0000hx-9V
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbZDMS2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753685AbZDMS2W
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:28:22 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:43600 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834AbZDMS2V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:28:21 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1131088wah.21
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/z/NF8Q5JD4sfrm5TwpKgYXQTpKBnxXIgxpOMaF09w4=;
        b=LOL665eZX2KcW+kS++R8KccK1svEb3qI7Lvvgi4UV+124RBXx0yf4uPMUOaWMkIQ+v
         neAHbmzT7w2aCiEfj1eE2JbUBV2JR2c7mDziEShnCRSFZ8DW2nQEqBUHCeVsnc7UwsQb
         xUwXqZRo3QUdQooY7aLDQvHXLTfcDFjxInMPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cPa4x714fwDNvOwROXr33BFEl/VSN31TGwp1yekfms8ZUR9mij291VN5AmuX4nGpt7
         h5TQvQpKblERd7AJ7NdPF8X590duNxctDSZeefDRsqiQsK6Mk1w5xyF/XZ5HuyTBOWis
         gNqCJJP9foS4mX6k7Lz4RZblfiq/6EetpSAEU=
Received: by 10.114.26.18 with SMTP id 18mr3282490waz.159.1239647301064;
        Mon, 13 Apr 2009 11:28:21 -0700 (PDT)
Received: from localhost.localdomain (97-116-116-167.mpls.qwest.net [97.116.116.167])
        by mx.google.com with ESMTPS id m30sm5963707wag.12.2009.04.13.11.28.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 11:28:20 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116465>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index b58b433..e8a385b 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -136,7 +136,9 @@ user is prompted for a password while the input is masked for privacy.
 --smtp-server-port=<port>::
 	Specifies a port different from the default port (SMTP
 	servers typically listen to smtp port 25 and ssmtp port
-	465). This can be set with 'sendemail.smtpserverport'.
+	465); symbolic port names are allowed. The port can also
+	be set with the 'sendemail.smtpserverport' configuration
+	variable.
 
 --smtp-ssl::
 	Legacy alias for '--smtp-encryption ssl'.
-- 
1.6.2.2.479.g2aec
