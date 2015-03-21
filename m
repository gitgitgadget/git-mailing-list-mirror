From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: [PATCH] t6039: fix broken && chain
Date: Sat, 21 Mar 2015 08:04:49 +0100
Message-ID: <550D1811.3040802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 08:05:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZDSv-0003ZI-1X
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 08:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbbCUHE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 03:04:56 -0400
Received: from mout.web.de ([212.227.17.12]:57259 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154AbbCUHEz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 03:04:55 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0LfRnJ-1ZJHnI37mL-00p1ba; Sat, 21 Mar 2015 08:04:53
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
X-Provags-ID: V03:K0:M/ozEoVJ+dOZchJW8KItdIMGjjk2rEG8Qd7XyepEnRHd16Vpf+M
 f5Sgo+hummgeD3czBaevK0y3W6YgD2PcdRGY4fzoqYYzRS8bJ9zpFILJd0Z6tgmP1NzitT1
 E5iLFnb5lXAe/ci3+MP1H8U6B58dtcbiqsRNs3vORX1SzynoRk56YcaJutXiJBw1VYqkZFA
 lMzdIAmjYOBqTt0OFBE3A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266012>

Add missing %%, detected by the --chain-lint option
---
 t/t6039-merge-ignorecase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6039-merge-ignorecase.sh b/t/t6039-merge-ignorecase.sh
index a977653..531850d 100755
--- a/t/t6039-merge-ignorecase.sh
+++ b/t/t6039-merge-ignorecase.sh
@@ -15,7 +15,7 @@ test_expect_success 'merge with case-changing rename' '
 	>TestCase &&
 	git add TestCase &&
 	git commit -m "add TestCase" &&
-	git tag baseline
+	git tag baseline &&
 	git checkout -b with-camel &&
 	>foo &&
 	git add foo &&
-- 
2.2.0.rc1.790.ge19fcd2
