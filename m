From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] Documentation: correct typo in example
Date: Thu, 12 May 2016 14:30:01 -0700
Message-ID: <20160512213001.30822-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 12 23:30:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0yBe-0001EP-Ks
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 23:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbcELVaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 17:30:23 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34728 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbcELVaW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 17:30:22 -0400
Received: by mail-pa0-f54.google.com with SMTP id r5so34291697pag.1
        for <git@vger.kernel.org>; Thu, 12 May 2016 14:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dSTqDVuAEJ0dSbczE52jkSDEDk2USfu9b/kzTr22j4E=;
        b=KLr+8BEdjZM0bjY6d95KQ5XzoTqfh41kuqIuXPceOkp22FQrsp9MeI4uib66LVngQr
         WaWPwPeQEBvdMRa+QpIiNc69wAO6LsLAMkkyWGKgtFH+lssElHSv9oBSKm6eE3AWF+Fn
         SIS6qMJK5LdoARVLcy8rKv5veeie2Ajp35VhLSCn9bBLCrzSgpVEGoaMVPaiTDZRUx/t
         kSo2OHO5VuCWrEdV1FbkqzJ/UtkLdVZwbmvtMf5SlE+p0JZYbr5lfl0S5/HKX0qqh6wB
         7Tfhm0QvMN+H/svycyIOCXMpmLXRABg1u2IFoy4+N81Sh6FYtDor+KwZpXm1HTBzkPCu
         VzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dSTqDVuAEJ0dSbczE52jkSDEDk2USfu9b/kzTr22j4E=;
        b=fT8d7eHxw2Gr6LltVwy79lFFi4wE62MEU7f630CPYd79vhGY4GGol/X0nq4ivDEpoG
         ACPk5S8leiiKHpbZIL2hWOoN3q3wcXMNzy8oSIY2md+xU0QdghaTpr66T7Sei/0GHqix
         CmGkhd7pDbSwdY8MocYgifmnbrHyhCaT7cJd9EOFspctGIO1UVe2TLVGEFgdx98KqBQL
         zNuDayQOAl/vaBl6+401gHRrY13p0fnMQrA41a1Ld4sPa4Quc9TGA3FsVDlE0zWHVXhi
         VCYcFENjth8CEVDW8mAuoU5LsIjSk6Sjk5Idat7PYkX+JIobr11jqai3siDx60jQP0NX
         rOPg==
X-Gm-Message-State: AOPr4FXpVyonO6VSgMLMct4I3Vb/RhysOX2EOdKoO3+Sw+Eu8JMEGM2Z9NDpZr07FpB6Th2Y
X-Received: by 10.66.82.166 with SMTP id j6mr17026262pay.140.1463088621269;
        Thu, 12 May 2016 14:30:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c9fc:8b37:8cb7:4400])
        by smtp.gmail.com with ESMTPSA id 28sm22085749pfs.1.2016.05.12.14.30.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 May 2016 14:30:20 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.397.g23dc3dd.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294482>

The example want's to explain how 'To see how attributes "crlf" and
"indent" are set for different paths.'

Spell the selected attribute correctly.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index 2602668..0d7e98c 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -74,7 +74,7 @@ static void setup_check(void)
 	if (check[0].attr)
 		return; /* already done */
 	check[0].attr = git_attr("crlf");
-	check[1].attr = git_attr("ident");
+	check[1].attr = git_attr("indent");
 }
 ------------
 
-- 
2.8.2.397.g23dc3dd.dirty
