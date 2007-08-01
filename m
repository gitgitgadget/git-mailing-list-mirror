From: David Kastrup <dak@gnu.org>
Subject: [PATCH] git-commit.sh: Permit the --amend message to be given with -m/-c/-C/-F.
Date: Wed, 1 Aug 2007 22:33:47 +0200
Organization: Organization?!?
Message-ID: <85zm1bq8um.fsf@lola.goethe.zz>
References: <86643znxgz.fsf@lola.quinscape.zz>
	<7v8x8v5g2z.fsf@assigned-by-dhcp.cox.net>
	<85myxbrrdl.fsf@lola.goethe.zz>
	<7vk5sf3uct.fsf@assigned-by-dhcp.cox.net>
	<857iofrnkj.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 22:49:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGL8Y-0003DS-Vc
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 22:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbXHAUtk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 16:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbXHAUtk
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 16:49:40 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:49162 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751323AbXHAUtj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 16:49:39 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 295754C887
	for <git@vger.kernel.org>; Wed,  1 Aug 2007 22:49:38 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 15AC1ABF65
	for <git@vger.kernel.org>; Wed,  1 Aug 2007 22:49:38 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-017.pools.arcor-ip.net [84.61.17.17])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id E19BE3425E2
	for <git@vger.kernel.org>; Wed,  1 Aug 2007 22:49:37 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id CAB491C3E076; Wed,  1 Aug 2007 22:48:49 +0200 (CEST)
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV version 0.91.1, clamav-milter version 0.91.1 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54476>


Signed-off-by: David Kastrup <dak@gnu.org>
---
 git-commit.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 4290ae2..d7e7028 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -190,7 +190,6 @@ $1"
 		;;
 	--a|--am|--ame|--amen|--amend)
 		amend=t
-		log_given=t$log_given
 		use_commit=HEAD
 		shift
 		;;
@@ -298,9 +297,9 @@ esac
 
 case "$log_given" in
 tt*)
-	die "Only one of -c/-C/-F/--amend can be used." ;;
+	die "Only one of -c/-C/-F can be used." ;;
 *tm*|*mt*)
-	die "Option -m cannot be combined with -c/-C/-F/--amend." ;;
+	die "Option -m cannot be combined with -c/-C/-F." ;;
 esac
 
 case "$#,$also,$only,$amend" in
-- 
1.5.3.rc2.84.gd0bef-dirty
