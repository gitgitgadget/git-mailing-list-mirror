From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 01/16] t3020 (ls-files-error-unmatch): remove stray '1' from end of file
Date: Sat, 25 Sep 2010 13:06:52 -0600
Message-ID: <1285441627-28233-2-git-send-email-newren@gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 21:05:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oza3z-00051f-Ls
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab0IYTF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 15:05:29 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54740 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab0IYTF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 15:05:28 -0400
Received: by pzk34 with SMTP id 34so891416pzk.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DbUxzhLkBgd6n+WOCk/tz3UC8svpi0WVELhgG01rO9g=;
        b=nlrebBwWyQQoqRL0MR8lPFRbYeZGUrk7+vRRAsl+kQlwWHNTHT2jl9mIE/Wr5Mn446
         1YIz57TUCRm+sLMpeXv52DBJEoBEZjwSasXhA02+6NZ5f/M/9ryf7GjnAy6OV79ysDb6
         TCyBtMZe0IukDK8KGG+NmUGwucgqxTuj0Ik50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rhCz2aFQV9IEQKghG/2imMHHfBRi79uI2w8Fr91r+sSzkcYUdsOAUuBUzKukc/n4L5
         wzLY2Rp9ECTZMeLJWnrIIRCbEN0dlVERaTOKuvyvZql+zXFDhaounYNXRrd+rlpTOFob
         bUG/PjSyeQKX3grNuIRSrOVhVZYusIRIY1t3o=
Received: by 10.114.79.10 with SMTP id c10mr5646111wab.220.1285441527842;
        Sat, 25 Sep 2010 12:05:27 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o17sm6338669wal.21.2010.09.25.12.05.25
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 12:05:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285441627-28233-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157176>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3020-ls-files-error-unmatch.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/t/t3020-ls-files-error-unmatch.sh b/t/t3020-ls-files-error-unmatch.sh
index a7d8187..ca01053 100755
--- a/t/t3020-ls-files-error-unmatch.sh
+++ b/t/t3020-ls-files-error-unmatch.sh
@@ -26,4 +26,3 @@ test_expect_success \
     'git ls-files --error-unmatch foo bar'
 
 test_done
-1
-- 
1.7.3.95.g14291
