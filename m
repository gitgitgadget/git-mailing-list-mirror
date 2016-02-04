From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/3] rebase --merge: adjust $((...)) coding style
Date: Thu, 4 Feb 2016 13:03:00 +0100 (CET)
Message-ID: <6c243cf13271ed285409063e501ec67c19df767d.1454587284.git.johannes.schindelin@gmx.de>
References: <cover.1454587284.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Elia Pinto <gitter.spiros@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 13:03:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRId0-0008Ap-IQ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 13:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbcBDMDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 07:03:11 -0500
Received: from mout.gmx.net ([212.227.17.22]:60270 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751333AbcBDMDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 07:03:09 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Mdrph-1ahYp132cv-00Pen0; Thu, 04 Feb 2016 13:03:02
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1454587284.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:CqV0CHQKdrkk6ePEU4GV4avxIzDtGiHcBZ2Rnt1uZGEs1HuFl4d
 zcyetmWrsNIwPUeweAgUJYWtpiuiZC9G4Bfsfp0KffCu7hiRYYfw8fGbjnSqylEF4UqIOY7
 6CFqvuu+AexTg1tCO63Kgec+yU5SHGfU/7DXDFXbSfGfijj0A+hXRESQlcTRVt9fxhiKoMB
 rV55MW3GToDAjs5T/O1Wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:REPKF+jXm14=:K2ldRhCpDhoxvRNs5RlDZG
 5IlkTkGq5oGUi+/9tzrosLWifc/2msA31lZwu5lnJN59Rd3h0wQlGlRcC4H3KbljPgwgSapqW
 YTUDAs0wlXADO3Zf/D6Ouen64h5eCYlwaQGh/+m6gFnGggvg2CbtkQe6hHIuTstDNsN+9DqRM
 m4L3DEfW+DwevnYQDdiXyNGbFadv8Vapb6g5VfdwNXphL1F6Re/jjVGBrPT+EnaiQEY65xsT1
 /aGq1egUyHSmGvRLEn3W1C+2LS+a9PlTwPAUVqPYXiFWeaycr12oTTwNnTfCaQw3umU32eXIb
 4SULZxm6EVXVTfIZRp5x4XRs9a6TUJcoge9ScxmRqE3sBuuQ6DJP9qF78hENRP0bMpURbv7EU
 sHivMicVg+8RPu41wQxuMtJGnG4RzXuanKQCMKu09LjInU4CG8482z+V6bZXOiU48zgDj7rmD
 6/z85T0v0TEx7evuwN0BtRExA8vN5Aqf7Boen1ZfBAFBat5hU7rU0m/3v5RZzXFiBmjA1ovZt
 Ph3x5FifDTxBHEAMgm5x+jbCxVEimi2MisUYuuEFrAj2aAgTyYqdbN3wE6drWEAPa9/08FlZT
 5b1tJaf+3dgGle0e/10LD9hsdE0SN/jcN2i++f5LisiU+wzzOiDHw89anLCPjp9jrjc0ktOWh
 HE6UL4TZoGzsLXk1aX+8tQHXiA2LPnYtDqwxsQmURO+zGZrp1bzv3v1b8O8oApTHVRJOU+OXY
 Jg5VFupgBq9A1wdHXeuxzib8JANkptgrRCtEyDjqdShQKjBlXQT92AtS3Atgpho6yXpfsH4k 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285458>

In 58634db (rebase: Allow merge strategies to be used when rebasing,
2006-06-21) we introduced $((...)) expressions containing spaces,
disagreeing with Git's existing source code's convention.

Naturally, 0bb733c (Use branch names in 'git-rebase -m' conflict hunks.,
2006-12-28) repeated the convention set forth in git-rebase--merge.sh.

Let's make the coding style consistent again.

Cc: Eric Wong <normalperson@yhbt.net>
Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--merge.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 2cc2a6d..a9bd39a 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -48,7 +48,7 @@ continue_merge () {
 	GIT_PAGER='' git log --format=%s -1 "$cmt"
 
 	# onto the next patch:
-	msgnum=$(($msgnum + 1))
+	msgnum=$(($msgnum+1))
 	echo "$msgnum" >"$state_dir/msgnum"
 }
 
@@ -59,7 +59,7 @@ call_merge () {
 	echo "$cmt" > "$state_dir/current"
 	hd=$(git rev-parse --verify HEAD)
 	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
-	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
+	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end-$msgnum))"'
 	eval GITHEAD_$hd='$onto_name'
 	export GITHEAD_$cmt GITHEAD_$hd
 	if test -n "$GIT_QUIET"
@@ -126,7 +126,7 @@ continue)
 skip)
 	read_state
 	git rerere clear
-	msgnum=$(($msgnum + 1))
+	msgnum=$(($msgnum+1))
 	while test "$msgnum" -le "$end"
 	do
 		call_merge "$msgnum"
@@ -144,7 +144,7 @@ write_basic_state
 msgnum=0
 for cmt in $(git rev-list --reverse --no-merges "$revisions")
 do
-	msgnum=$(($msgnum + 1))
+	msgnum=$(($msgnum+1))
 	echo "$cmt" > "$state_dir/cmt.$msgnum"
 done
 
-- 
2.7.0.windows.1.7.g55a05c8
