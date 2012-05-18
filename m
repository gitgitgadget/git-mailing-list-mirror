From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20remote=3A=20fix=20typo?=
Date: Fri, 18 May 2012 18:46:01 +0200
Message-ID: <1337359561-17337-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 18 18:46:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVQK0-0005mg-FG
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 18:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170Ab2ERQqN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 12:46:13 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53466 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932817Ab2ERQqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 12:46:09 -0400
Received: by wgbdr13 with SMTP id dr13so2957072wgb.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=HpwVyG9nMQlTxTYYvxOXadxv1qEZr6qGi+lPN5wSR/M=;
        b=zWgOW2sJucNIWPZE/DZtIT/boqWGBJYasEhOZZ0OAbQtiTWPQSSJTyw+H/wEM8+MxX
         2xdt+U2hJfdfY7uoObw0uu9TDq4l9UGHvzrNV01i009u4nevSLr+PnSRoQH9C3OxRvMg
         JbXXZuDujtLNl18qMMo+kN66TARUdGRyOp4DWinaii4XuWXUuFN+sngL+tSCwFfZmWfr
         tMu0QBONRFz1U7YlxL0tbJNMfF17FGvLlNLzG1ENmvMadk2qL6XeK5drxe4Hygx5qpCI
         LjaO+SgJ1zYhti17lTzvoqafd0TRhLBeYroofXgGwqmc2uG070JHLNS4e8yO0DsK20uE
         gnSw==
Received: by 10.180.78.105 with SMTP id a9mr3126317wix.20.1337359568361;
        Fri, 18 May 2012 09:46:08 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id eb8sm2067351wib.11.2012.05.18.09.46.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 May 2012 09:46:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197962>

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 builtin/remote.c |    2 +-
 1 Datei ge=C3=A4ndert, 1 Zeile hinzugef=C3=BCgt(+), 1 Zeile entfernt(-=
)

diff --git a/builtin/remote.c b/builtin/remote.c
index 0f0c594..920262d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -674,7 +674,7 @@ static int mv(int argc, const char **argv)
 				      strlen(rename.old), rename.new,
 				      strlen(rename.new));
 		} else
-			warning(_("Not updating non-default fetch respec\n"
+			warning(_("Not updating non-default fetch refspec\n"
 				  "\t%s\n"
 				  "\tPlease update the configuration manually if necessary."),
 				buf2.buf);
--=20
1.7.10.2
