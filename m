From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/3] rebase--interactive: adjust the coding style of
 $((...))
Date: Thu, 4 Feb 2016 13:02:30 +0100 (CET)
Message-ID: <dbd8ee3b1de55b7414c91bf203be2aaa77b78822.1454587284.git.johannes.schindelin@gmx.de>
References: <cover.1454587284.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Elia Pinto <gitter.spiros@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 13:02:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRIca-0007d9-Ii
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 13:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbcBDMCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 07:02:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:63080 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbcBDMCn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 07:02:43 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lh7sF-1ZfG9v0ChT-00oUsq; Thu, 04 Feb 2016 13:02:32
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1454587284.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:4+NUiNZ8BHcSOmw3V4ej/apfVMhkBlZtTNhfYWRdqlbvrSUfynn
 yYvtTI2Rqsd7OBGOrvmHSFbkZ2VzUAizzc2upmER5iAICQy+7E8TmqxmRLPEueIydejh2Ad
 TtWv0n4nBq/XZX0SCulBTFPv1hXzhmuPSmumSsRCcYJFVyR+TvaQZzZR6BtwtNvY4jfo0Uh
 jbMJSCOg2BGz1p8gXH2uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mNpR8lIyj4U=:uDV/ThrKXX7yLZOVpX0TYA
 +xIV/AQgRJ24qVf/xTf2BNtWHlaJvt3mPwqz/dCJAgWfRyCNHRKhhSfAiQrR9PuAVZdFgIsUS
 OXXeN4Dl1D9Ptus56GE1EapB2qXRRsE4Nshx0M0/6FzbaYlcYuj3C4MZ4OQ2NgaUtlyJKVKyk
 c/wC4xkOQ+MUWrf7y8QNktO2q/19GOpCXmZ/Ucjo6GAYIUzLXZY7Q8Wc3GMLYFDATf0dzMxqh
 fLa7A0Do9WztshyRDOyUpbmzf+jP82OeqZgnUBcuXB/rj4uZPNcsp9MSOKg5L6P6c12PlzaXu
 23TUydZiM0iC2XyicgsAGYiVjPX2AwY7Sft84kGcztSWlF2tIWuwspRp3WgaU09re/KAvY0hu
 bWuo+eq5jx7UYSXGZ3IYXNf9fxVlou3sRgw8Gs/iZO5+YdpRbNa9zMA7Xu9ZGYAHC3bg2F+K1
 vw6yG2Av/GFYTXE8CIAiwIYwhip2Xo5h8l9uUKyLjokiOuta9Yx+xb1ZWxpC2hMqxWyz8X9JA
 uMysLeIPZAwqjHV/SNnMeQtmdeUWCzvlIUk1GwkhHCCS4ENyRla3wcyjLJusWXPltvlKtTNRE
 P69Cq+iT8wyZpZlZnJFO/CbJTor/Bf3C7/oDXPihlYGE7L7hU7+4oN8xLXSNpsib7I+ZdETrE
 wW1NDYP/40/JACgHn7/W1Crj/OKxdOE5wawUztoTFj+gHJqyvAVFCDiP10kV/lMs2I0ETQVqu
 XS8xHKVTYFr9Rsyt/wu8fn+7oiG67D0gn+GhxTCPGNnD7DXQH50mn0NxyCRUV3Ov4jrDZ9dt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285457>

In 180bad3 (rebase -i: respect core.commentchar, 2013-02-11) we changed
the coding style of an arithmetic expression to introduce spaces. The
existing $((...)) expression did not use that convention, though, and
neither was it the habit of the other shell scripts in Git's source code.

Later, 1db168e (rebase-i: loosen over-eager check_bad_cmd check,
2015-10-01) repeated the same coding style, again not matching the rest of
the source code's style.

Let's make the coding style consistent again.

Cc: John Keeping <john@keeping.me.uk>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c0cfe88..3e2bd1b 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -122,7 +122,7 @@ mark_action_done () {
 	mv -f "$todo".new "$todo"
 	new_count=$(git stripspace --strip-comments <"$done" | wc -l)
 	echo $new_count >"$msgnum"
-	total=$(($new_count + $(git stripspace --strip-comments <"$todo" | wc -l)))
+	total=$(($new_count+$(git stripspace --strip-comments <"$todo" | wc -l)))
 	echo $total >"$end"
 	if test "$last_count" != "$new_count"
 	then
@@ -895,7 +895,7 @@ check_bad_cmd_and_sha () {
 	lineno=0
 	while read -r command rest
 	do
-		lineno=$(( $lineno + 1 ))
+		lineno=$(($lineno+1))
 		case $command in
 		"$comment_char"*|''|noop|x|exec)
 			# Doesn't expect a SHA-1
-- 
2.7.0.windows.1.7.g55a05c8
