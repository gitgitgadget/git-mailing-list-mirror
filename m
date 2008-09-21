From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] gitattributes documentation: link to gitignore for glob format
Date: Sun, 21 Sep 2008 19:43:51 +0700
Message-ID: <1222001031-11382-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 14:50:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhOO8-0001BI-Ij
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 14:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbYIUMoG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Sep 2008 08:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbYIUMoF
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 08:44:05 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:16023 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbYIUMoD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 08:44:03 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1154792rvb.1
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 05:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=7rnkElozIb88sZyaZ7VggmD+lycuXjC0UQ8iG74h/dM=;
        b=AtjBH7H67tqpwt11wQ24sIboTBqqvG7RDSQ08MylN9P5SGtdxs4CqHh0weE7vd5S1S
         FQpr7o+9MSaBaY5yFZWzc3I5nGdLK58sXNZ9kTdZVNQnlSzAi0XSmgntrOjPTVe5PpHN
         ncRfudz0XEvtF31BChvGP/nknf4zxwiY/+Emg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=DsppBGRSAg5xXWcHTO8ZsITzVOLwS/dI2oJrjgtWsAfpdLxRQAXOeQhm23rarewKhH
         ZgvlcZw1/r1OZ7Ho7Yc7Ct6IQnmHC7m3r5cj6QvleNauxkQ6yIkRQjwCMGqBrQEKKRik
         Xhqq2Q0z5a48ljpLBJ5GxhDSvRxefCT2wFxDo=
Received: by 10.140.135.19 with SMTP id i19mr1252726rvd.169.1222001042532;
        Sun, 21 Sep 2008 05:44:02 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.36.54])
        by mx.google.com with ESMTPS id k41sm4167102rvb.9.2008.09.21.05.43.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Sep 2008 05:44:01 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Sep 2008 19:43:51 +0700
X-Mailer: git-send-email 1.6.0.2.427.g8dbf1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96393>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitattributes.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 9a75257..45c11df 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -21,7 +21,9 @@ Each line in `gitattributes` file is of form:
 	glob	attr1 attr2 ...
=20
 That is, a glob pattern followed by an attributes list,
-separated by whitespaces.  When the glob pattern matches the
+separated by whitespaces. Glob pattern format is as same as
+one used by `gitignore` files. Please refer to linkgit:gitignore[5]
+for more information. When the glob pattern matches the
 path in question, the attributes listed on the line are given to
 the path.
=20
--=20
1.6.0.2.427.g8dbf1
