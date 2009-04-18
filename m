From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3.5 12/12] Docs: send-email: git send-email -> 'send-email'
Date: Sat, 18 Apr 2009 12:02:08 -0500
Message-ID: <1240074128-16132-13-git-send-email-mfwitten@gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-7-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-8-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-9-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-10-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-11-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-12-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 19:10:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvE3S-0007sD-A5
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 19:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbZDRRIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 13:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753805AbZDRRIk
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 13:08:40 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:49433 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547AbZDRRIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 13:08:39 -0400
Received: by qw-out-2122.google.com with SMTP id 5so486458qwd.37
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LJei/5r0Arv1lIzqTa4/Hn6dWjtLiYI9PnoYg8xZKeo=;
        b=NPjmqR8K58n4+rXHEuRv9OXQSCJx0byZZ2MM+CaH3Lt7Ufn3RWtmbs0+iQJB2vLgoY
         yGpjnWcvnkDw0NLL20UueXBa35X/JDzxh/CK6vGiHWw/xV/bRBR3DnqqlSX19A10v+xM
         ZSprxyZpca84haRd86MK5tJClKDFptsosQYCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wVwcsEtYgDKlPEntI18U99En0qk5yy5pj+0vEdJfW+pSO1fwLs9Oo/Mgg25ozHhvrW
         z66Gzo/rCi7ELZxeQvXkMJ5CnXRVzj1vzdAuixV/XIZ0cDUtlmdRP24gbHa0ghqY9Rsc
         i4davN9MHWq2nG/lz73AlwCG68vAOaoqaenMw=
Received: by 10.220.99.149 with SMTP id u21mr4124404vcn.94.1240074518697;
        Sat, 18 Apr 2009 10:08:38 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-103.mpls.qwest.net [97.116.125.103])
        by mx.google.com with ESMTPS id 6sm1776586ywn.52.2009.04.18.10.08.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 10:08:38 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1240074128-16132-12-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116856>

For the sake of consistency.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3b36ac7..11965eb 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -59,7 +59,7 @@ The --cc option must be repeated for each user you want on the cc list.
 	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR to edit an
 	introductory message for the patch series.
 +
-When '--compose' is used, git send-email will use the From, Subject, and
+When '--compose' is used, 'send-email' will use the From, Subject, and
 In-Reply-To headers specified in the message. If the body of the message
 (what you type after the headers and a blank line) only contains blank
 (or GIT: prefixed) lines the summary won't be sent, but From, Subject,
@@ -244,7 +244,7 @@ Administering
 --
 - 'always' will always confirm before sending
 - 'never' will never confirm before sending
-- 'cc' will confirm before sending when send-email has automatically
+- 'cc' will confirm before sending when 'send-email' has automatically
   added addresses from the patch to the Cc list
 - 'compose' will confirm before sending the first message when using --compose.
 - 'auto' is equivalent to 'cc' + 'compose'
@@ -261,10 +261,10 @@ have been specified, in which case default to 'compose'.
 	When an argument may be understood either as a reference or as a file name,
 	choose to understand it as a format-patch argument ('--format-patch')
 	or as a file name ('--no-format-patch'). By default, when such a conflict
-	occurs, git send-email will fail.
+	occurs, 'send-email' will fail.
 
 --quiet::
-	Make git-send-email less verbose.  One line per email should be
+	Make 'send-email' less verbose.  One line per email should be
 	all that is output.
 
 --[no-]validate::
-- 
1.6.2.2.479.g2aec
