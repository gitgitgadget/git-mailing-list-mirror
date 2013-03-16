From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/12] pretty-formats.txt: wrap long lines
Date: Sat, 16 Mar 2013 09:24:32 +0700
Message-ID: <1363400683-14813-2-git-send-email-pclouds@gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 03:25:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGgoH-00022S-T0
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 03:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184Ab3CPCY7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 22:24:59 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:64468 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125Ab3CPCY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 22:24:58 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp2so4525978pbb.6
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 19:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=NQqZZbZc6Xz2iLdiAQaSLwc/yO/UN8l8N4VFi7B2O0o=;
        b=QDOzDeGcR0DBcJljct9wuCeN3S0T/ItTOmTY/gadJJR7r1gOo1OiyJCsTXHj1j7Eon
         M3i1KvFG9Un14ReISm+LMb2tTCDEz1RMHEK5UoAdJ9iHyBqdiB+U9E231d9XpwVsf5Hu
         2WPQsxKsTjjU50YMGHYxQcAes+N25rJ1E/7y9pIME8c9oyVC/HKqsV+e/CK8OVccvBki
         VT6kh9NlXwcNLJ4JFNqa+y7432A02zRzTgY7hJFu95p5n6Md24JwbPwRR71nl7hnWTVY
         hF6rmZCvYS1Wrodg/0x73fwDr6XhiQrJ5qMtuQSzVCoB3i8VMFhP8KNHrwMxFuVNGxu3
         Knkg==
X-Received: by 10.68.218.166 with SMTP id ph6mr21992631pbc.33.1363400698182;
        Fri, 15 Mar 2013 19:24:58 -0700 (PDT)
Received: from lanh ([115.74.58.84])
        by mx.google.com with ESMTPS id kl4sm11497291pbc.31.2013.03.15.19.24.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Mar 2013 19:24:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Mar 2013 09:24:52 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218273>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/pretty-formats.txt | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index 105f18a..66345d1 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -106,18 +106,22 @@ The placeholders are:
 - '%P': parent hashes
 - '%p': abbreviated parent hashes
 - '%an': author name
-- '%aN': author name (respecting .mailmap, see linkgit:git-shortlog[1]=
 or linkgit:git-blame[1])
+- '%aN': author name (respecting .mailmap, see linkgit:git-shortlog[1]
+  or linkgit:git-blame[1])
 - '%ae': author email
-- '%aE': author email (respecting .mailmap, see linkgit:git-shortlog[1=
] or linkgit:git-blame[1])
+- '%aE': author email (respecting .mailmap, see
+  linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%ad': author date (format respects --date=3D option)
 - '%aD': author date, RFC2822 style
 - '%ar': author date, relative
 - '%at': author date, UNIX timestamp
 - '%ai': author date, ISO 8601 format
 - '%cn': committer name
-- '%cN': committer name (respecting .mailmap, see linkgit:git-shortlog=
[1] or linkgit:git-blame[1])
+- '%cN': committer name (respecting .mailmap, see
+  linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%ce': committer email
-- '%cE': committer email (respecting .mailmap, see linkgit:git-shortlo=
g[1] or linkgit:git-blame[1])
+- '%cE': committer email (respecting .mailmap, see
+  linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%cd': committer date
 - '%cD': committer date, RFC2822 style
 - '%cr': committer date, relative
@@ -136,9 +140,11 @@ The placeholders are:
 - '%gD': reflog selector, e.g., `refs/stash@{1}`
 - '%gd': shortened reflog selector, e.g., `stash@{1}`
 - '%gn': reflog identity name
-- '%gN': reflog identity name (respecting .mailmap, see linkgit:git-sh=
ortlog[1] or linkgit:git-blame[1])
+- '%gN': reflog identity name (respecting .mailmap, see
+  linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%ge': reflog identity email
-- '%gE': reflog identity email (respecting .mailmap, see linkgit:git-s=
hortlog[1] or linkgit:git-blame[1])
+- '%gE': reflog identity email (respecting .mailmap, see
+  linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%gs': reflog subject
 - '%Cred': switch color to red
 - '%Cgreen': switch color to green
--=20
1.8.2.83.gc99314b
