From: Kim Phillips <kim.phillips@freescale.com>
Subject: [PATCH] contrib/completion: remove parentheses from prompt
Date: Fri, 22 Apr 2011 14:32:48 -0500
Organization: Freescale Semiconductor, Inc.
Message-ID: <20110422143248.1f4f84c0.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 21:33:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDM6d-0006cW-SM
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 21:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423Ab1DVTd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2011 15:33:27 -0400
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:43442
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751984Ab1DVTd0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2011 15:33:26 -0400
Received: from mail188-ch1-R.bigfish.com (216.32.181.173) by
 CH1EHSOBE017.bigfish.com (10.43.70.67) with Microsoft SMTP Server id
 14.1.225.8; Fri, 22 Apr 2011 19:33:24 +0000
Received: from mail188-ch1 (localhost.localdomain [127.0.0.1])	by
 mail188-ch1-R.bigfish.com (Postfix) with ESMTP id AEDCEF983DB	for
 <git@vger.kernel.org>; Fri, 22 Apr 2011 19:33:24 +0000 (UTC)
X-SpamScore: 0
X-BigFish: VS0(zzzz1202hzz8275bhz2dh2a8h668h839h64h)
X-Spam-TCS-SCL: 3:0
X-Forefront-Antispam-Report: KIP:(null);UIP:(null);IPVD:NLI;H:mail.freescale.net;RD:none;EFVD:NLI
Received: from mail188-ch1 (localhost.localdomain [127.0.0.1]) by mail188-ch1
 (MessageSwitch) id 1303500775623527_7542; Fri, 22 Apr 2011 19:32:55 +0000
 (UTC)
Received: from CH1EHSMHS009.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.254])	by mail188-ch1.bigfish.com (Postfix) with ESMTP id
 58C361878057	for <git@vger.kernel.org>; Fri, 22 Apr 2011 19:32:52 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by CH1EHSMHS009.bigfish.com
 (10.43.70.9) with Microsoft SMTP Server (TLS) id 14.1.225.8; Fri, 22 Apr 2011
 19:32:50 +0000
Received: from az33smr01.freescale.net (10.64.34.199) by
 039-SN1MMR1-001.039d.mgd.msft.net (10.84.1.13) with Microsoft SMTP Server id
 14.1.270.2; Fri, 22 Apr 2011 14:32:49 -0500
Received: from widmer (widmer.am.freescale.net [10.82.123.5])	by
 az33smr01.freescale.net (8.13.1/8.13.0) with SMTP id p3MJWnbf020998	for
 <git@vger.kernel.org>; Fri, 22 Apr 2011 14:32:49 -0500 (CDT)
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
X-OriginatorOrg: freescale.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171942>

Save horizontal terminal line real estate by removing
parentheses from the prompt branch display.  The branch
is already sufficiently visually delimited by the preceding
space character.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 contrib/completion/git-completion.bash |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 840ae38..1373fd4 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -268,7 +268,6 @@ __git_ps1 ()
 
 				b="$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
 				b="unknown"
-				b="($b)"
 			}
 		fi
 
@@ -312,7 +311,7 @@ __git_ps1 ()
 		fi
 
 		local f="$w$i$s$u"
-		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
+		printf "${1:- %s}" "$c${b##refs/heads/}${f:+ $f}$r$p"
 	fi
 }
 
-- 
1.7.4.5.2.g95442
