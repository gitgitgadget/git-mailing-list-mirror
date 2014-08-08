From: Linus Arver <linusarver@gmail.com>
Subject: [PATCH v2 5/7] Documentation: git-init: reword parenthetical statements
Date: Fri,  8 Aug 2014 10:29:18 -0700
Message-ID: <1407518960-6203-6-git-send-email-linusarver@gmail.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
 <1407518960-6203-1-git-send-email-linusarver@gmail.com>
Cc: Steven Drake <sdrake@xnet.co.nz>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johan Herland <johan@herland.net>,
	Linus Arver <linusarver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 19:30:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFo0E-00031k-CP
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 19:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbaHHRam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 13:30:42 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:34057 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaHHRah (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 13:30:37 -0400
Received: by mail-yh0-f44.google.com with SMTP id f73so4342588yha.3
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lJ/yDgOS4OqSbIwAJRW1hZ0t1S2Fvbk45TsYk7PYKKw=;
        b=woX3g9v4DSwtsiP+fNrg6eVP9w0JYZSdPMrGY+I6ymtSCMKNwUtPEYiRPnho3/uZ49
         FqN5lvmlgPKXp1LfT2cHBvGN05Hzv6yE4mtqzmSOt+jRr0fIVIGG8aDKQvLYweNqACfH
         WuWCo+9NLrCWOimI9xkMIkDu8AjEOyodVAgffxe2mz1s1vmev+5ZEOkqKujCAjhjm2/4
         koqmUt88EcniFeQu0EKxPEcijetYtC9c3i2cXfDE8/6mNvSKalnHpEhhHB1WwR78Wq2W
         wWJuUEwXkuAwQo9R/LMnnst0pnVjrnPrrizTdCiSoVaarz3OPY3S8POtnCvNqOl17dCj
         Y4bA==
X-Received: by 10.236.208.2 with SMTP id p2mr5214791yho.173.1407519036988;
        Fri, 08 Aug 2014 10:30:36 -0700 (PDT)
Received: from k0.localdomain (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id u47sm6776458yhm.35.2014.08.08.10.30.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 10:30:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1407518960-6203-1-git-send-email-linusarver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255056>

Signed-off-by: Linus Arver <linusarver@gmail.com>
---
 Documentation/git-init.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 3f4e46a..21e5ad9 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -108,8 +108,8 @@ By default, the configuration flag `receive.denyNonFastForwards` is enabled
 in shared repositories, so that you cannot force a non fast-forwarding push
 into it.
 
-If you name a (possibly non-existent) directory at the end of the command
-line, the command is run inside the directory (possibly after creating it).
+If you provide a 'directory', the command is run inside it. If this directory
+does not exist, it will be created.
 
 --
 
-- 
2.0.4
