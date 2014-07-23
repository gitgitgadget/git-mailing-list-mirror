From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] gitrepository-layout.txt: s/ignored/ignored if/
Date: Wed, 23 Jul 2014 18:43:11 +0700
Message-ID: <1406115795-24082-2-git-send-email-pclouds@gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 13:44:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9uxz-0002HL-Kd
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 13:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757444AbaGWLoJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2014 07:44:09 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:59866 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634AbaGWLoG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 07:44:06 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so1491857pdb.13
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 04:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Csi3XWEerZpCjsh7vXyF5Tt7KDmFJEdqxSXu9gi80i4=;
        b=iUixpFhbWMrO2/ls6fCzVlJsCxcaF8stP/RcYYDU58qwkJCZ+xBzRXDyk4xAIjMbf6
         4u4ggEn2f6bjgxvXqdi03uaPk05VOpK5tenDetnNwUynooeD4mZ+IZpabdummLKk/jd4
         d7jwpr1ov7522T0IYfh8YR+NcZuktNsmtHpuvXEDH2aWMhL4cbgMm/Y9UZ2w1olCpl7N
         nA+vIP9K6zQxFwhQZKutTctFvnydx/y2nZ8Cat37kNNIirpYKlC9EmFpWzUMuEjKYXWt
         8PqCmayw8FsOmBLx4uUJdB/4bziBbTvoFH43Xt19GaopEWieSRyBAU2MgOtovgpt0o4B
         gQ2A==
X-Received: by 10.68.244.40 with SMTP id xd8mr980130pbc.24.1406115846178;
        Wed, 23 Jul 2014 04:44:06 -0700 (PDT)
Received: from lanh ([115.73.248.125])
        by mx.google.com with ESMTPSA id yo9sm8012658pac.25.2014.07.23.04.44.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jul 2014 04:44:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 23 Jul 2014 18:43:59 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254064>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitrepository-layout.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index bed4f1a..6bd82af 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -139,7 +139,7 @@ is often called 'detached HEAD.'  See linkgit:git-c=
heckout[1]
 for details.
=20
 config::
-	Repository specific configuration file. This file is ignored
+	Repository specific configuration file. This file is ignored if
 	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/config" will be
 	used instead.
=20
@@ -220,7 +220,7 @@ remotes::
 logs::
 	Records of changes made to refs are stored in this
 	directory.  See linkgit:git-update-ref[1]
-	for more information. This directory is ignored
+	for more information. This directory is ignored if
 	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/logs" will be used
 	instead.
=20
@@ -252,7 +252,7 @@ modules::
 repos::
 	Contains worktree specific information of linked
 	checkouts. Each subdirectory contains the worktree-related
-	part of a linked checkout. This directory is ignored
+	part of a linked checkout. This directory is ignored if
 	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/repos" will be
 	used instead.
=20
--=20
1.9.1.346.ga2b5940
