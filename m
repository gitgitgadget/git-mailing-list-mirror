From: Alangi Derick <alangiderick@gmail.com>
Subject: [PATCH] fixed translation errors in fetch-pack
Date: Mon, 4 May 2015 12:38:45 +0100
Message-ID: <554769fe.c864b40a.7420.ffff8c0c@mx.google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon May 04 14:52:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpFrC-0004n5-UF
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 14:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbbEDMrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 08:47:47 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33541 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454AbbEDMpw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 08:45:52 -0400
Received: by wief7 with SMTP id f7so76715123wie.0
        for <git@vger.kernel.org>; Mon, 04 May 2015 05:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:date:subject;
        bh=Y7dGvrHjzOiqtHqHnU4yMJkJjuHULN7O3hZW8v+Y5dg=;
        b=kbgFoJEXjju9+qBGLNfJkDJz9apE2N6mNxcWDkC115IzPr/Q3cBjh3+bvw+EBKMWqi
         Y6HFA67OyRqAM8Oc5010AYo5owOud1u3LC6/76Yf+F3niT5yGlLAUgMj32WfWJz4Oj/D
         NgKbyJaKwUnxNc31AwDKl8hZ2pkndrBV0lyIJtihsj9Zfev6xRzlpruX/KNOrLaY3d2V
         DZcc2POi9A7vB39do/uE/pR+BUr8g93nYdlfoSxahBrJza9MMxtkdEnPIK0uPFBNumUj
         EwPfYmvBy+gK7GTYghOjpLPtAeWC7Np2OZJbpyh1yqQLLyMBvmepsRENO4pMeAstvudd
         MIJg==
X-Received: by 10.194.171.36 with SMTP id ar4mr40558198wjc.7.1430743551465;
        Mon, 04 May 2015 05:45:51 -0700 (PDT)
Received: from localhost ([195.24.220.134])
        by mx.google.com with ESMTPSA id fa8sm11068715wib.14.2015.05.04.05.45.49
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2015 05:45:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268324>

Signed-off-by: Alangi Derick <alangiderick@gmail.com>
---
 builtin/fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 4a6b340..326cb77 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -204,7 +204,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < nr_sought; i++) {
 		if (!sought[i] || sought[i]->matched)
 			continue;
-		error("no such remote ref %s", sought[i]->name);
+		error(_("no such remote ref %s"), sought[i]->name);
 		ret = 1;
 	}
 
-- 
2.4.0.8.geba5036.dirty
