From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 3/3] completion: add missing branch.*.rebase values
Date: Wed, 13 Jan 2016 07:57:59 +0100 (CET)
Message-ID: <e2c52057ff9276b4e1e868af0ba209cc4e313867.1452668201.git.johannes.schindelin@gmx.de>
References: <cover.1452612112.git.johannes.schindelin@gmx.de> <cover.1452668201.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:58:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJFNq-00073J-4V
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 07:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462AbcAMG6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 01:58:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:50963 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754286AbcAMG6E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 01:58:04 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MUHoI-1ak5t42eig-00R1jf; Wed, 13 Jan 2016 07:58:00
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452668201.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:WGjALRumLq7z82zPtzZwetOmnWwlrQc5hxP6ByLEXsBVS86LYEz
 waI8eVRSOfXEG8oQr/GwlOphHene31idVLov1I1WxtdxZKKGsjqQC26Nf+u62ybNS1CsdAN
 KBSv3b0NJ2bbuOclyqNE9Ia9FxH9yAHWHQulHCM+V45xtdaF6gsnT7b0HB8647cBXENkE5b
 pgaFuAinSb8gLEkWxrwYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3W7wqS5mpv4=:FyPlvHR+JUpFKMwcCQvPJa
 9zVk1Ambi6t7bosLj+UyvZY6jeV+yzegNMdoWxk6eNZUh6IizDcWsy1/FPsRfLFijwp8kTr/A
 OTGD4d4KEH26Nts5+l//0dFabSYQ/uY8szfxSrR1DP7lyl+YlynXeqsxfR4CnXBsAL0d+Ya2x
 lOWG/L97pyWPcJTsknLfcZgUf0sEQTXSxpIysLaTLyem6mrGchwCbC7vka4ev2IWvkyX2tsqX
 qSTfAEPtNaF1sjoQ+aA4P9BrUcGRD6qmUP7CGZeBOah0a3FBvqtWI3ct1Kmjfc6oaY74aMqCr
 76KlOExwM8jP6zSFPUJekSkq5ce2nM64nCDGEVKEvgXReyiRxM7beHRMTBZvd5jfmF1l93tHr
 0vsWC7FMXwGVXTo6KZb+QC86+U738SOwre9RMdLzAYfiY6pv6JbAIbrCjIiQIfUZHZjSs0bhi
 wGvcgrEECfs99ekmChGLqLB3wyYttF9mFcheBEm28QYNfZZyEIYz8+R2PtqVLK5Q2hqGQ/B+M
 5pUS28abZ1pGP1qUv6BIf4JdcgP2CLQSTygKh5n9LLP8crFji97LZtp9ExtyoLuvPJqe709MH
 aNi246yL3AFkCvRJvI3WWiJn7nVzqo4ocKxXQZXrDoyBHWPoI7HOc1VuWEMr7l1PTzPZBHE/P
 GdrwWgcXZqAMqwlnBWGMBd+1FU26SnSzVKKW5HT8zU0eYz78EH27r/rMO92N2zkKlC5g1jyJ+
 l6tdG5cN9gPcU1SWiH9JGpFFfzigCIaln1thQj81QX6x5YZc1sXEUkASs5WIZKgaLN1uQbDO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283888>

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
