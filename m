From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/24] git-status.txt: advertisement for untracked cache
Date: Sun,  8 Mar 2015 17:12:47 +0700
Message-ID: <1425809567-25518-25-git-send-email-pclouds@gmail.com>
References: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 11:15:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYFB-0004lQ-IH
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbbCHKP3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 06:15:29 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:41809 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbbCHKPY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:15:24 -0400
Received: by pablj1 with SMTP id lj1so58496989pab.8
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AntNTRnzvzOT5yL6NMi6yq4gCVjGNfqmwjhBF0aPdNw=;
        b=HQtDEnF7Xv9hASCk4FhDqe/kQrKS4dTtq4Z3YUlPqxrjsi+SQ/X5faapMggbTJSZlS
         53EwMLLdAjJ2yEatdQX1oy4qNAKqGg8ABkoXEAz4dn4iRzVOW15uFVipIUBY0Azkr7mU
         Ov0kIcy8rejI9/PsEhfuKRgb7INHnNwfO8xCQHbjbrF0ZP9QQEsZplnJu0WoSdWC4SuF
         F9RqTszc1uRgU9mbP5SPaUVN2/M95DAOshpsklz8D3RagN/quOZ3mYpHFSi0vC+2MaQ4
         3Sh7D2OFu9Qmm1Dno7QshAxtabmJg4mTY8kAMzRy8ffR/rSf7o8aThDD71sZhdupc7xy
         4ggw==
X-Received: by 10.70.47.193 with SMTP id f1mr22951785pdn.158.1425809724546;
        Sun, 08 Mar 2015 03:15:24 -0700 (PDT)
Received: from lanh ([115.73.247.162])
        by mx.google.com with ESMTPSA id k14sm14361120pbq.53.2015.03.08.03.15.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 03:15:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Mar 2015 17:15:20 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265080>

When a good user sees the "too long, consider -uno" advice when
running `git status`, they should check out the man page to find out
more. This change suggests they try untracked cache before -uno.

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-status.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.tx=
t
index def635f..4dcad4e 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -58,7 +58,10 @@ When `-u` option is not used, untracked files and di=
rectories are
 shown (i.e. the same as specifying `normal`), to help you avoid
 forgetting to add newly created files.  Because it takes extra work
 to find untracked files in the filesystem, this mode may take some
-time in a large working tree.  You can use `no` to have `git status`
+time in a large working tree.
+Consider enabling untracked cache and split index if supported (see
+`git update-index --untracked-cache` and `git update-index
+--split-index`), Otherwise you can use `no` to have `git status`
 return more quickly without showing untracked files.
 +
 The default can be changed using the status.showUntrackedFiles
--=20
2.3.0.rc1.137.g477eb31
