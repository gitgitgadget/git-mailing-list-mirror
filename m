From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] urls.txt: avoid auto converting to hyperlink
Date: Fri, 24 May 2013 22:44:03 +0700
Message-ID: <1369410243-27732-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 24 17:43:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufu9B-0000Rw-0m
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 17:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677Ab3EXPmv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 May 2013 11:42:51 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:60911 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756663Ab3EXPmu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 11:42:50 -0400
Received: by mail-pd0-f177.google.com with SMTP id u11so4241702pdi.22
        for <git@vger.kernel.org>; Fri, 24 May 2013 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=9laOV3Dse2oaTDJ3jZToowq3jsfdUXeUIkv5tUZGM4I=;
        b=uKWd5FaefKjluz1T0xkvyvN4QlFfgc/hBtk14cpaLK0gbziH49BnUEPvjvVTP+aT5D
         LDAdsYRRcojOMRZ/3qxFVzvw78GrCkTyIDAbhGfrEQEv7QqdDx5Xgk+UnhUP3keB+BbB
         p/PZeE980/LxU7ksN3QItxW8FXGov/RU5re7FQ6cOh69NrCxn/rZMnQkHlh4WLoYc1pD
         JPG8pCflgJK17S8eeyxdzkVKjoZGxTLk3M2aQo4DFu78d21vmCkONW33c3eUPoLxySVY
         sGoQhMdpKHf/9B99bykTLX2B1tQLdnRx2n7dFQ+7eFHWS7MXX1othumktTQOgBprpfGo
         49aw==
X-Received: by 10.68.105.164 with SMTP id gn4mr18381818pbb.42.1369410169880;
        Fri, 24 May 2013 08:42:49 -0700 (PDT)
Received: from lanh ([115.73.195.154])
        by mx.google.com with ESMTPSA id q18sm17943679pao.4.2013.05.24.08.42.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 May 2013 08:42:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 24 May 2013 22:44:04 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225366>

file:///path/to/repo.git/ is converted to a hyperlink while others are
not. Put a backslash to avoid the conversion. Tested with asciidoc
8.6.5.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/urls.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 3ca122f..60ba300 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -33,7 +33,7 @@ For local repositories, also supported by Git nativel=
y, the following
 syntaxes may be used:
=20
 - /path/to/repo.git/
-- file:///path/to/repo.git/
+- \file:///path/to/repo.git/
=20
 ifndef::git-clone[]
 These two syntaxes are mostly equivalent, except when cloning, when
--=20
1.8.2.83.gc99314b
