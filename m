From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] tg-log: move note from tg base to tg log
Date: Mon,  4 Oct 2010 21:06:29 +0200
Message-ID: <1286219189-22054-1-git-send-email-bert.wesarg@googlemail.com>
References: <AANLkTi=sc-FBG=CeNTv9H4Fj0KqdHkoudjQHqEYZxPuV@mail.gmail.com>
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 21:06:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2qN2-00029n-Tg
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 21:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370Ab0JDTGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 15:06:35 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48391 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243Ab0JDTGe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 15:06:34 -0400
Received: by bwz11 with SMTP id 11so3887886bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 12:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=ZPGW9Z+QtmyXoxA0XvFPagqqKpMlaVuYGsBPLSMF85E=;
        b=AuuApqarZotNrWtLd/WWDSQrP1TatYDoQ7ANQ0E1r1rAhKc9YPX1AInO3OL3XmdNny
         ntxbFOaW9uIo68pnbJ6ap6TbZ68nPGxeHPYBDsa6Obq156q5TJevFWCnTF/IjOYqtlCa
         WjfaBHMth65T6gpiBGV73YquZYn3yf1c06PhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZtLUjlZSV5kvrQ7hnM4zPTwDf9RJKZAjEJqNZsCzBb3YKkBkGHs9wb/jSYr82SmlNE
         As2LCOl+d2yo/meskVpHY3CKYqxZZECrJKjdvuMfv1z9sHcMxzuWX1bO1tc8n34Iwdip
         ib6chUWKiP3kitCq7mQRkKaPjjjHFvEQWqERA=
Received: by 10.204.112.84 with SMTP id v20mr7251226bkp.213.1286219192790;
        Mon, 04 Oct 2010 12:06:32 -0700 (PDT)
Received: from localhost (p5B0F7A6E.dip.t-dialin.net [91.15.122.110])
        by mx.google.com with ESMTPS id 11sm4064768bkj.23.2010.10.04.12.06.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 12:06:31 -0700 (PDT)
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <AANLkTi=sc-FBG=CeNTv9H4Fj0KqdHkoudjQHqEYZxPuV@mail.gmail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158097>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 README |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/README b/README
index ce0c3a6..2331117 100644 README
--- a/README
+++ b/README
@@ -514,20 +514,17 @@ tg base
 ~~~~~~~
 	Prints the base commit of the current topic branch.  Silently
 	exits with exit code 1 if you are not working on a TopGit
-	branch.  The following command can be useful to get a summary
-	of the work you have made on a topic branch:
-
-		git log --first-parent --no-merges `tg base`..
-
-	(Note: if you have shared the TopGit branch, the above command
-	only lists the commits that were made in the current
-	repository, so you will not see work done by your
-	collaborators.)
+	branch.
 
 tg log
 ~~~~~~
 	Prints the git log of the named topgit branch.
 
+	Note: if you have shared the TopGit branch, this command
+	only lists the commits that where made in the current
+	repository, so you will not see work done by your
+	collaborators.
+
 TODO: tg rename
 
 
-- 
tg: (ff59ac7..) bw/log (depends on: master)
