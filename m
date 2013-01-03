From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/5] config.txt: a few lines about branch.<name>.description
Date: Thu,  3 Jan 2013 21:03:07 +0700
Message-ID: <1357221791-7496-2-git-send-email-pclouds@gmail.com>
References: <1357221791-7496-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 15:03:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqlOQ-0001Di-Ru
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 15:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412Ab3ACODP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2013 09:03:15 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:41164 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045Ab3ACODM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 09:03:12 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb11so8643455pad.24
        for <git@vger.kernel.org>; Thu, 03 Jan 2013 06:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=/X34pwKvUE7mnCWu986phXXDuk166xi6BRmvCqZv24U=;
        b=VpyxTEbfFt0FFhOT74RGZTAzk1eHSuuT4gjPzJsVGMTPfdJ7MhTcdO+H2NeNI/2EN4
         0Xrnt+QwFnYDrq+p3+CG9jsgrA5dtCuufcTSlbGxXmOed2EKYC+YfGyzynWTC+JFDP/5
         FL1TC/WzJVPdNPR/hcRlPzYcCiVbaSv6GTYdg24wVokOtR6kxA/NPvrS7Wjj29lSJsVr
         2LFQz6rY+rkBXmbSpGUwK6C6hF76TWcNN3if1il6E45N+HmFbe18Q8GYrDOH4BGBll2T
         ZM8SefUtAhrzmQeA5iG0GYulyUfaqERWIqEPcu+HJaxzZuWtaO4vgBDDcRsAAgVbwNp0
         o2mA==
X-Received: by 10.68.252.4 with SMTP id zo4mr155440873pbc.126.1357221792571;
        Thu, 03 Jan 2013 06:03:12 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id qn3sm28221978pbb.56.2013.01.03.06.03.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Jan 2013 06:03:11 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 03 Jan 2013 21:03:18 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357221791-7496-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212584>


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
