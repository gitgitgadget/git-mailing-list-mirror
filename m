From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] blame: remove obsolete comment
Date: Thu, 25 Jun 2015 18:08:14 +0700
Message-ID: <1435230494-7030-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 13:08:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z850l-0002rF-Lj
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 13:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbbFYLH5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2015 07:07:57 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34219 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbbFYLHp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 07:07:45 -0400
Received: by pabvl15 with SMTP id vl15so48160472pab.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 04:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=nL1fAX/5GQIPsQYylKxqZW3ZU4qX8ZpEueMyA9sVJUE=;
        b=WmMsK7r2nn1fsv2JEWu2AAbZzTmI8HAlIoCoa4m/lwziRAVEURUUDlXOpWRqMTO+5j
         WfIjh9Zwcs9NqJREywMNbmpyqpilyDii9fQYtKIv376WANNmRsS97iYc1ObmOA4aE40r
         A/5cF2WuvteupKhT3SZ/6UxhMMbyTePVGAvqYBYrVajfOYf0WcAAnX42gno4HibQG6cF
         KH9Im6y/QHg+47AcPdSa2IKd8ungVKb0lcaYyXAJy+rh4/lbA60IVObc5aI28zzHFgcE
         A9kCL/4DldZjVqucgod8C/UuKYTTlMV2TAi9uXrS3MmbTMrpguIf6L4azSVt/2vPb3cK
         5PHw==
X-Received: by 10.66.147.4 with SMTP id tg4mr91002462pab.69.1435230464733;
        Thu, 25 Jun 2015 04:07:44 -0700 (PDT)
Received: from lanh ([115.73.33.22])
        by mx.google.com with ESMTPSA id i10sm29746799pdr.78.2015.06.25.04.07.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 04:07:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 25 Jun 2015 18:08:16 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272657>

That "someday" in the comment happened two years later in
b65982b (Optimize "diff-index --cached" using cache-tree - 2009-05-20)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/blame.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index b3e948e..b077bb6 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2371,11 +2371,6 @@ static struct commit *fake_working_tree_commit(s=
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
