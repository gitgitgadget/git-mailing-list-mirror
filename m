From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] config.txt: update versioncmp.prereleaseSuffix
Date: Tue, 10 Mar 2015 17:16:35 +0700
Message-ID: <1425982595-32026-1-git-send-email-pclouds@gmail.com>
References: <xmqqmw3s5j1y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 11:16:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVHDY-00080j-Cd
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 11:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbbCJKQs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2015 06:16:48 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:32772 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbbCJKQr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 06:16:47 -0400
Received: by pdev10 with SMTP id v10so731414pde.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4vZM/2+r25gGD3xjmLOY7HpLqYpnVQ2lzHTW06jAlX0=;
        b=xE4VxPyLnYgBs007O7leVV+nzVCFgLddXOpbUQKchFRGHTj6Yovl+TEdIc8KaCEHMX
         e/DM2C1Ehj/Huzmpkk0LZJoa+vlrOCUw9Vg7aeXPbtejfQBOWIa0+FifsN28EQa/dkWv
         X2Pwpua7az7bTzgRppFKV4nvyFiCeaAMIAU+CxL3QQ8+CpSLUEjsckT8WtF7L0pTdfbE
         8ciTO4dvmqsrLRmyMydGzvGXLHoUEF4kIotoUpIUU+tyB21cg1DxPYcBe8efHYnMPHBa
         D0LYfgyM8KAs5Yewiw5Uwkidt6+lb0ypE9xZRwf66idcB3p7iAykakVEeKtnm3xlykoQ
         zaUQ==
X-Received: by 10.70.38.195 with SMTP id i3mr64266775pdk.76.1425982606488;
        Tue, 10 Mar 2015 03:16:46 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id dr5sm170313pdb.48.2015.03.10.03.16.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2015 03:16:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 Mar 2015 17:16:43 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <xmqqmw3s5j1y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265223>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 69a7345..fe8705d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2527,8 +2527,13 @@ versionsort.prereleaseSuffix::
 	When version sort is used in linkgit:git-tag[1], prerelease
 	tags (e.g. "1.0-rc1") may appear after the main release
 	"1.0". By specifying the suffix "-rc" in this variable,
-	"1.0-rc1" will appear before "1.0". One variable assignment
-	per suffix.
+	"1.0-rc1" will appear before "1.0".
++
+This variable can be specified multiple times, once per suffix. The
+order of suffixes in the config file determines the sorting order
+(e.g. if "-pre" appears before "-rc" in the config file then 1.0-preXX
+is sorted before 1.0-rcXX). The sorting order between different
+suffixes is undefined if they are in multiple config files.
=20
 web.browser::
 	Specify a web browser that may be used by some commands.
--=20
2.3.0.rc1.137.g477eb31
