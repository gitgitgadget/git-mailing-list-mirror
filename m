From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-cherry: remove unused variable
Date: Sun, 27 Aug 2006 13:19:45 +0200
Message-ID: <44F17FD1.8010406@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 27 13:19:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHIgA-0007H1-3T
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 13:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWH0LTn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 07:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWH0LTn
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 07:19:43 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:58046
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1750795AbWH0LTn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 07:19:43 -0400
Received: from [10.0.1.3] (p508E7AB6.dip.t-dialin.net [80.142.122.182])
	by neapel230.server4you.de (Postfix) with ESMTP id 0306FB03A;
	Sun, 27 Aug 2006 13:19:41 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26091>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/git-cherry.sh b/git-cherry.sh
index f0e8831..8832573 100755
--- a/git-cherry.sh
+++ b/git-cherry.sh
@@ -51,9 +51,6 @@ patch=$tmp-patch
 mkdir $patch
 trap "rm -rf $tmp-*" 0 1 2 3 15
 
-_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
-
 for c in $inup
 do
 	git-diff-tree -p $c
