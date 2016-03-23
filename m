From: larsxschneider@gmail.com
Subject: [PATCH v3 1/2] Documentation: fix git-p4 AsciiDoc formatting
Date: Wed, 23 Mar 2016 11:59:01 +0100
Message-ID: <1458730742-88607-2-git-send-email-larsxschneider@gmail.com>
References: <1458730742-88607-1-git-send-email-larsxschneider@gmail.com>
Cc: gitster@pobox.com, luke@diamand.org,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 11:59:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aigVT-0000Qg-Fx
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbcCWK7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:59:11 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37793 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbcCWK7I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 06:59:08 -0400
Received: by mail-wm0-f53.google.com with SMTP id p65so18558355wmp.0
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 03:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/CwBLEX/vnhPwIxme71GgKBS4xp1pVRFyLRDNkyGwsE=;
        b=sqEJOsm+2MW0/+4kCq4J1ek9RKhDYr+Yw1oz7P0rg6QUZpl8O/LDhXdevuBVWcQeh3
         rcoU/uYgxgem4pjf7vI8v3jASL9kZFeqdKKxFQd45NNaS9UEAnY0LvkahCgsPUv5oPmS
         WJJzj946A00o2nYvG39RKh+OLQ/T9wVn/1E9eikkI+OA6+w9de+8d08ZN081kJ3UxoRx
         Nx6IKTCYxV6+TL8Lx6gUACkRKiNjMNwp//EaUZffbJkqwNWFZRnf5ktMzo7RhM4Y0ZRR
         wA87H+tUeFIzB892YPXY+05ms7qJL48HzAy3Dpt1Y4UisRGGYi5ZtDALVsfHo3zU6WX3
         E1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/CwBLEX/vnhPwIxme71GgKBS4xp1pVRFyLRDNkyGwsE=;
        b=Ra35fWEgMrVNJ46ZRLndcH5TkvqNgoI7zK4++e6AGWhnhXoIndpFDRc9zgqyf8qYKo
         E4118jweF+ALNPWC0Li/52qO2yEySzV5h3HV0unEzTORfEuNn3uEDBtlq1lvWlql45Da
         PBOluirJTMaumoABMOgTilJiTIzofWxAuIwx/an4+GBtk4Hn0Scm4yOr+nKqgNT9UG0+
         0L7Q5SIk2cBSCYvCYYC9fSKa7smltC6E/FR9VLjGeTygOA+HqAtA04aSvbPlNoNRMicj
         VJDPiXQw5Zu7bOZYaalE8jJipNSyjEfMT0ca2FzX40syg+htzhQS7a4smjICdfPiAwTq
         WtzQ==
X-Gm-Message-State: AD7BkJIYpO9LbJWet1IGr2O0L+gbw5I/jD0X0hFH8qvuV3ZO4+jUk/w0yKpYKVB/NQQc+Q==
X-Received: by 10.28.140.11 with SMTP id o11mr24628352wmd.81.1458730746808;
        Wed, 23 Mar 2016 03:59:06 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BA3D3.dip0.t-ipconnect.de. [80.139.163.211])
        by smtp.gmail.com with ESMTPSA id j18sm21764781wmd.2.2016.03.23.03.59.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 23 Mar 2016 03:59:06 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1458730742-88607-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289646>

From: Lars Schneider <larsxschneider@gmail.com>

Noticed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 738cfde..6efe830 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -520,15 +520,13 @@ git-p4.pathEncoding::
 git-p4.largeFileSystem::
 	Specify the system that is used for large (binary) files. Please note
 	that large file systems do not support the 'git p4 submit' command.
-	Only Git LFS [1] is implemented right now. Download
-	and install the Git LFS command line extension to use this option
-	and configure it like this:
+	Only Git LFS is implemented right now (see https://git-lfs.github.com/
+	for more information). Download and install the Git LFS command line
+	extension to use this option and configure it like this:
 +
 -------------
 git config       git-p4.largeFileSystem GitLFS
 -------------
-+
-	[1] https://git-lfs.github.com/
 
 git-p4.largeFileExtensions::
 	All files matching a file extension in the list will be processed
-- 
2.5.1
