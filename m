From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH] Google seems to have renamed the imap folder
Date: Tue, 17 Feb 2009 09:06:16 +0000
Message-ID: <43d8ce650902170106k7635223pc886899adc609faf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 10:07:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZLve-0006XA-6S
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 10:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbZBQJGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 04:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbZBQJGS
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 04:06:18 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:51613 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbZBQJGR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 04:06:17 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1072705ywh.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 01:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=fwAHet/uCN3DGgbtNkhtkyRrelXJJO58R14nWXHeClQ=;
        b=Cb85pF7ysy5vX+mIPPymwriHncVWtKRHp/2LHf7xWerscZm9/saUm7s65yqM5kJ78P
         nwvhN5o/TKgsbgG4LpRUdN7IBp+vaBWs+OP+G6ucuOupWp3Hh7bUmbHkASqzQDxi0Til
         +xgUbwunQoIY3QmnjMpA52B9EQbjVb8qDyg2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=bARxSTg3KramH//p/eY6wdgRoKwhc0yr82uPWFbtdcbRO1WTa7aHcEit5QarRmk0kH
         SjY1EoHbezDNTOc0/GSDREsCX8WDRnkKogwciYxoGjNewDwY15VLjOTCDdcUcDL1scFp
         VM49oGZe4RI0kEbQ4GLWNpm0kJbLvcnskrVHU=
Received: by 10.150.201.17 with SMTP id y17mr6218664ybf.198.1234861576065; 
	Tue, 17 Feb 2009 01:06:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110340>

Signed-off-by: John Tapsell <johnflux@gmail.com>
---
 Documentation/SubmittingPatches |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 9b559ad..f9850b3 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -496,7 +496,7 @@ IMAP support is available. First, edit your
~/.gitconfig to specify your
 account settings:

 [imap]
-	folder = "[Gmail]/Drafts"
+	folder = "[Google Mail]/Drafts"
 	host = imaps://imap.gmail.com
 	user = user@gmail.com
 	pass = p4ssw0rd
@@ -513,3 +513,4 @@ command to send the patch emails to your Gmail
Drafts folder.

 Go to your Gmail account, open the Drafts folder, find the patch email, fill
 in the To: and CC: fields and send away!
+If you get an error that the "Folder doesn't exist" try with folder =
"[Gmail]/Drafts".
-- 
1.6.2.rc1
