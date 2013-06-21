From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 11/16] ls-remote doc: don't encourage use of branches-file
Date: Fri, 21 Jun 2013 16:42:35 +0530
Message-ID: <1371813160-4200-12-git-send-email-artagnon@gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:16:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzKR-0003cP-3j
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398Ab3FULQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:16:24 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:45985 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030336Ab3FULQV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:16:21 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so7639104pbb.20
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IeyHc0eQgmI0cOnQwcjHnO1rxs+HpiWmFXJtDU6qQQ4=;
        b=uV4MciA5smcDXFujsKc9xvzstUeC4MVI61GQEHXHjWzOADKzHzt2laH3v+nLfOPOjM
         3Fsmid/jVhoSnGIst9EsT42fZErXkj8cz72wv+wKUjD4POOFMqepy2DH+3tJU4TiQUWc
         ZtDKHF2YJdNqLVap59I2qaG+JwwX3h4XTB3in+f8QPDu3Wo8+uekzboBcOpFOU7W2k7V
         CIN+5JTT19+hzoZYj70RxqeL8NSip0zrblTZ834Hft26BQv5zzPHClDLxllCCQw1wzAw
         g4y0mPIETCebrYPc4IA8P4742TmPtF3ACZ+flgclXubhqC1G3vkC7dNNyM0067h9UkFb
         JXcQ==
X-Received: by 10.68.14.6 with SMTP id l6mr11947232pbc.202.1371813381477;
        Fri, 21 Jun 2013 04:16:21 -0700 (PDT)
Received: from localhost.localdomain ([122.164.10.8])
        by mx.google.com with ESMTPSA id ig4sm4486341pbc.18.2013.06.21.04.16.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:16:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.499.g7ad3486.dirty
In-Reply-To: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228602>

One outdated example encourages the use of $GIT_DIR/branches files.
Replace it with an equivalent example using a remote.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-ls-remote.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 0715892..340c3ff 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -70,8 +70,8 @@ EXAMPLES
 	$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master pu
 	5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
 	c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/pu
-	$ echo http://www.kernel.org/pub/scm/git/git.git >.git/branches/public
-	$ git ls-remote --tags public v\*
+	$ git remote add korg http://www.kernel.org/pub/scm/git/git.git
+	$ git ls-remote --tags korg v\*
 	d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
 	f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
 	c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
-- 
1.8.3.1.499.g7ad3486.dirty
