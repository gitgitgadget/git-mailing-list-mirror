From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/6] blame: remove obsolete comment
Date: Sun, 27 Dec 2015 08:51:27 +0700
Message-ID: <1451181092-26054-2-git-send-email-pclouds@gmail.com>
References: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 02:52:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aD0Vb-0006gr-3K
	for gcvg-git-2@plane.gmane.org; Sun, 27 Dec 2015 02:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336AbbL0BwH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2015 20:52:07 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33018 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbbL0Bve (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 20:51:34 -0500
Received: by mail-pf0-f173.google.com with SMTP id q63so59871320pfb.0
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 17:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cLHSTHgDK5VP7gsl6FN2o1gtadyLFho7m/xIwDzgMWk=;
        b=SG8UAZj0upCmFwpjzWDFY0URpsMpCZ14lYSFU5zpr/eTdHa9bwLeMxUGrnw+He9dva
         2eB/jZvsTeKWQeSh2jkophcKJc9tHfwK8GNw4cK4eIycaIUNpRlLHEoV5oqaU1eyWqOu
         NjoxwVc+nRGzcQIsqDcQj/WXtpgItXEwPm+ridZaVZRX0daQ956cSH+vI/f5pxeJLMsF
         6ZIpDQZKaYS7VBM2FRsNCqA6ti5ZidQeWIHwhQIpXJl+4qwZ3/ZmFJ0Qr56ON55oAnuQ
         D1rWu+n7XiAunx4gimrkoKMpQoRL26MJQpi8SzV6WMQ1Zj2xXF5Qoa3ZJCdSiV60uOQ+
         44YQ==
X-Received: by 10.98.19.82 with SMTP id b79mr27045868pfj.28.1451181094250;
        Sat, 26 Dec 2015 17:51:34 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id cn1sm67568876pad.11.2015.12.26.17.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Dec 2015 17:51:33 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 27 Dec 2015 08:51:40 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283005>

That "someday" in the comment happened two years later in
b65982b (Optimize "diff-index --cached" using cache-tree - 2009-05-20)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/blame.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 06484c2..9a0df92 100644
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
