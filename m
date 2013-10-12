From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 6/7] pull: cleanup documentation
Date: Sat, 12 Oct 2013 02:01:59 -0500
Message-ID: <1381561322-20059-5-git-send-email-felipe.contreras@gmail.com>
References: <1381561322-20059-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:08:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtJJ-0002IP-J5
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816Ab3JLHIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:08:17 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:40552 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab3JLHIP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:08:15 -0400
Received: by mail-oa0-f43.google.com with SMTP id i3so3126932oag.16
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w+YUHKfiJ6JWA+gbdD6/xeaV8dZq+qLS4aRrzWrcUmY=;
        b=tQUZvUoMxD0Zoys0RU2KrqIjcbxBN2ght32ZJvnRCc53TDKG/mwBEPPvSFi/LxLsbh
         tfvwQTSffimt+dKI/KwCZwJFPpEBatVsUhUs8j5KSpuk0dWE2/1ea73AnXKWyI9bnxAO
         kbbELlkaIlbyfSzuvoCKNFw0E0EvBmUzE1Utgd8lrBoRJp7w6AfcnKrYlp4yWJuNjkET
         ND9t28GZ7ExpvvKtgbix2VnRe0yicRLKJl645MicwOSYxjrlAQI/6l1akuqXhNKzQvnv
         Y6HaVamlyr6GTF8aBoMwA0R4xuNg1lNDh+rn5IwRyOlYIS+pL49ybg11bc44jVDJeVCF
         uu2A==
X-Received: by 10.60.45.102 with SMTP id l6mr13727549oem.36.1381561694705;
        Sat, 12 Oct 2013 00:08:14 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r3sm101368939oep.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:08:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561322-20059-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235952>

'origin/master' is very clear, no need to specify the 'remotes/' prefix,
or babysit the user.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index e09f004..6d55737 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -39,7 +39,7 @@ Assume the following history exists and the current branch is
 "`master`":
 
 ------------
-	  A---B---C master on origin
+	  A---B---C origin/master
 	 /
     D---E---F---G master
 ------------
@@ -51,7 +51,7 @@ result in a new commit along with the names of the two parent commits
 and a log message from the user describing the changes.
 
 ------------
-	  A---B---C remotes/origin/master
+	  A---B---C origin/master
 	 /         \
     D---E---F---G---H master
 ------------
-- 
1.8.4-fc
