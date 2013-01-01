From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] config.txt: a few lines about branch.<name>.description
Date: Tue,  1 Jan 2013 16:30:53 +0700
Message-ID: <1357032655-21103-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 10:31:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpyBr-0001va-OA
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 10:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110Ab3AAJa5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2013 04:30:57 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:38408 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105Ab3AAJa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 04:30:56 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so6029272dak.20
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 01:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=/X34pwKvUE7mnCWu986phXXDuk166xi6BRmvCqZv24U=;
        b=dSnlxOgql8ApJ0AftlQ0RCWotBi6mTxqixJcRXdazOab1tfSW1IQECU/d4Xt7K3f4s
         zkq4aICWcVz9yqOAnBE+AsInTvDbRyFfKYQWeL3GUcwkDDL9YoNOtMmzNmbVjUa8KBS1
         OHzGXcQ4C6U4zrFrfkqkL0ijMQiDMgdZZqLmAieb9qDk1UkDVWrydLqej6MIfP/PMF/8
         STPUAsJND37HwvWeZuzZPZVg47OND8dZGJjwvO1r8peDxSshnx358eo9rEhcAlZL9ila
         bFZyOKm+OCuOVj9C/1xn4v3dVVFIfKKaVXNvl867BZSUe8sX9wKIPtcLE7kMbNunF01e
         58CQ==
X-Received: by 10.68.209.133 with SMTP id mm5mr135400025pbc.42.1357032655878;
        Tue, 01 Jan 2013 01:30:55 -0800 (PST)
Received: from lanh ([115.74.57.25])
        by mx.google.com with ESMTPS id jv1sm21103806pbc.36.2013.01.01.01.30.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Jan 2013 01:30:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 01 Jan 2013 16:31:01 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212417>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf8f911..ee64846 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -735,6 +735,12 @@ branch.<name>.rebase::
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
=20
+branch.<name>.description::
+	Branch description, can be edited with
+	`git branch --edit-description`. Branch description is
+	automatically added in the format-patch cover letter or
+	request-pull summary.
+
 browser.<tool>.cmd::
 	Specify the command to invoke the specified browser. The
 	specified command is evaluated in shell with the URLs passed
--=20
1.8.0.rc2.23.g1fb49df
