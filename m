From: Francis Moreau <francis.moro@gmail.com>
Subject: Can't understand the behaviour of git-diff --submodule
Date: Fri, 26 Oct 2012 16:07:27 +0200
Message-ID: <CAC9WiBgzbsury2f9FyAu=Pgn31f2uCtq7AvsVWGWEwoV6KbyjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 16:07:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRkZY-0005Cm-By
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 16:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933097Ab2JZOH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 10:07:28 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:59664 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab2JZOH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 10:07:27 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2664003oag.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 07:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Cfsr6xRUYDWJ872ATX/jE3f7fg0X2vvxmlCBRFGF0zE=;
        b=ZHnb6JmNk9C0m/SdZYENpg2rQwxEAUMqvcj64xC7+tRH9oWHAB/RxPlyNRfxE+p0a0
         KFkyOBtykAimcm0d/WLGkS9dtnjIBihyZaeOD95WN/AXAaCcoAO8IXk5CQS1uuX1DFul
         3Rn4rkahYtf2RgOtEX7pD0rvUc5pEdeiS89ByqF2nbjziwjU751sCC9vlyVfuhrm1sOs
         nib2DodGbYzDfJ+DCgQat+oKARqxi0ardwK+qrSW/N/RhjjfVVOrVEsFV1F1PiRWZct9
         Zm9DFYth7yjAOTjk8q4igS2T2P5fHAZbf23dPdMU092ZQFOxCRb3o/T2fAQJakF1iwQe
         C9JA==
Received: by 10.182.64.101 with SMTP id n5mr18252959obs.11.1351260447390; Fri,
 26 Oct 2012 07:07:27 -0700 (PDT)
Received: by 10.60.93.163 with HTTP; Fri, 26 Oct 2012 07:07:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208450>

Hi,

I'm trying to use the --submodule switch with git-diff but doesnt
understand the following behaviour:

$ git diff 2c9a257718d1803de720f95766ff256d33accad5 HEAD
diff --git a/configs b/configs
index 16c6a89..ce12289 160000
--- a/configs
+++ b/configs
@@ -1 +1 @@
-Subproject commit 16c6a89f245f0eed7fb0bce8e027c59fcf1d543e
+Subproject commit ce12289c5bfca7b2c423d9f1871c13ad1ba1dc32

but adding the --submodule option gives:

$ git diff --submodule=log 2c9a257718d1803de720f95766ff256d33accad5 HEAD
Submodule configs 16c6a89...ce12289 (commits not present)

Could anybody enlight me ?
-- 
Francis
