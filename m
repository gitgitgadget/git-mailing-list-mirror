From: Ian Liu Rodrigues <ian.liu88@gmail.com>
Subject: [PATCH] Makefile: fix some typos in the preamble
Date: Sat, 13 Sep 2014 11:20:22 -0300
Message-ID: <CAD+ArX07pvmFKaCzy+dTcbga56U=fCgpPN-T3+QSudfFSVr=bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 13 16:21:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSoCJ-00018f-Bk
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 16:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbaIMOUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 10:20:55 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:44635 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbaIMOUy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 10:20:54 -0400
Received: by mail-la0-f48.google.com with SMTP id ty20so2527257lab.35
        for <git@vger.kernel.org>; Sat, 13 Sep 2014 07:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=APLDcBCjVu9CN/UfkfD+aXnWi6giol4WppObYIUlx3I=;
        b=eoPVSfYEi8YFq2NQoXYvF7zR+PIJGlm4cNUfpN5WXrt9yw810MB9bx7jmFRAG31UAe
         hEZNYVUSY87ELTFi2L50H6N8f8Z0WrC1xJSn/O7++i2w+INRdN7Xwgf7u/7JCVSe3j8j
         HP2qfzmaRp4n4ElyDcCeXiRFakcTZYexpQotakcqirSYw4Sz8OfO5Ai2OwM3t/qtJ7/H
         vaiheF/9gOiu7KMwyDpUEwQIsdWOZMNmzKeexiLlSFEtFjl4Rso5aR+RSxzesudzBCYk
         w1QGga2bG0DzmDjHSn/seOcyoR9kgqff130m7a9pFDFYaYV4m0uz7OmI9DwtSZfmT4Uq
         etqw==
X-Received: by 10.152.4.39 with SMTP id h7mr16471862lah.49.1410618052457; Sat,
 13 Sep 2014 07:20:52 -0700 (PDT)
Received: by 10.25.22.209 with HTTP; Sat, 13 Sep 2014 07:20:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256966>

Signed-off-by: Ian Liu Rodrigues <ian.liu88@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9f984a9..496af55 100644
--- a/Makefile
+++ b/Makefile
@@ -14,11 +14,11 @@ all::
 # Define INLINE to a suitable substitute (such as '__inline' or '') if git
 # fails to compile with errors about undefined inline functions or similar.
 #
-# Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf()
+# Define SNPRINTF_RETURNS_BOGUS if you are on a system which snprintf()
 # or vsnprintf() return -1 instead of number of characters which would
 # have been written to the final string if enough space had been available.
 #
-# Define FREAD_READS_DIRECTORIES if your are on a system which succeeds
+# Define FREAD_READS_DIRECTORIES if you are on a system which succeeds
 # when attempting to read from an fopen'ed directory.
 #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
-- 
2.1.0
