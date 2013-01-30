From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/3] fixup! mergetool--lib: add functions for finding available tools
Date: Wed, 30 Jan 2013 19:55:44 +0000
Message-ID: <2c7dec096455e6e43d2e9aa28668f69a26f3d5f9.1359575447.git.john@keeping.me.uk>
References: <cover.1359575447.git.john@keeping.me.uk>
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 20:56:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0dly-0006Rv-B8
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 20:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817Ab3A3T4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 14:56:20 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:58132 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab3A3T4T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 14:56:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 06E2322EE9;
	Wed, 30 Jan 2013 19:56:19 +0000 (GMT)
X-Quarantine-ID: <e-U1sEI09spd>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e-U1sEI09spd; Wed, 30 Jan 2013 19:56:18 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 296FD22BF4;
	Wed, 30 Jan 2013 19:56:18 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 1D42E161E4E3;
	Wed, 30 Jan 2013 19:56:18 +0000 (GMT)
X-Quarantine-ID: <nuGoPYe6SZ2D>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nuGoPYe6SZ2D; Wed, 30 Jan 2013 19:56:18 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id A3AF8161E02E;
	Wed, 30 Jan 2013 19:56:11 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.1
In-Reply-To: <cover.1359575447.git.john@keeping.me.uk>
In-Reply-To: <cover.1359575447.git.john@keeping.me.uk>
References: <cover.1359575447.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215062>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-mergetool--lib.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 25631cd..b6ed2fa 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -34,9 +34,9 @@ show_tool_names () {
 				then
 					echo "$preamble"
 					preamble=
-					shown_any=yes
 				fi
-				printf "%s%s\n" "$per_line_prefix" "$tool"
+				shown_any=yes
+				printf "%s%s\n" "$per_line_prefix" "$toolname"
 			fi
 		done
 		test -n "$shown_any"
@@ -244,6 +244,7 @@ show_tool_help () {
 
 	tab='	' av_shown= unav_shown=
 
+	cmd_name=${TOOL_MODE}tool
 	if show_tool_names 'mode_ok && is_available' "$tab$tab" \
 		"$tool_opt may be set to one of the following:"
 	then
-- 
1.8.1.1
