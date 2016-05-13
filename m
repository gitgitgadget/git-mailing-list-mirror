From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/5] Documentation: correct typo in example for querying attributes
Date: Fri, 13 May 2016 16:13:23 -0700
Message-ID: <20160513231326.8994-3-sbeller@google.com>
References: <20160513231326.8994-1-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, git@vger.kernel.org,
	Jens.Lehmann@web.de, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat May 14 01:13:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1MH5-00085Y-Qv
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 01:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbcEMXNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 19:13:38 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36489 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbcEMXNg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 19:13:36 -0400
Received: by mail-pa0-f41.google.com with SMTP id bt5so44634277pac.3
        for <git@vger.kernel.org>; Fri, 13 May 2016 16:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jvboVo6/hZCJzwNmJNEQ413fdrGr7npSTl+bSSvtZb4=;
        b=GZWqJQrNzcgMQb9+vIOwOeZLnmBxhGx4DM7t1OOn+y/3OUWR236fz7k2r6tw2BxZ0T
         Lkkuj57AlTl4zpgdXKdbR0xi++pFpcR7bc0trTzJe5FtefL70mMftTtieKl/f5M9EyOw
         gjh4p0Y5Nxsrc83EfqPDtnWjbT8RYfeyQoW0jDeTMevh5+VmK7P3az+8RP+u5Pn9awA9
         jAVq3vz3qatTDYJ0Qe3qPG2Qcso9ASy4GM5id3GU5lHmG1bDSjnXNrj8DS7g38iN+GLy
         QikMK26FmRi+qyHnnh4D2ArvCqf5r2GJ36PH2rTwArqBOFpQ5A1pDjtGQCKe0O/sTLIU
         B82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jvboVo6/hZCJzwNmJNEQ413fdrGr7npSTl+bSSvtZb4=;
        b=kgf5IM771u6JGpLKSrk5AYbPMNFxUT87p2QzfgkfSYlyeIA9fAz512xSgiQ0lZ4Usa
         GYmT1SX7NwFcnJKRzXGEahH3wKGrxzUiwv3TzgqGb3Tk3GDFFpxFKzi10FpoBwATSDeM
         /wyfuSillczVvgb1up0284lAlY4F5+pjWQanzTwe/XVp9q9CxbcCainR3shgPr551/T5
         t0bSU7U/K9ozGc3GFf/RoMCQkx5CpfZmoEXLnS9E1uk7z7A6JirF+uoTBfZxEGY2TPCI
         DKGrHOsm9aKOfUqHR5Ty/CLuQ9UVNKLOzoWAvswxmyc9C6Wu9SRixh8ZzlyisxXWm45o
         K7mg==
X-Gm-Message-State: AOPr4FUhqeRTPi5sDJYcWVAzAhEEkAR0MKWh9+Qz0ihrXtWykgW16f8PNPI7hOKAvxp6Alte
X-Received: by 10.67.30.68 with SMTP id kc4mr27015970pad.19.1463181215452;
        Fri, 13 May 2016 16:13:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e84e:cb12:277e:4f09])
        by smtp.gmail.com with ESMTPSA id eh9sm29840892pad.47.2016.05.13.16.13.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 May 2016 16:13:34 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.g6647087.dirty
In-Reply-To: <20160513231326.8994-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294592>

The introductory text of the example has a typo in the
specification which makes it harder to follow that example.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index 2602668..36fc9af 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -61,7 +61,7 @@ Querying Specific Attributes
 Example
 -------
 
-To see how attributes "crlf" and "indent" are set for different paths.
+To see how attributes "crlf" and "ident" are set for different paths.
 
 . Prepare an array of `struct git_attr_check` with two elements (because
   we are checking two attributes).  Initialize their `attr` member with
-- 
2.8.2.401.g6647087.dirty
