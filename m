From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] t7502-commit: fix spelling
Date: Mon, 24 May 2010 16:51:17 +0800
Message-ID: <1274691077-2928-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 24 10:51:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGTNw-0004Ri-UJ
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 10:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106Ab0EXIvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 04:51:40 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55838 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756074Ab0EXIvk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 04:51:40 -0400
Received: by pvg4 with SMTP id 4so698688pvg.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=3Xdbs7IjdRue5L+3faeeZlRtVpnHCDiOr+6+tipJ73A=;
        b=kb3u6wMe85SOVX0wIB+6lnHUXK7uUdlEbHFJVG4xkH7LRyMDwKI5IWXUnCgy5lzA7D
         8GeHiCMAbFMZA/wbZlxZ70z/V0tR4xnO3PKd0pho9fUiei/7rEv0+gR1Ukgi82OfVbxE
         CJkY3WvSJQvxzYfwx60oSA8EUV2v5tDAtGgNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=M0ZE/FlvCq7hJ6oOU2Oo84bvbAIj40+R+9JAOaFNYoxBgLXk3vrd4VFMrOkuHnozO8
         K+MBtdJahmIOeH/lfXVJPMqC60RIVkQ4pvnsp6F2HrEDiK+VtglgTt82KMyRpu0y5QAV
         /9g9JbAfRVn8fVRispI7FxaU5HC8sT6HRUcts=
Received: by 10.114.172.20 with SMTP id u20mr2159738wae.211.1274691099489;
        Mon, 24 May 2010 01:51:39 -0700 (PDT)
Received: from localhost.localdomain (cm218.zeta152.maxonline.com.sg [116.87.152.218])
        by mx.google.com with ESMTPS id c1sm36636862wam.19.2010.05.24.01.51.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 01:51:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.259.g405af
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147613>

s/subdirecotry/subdirectory/

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t7502-commit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 844fb43..9504466 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -35,7 +35,7 @@ test_expect_success 'partial' '

 '

-test_expect_success 'partial modification in a subdirecotry' '
+test_expect_success 'partial modification in a subdirectory' '

 	test_tick &&
 	git commit -m "partial commit to subdirectory" not &&
--
1.7.1.189.g07419
