From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/3] completion: add missing branch.*.rebase values
Date: Tue, 12 Jan 2016 16:22:21 +0100 (CET)
Message-ID: <cf10b421435e456c0dce15e547bb748081919b08.1452612112.git.johannes.schindelin@gmx.de>
References: <cover.1452612112.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 16:22:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ0mZ-0000d0-Ty
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 16:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbcALPWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 10:22:43 -0500
Received: from mout.gmx.net ([212.227.17.20]:52174 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762707AbcALPWm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 10:22:42 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MPUFR-1aEJwt0XR3-004fwl; Tue, 12 Jan 2016 16:22:22
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452612112.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:9/Ty+fzUeZ3/HYp4UDyHp5LDjaNhCbGi78T1r4pVykYvnBZ0+zM
 ilZcxDvd6J7JAHNbFut1UcIGQFVkvjW18NApwS9PpaKkwaSmKPHOK/vKU1QB3I7Zw/3Wwdk
 0QBnUVuTT7CtaUHLSf41cAlVE4yMfFpSFiEGZQdkfRd2XaFYht+jv5yj7GPprkj50uQWjww
 eGNyrbYRJfz0Pmwo8+d8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:efmpQNMNPAA=:MCh3hzZa2TMpHmHYjn+5YS
 Lrmm6pGRYUhbSQhEPB/6Sx9q9JF+tuJhcoZZLuBZAKZeixCXMBl84TGyhP2SOzQ/02mntJM4K
 TF1iiy/ekRhu0ENT4NvSGIHB6HD6s3Akka+63yIQngJhV7rUhUVRS9cMW1XmGfheGEPHHPak8
 pr3/upHaKJ4BXOyAaKKX35ptzDF0fsm8WgydTXOK8/RG1QYqRxNnYEfuO+jgwjS1IHGDDcyi2
 QW5x5zCHJwjRqBw2hLeM+I+tn80KuCBrN22pYPtaB5GbnwU+cJ542mdfbzHigmfk9ymxUzAQo
 iuz2xhf0TA0W8zH8zxtvm/bFKZpVIlTS2guhV615HArO8w1tVasEScjN/iUDAobtdIxDnZwcb
 IB40zaVQjIHhyAuHGaX2j8kJYKNPL65kKGw19lt4tQ54GX6jrydLeyrYRdIwpHkQ9CqTO4fAx
 LPItmzWJwd/tYGcGc5zncpiVrXsuQRhUbbG52s6kp0zVLZllU5mvaL6phjtnioyFakGLj0DY8
 vU9aEuedS1ltF2bX3/QS8ANU9aZf6pDgaByCpCoHJo5ClSrmwITbsjQlnEIgAI/GEeDUpx4fb
 q4qkLRmBO0VCawdS2Ql55KBqMpBWk4Lrm2WVKaToJRjJ605++RHn+VpFWzPJZ9bLE1sa0TVCX
 ZEIDBRxWWYk2hr4A8cG/YMy94rMVcmIhGw1/xCLhcn/RyCez74UQ0pbEbb8YBBpENMe0ueyFK
 VW0tz5pgipYHae1w/rnx8s2tFwN/jFRAG6jnPhtchXMKdU7Lt5kGVP70xExHJ7GMznUKAA5y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283820>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ab4da7f..51f5223 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1809,7 +1809,7 @@ _git_config ()
 		return
 		;;
 	branch.*.rebase)
-		__gitcomp "false true"
+		__gitcomp "false true preserve interactive"
 		return
 		;;
 	remote.pushdefault)
-- 
2.6.3.windows.1.300.g1c25e49
