From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 04/11] Document that '--message=<msg>' is long version of '-m <msg>'
Date: Sat, 16 Jun 2007 21:03:40 +0200
Message-ID: <1182020633805-git-send-email-jnareb@gmail.com>
References: <11820206272990-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 16 20:58:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzdU2-0007JN-1l
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 20:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbXFPS6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 14:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753967AbXFPS6R
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 14:58:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:8389 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbXFPS6M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 14:58:12 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1101905ugf
        for <git@vger.kernel.org>; Sat, 16 Jun 2007 11:58:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gY1qjQi2zTeQ3NhTwLnpxm0EqEbVqLgjN6odQvLG4ToxV4vvq98C3B0ZmRHOGprWtuCHsrQyT8tfPRb51nBe2/EbGz3c9tYpGQM4f/DGdXAdB6ZrWmr6sQERbWobQyvp9ozxJkTUjZgEiMVZgYt45Mb6ZELDy9A2Ong39QA1jjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FZ+/Pxjura6MbzlsxiPW3NjuwChhOoPVQ7v7RmRvbtQfYmqgSNaWPvz1WhZ8hnl0ijU4cd0vfJV91/ST8j48u01MeRBVP0l+BPyv7NIA6N8geNbLioXWiTabifH5p+IFxixhhQxRCx219NTUJSDJHQ0XF+hx+KWs0duG41Pp7sU=
Received: by 10.78.153.17 with SMTP id a17mr1716753hue.1182020292275;
        Sat, 16 Jun 2007 11:58:12 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id h6sm1875671nfh.2007.06.16.11.58.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jun 2007 11:58:11 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l5GJ3r3n004238;
	Sat, 16 Jun 2007 21:03:53 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l5GJ3r5o004237;
	Sat, 16 Jun 2007 21:03:53 +0200
X-Mailer: git-send-email 1.5.2
In-Reply-To: <11820206272990-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50296>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/git-commit.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 53a7bb0..352a494 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -71,7 +71,7 @@ OPTIONS
 	Override the author name used in the commit.  Use
 	`A U Thor <author@example.com>` format.
 
--m <msg>::
+-m <msg>|--message=<msg>::
 	Use the given <msg> as the commit message.
 
 -s|--signoff::
-- 
1.5.2
