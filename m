From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-merge: show usage if run without arguments
Date: Sat, 21 Oct 2006 20:51:04 +0200
Message-ID: <453A6C18.70206@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 21 20:51:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbLw5-0007Yn-EN
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 20:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422786AbWJUSvG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 14:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422792AbWJUSvG
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 14:51:06 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:34690
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1422786AbWJUSvD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 14:51:03 -0400
Received: from [10.0.1.3] (p508E640B.dip.t-dialin.net [80.142.100.11])
	by neapel230.server4you.de (Postfix) with ESMTP id 90E191B031;
	Sat, 21 Oct 2006 20:51:02 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29657>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/git-merge.sh b/git-merge.sh
index 49c46d5..cb09438 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -93,6 +93,8 @@ finish () {
 	esac
 }
 
+case "$#" in 0) usage ;; esac
+
 rloga=
 while case "$#" in 0) break ;; esac
 do
