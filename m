From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 07/10] git-tag.txt: list all modes in the description
Date: Tue, 15 Feb 2011 14:09:10 +0100
Message-ID: <d40d37a59ce17ff833edf07fd20f0faebde319a3.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 14:12:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpKi6-0004O3-KP
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 14:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625Ab1BONMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 08:12:34 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54208 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751466Ab1BONMa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 08:12:30 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E11E02089C;
	Tue, 15 Feb 2011 08:12:29 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 15 Feb 2011 08:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=ggiICY3wns3n5+DspsPtJNior74=; b=tS7SD+gDQ01Wy/MRxhagp7QkiJrKY7aQMWuTJLjxRw7LkLo0kCC109oSC73Ac5kNolkUoPLjL/RB4H2jiaqLvR8v6RuaNqi9Fv6cThn0fAIxVB+4igfLu8UDjCohIRk8Y8kFMeHe8NHEeNgBSUPVjwzTA0OCNPX9+NYsMSgmiQ4=
X-Sasl-enc: VYujkZqqJZSZaajhNOJTB04iKiPRxr1Zi2zdtfppIUOU 1297775549
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6AA93443B97;
	Tue, 15 Feb 2011 08:12:29 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297775122.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166850>

Currently, the description sounds as if it applied always, but most of
its content is true in "create tag mode" only.

Make this clearer by listing all modes upfront.

Also, sneak in some linguistic improvements and make it clearer that
lightweight tags are "created" because "written" may be misread as
"are output".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-tag.txt |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 8b169e3..65f76c5 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -18,21 +18,22 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Adds a tag reference in `.git/refs/tags/`.
+Add a tag reference in `.git/refs/tags/`, unless `-d/-l/-v` is given
+to delete, list or verify tags.
 
-Unless `-f` is given, the tag must not yet exist in
+Unless `-f` is given, the tag to be created must not yet exist in the
 `.git/refs/tags/` directory.
 
 If one of `-a`, `-s`, or `-u <key-id>` is passed, the command
-creates a 'tag' object, and requires the tag message.  Unless
+creates a 'tag' object, and requires a tag message.  Unless
 `-m <msg>` or `-F <file>` is given, an editor is started for the user to type
 in the tag message.
 
 If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <key-id>`
 are absent, `-a` is implied.
 
-Otherwise just the SHA1 object name of the commit object is
-written (i.e. a lightweight tag).
+Otherwise just a tag reference for the SHA1 object name of the commit object is
+created (i.e. a lightweight tag).
 
 A GnuPG signed tag object will be created when `-s` or `-u
 <key-id>` is used.  When `-u <key-id>` is not used, the
-- 
1.7.4.1.74.gf39475.dirty
