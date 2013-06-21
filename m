From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 10/16] ls-remote doc: rewrite <repository> paragraph
Date: Fri, 21 Jun 2013 16:42:34 +0530
Message-ID: <1371813160-4200-11-git-send-email-artagnon@gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:16:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzKg-0003xG-2e
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393Ab3FULQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:16:23 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:40775 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030390Ab3FULQU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:16:20 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so7663959pab.10
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OzPozBuUWE7fStrhDazQvsEpCnfRRVL6B2mn3FISwn0=;
        b=u2TB61Cbq4ifcVDHjmoQ6eu/JXiRXHU5NR/fsbBAGcxHcjNR6ji209+TEGwMnufDhm
         MNALKs9DnTRsQ9DCzCwDdzwtT7ysLA2Ft7sYLAMvgCeiP8JAEDc/4b5u/SopIyOq8moe
         zq/EiahwQlFUQvSUwN1vHbiw6sW/YBiwa/T1TrRMM55bR4NQCYDSzmlNAP/c5RXbetrh
         cgHoco244JJ5q+uwOdOeWYzxOyQLc6eHN5fLzGQ8NVFYE2IiH/QB/ClUw2WdoEs/sN4N
         UoK/f6jTk6Pz22XzuTdmFO82NR1j8Z4PxjcsB6L+Uz6jZRGrdDCw8JC3lfPUeFhzxWJ4
         x0Ow==
X-Received: by 10.66.245.110 with SMTP id xn14mr15709022pac.130.1371813379437;
        Fri, 21 Jun 2013 04:16:19 -0700 (PDT)
Received: from localhost.localdomain ([122.164.10.8])
        by mx.google.com with ESMTPSA id ig4sm4486341pbc.18.2013.06.21.04.16.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:16:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.499.g7ad3486.dirty
In-Reply-To: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228608>

Replace the <repository> paragraph containing specific references to
$GIT_DIR/branches and "." with a generic urls-or-remotes paragraph
referencing the relevant sections in the git-fetch(1) manpage.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-ls-remote.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index a24b8b6..0715892 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -48,9 +48,9 @@ OPTIONS
 	exit without talking to the remote.
 
 <repository>::
-	Location of the repository.  The shorthand defined in
-	$GIT_DIR/branches/ can be used. Use "." (dot) to list references in
-	the local repository.
+	The "remote" repository to query.  This parameter can be
+	either a URL or the name of a remote (see the GIT URLS and
+	REMOTES sections of linkgit:git-fetch[1]).
 
 <refs>...::
 	When unspecified, all references, after filtering done
-- 
1.8.3.1.499.g7ad3486.dirty
