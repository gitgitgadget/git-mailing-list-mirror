From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 06/10] Documentation/tag: remove double occurance of "<pattern>"
Date: Thu,  9 Jul 2015 15:57:47 +0530
Message-ID: <1436437671-25600-6-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 12:28:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD94F-0003fD-LC
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 12:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbbGIK22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 06:28:28 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36769 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbbGIK2P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 06:28:15 -0400
Received: by pdjr16 with SMTP id r16so1971473pdj.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 03:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r1YhcPC4VydT19RbLptdhv+FsABqULaZMPfDBQYLwlg=;
        b=o9AJJlfRM6JDoYlcUCrgcSuSGgyi3DYLNW4zzltoC1XOtlrFROrtGOo1tkKKs9J5fI
         qTpVrP/PimMLz5iluPA7tvxnIcBc7DKu/Q3Z7Vrj2NFkUz9a0G0JzjJVmO884s2oFv92
         7kk4t3Kzs6xBtMmmTiY4GA3rLaJvTUZ6FD+HncIgRotW9YsqriWHxo00N2gf4A53/l3s
         +ym5EzDq+LGZTo8LIDrldREOSW0yrAI7PnLGQYdK/SOjXD67P1RMiLVmRnatHX5w9bCd
         D9/+Tpt5CNI8WioFvkJiHP8Uqjsjb3BkkvqOj+PFceXvH4N1mBaTkyGQSzdRQ1XScGJv
         xm2A==
X-Received: by 10.70.126.33 with SMTP id mv1mr30127089pdb.64.1436437693928;
        Thu, 09 Jul 2015 03:28:13 -0700 (PDT)
Received: from ashley.localdomain ([49.201.133.206])
        by smtp.gmail.com with ESMTPSA id b10sm5449836pdo.84.2015.07.09.03.28.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Jul 2015 03:28:13 -0700 (PDT)
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436437671-25600-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273734>

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-tag.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 034d10d..4b04c2b 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -14,7 +14,6 @@ SYNOPSIS
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
 	[--column[=<options>] | --no-column] [<pattern>...]
-	[<pattern>...]
 'git tag' -v <tagname>...
 
 DESCRIPTION
-- 
2.4.5
