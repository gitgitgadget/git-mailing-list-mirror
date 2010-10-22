From: Mathias Lafeldt <misfire@debugon.org>
Subject: [PATCH 3/3] GIT-VERSION-GEN: style nitpicks
Date: Fri, 22 Oct 2010 13:24:29 +0200
Message-ID: <4CC1746D.5070907@debugon.org>
References: <cover.1287746107.git.misfire@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 13:24:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Fjs-0003t0-E6
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 13:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897Ab0JVLYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 07:24:33 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:62320 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755751Ab0JVLYc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 07:24:32 -0400
Received: from [192.168.2.102] (dslb-088-071-188-252.pools.arcor-ip.net [88.71.188.252])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LaYSx-1OmXYX2Dpn-00lwtp; Fri, 22 Oct 2010 13:24:31 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100915 Thunderbird/3.0.8
In-Reply-To: <cover.1287746107.git.misfire@debugon.org>
X-Provags-ID: V02:K0:cITMxK2ixvL45f9jSWQ69lyMjQU82zZVJyFYnU4aAGR
 9G648n3Sqm0uh1A0UzuPz98L0oC2nxl1jDxsEdZAQIQvhsN7Or
 Zp9q0ZL4uvC/EaR9Fo+kJIyCIagEQY2OAGImabZ9TRl2pitkdc
 XZqgS/bMcOovE4ADbKBFqZhYoUQFFtcTPS1PKlcmIMPxtMgWQn
 04/fhYc9qI87LrGI4/+FXc5FrPr8dG3toaAHA2bCco=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159681>

- remove superfluous semicolon
- simplify version comparison
- remove empty lines at end of file

Signed-off-by: Mathias Lafeldt <misfire@debugon.org>
---
 GIT-VERSION-GEN |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 427d5d6..60bef5a 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -18,7 +18,7 @@ elif test -d .git -o -f .git &&
 	v[0-9]*) : ;;
 	esac
 then
-	VN=$(echo "$VN" | sed -e 's/-/./g');
+	VN=$(echo "$VN" | sed -e 's/-/./g')
 else
 	VN="$DEF_VER"
 fi
@@ -31,9 +31,9 @@ then
 else
 	VC=unset
 fi
-test "$VN" = "$VC" || {
+
+if test "$VN" != "$VC"
+then
 	echo >&2 "GIT_VERSION = $VN"
 	echo "GIT_VERSION = $VN" >$GVF
-}
-
-
+fi
-- 
1.7.3.2
