From: A.J.Delaney@brighton.ac.uk
Subject: [Patch] Error message grammar
Date: Wed, 02 Mar 2011 21:37:18 +0000
Message-ID: <1299101838.2807.54.camel@SillyFace>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-lGwibIDJ9lIotAgUOZkP"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 22:37:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Putjk-0001u5-Me
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 22:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757454Ab1CBVh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 16:37:26 -0500
Received: from mail49.messagelabs.com ([85.158.136.51]:46798 "EHLO
	mail49.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757122Ab1CBVhX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 16:37:23 -0500
X-VirusChecked: Checked
X-Env-Sender: A.J.Delaney@brighton.ac.uk
X-Msg-Ref: server-9.tower-49.messagelabs.com!1299101840!6693057!1
X-StarScan-Version: 6.2.9; banners=brighton.ac.uk,-,-
X-Originating-IP: [194.81.203.230]
Received: (qmail 3554 invoked from network); 2 Mar 2011 21:37:20 -0000
Received: from msa1.bton.ac.uk (HELO msa1.bton.ac.uk) (194.81.203.230)
  by server-9.tower-49.messagelabs.com with DHE-RSA-AES256-SHA encrypted SMTP; 2 Mar 2011 21:37:20 -0000
Received: from [87.127.55.57] (port=42242 helo=[10.0.1.35])
	by msa1.bton.ac.uk with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <A.J.Delaney@brighton.ac.uk>)
	id 1PutjU-0003kJ-40
	for git@vger.kernel.org; Wed, 02 Mar 2011 21:37:20 +0000
X-Mailer: Evolution 2.32.2 (2.32.2-1.fc14) 
X-UoB-Sender: A.J.Delaney@brighton.ac.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168350>


--=-lGwibIDJ9lIotAgUOZkP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Dear all,
	I got an error message from git and the grammar tweaked me (maybe it's
just the mood I'm in).  I'm not subscribed to the list.

-- 
Aidan


___________________________________________________________
This email has been scanned by MessageLabs' Email Security
System on behalf of the University of Brighton.
For more information see http://www.brighton.ac.uk/is/spam/
___________________________________________________________
--=-lGwibIDJ9lIotAgUOZkP
Content-Disposition: attachment; filename="0001-Fixed-grammar-on-two-error-messages.patch"
Content-Type: text/x-patch; name="0001-Fixed-grammar-on-two-error-messages.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 743d2eda72eb393bee41ac98a3994d110916b08a Mon Sep 17 00:00:00 2001
From: Aidan Delaney <aidan@phoric.eu>
Date: Wed, 2 Mar 2011 21:30:36 +0000
Subject: [PATCH] Fixed grammar on two error messages.

---
 builtin/commit.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 355b2cb..d56ddeb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -991,9 +991,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	handle_untracked_files_arg(s);
 
 	if (all && argc > 0)
-		die("Paths with -a does not make sense.");
+		die("Using paths with -a does not make sense.");
 	else if (interactive && argc > 0)
-		die("Paths with --interactive does not make sense.");
+		die("Using paths with --interactive does not make sense.");
 
 	if (null_termination && status_format == STATUS_FORMAT_LONG)
 		status_format = STATUS_FORMAT_PORCELAIN;
-- 
1.7.4


--=-lGwibIDJ9lIotAgUOZkP--
