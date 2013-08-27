From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] documentation: clarify notes for clean.requireForce
Date: Tue, 27 Aug 2013 22:11:29 +0800
Message-ID: <07b4019b473c2e6d46e75b5ae5ce3f431e4e74d0.1377612590.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 16:14:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEK2N-0004NE-37
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 16:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab3H0OOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 10:14:16 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:49590 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097Ab3H0OOO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 10:14:14 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so4924733pbb.10
        for <git@vger.kernel.org>; Tue, 27 Aug 2013 07:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=WIo6Dz5IlCj7jxjgHn4fR8jTXQ/zWJMFXbb6ZT12Geg=;
        b=ofKsCXdSXkpBleYWnlX8SxzVssr+MSiIs2FTlvw2uu4fTqfzpzX3fIvl2UusG8pZ7f
         5HJzODECCaIHl5RI3YwVJTszn3yr+lQSeMT/HI8cYSdDaMB6tN6JtC6dMdHe0LTL9VeQ
         eklHWueymuHRRDCZtyQ6d9zGQpMnhqIbk064TAAHPvY4WVts9tc1ahwUeCV6KoNaOfcD
         u5NWZeduTxiwhIEtyS0YpfP1IDElrDtIsAjr6fcA6ddeXFAnSlDaBlfDRlGGtUG8hcqe
         aqhR0QVHmVS8JSKUlbwhBbtyui6AZiLLHr2PSQlhKEzmgXHSlRY8ZRkYSKEtjNMPYGaG
         PUrA==
X-Received: by 10.68.194.104 with SMTP id hv8mr9113984pbc.168.1377612853422;
        Tue, 27 Aug 2013 07:14:13 -0700 (PDT)
Received: from localhost.localdomain ([114.248.144.150])
        by mx.google.com with ESMTPSA id pu5sm27164588pac.21.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 Aug 2013 07:14:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.2.gf223459
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233090>

Add "-i" (interactive clean option) to clarify the documentation for
"clean.requireForce" config variable. Also replace the example in
`gitcli.txt` with safer git clean command.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 Documentation/config.txt | 4 ++--
 Documentation/gitcli.txt | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8361380..547149d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -795,8 +795,8 @@ browser.<tool>.path::
 	working repository in gitweb (see linkgit:git-instaweb[1]).
 
 clean.requireForce::
-	A boolean to make git-clean do nothing unless given -f
-	or -n.   Defaults to true.
+	A boolean to make git-clean do nothing unless given -i,
+	-f or -n.   Defaults to true.
 
 color.branch::
 	A boolean to enable/disable color in the output of
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 9ac5088..4005a3b 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -135,7 +135,7 @@ Aggregating short options
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 Commands that support the enhanced option parser allow you to aggregate short
 options. This means that you can for example use `git rm -rf` or
-`git clean -fdx`.
+`git clean -idx`.
 
 
 Abbreviating long options
-- 
1.8.4.rc3.2.gf223459
