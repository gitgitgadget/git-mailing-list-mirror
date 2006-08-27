From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-reset: remove unused variable
Date: Sun, 27 Aug 2006 13:19:58 +0200
Message-ID: <44F17FDE.5090805@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 27 13:20:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHIgJ-0007IU-Rr
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 13:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWH0LTz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 07:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWH0LTz
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 07:19:55 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:60094
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1750803AbWH0LTy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 07:19:54 -0400
Received: from [10.0.1.3] (p508E7AB6.dip.t-dialin.net [80.142.122.182])
	by neapel230.server4you.de (Postfix) with ESMTP id B349D5008;
	Sun, 27 Aug 2006 13:19:53 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26092>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/git-reset.sh b/git-reset.sh
index 36fc8ce..3133b5b 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -3,9 +3,6 @@ #!/bin/sh
 USAGE='[--mixed | --soft | --hard]  [<commit-ish>]'
 . git-sh-setup
 
-tmp=${GIT_DIR}/reset.$$
-trap 'rm -f $tmp-*' 0 1 2 3 15
-
 update=
 reset_type=--mixed
 case "$1" in
