From: Linus Arver <linusarver@gmail.com>
Subject: [PATCH 6/7] Documentation: git-init: template directory: reword and cross-reference
Date: Sat,  2 Aug 2014 11:06:56 -0700
Message-ID: <1407002817-29221-7-git-send-email-linusarver@gmail.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
Cc: Steven Drake <sdrake@xnet.co.nz>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Linus Arver <linusarver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 20:08:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDdj5-00082o-16
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 20:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbaHBSIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 14:08:09 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:46422 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbaHBSIH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2014 14:08:07 -0400
Received: by mail-yk0-f175.google.com with SMTP id q200so3190381ykb.34
        for <git@vger.kernel.org>; Sat, 02 Aug 2014 11:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Odm0z4vYjBGqCsli41cN/dDeFzsd2Qt8bfxd5lg7i3E=;
        b=EyXdgst0eq8EJ/d3wZ+IiS52H90EZP3OqVn8OH0mMscNw2zRWrYy0h3/W10R8LhXpC
         W/LaR0KSmG2o602FjV6C3Sn4ZQ2DsXHRk20MCYHJatus4PnqcGdltM5z95Wz4/0KMoJV
         FWmJWpMApR7OgNHH4yrA0WQdAuaM00e+Uvw3n0BPqKD0FBGQGHuUZzPdHirHGc4XqjA6
         XnKK7jYP9VZWpCwfE08QBpN4EdXjEOQXwgTTOyLn1asiiTEsKaM7IapcqZ/CXOw0OPtc
         NEk06g7PFmYDW6+BEvLK8ObrbpmTMHO5ZaJe447xMQZ77HbGAfpW2wCV/HaI/k8NzaSi
         4x0A==
X-Received: by 10.236.91.74 with SMTP id g50mr20055125yhf.59.1407002886882;
        Sat, 02 Aug 2014 11:08:06 -0700 (PDT)
Received: from k0.localdomain (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id i24sm20618668yha.12.2014.08.02.11.08.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Aug 2014 11:08:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.3
In-Reply-To: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254711>

Signed-off-by: Linus Arver <linusarver@gmail.com>
---
 Documentation/git-init.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 96d6e67..b94d165 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -126,9 +126,8 @@ The template directory will be one of the following (in order):
 - the `init.templatedir` configuration variable; or
 - the default template directory: `/usr/share/git-core/templates`.
 
-The default template directory includes some directory structure, some
-suggested "exclude patterns", and copies of sample "hook" files.
-The suggested patterns and hook files are all modifiable and extensible.
+The default template directory includes some directory structure, suggested
+"exclude patterns" (see linkgit:gitignore[5]), and sample hook files (see linkgit:githooks[5]).
 
 EXAMPLES
 --------
-- 
2.0.3
