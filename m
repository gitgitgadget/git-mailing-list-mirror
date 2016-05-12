From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 1/2] t3404: fix typo
Date: Thu, 12 May 2016 17:44:01 +0200 (CEST)
Message-ID: <79ea39ba9583465cdd6e908dcd7ef056591d941e.1463067811.git.johannes.schindelin@gmx.de>
References: <cover.1462888768.git.johannes.schindelin@gmx.de> <cover.1463067811.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 17:59:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0t1G-0005Gq-BP
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 17:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbcELP7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 11:59:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:55917 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751891AbcELP7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 11:59:17 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LxgHz-1bhPxn2xsB-017HZC; Thu, 12 May 2016 17:59:08
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1463067811.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:epIAP9UYiNJk9EAdDwXDZ8blUQbIpK1mlnsMsUtf5PWNTuLZTP8
 z+rSfR24VMBtZ80W9TOonOvx66YjU/76Lb/NzguJJ/zsmpyjRaCUO/7QuWgNRbao0bVrSX5
 mwSExClO0uOF9ZRlhS0vx2M+4yUAZ0KBsXUhzW9KGQL1b1IgbDRTnE0RbMjRw7zL9IyJpaX
 Sg1Vfuuq9DmzsuBHObLLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X+7kHkLED4M=:ykyX5FYn1KPWTr3BKjARts
 05alvLw5cq6qYIkerYKSNauc8Zn3ucxJ+3l/L+jjpQWsV0uUZyNGdWxzfGjMrfEhG4TITrxVN
 nQwVU4lcSEP4OmT5fK6XR+lvcTaWIbkDlYcTdOZ4it08K5D9NzWDjPNvvRO81jPStinZ58L6T
 BrZQBvWkYW66CotazDuK8uGk3ixXPJw9oxG7Vruv2lp/dpkiylEAHSJGLR0w2a+kEH+wVEEA/
 dP7pw2UvYzn2HXXb+um2GBfZTn9g2dSpTGyg2KjzDGZev2p1sZSC1Zmxx0EhQqQ53mADMyPN0
 QH9uH/Odluy7CmZn3jbAau4PAkE5igZ7k2k4qAljpaN3op6G8Og3vVzboZ/MPGvF49TvlxUni
 c7MPl/ivypoK/bSpM00zbB35jGq7MC7oSTAyVjQGsz6eH6ulOa2BcE7dc51Vklh9xEU07QeeJ
 W1wmg2ISV9HtWuB7Q8nNs690UPuM544ShVn3S9UDNmprTAO6ZjRtKuUGuCfmyc0roiydiwzA1
 lGStvno2ISH4rivJXAGmzgnyDvaSbL25jzpy9TICvwQVHbEisSRKUuJFaZdLj2ZLVnu0hxlgV
 ICU2qcNvjfess6FsacN9zxMYNWd72s4+lTuJwNavFv1n38DzvyBxUnAq/+WScLRS17UP9Ik9t
 tnylfU0v+TaICfXfZ0TX65irxq8TbCOK/w0PzBStkfj7xpelWw1ggWdzEdYI2E6oYFhLS2A5U
 I77k34T9/YL3wsojxaFh55nZIQz8WhdYNkY9CY3yClZrzj6FtcUyLH2Xlx4aR8eDIc/iivE8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294411>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3404-rebase-interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d96d0e4..66348f1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -62,7 +62,7 @@ test_expect_success 'setup' '
 
 # "exec" commands are ran with the user shell by default, but this may
 # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
-# to create a file. Unseting SHELL avoids such non-portable behavior
+# to create a file. Unsetting SHELL avoids such non-portable behavior
 # in tests. It must be exported for it to take effect where needed.
 SHELL=
 export SHELL
-- 
2.8.2.465.gb077790
