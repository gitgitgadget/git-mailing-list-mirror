From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 3/3] completion: add missing branch.*.rebase values
Date: Wed, 13 Jan 2016 13:17:22 +0100 (CET)
Message-ID: <409097954d16f7a3d8d16a985d6fac06eb050499.1452687410.git.johannes.schindelin@gmx.de>
References: <cover.1452668201.git.johannes.schindelin@gmx.de> <cover.1452687410.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 13:17:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJKMr-00021l-On
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 13:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbcAMMRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 07:17:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:56332 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754075AbcAMMRa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 07:17:30 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M2WgT-1a0yhS2nnp-00sOpq; Wed, 13 Jan 2016 13:17:23
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452687410.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:/QzsI9cP2h0qdPXlUVOY2ZWKbAQYYRrCwdqX71UcEDjUJ73PG04
 fS54cYx7IYc/AcXCVolwt2LrtkYar6DXba2seXLM6YnBTY1Cdp2cR5f+Te+IrXsxqouaTs9
 7ZYDOFr7pMvn1aYiAB2UseoeyBzS9Q+n85qEgJ28kJFdDcgtZjs5bhFmY7CI+8Nur9bxmLm
 BHtfqN+A/IJBReKh/Dtlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fFkp8Dh7/pE=:T+LwBmDix9qBri83PaBGOh
 SnWqVty92S2G48xO9KIi8pPfe2UZzFu0x/CPHjCDkObZN12bbZmOA8WFa90S+LNFP+ZOXS3LS
 G4KcV+9nS7bO567yBS4jhYsIICAYg35kh+6NCCE82vVAArBVBhxC2wsEFCCu5IhhB5DuwDD+e
 /hyOdYuifRp7SsCODX+CnEJ/qgN/9TVRoPSqjvcwgYnL0MzMXKsD7sw6bPZ4g/O6zzHPT4oVR
 X7CESENJh6edp9OT2JiNsdG4dGd7VdVN7tVGKNHbB0nMLR08iQVWaCBdT6Mn7j7G4h5XDxmY9
 yhzYT2Mv7yM3NAdfqAbPyPbMm7gQvriDVN+xh2uEamJ+EP7sdTlXHoTlKtY5vFd4qnVqw0ud0
 GIW7ZUK6lTN045DQkN19WH0svAFybxKe+K+L89hDiXYzVU+sqWwgNakb7UvuDTX6LrKY8HD4p
 6B8rC+oDt3iCbkj5zKwJYV7Le8bG/1+TaIljVImVjL5eOkCKdfDgtzkLQU24b8nMnawmeUbsF
 bxWJaCFpveU1XuoDcyCUV5e9sFlKAGdpBVD/yckw1LShQ2U2lXCpW6HoIPv/h1nyqZJPQ/GW1
 F60pz1/ze7bchPGLLYp/9imvezvlw3JwVDdLbZzJyXoBGV1LHeqVwMW6L5/F8T8DXtuXj0TF8
 RPgMD/R6yb9WBKl78ATSRmR/tSET52qvBsI/mI+e9arsNtAVB6KTuXtt4D8hDBwMTV3A6TkvO
 2wxHfRo9DHJ9jHcqotnkN7cQdwXLBRIa8Y5lT2piITPF+vO+GxY0dGPY3KTkMNYQHi606AZ0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283905>

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
