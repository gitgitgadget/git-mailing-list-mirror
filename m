From: Hiroyuki Sano <sh19910711@gmail.com>
Subject: [GSoC][PATCH 2/2] attrs: add "css" to the list of userdiff bulit-in patterns
Date: Sun,  8 Mar 2015 20:03:44 +0900
Message-ID: <1425812624-6671-2-git-send-email-sh19910711@gmail.com>
References: <1425812624-6671-1-git-send-email-sh19910711@gmail.com>
Cc: Hiroyuki Sano <sh19910711@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 12:04:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUZ0b-0007Xt-0k
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 12:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbbCHLE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 07:04:26 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35455 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbbCHLEY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 07:04:24 -0400
Received: by pabli10 with SMTP id li10so64996422pab.2
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 04:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7dFK38YTgX9fnk5oQNp/NhHmpUmp8AED/rA8Z3XeDD4=;
        b=gBYFLoUypVsdYb5szdNUe9xsFNdBBec/F1WY5LU/tsvPk0EcYiyjrCUjzo/umpg3V8
         IkxYYZIeaMcHNJQ0O33SyDjSLCBrroMoTb5aHc1MnWHXhxloYSXr4dcf8zAJO2nngA88
         cIp1++6TDYVY2N1tpV3ZCmSWvo9dnq8kAQg+G6Fx191Hv+K63aEPMa/416SA90bxWOyA
         I1789MHl475U3+fU2lsO93Okpa8p2bCg2qPHpKb2VIIq3mrSYHXVEhkbnMkIACtP1imL
         2XbfY6jjBUcLbFAjQ2mcqtV1qKe5/ia5velWMhxQPxzsOpNzABpVWMLRXUyTYa8PEiXL
         75Qw==
X-Received: by 10.66.100.202 with SMTP id fa10mr35174626pab.36.1425812664579;
        Sun, 08 Mar 2015 04:04:24 -0700 (PDT)
Received: from localhost (iris.u-aizu.ac.jp. [163.143.87.170])
        by mx.google.com with ESMTPSA id zs9sm14470570pbc.43.2015.03.08.04.04.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 04:04:23 -0700 (PDT)
X-Mailer: git-send-email 2.3.1
In-Reply-To: <1425812624-6671-1-git-send-email-sh19910711@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265084>

Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
---
 Documentation/gitattributes.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index c892ffa..8904a2a 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -525,6 +525,8 @@ patterns are available:
 
 - `csharp` suitable for source code in the C# language.
 
+- `css` suitable for source code in the CSS documents.
+
 - `fortran` suitable for source code in the Fortran language.
 
 - `html` suitable for HTML/XHTML documents.
-- 
2.3.1
