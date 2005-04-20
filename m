From: Steven Cole <elenstev@mesatop.com>
Subject: Possible problem with git-pasky-0.6.2 (patch: **** Only garbage was found in the patch input.)I
Date: Wed, 20 Apr 2005 17:06:09 -0600
Message-ID: <200504201706.09656.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 01:07:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOOH1-0004gw-LE
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 01:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVDTXKY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 19:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVDTXKY
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 19:10:24 -0400
Received: from taco.zianet.com ([216.234.192.159]:18188 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S261834AbVDTXKN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 19:10:13 -0400
Received: (qmail 72815 invoked from network); 20 Apr 2005 23:10:11 -0000
Received: from 216-31-65-218.zianet.com (216.31.65.218)
  by 0 with SMTP; 20 Apr 2005 23:10:11 -0000
To: Petr Baudis <pasky@ucw.cz>
User-Agent: KMail/1.6.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

After getting the latest tarball, and make, make install:

[steven@spc git-pasky-0.6.2]$ git pull pasky
MOTD:  Welcome to Petr Baudis' rsync archive.
MOTD:
MOTD:  If you are pulling my git branch, please do not repeat that
MOTD:  every five minutes or so - new stuff is likely not going to
MOTD:  appear so fast, and my line is not that thick. Nothing wrong
MOTD:  with pulling every half an hour or so, of course.
MOTD:
MOTD:  Feel free to contact me at <pasky@ucw.cz>, shall you have
MOTD:  any questions or suggestions.


receiving file list ... done
2e/1f16579fdcd9cd5d242f53a3cfaad52ac5d207
3e/f49665799151ced5e03ae1d544b1d67a6b7e5b
74/b4083d67eda87d88a6f92c6c66877bba8bda8a
7f/621eae988378ee776c040a5856e873e41691e1
a2/44b27ac61489b7d7fa4246e82479897d3bb886
a3/87546d148df5718a9c53bbe0cbea441e793d98
a4/6844fcb6afef1f7a2d93f391c82f08ea322221
a6/7b79e97f9db01bc270a07f3be9cda610845128
ba/4c6268d14989801b15e87cab98f6a236cc5e7f
f9/3b5e3d8a427d93e7e5125b55b17cd1a9479af9

wrote 228 bytes  read 99996 bytes  6466.06 bytes/sec
total size is 1753925  speedup is 17.50

receiving file list ... done

wrote 62 bytes  read 633 bytes  198.57 bytes/sec
total size is 369  speedup is 0.53
Tree change: 55f9d5042603fff4ddfaf4e5f004d2995286d6d3:a46844fcb6afef1f7a2d93f391c82f08ea322221
*100755->100755 blob    a78cf8ccab98861ef7aecb4cb5a79e47d3a84b67->74b4083d67eda87d88a6f92c6c66877bba8bda8a     gitcancel.sh
Tracked branch, applying changes...
Fast-forwarding 55f9d5042603fff4ddfaf4e5f004d2995286d6d3 -> a46844fcb6afef1f7a2d93f391c82f08ea322221
        on top of 55f9d5042603fff4ddfaf4e5f004d2995286d6d3...
patch: **** Only garbage was found in the patch input.

This may be a harmless message, but I thought I'd bring it to your attention.

Steven
