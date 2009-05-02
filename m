From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH] t4018-diff-funcname: add cpp xfuncname pattern to syntax test
Date: Sat,  2 May 2009 09:31:16 -0500
Message-ID: <1241274676-7820-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat May 02 16:29:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0GDi-000288-1A
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 16:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756153AbZEBO33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 10:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755812AbZEBO32
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 10:29:28 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:34339 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607AbZEBO31 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 10:29:27 -0400
Received: by gxk10 with SMTP id 10so5895117gxk.13
        for <git@vger.kernel.org>; Sat, 02 May 2009 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=KmJLuqkWZFWI8oiA9048WgCAp6CrO+iYZlxyzqYHHrg=;
        b=tYWOFvX1CGUmDaTOE++/v6hh6es1k4DWCnkugkHQkfduaZG8mxpkZoGH9eucJ7I1dg
         ncT1QJMrcoMMxXiGh4k6JrzZlBMnWxsRR1WzPrZvsC55czU/O7lNXCPui8vbHn7e1muP
         bk7TbjQhObuNVUYC3Zf3Ng3LaXI19g1IbtT5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Yw+M3UQsBpjNd1c8QlM7kk0iZ+voVmEuLFakzYUEXUG6zoZBz2+nsEFrdsn3W/g/tZ
         he56WcK0I6jLhH2FnU6RbrVCAsJi+GA7VZDk6oSDJMnPlo7+j0KDBv2/bXQwp7MsqYBT
         AH/h9z+MJAwi+McXvKayOL1R0l4snuPkP3mQg=
Received: by 10.90.104.15 with SMTP id b15mr3316985agc.98.1241274567346;
        Sat, 02 May 2009 07:29:27 -0700 (PDT)
Received: from localhost.localdomain ([96.19.141.3])
        by mx.google.com with ESMTPS id 8sm7332313agd.37.2009.05.02.07.29.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 May 2009 07:29:26 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc4.1.gfa961
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118134>

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t4018-diff-funcname.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index be54134..5b10e97 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -32,7 +32,7 @@ EOF
 
 sed 's/beer\\/beer,\\/' < Beer.java > Beer-correct.java
 
-builtin_patterns="bibtex html java objc pascal php python ruby tex"
+builtin_patterns="bibtex cpp html java objc pascal php python ruby tex"
 for p in $builtin_patterns
 do
 	test_expect_success "builtin $p pattern compiles" '
-- 
1.6.3.rc4.1.gfa961
