From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Ignore generated test executable
Date: Sat, 6 Feb 2016 15:42:49 +0100 (CET)
Message-ID: <d6bde03c5989dc7a619251166134e64b97f2711c.1454768585.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 15:43:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aS44i-0003qt-7l
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 15:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbcBFOm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 09:42:56 -0500
Received: from mout.gmx.net ([212.227.17.21]:57997 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbcBFOmz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 09:42:55 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MC8iq-1aJId82e6S-008pgd; Sat, 06 Feb 2016 15:42:50
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:2GyB+ELTih075jr5+OtVM2923DJ5UmmIf7KMAFKI8lcpsJs5OYu
 KJWMGihEN0IPldAlbqCYCWuACUfeQ056WiC52jEW2k+7zy+lnT2YwLz3OyNC92yJkVWREZC
 NxkpPFCirwcdMBIC7zu0LFR3BClK5VKuvwuTgVFFrhknJa04htZDeGUdTj/Z0prou3ZiAaO
 70bKRHU47UlTeHagOlfdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OcbN/cdQPkE=:Ds70jVFZXWXDvufV5mYmAS
 FB/7I+EMJYSSYHheEu2YNmc9Y6FsZKZFKJXQPXzPx2jXa1wq3u/AMXn/D2z7PzlytHOUJe23r
 hjeD3hMDqr21edgYJv+giqFcXIXzpK/tE5GwRkgZAtqpGzlwuhxSTjH/8sqc+XVuEsp7XeQQG
 xjdRLfYT9H7im2wqdWty7/pTiE5qMtKtj78i5AFObSwFttoeiusyPD44MqyBAVORzZIiICMyO
 O9C9wYQuu0eSi61GbsLKAnR4dIQR+3JUAshF/9TbhupUVIYOI0sK2bJ9E04qhgFqo0QuF8TEn
 jkZF2IcD5o+ItWiIZB8V7v4WraUleWxqOVTxYUc0W9Y/dE32+neYsA2Y+1D+g7dfGjxgEgIvy
 YP8dB2y+QCLPZRrmU9uCJBI90lkPqtCozTUHZuda0IISUB41S0PIVQLr6vbGcWe7ZprNL6jW6
 WiR7Xmk09hnrnoT2ipOAq4+7/j37Goyx1aiIdZraotpqH82DAfSVVijSZE9eLN4N8k2iPUCmc
 7vcGoI9H+5RW/BxR8FvgYG1As+boyg72ToNuPvRmIAXHxysw78CzunU28pRT19D+eywqqzQiG
 CV7CvSyRmZkAOqJmPdhmtPdKhdwpaL9QtHyzurSmmGPS2nD+LZGfsvya87qk5csQwJxr4GSuQ
 Y8IPb7LeBQwkoGt/BF4Q+5OcJGzVJc/TZVe9FhkLl/G2ON/4kcTz0lUmq9zITZb+o2mTCY+GB
 /EoWjqz2koO5ldEq9M31BNRTcc0ZOHKJ3ibpAKdGIoWt5AqNck06PbYlZx0wyTO3giWMJUXR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285692>

In "mingw: fix t5601-clone.sh", this developer introduced a new test
executable, test-fake-ssh. Naturally, he forgot to update the .gitignore
file accordingly. This patch fixes that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This is on top of 'next', of course. My apologies that I did not
	catch this earlier.

 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 1c2f832..5087ce1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -187,6 +187,7 @@
 /test-dump-cache-tree
 /test-dump-split-index
 /test-dump-untracked-cache
+/test-fake-ssh
 /test-scrap-cache-tree
 /test-genrandom
 /test-hashmap
-- 
2.7.0.windows.1.7.g55a05c8
