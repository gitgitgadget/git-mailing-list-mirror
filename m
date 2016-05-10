From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] t3404: fix typo
Date: Tue, 10 May 2016 16:05:58 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605101605480.4092@virtualbox>
References: <cover.1462888768.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 16:06:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b08Id-0005FG-C2
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 16:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbcEJOGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 10:06:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:52250 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbcEJOGF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 10:06:05 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MIuSH-1b23At1t4z-002VEd; Tue, 10 May 2016 16:05:58
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462888768.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:jHrvNYUoi+dVaY1CeulGrDN4jnP3qZKR3O8amngI36jWYQFI4LG
 0PmmfCGeonO9/21LkLRHICvUCyvk7OY8lcmUzjPJjeW5Dh+mBqXIStzNliGVVDm9MZn4RlX
 WC+pPSV/Kp42RjIDlCyyUWTA1mmmfyE2WlffAgFFOhtIlogBhS5hBMYZtN4rV340nTfWkx4
 yI4kjN9VGCMCdKHz0S+Iw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/PH4kAzM4nM=:eTgjvAOL3UX7IbCvb0voet
 oXrg6Tf/FyJby7PMz+molC20JPaRcCoxRpk5NjhhvvD/a3IlO9OyJ5q1ZUUqoRoWrmjw46608
 wDz2/Vth+ehabNpWDjqxDplAAHnkD5hu2CLltObrSG+/07mQlFOE6gZYqAVOekVUUHtUSZMj6
 tDL6rsIiv5MS72PzT0dMAoxPTIChjX8Y9yVa2nuxaGdJ75gCniB7uQ2SvRU7cloONIcMr3Nve
 N5Uoe7iSLnhwvKQcpVxyNctEh4GusJ362N9yNbOrJpQsP38yg3AGnmR3zRArYcMpGxTP865Yl
 319ypIVkV0kExTKQNvc3LWdjwvApSvQtcs2jAtMM9R9UZy9wGDMa6sChzaAhvgRpYNgb0MqQ2
 3/Kbv+qITyd/lP+8+/uL1nnOgJoC0uPqO6qttyXszMQ1vY1WVkMrCBE0Wx3u+KFxiNuVkefqo
 L8oRNPAJUgMmHrCvst4vH2lSxHvY3W5PdQqyW/ntsGqED97gfA0QcUPAk8au0DhzZPaNdPeTT
 z9lfqi1RK7jLR4y20GiBFUaIZze57tHXXJ2+7Ej8fumjIH17jHNzsDXfRlRlvicfqsE/tuAr4
 gN/se7tULAlb/6kOS86iHLWhHZjcJUUd8fUqUJA36jxLGUTwcFVRpPZs5GX+PjyLr0ZKDoqIW
 S2K1vMQZKckJj6aMw+MYAFU16bbJipbCYrLpAj7OHqG+thy2jjEA7K1Hd8ihytkpoMdyL+Fuw
 CF2v532ssh41bhTBc0RNmnyK39iBDsE8n+prdMqz5lIrNu3aYWs2Ii0TWCJ77kyjwfNRXLcq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294133>

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
2.8.2.463.g99156ee
