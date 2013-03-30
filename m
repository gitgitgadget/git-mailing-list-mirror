From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 01/12] pretty-formats.txt: wrap long lines
Date: Sat, 30 Mar 2013 16:35:01 +0700
Message-ID: <1364636112-15065-2-git-send-email-pclouds@gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 30 10:35:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULsCQ-0002ER-Vb
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 10:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136Ab3C3JfQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Mar 2013 05:35:16 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55905 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030Ab3C3JfO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 05:35:14 -0400
Received: by mail-pa0-f46.google.com with SMTP id rl6so653659pac.33
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 02:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=NQqZZbZc6Xz2iLdiAQaSLwc/yO/UN8l8N4VFi7B2O0o=;
        b=n8w25fU0Tm3ubFHFQpXBC+CQAamkReyRSllZCMieuJmN4Amu8fe+UgAaaySwSt32zK
         Q3DA+K/8gmsVnkPSPDkyXZ49U08t66PStL0ARFMUaJ9kf0wsMTUfoBzvhLd+ZBHgPhXG
         0nByiOxaR15lk9yK/YwRfoAcmwSVt/9vv4rlSMH+iPxgTIKmuBTv9dafMR5X9sIxSmZc
         9ERcoO0LthgnH9hNtP52eoyQshuGDC28rk0BVZpHNrYyGHxG/UiHpv8IO56TQ4qJ6D2E
         0h70OM1lizBbiRozygTfKTfmIdkQwK6pO7WjTVm9osneJojuQIK0WVMHYOxjispSD8Ee
         JLZw==
X-Received: by 10.66.187.231 with SMTP id fv7mr8701334pac.46.1364636113843;
        Sat, 30 Mar 2013 02:35:13 -0700 (PDT)
Received: from lanh ([115.74.55.89])
        by mx.google.com with ESMTPS id oq3sm6813415pac.16.2013.03.30.02.35.10
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 30 Mar 2013 02:35:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Mar 2013 16:35:19 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219570>


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
