From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3 02/13] Docs: send-email: Refer to CONFIGURATION section for sendemail.multiedit
Date: Mon, 13 Apr 2009 13:23:46 -0500
Message-ID: <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:28:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtQst-00089s-5J
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbZDMS0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbZDMS0T
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:26:19 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:43471 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbZDMS0S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:26:18 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1130673wah.21
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=U4W5/fxwfpb3/4UjhajkiASKl1b0v1jrk0ak4MzmQO4=;
        b=kDrLgRVrPkQ/T7oTsg0jU9AmXQLBSbM7VRjA9Em0shFeaBhruEAGrRvJUNMzEy8wJS
         1Sq1dV7sCO4DnGb8m8tKx1eOG1XRQuf/FtLggw8wBTyYt64ig8Cz8U6ki+3L6YhSc72h
         q5TBl2W/P1FiUvIP4FNVn6hnenfNPgX7a7f9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tcYEY7gIhCfRCWiR7SqdxgvVUm/qBvG6N7esgYqtd2Kgxesw4UYhBvMA4IRx/16SQG
         a5wsNTLzaDd9xaiZNkrk9HSfzpObhXdlRs1RPthcrNq2feIIRWvMVZht/mEpWc8WrHr9
         EZ1pEv1ffxoCtR/wcPJpAvs3/sqLQlyL5A9m8=
Received: by 10.114.167.3 with SMTP id p3mr3287026wae.127.1239647177572;
        Mon, 13 Apr 2009 11:26:17 -0700 (PDT)
Received: from localhost.localdomain (97-116-116-167.mpls.qwest.net [97.116.116.167])
        by mx.google.com with ESMTPS id m30sm5963707wag.12.2009.04.13.11.26.16
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 11:26:16 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116463>

Replace description of sendemail.multiedit in --annotate docs
with a reference to the CONFIGURATION section.

Add such a reference to the --compose documentation.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 4db5a09..7b87d6e 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -40,9 +40,8 @@ Composing
 ~~~~~~~~~
 
 --annotate::
-	Review each patch you're about to send in an editor. The setting
-	'sendemail.multiedit' defines if this will spawn one editor per patch
-	or one for all of them at once.
+	Review and edit each patch you're about to send. See the
+	CONFIGURATION section for 'sendemail.multiedit'.
 
 --bcc=<address>::
 	Specify a "Bcc:" value for each email. Default is the value of
@@ -67,6 +66,8 @@ In-Reply-To headers specified in the message. If the body of the message
 and In-Reply-To headers will be used unless they are removed.
 +
 Missing From or In-Reply-To headers will be prompted for.
++
+See the CONFIGURATION section for 'sendemail.multiedit'.
 
 --from=<address>::
 	Specify the sender of the emails.  This will default to
-- 
1.6.2.2.479.g2aec
