From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH 2/6] Google has renamed the imap folder
Date: Thu, 19 Feb 2009 07:36:11 +0000
Message-ID: <200902190736.11912.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 08:38:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La3Tm-0002pi-ED
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 08:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbZBSHgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 02:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbZBSHgR
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 02:36:17 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:17563 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbZBSHgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 02:36:16 -0500
Received: by rv-out-0506.google.com with SMTP id g9so168828rvb.5
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 23:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:date:to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=BwD+NkhgLVbKM6W4OEdwf4zsBdU+mc4FI0hwLFijNGM=;
        b=P+KkdFmrRw0G2Vh52fWz1Tj5ipqbQjmtnJMVQ+/o35cS4fHbAV1Tzteb7Q4Jat0H2v
         CXuA+ab4zPN6TKT+IeveP5HG/aozJv5dAHUiXwSJhJuTNEU/d/P0TkfNTO6IX9Sh4NH2
         vVUN1IwxC6bXfjEayfAawS0X3Zyei3MG3ifI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:date:to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=yDOfkNUBtqlp6Zsi3MA8uf+HelRW3U2DpFYUMWULpDXEAA4MX6hvqpN5yAfl13KEKa
         G+u0VKAN/RNEFom56yjOJMbYToE1ukt+OmUidJ15abT+L5zMaf2xuN36dHu4faQ5FtUO
         KU0bDNBPg05DdK/fAgcWia6bVhHg5R5bkaOAw=
Received: by 10.142.210.8 with SMTP id i8mr4122512wfg.343.1235028975070;
        Wed, 18 Feb 2009 23:36:15 -0800 (PST)
Received: from johnflux-desktop.localnet (58-190-81-184.eonet.ne.jp [58.190.81.184])
        by mx.google.com with ESMTPS id 30sm1670233wff.7.2009.02.18.23.36.13
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 23:36:14 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110637>

Also add a comment that the web interface wraps the lines

Signed-off-by: John Tapsell <johnflux@gmail.com>
---
 Documentation/SubmittingPatches |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 9b559ad..ae7525d 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -491,18 +491,27 @@ message, complete the addressing and subject fields, and press send.
 Gmail
 -----
 
+GMail does not appear to have any way to turn off line wrapping in the web
+interface, so this will mangle any emails that you send.  You can however
+use any IMAP email client to connect to the google imap server, and forward
+the emails through that.  Just make sure to disable line wrapping in that
+email client.  Alternatively, use "git send-email" instead.
+
 Submitting properly formatted patches via Gmail is simple now that
 IMAP support is available. First, edit your ~/.gitconfig to specify your
 account settings:
 
 [imap]
-	folder = "[Gmail]/Drafts"
+	folder = "[Google Mail]/Drafts"
 	host = imaps://imap.gmail.com
 	user = user@gmail.com
 	pass = p4ssw0rd
 	port = 993
 	sslverify = false
 
+You might need to instead use:  folder = "[Google Mail]/Drafts" if you get an error
+that the "Folder doesn't exist".
+
 Next, ensure that your Gmail settings are correct. In "Settings" the
 "Use Unicode (UTF-8) encoding for outgoing messages" should be checked.
 
@@ -513,3 +522,4 @@ command to send the patch emails to your Gmail Drafts folder.
 
 Go to your Gmail account, open the Drafts folder, find the patch email, fill
 in the To: and CC: fields and send away!
+
-- 
1.6.2.rc1.3.g7d31b.dirty
