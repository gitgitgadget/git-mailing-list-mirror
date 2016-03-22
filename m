From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 4/4] mingw: skip some tests in t9115 due to file name
 issues
Date: Tue, 22 Mar 2016 18:43:00 +0100 (CET)
Message-ID: <7b4eca83305ec05af6434ff80269ba563f2d581d.1458668543.git.johannes.schindelin@gmx.de>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:43:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiQKq-0003KE-Vj
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 18:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756479AbcCVRnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:43:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:59653 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756401AbcCVRnK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:43:10 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MfjJY-1aNbhB0Uaa-00NAi6; Tue, 22 Mar 2016 18:43:01
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1458668543.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:LelPSPMzWJxKq/47rqAa4I9ZpWUZz0hMwi4W22SNggboIWI+YN9
 BnE5LIx8N9MnHiHftbVid7j3VkLx+pjhPmJwl3lQS816NKsieLt/q0dn7X5cx/hSDZr24Dz
 /1EUzdU6yxj9xoCMiR1mJU//BrC2dksVfxqNShubrQYTKmLc/UnZG6cg/LNJqVOrhG0EXCD
 o2R9sMv+TK6U75wFGACEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gNAD3MG6Ui4=:Uo3ohj69ejw/biW7YKHHoE
 C2XN9WZMG3t56xXmX531uML+3sWLurPhfwpNIlB+U++E3oUAvgLgnYHGqmZkpjFq8lesVM+1H
 cEHqA0+CugTwX/XAalv8IJs93iPLOL3wJv3YLHWvSyKxFB01+0I5mrJqqDWZZWw9VHa+e8N52
 /Cds5MOHl8ZWPPVuLdHgQT86F+XL57CB0cFRNF9VRb9nEtNfPHLkKcSRVDpVHNuSpe+9mytjP
 /oG9jA8cyY/BfVJS4G5FRqGvRRqBBzREckI2U+867fL9kwAG37eW4slB4f6NywEGvrds7Gi08
 /DzD1KQMuAZxo796VGjDATVeUrmTwaA0IhJh2G1SDKv/cijB2IsIb0s+s8Q8Es7SlcjIA7bb8
 tfP/vzC+dzJvNdl1iM1s3g3kg4Tja1HNRJfhP2z30+jDyWz3shdwJl7Z944z9b/eFZTa5Atr5
 nQjUwJRjJdGBaCsCXJKRnfxGxxeCdMSYTDiqU5lHQFHEYLSXo7EF3Qz9ZdsTlr5E3Jal/Reeg
 Wx2JvcW0idpb01zbwMkJlISt9dM6bt5yKKvufqrOrzHWACvuQ4bgM0wNHZvDOmImbcSVbag4a
 n3f2xzO6F5PmmLWWy5vaR93sWy08vJX/eKzXzZwPrT6cObdGT2/4oqZcwXnEjH+b1i5X6cqLh
 RIr5m8Wz8+95GZJ+WAsNOC1ANOQkIFTG3BTKZaysxqk7wED9+YAieeQ7aZEczTXeKjBB/PpxL
 Ve/gOObChTQ9LoFMnhCPpoL8asNaSY7DTmYCnc8mpJ3QjQ4J00UKNfSq/UR9KMVtdGYGX9ln 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289525>

These two tests wanted to write file names which are incompatible with
Windows' file naming rules.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9115-git-svn-dcommit-funky-renames.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 0990f8d..864395e 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -93,7 +93,7 @@ test_expect_success 'git svn rebase works inside a fresh-cloned repository' '
 # > to special UNICODE characters in the range 0xf000 to 0xf0ff (the
 # > "Private use area") when creating or accessing files.
 prepare_a_utf8_locale
-test_expect_success UTF8 'svn.pathnameencoding=cp932 new file on dcommit' '
+test_expect_success UTF8,!MINGW 'svn.pathnameencoding=cp932 new file on dcommit' '
 	LC_ALL=$a_utf8_locale &&
 	export LC_ALL &&
 	neq=$(printf "\201\202") &&
@@ -105,7 +105,7 @@ test_expect_success UTF8 'svn.pathnameencoding=cp932 new file on dcommit' '
 '
 
 # See the comment on the above test for setting of LC_ALL.
-test_expect_success 'svn.pathnameencoding=cp932 rename on dcommit' '
+test_expect_success !MINGW 'svn.pathnameencoding=cp932 rename on dcommit' '
 	LC_ALL=$a_utf8_locale &&
 	export LC_ALL &&
 	inf=$(printf "\201\207") &&
-- 
2.7.4.windows.1
