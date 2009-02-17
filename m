From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH 2/2] Google has renamed the imap folder
Date: Tue, 17 Feb 2009 10:45:05 +0000
Message-ID: <200902171045.05904.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 11:46:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZNTI-00055W-Jb
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 11:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbZBQKpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 05:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbZBQKpL
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 05:45:11 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:59652 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbZBQKpK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 05:45:10 -0500
Received: by rv-out-0506.google.com with SMTP id g9so1453324rvb.5
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 02:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:date:to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=wSdaylEIDJm2E9C+PvLKA5ZWWMsFbe4Xb4XYs5a+vSQ=;
        b=irL+IlQvGULK6GyFI1wCCNTlvg/vTsnRrOZ4bAYm6pRzrz0Np4pYXaPnLgWijx7Rgb
         TdyZnVa0yARKmY5GTCfOlM6NY6uEOxZt6I05UDrAt5Vl9lJ2piwheuLuh6ulHSI7BOXZ
         KBgeYONitQROxYpL1cfu2BB3xEHEdYRB07f3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:date:to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=asGfapepHE7/0adUrWx0Yk69RsMsqDKUGYM51dqk56rIh56O+y41gEDW7BAnuGNjnv
         HGniQIJHScF8hrWHfTm98CdjxdUr99b+0TZaHY54KuDqQvaBXU8MNE0l5yWjcP7XOkUp
         ahGeOou8HX4VSIUjoFtXbuwkQcLCxMcD/LBkY=
Received: by 10.141.122.20 with SMTP id z20mr432976rvm.216.1234867509073;
        Tue, 17 Feb 2009 02:45:09 -0800 (PST)
Received: from johnflux-desktop.localnet (58-190-81-184.eonet.ne.jp [58.190.81.184])
        by mx.google.com with ESMTPS id f42sm6051225rvb.3.2009.02.17.02.45.07
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 02:45:08 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110355>

Also add a comment that the web interface wraps the lines

Signed-off-by: John Tapsell <johnflux@gmail.com>
---
 Documentation/SubmittingPatches |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 9b559ad..aa41c9e 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -491,12 +491,18 @@ message, complete the addressing and subject fields, and press send.
 Gmail
 -----
 
+GMail does not appear to have any way to turn off line wrapping in the web
+interface, so this will mangle any emails that you send.  You can however
+use any IMAP email client to connect to the google imap server, and forward
+the emails through that.  Just make sure to disable line wrapping in that
+email client.
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
@@ -513,3 +519,5 @@ command to send the patch emails to your Gmail Drafts folder.
 
 Go to your Gmail account, open the Drafts folder, find the patch email, fill
 in the To: and CC: fields and send away!
+If you get an error that the "Folder doesn't exist" try with folder = "[Gmail]/Drafts".
+
-- 
1.6.2.rc1
