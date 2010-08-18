From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] t7403: add missing &&'s
Date: Wed, 18 Aug 2010 23:20:33 +0200
Message-ID: <4C6C4EA1.3070702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 23:21:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olq4G-0000NA-Qu
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 23:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064Ab0HRVU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 17:20:56 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:58375 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903Ab0HRVUy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 17:20:54 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id 23A991665E0B8;
	Wed, 18 Aug 2010 23:20:39 +0200 (CEST)
Received: from [93.240.124.161] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Olq3r-00043D-00; Wed, 18 Aug 2010 23:20:39 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+JStU2MGP4lLG7WZrX0IW8Qpye+ggHBgIfsza/
	UE4vd2oTfmRtplFrYBnEVmAM8jw51d238kVUiAAITnE3gN070y
	ZmEy3JpFNZfR1ok5inPw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153886>

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/t7403-submodule-sync.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 7538756..bade217 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -14,7 +14,7 @@ test_expect_success setup '
 	echo file > file &&
 	git add file &&
 	test_tick &&
-	git commit -m upstream
+	git commit -m upstream &&
 	git clone . super &&
 	git clone super submodule &&
 	(cd super &&
@@ -42,7 +42,7 @@ test_expect_success 'change submodule url' '
 	) &&
 	mv submodule moved-submodule &&
 	(cd super &&
-	 git config -f .gitmodules submodule.submodule.url ../moved-submodule
+	 git config -f .gitmodules submodule.submodule.url ../moved-submodule &&
 	 test_tick &&
 	 git commit -a -m moved-submodule
 	)
-- 
1.7.2.1.224.g2f41ea.dirty
