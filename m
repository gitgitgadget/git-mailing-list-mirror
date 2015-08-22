From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/8] blame: remove obsolete comment
Date: Sat, 22 Aug 2015 08:08:04 +0700
Message-ID: <1440205700-19749-2-git-send-email-pclouds@gmail.com>
References: <xmqqy4j80wdb.fsf@gitster.dls.corp.google.com>
 <1440205700-19749-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, phiggins@google.com,
	snoksrud@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 03:08:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSxIZ-0004l6-R7
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 03:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbbHVBIj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 21:08:39 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33573 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbbHVBIi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 21:08:38 -0400
Received: by pdrh1 with SMTP id h1so32475606pdr.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 18:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=b2fsWawppPQl1ffK60d7KFb4OLSZAkJRe4pByJnDDAY=;
        b=0foJbcWbob2YGVbKrAyAYZKGeraqKdvNp4xmNS1Q4hC2I+OMbKRegWEW4Rz5cV+6/C
         nYLjPG8UxbsHlz/9nrFjO3z9+nnZpXnasWz80Kx/Czfz5p5reBq8N53WwGX1ot3i7EKY
         9goP+ISHfuneYfFltROWywIg382uiKDe9UTpsXMq2nFNrDbVtWmac0rgT0sS8b8OiTjs
         lH5wn4mnbh3OBYrakzL904gNkAxi6BmBGrAyL8bDjizRLTXLbyh9zIPAvq7OJBJOCbfa
         y76EGWCMMOlINWPsApZXx4Y13JJYGf4+OtsRb2+L7SrkAWiZZzNNUS/KWQUnvK4MUk7G
         I+Uw==
X-Received: by 10.70.52.226 with SMTP id w2mr22515871pdo.88.1440205717721;
        Fri, 21 Aug 2015 18:08:37 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id fw15sm9161446pdb.26.2015.08.21.18.08.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 18:08:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Aug 2015 08:08:34 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440205700-19749-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276353>

That "someday" in the comment happened two years later in
b65982b (Optimize "diff-index --cached" using cache-tree - 2009-05-20)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/blame.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 4db01c1..942f302 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2379,11 +2379,6 @@ static struct commit *fake_working_tree_commit(s=
truct diff_options *opt,
 	ce->ce_mode =3D create_ce_mode(mode);
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
=20
-	/*
-	 * We are not going to write this out, so this does not matter
-	 * right now, but someday we might optimize diff-index --cached
-	 * with cache-tree information.
-	 */
 	cache_tree_invalidate_path(&the_index, path);
=20
 	return commit;
--=20
2.3.0.rc1.137.g477eb31
