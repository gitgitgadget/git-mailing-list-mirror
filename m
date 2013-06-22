From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 08/14] ls-remote doc: fix example invocation on git.git
Date: Sat, 22 Jun 2013 13:28:15 +0530
Message-ID: <1371887901-5659-9-git-send-email-artagnon@gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 10:03:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqImk-0000mq-OY
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 10:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423757Ab3FVICA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 04:02:00 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:56241 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423747Ab3FVIB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 04:01:58 -0400
Received: by mail-pa0-f45.google.com with SMTP id bi5so8853175pad.32
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 01:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4+xR7ZIxUO/vetVhEhw44IWwlWxMBYqwU9ZAH0NE+f8=;
        b=EZJVHo7X6I6bXjxUTwrhQuzphFvFJaUCQyX0Kc29seau5JLfWHxgdSgPx+4IK5rBLj
         GlxaoKevlpafUOv8cUAfjWrxza9owjkBgs/DRgoiHwKYRztr8FFzht2c6ves3gdgOnG5
         6JHriVGDkSPijDjKch1bCLSAhCyIGPOqI4sWfbub61WOz0vrQ3J8mChkiL+Xl9W2ofvx
         oFLYHDpmuTYY00n5lVf8HjCS4cBxMxH25HN6EztweoLVXAVOFPxi+wXLAAIwv2ynQ6wP
         ZieMirbEefmo4xaWitq56knXt4H2PZANbnUAvUVrPH+5IZM7tO63rfHsE15J4hu+MZcv
         M+vA==
X-Received: by 10.66.163.38 with SMTP id yf6mr19367500pab.45.1371888117918;
        Sat, 22 Jun 2013 01:01:57 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id dc3sm8355333pbc.9.2013.06.22.01.01.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 01:01:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.gd3dfebf
In-Reply-To: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228688>

Under the EXAMPLES section, there is one invocation on the git.git
repository that attempts to list the refs master, pu, and rc.  The ref
rc does not exist in today's repository, so remove it.  Among other
things, this example demonstrates that the "<refs>..." argument is
simply a filter; requesting a non-existent ref is not an error.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-ls-remote.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 774de5e..cce4f93 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -70,7 +70,6 @@ EXAMPLES
 	$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master pu rc
 	5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
 	c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/pu
-	b1d096f2926c4e37c9c0b6a7bf2119bedaa277cb	refs/heads/rc
 	$ echo http://www.kernel.org/pub/scm/git/git.git >.git/branches/public
 	$ git ls-remote --tags public v\*
 	d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
-- 
1.8.3.1.498.gacf2885
