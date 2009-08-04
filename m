From: Adam Brewster <adambrewster@gmail.com>
Subject: [PATCH] svn: Add && to t9107-git-svn-migrarte.sh
Date: Mon,  3 Aug 2009 21:40:37 -0400
Message-ID: <1249350039-7338-2-git-send-email-adambrewster@gmail.com>
References: <1249350039-7338-1-git-send-email-adambrewster@gmail.com>
Cc: normalperson@yhbt.net, Adam Brewster <adambrewster@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 03:41:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY92L-0004K0-RX
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 03:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986AbZHDBlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 21:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890AbZHDBlu
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 21:41:50 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:35732 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbZHDBlu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 21:41:50 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1924262qwh.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 18:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=biy9cPvbIX/4xSkqITp46hXTPeATKTGqz8vvlRsRVqo=;
        b=xUfeqrtWP3JDxadxkXmo0SIQFHls0d/qdNuqKxiA91jAbwJ2zIiekXjnhnTYFKapte
         pa/B5uEVxp0Xshi8K6d9isT8kuJ22R4p/RQXW6WqUYY9KY1BnH08bIqjt31sPIPAmdmN
         KWDL3W9367JFI2cFBSxpmjS39TMdkZtHqBOS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XMqz5/0yR4jHE+NUh7cZh5SmfoKgXAJq/+N35N9vFB78yPK2EZdV7NLE+sZB2eyXAE
         dw6VL1kUxjwj2Tg549tX8mUHfKtkiEum0ne60KMS1QFgNAw9wO5khbyZNTZiAEoknuq/
         dzIXjUffcIiIcHwhTiulFS5MHR8qzGUgoR354=
Received: by 10.224.54.75 with SMTP id p11mr2548123qag.358.1249350110312;
        Mon, 03 Aug 2009 18:41:50 -0700 (PDT)
Received: from MBE.internal (c-24-61-131-49.hsd1.nh.comcast.net [24.61.131.49])
        by mx.google.com with ESMTPS id 8sm14139385qwj.6.2009.08.03.18.41.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Aug 2009 18:41:49 -0700 (PDT)
Received: by MBE.internal (Postfix, from userid 1000)
	id AB44321C826; Mon,  3 Aug 2009 21:40:39 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1249350039-7338-1-git-send-email-adambrewster@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124740>

It was probably intended for the test to fail unless all of the
commands succeed.
---
 t/t9107-git-svn-migrate.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 3a9e077..145a367 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -93,7 +93,7 @@ test_expect_success 'migrate --minimize on old inited layout' '
 	grep "^branches/b:refs/remotes/b$" fetch.out &&
 	grep "^tags/0\.1:refs/remotes/tags/0\.1$" fetch.out &&
 	grep "^tags/0\.2:refs/remotes/tags/0\.2$" fetch.out &&
-	grep "^tags/0\.3:refs/remotes/tags/0\.3$" fetch.out
+	grep "^tags/0\.3:refs/remotes/tags/0\.3$" fetch.out &&
 	grep "^:refs/${remotes_git_svn}" fetch.out
 	'
 
-- 
1.6.0.6
