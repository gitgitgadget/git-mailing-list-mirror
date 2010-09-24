From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCHv2 01/16] t3020 (ls-files-error-unmatch): remove stray '1' from end of file
Date: Fri, 24 Sep 2010 16:22:41 -0600
Message-ID: <1285366976-22216-2-git-send-email-newren@gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 00:21:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGdz-0000U4-J1
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758241Ab0IXWVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:21:18 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45492 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683Ab0IXWVS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:21:18 -0400
Received: by qyk33 with SMTP id 33so4608692qyk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DbUxzhLkBgd6n+WOCk/tz3UC8svpi0WVELhgG01rO9g=;
        b=T1XFro82RBjbNRJvuaSjYVke8JIoXcQ+03v+UfHKYjDt+kmMAos1qdUgHAoTmTt/Kg
         oEnSG7R6N5wM4/iiXHxoCBvonhBbZDS6N1y/esmaKeRAHvcB2fcsOj+syGCv/innU1os
         T7myvepivj9TBgnNCtcCQA+DWwFqCoTY1RuLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=utygEFnNcwI88AEzbsGlSY3PddvJjcmzSPtjJoK3hFI63+iq1PaZqXbxv+rAXlHDRs
         ab5XgmdBn1UwfPatbAgn1d0JI8lnTSlievR54xElLfvPRo5hu7Jtizz1DROx0a0scRBh
         e9ehisEHJYFL/jjNwwJ82cjiSmwxEr6MQaOjA=
Received: by 10.220.53.132 with SMTP id m4mr1366278vcg.232.1285366876748;
        Fri, 24 Sep 2010 15:21:16 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r35sm1865945vbw.17.2010.09.24.15.21.14
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 15:21:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285366976-22216-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157073>


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
