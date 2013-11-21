From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] glossary-content.txt: fix documentation of "**" patterns
Date: Thu, 21 Nov 2013 13:44:20 +0700
Message-ID: <1385016260-9718-2-git-send-email-pclouds@gmail.com>
References: <1384910801-11125-1-git-send-email-pclouds@gmail.com>
 <1385016260-9718-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 07:44:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjO0G-00037q-Mu
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 07:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090Ab3KUGog convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Nov 2013 01:44:36 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:46502 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab3KUGof (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 01:44:35 -0500
Received: by mail-pd0-f179.google.com with SMTP id r10so7715645pdi.24
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 22:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gItnYXLnD9a9amUZOhBCnFT3bjMVowunxOqlBFaWTKM=;
        b=j/0x7DpU80p2BBh7wx30lVwaaBIrsQ9oHjQYAmzc0lITEyGhgtDhtZECUfaMvdzopH
         7cObPPI4Hop6VmXIQhDoy9v1o5dFAuu0eQSJB7Sbya/KQYxyFrPwx6KPiUdbYC9Xzf76
         VQW3xn2DDv89PxKQkM3oqCX/J3M5qqEJTYDVoePANxzmIzmwTGfl/M20025sMAGdKnTN
         sM4zMtSA9HEuw40W/evvm9VAPe7p/cR5CQPkapZXb0prdogrHcTWcWPXXqPjZMLnE30O
         porcwd8qxrqeWXAi4Q3ll+5z8jDtRuJZm0T+xT00RX+ucIaH/If5E1+78Patf7QtAqYQ
         51cg==
X-Received: by 10.68.229.10 with SMTP id sm10mr4724718pbc.154.1385016275310;
        Wed, 20 Nov 2013 22:44:35 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id pl1sm43099727pbb.20.2013.11.20.22.44.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 Nov 2013 22:44:34 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 21 Nov 2013 13:44:29 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1385016260-9718-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238111>

"**" means bold in ASCIIDOC, so we need to escape it. This is similar
to 8447dc8 (gitignore.txt: fix documentation of "**" patterns -
2013-11-07)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 There is another instance of '**' in RelNotes/1.8.5.txt. Junio you
 may want to fix it too.

 Documentation/glossary-content.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index e22b524..1b56ba4 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -362,12 +362,12 @@ full pathname may have special meaning:
=20
  - A leading "`**`" followed by a slash means match in all
    directories. For example, "`**/foo`" matches file or directory
-   "`foo`" anywhere, the same as pattern "`foo`". "**/foo/bar"
+   "`foo`" anywhere, the same as pattern "`foo`". "`**/foo/bar`"
    matches file or directory "`bar`" anywhere that is directly
    under directory "`foo`".
=20
- - A trailing "/**" matches everything inside. For example,
-   "abc/**" matches all files inside directory "abc", relative
+ - A trailing "`/**`" matches everything inside. For example,
+   "`abc/**`" matches all files inside directory "abc", relative
    to the location of the `.gitignore` file, with infinite depth.
=20
  - A slash followed by two consecutive asterisks then a slash
--=20
1.8.2.82.gc24b958
