From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] git-fetch: print the new and old ref when fast-forwarding
Date: Sat, 25 Feb 2006 12:20:13 +0100
Organization: Chalmers
Message-ID: <44003D6D.2010406@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Feb 25 12:20:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCxTI-0006pI-IG
	for gcvg-git@gmane.org; Sat, 25 Feb 2006 12:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWBYLUQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 25 Feb 2006 06:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWBYLUQ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Feb 2006 06:20:16 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:2989 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1030213AbWBYLUP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2006 06:20:15 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn2.hy.skanova.net (7.2.070)
        id 43FB2D05000F7A82; Sat, 25 Feb 2006 12:20:14 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16760>

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>

---
This is useful when you check out new changes with gitk.
Just copy/paste the old ref into gitk from the terminal.

 git-fetch.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

78f2844c17bb8627e84389e3026906d074c43363
diff --git a/git-fetch.sh b/git-fetch.sh
index fcc24f8..a3e2a34 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -164,6 +164,7 @@ fast_forward_local () {
 		;;
 	    *,$local)
 		echo >&2 "* $1: fast forward to $3"
+		echo >&2 "  from $local to $2"
 		git-update-ref "$1" "$2" "$local"
 		;;
 	    *)
--=20
1.2.3.gc412
