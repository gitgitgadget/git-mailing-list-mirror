From: David Greaves <david@dgreaves.com>
Subject: First git-pasky bug report? :) error: bad signature/verify header
 failed
Date: Mon, 18 Apr 2005 14:22:43 +0100
Message-ID: <4263B4A3.4030000@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 15:21:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNWAG-0006c2-8R
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 15:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVDRNX3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 09:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVDRNX3
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 09:23:29 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:34472 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262077AbVDRNWu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 09:22:50 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id AC66AE6D6F; Mon, 18 Apr 2005 14:21:14 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 07585-02; Mon, 18 Apr 2005 14:21:14 +0100 (BST)
Received: from oak.dgreaves.com (modem-2998.lemur.dialup.pol.co.uk [217.135.139.182])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 723DCE6A84; Mon, 18 Apr 2005 14:21:13 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DNWD6-0004gh-1F; Mon, 18 Apr 2005 14:22:44 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi

I'm just starting to look at git (and cogito).

Earlier this morning I got and built 
http://pasky.or.cz/~pasky/dev/git/git-pasky-base.tar.bz2
I then did a "git pull pasky" and a make.
All went well.
A couple of hours later I did another git pull pasky and had the problem 
shown below.

I moved the directory to one side and reissued the commands and all was 
well:
  723  tar xvfj git-pasky-base.tar.bz2
  724  cd git-pasky-0.4/
  725  make
  726  git pull pasky
  727  make
  728  git pull pasky
  729  history | tail -10

This is just a heads up in case there's anything useful here.
It may just have been locking issues and me pulling whilst the repo was 
being updated or something...

I'll hold the bad directory for a day or two in case anyone wants any 
diagnostics running.

David


david@ash:/everything/devel/git/git-pasky-0.4$ git pull pasky
MOTD:  Welcome to Petr Baudis' rsync archive.
MOTD:
MOTD:  If you are pulling my git branch, please do not repeat that
MOTD:  every five minutes or so - new stuff is likely not going to
MOTD:  appear so fast, and my line is not that thick. Nothing wrong
MOTD:  with pulling every half an hour or so, of course.
MOTD:
MOTD:  Feel free to contact me at <pasky@ucw.cz>, shall you have
MOTD:  any questions or suggestions.



Tree change: 
c29b3b29c2861ab0ffb475c7a7c9cfc946106eaf:5bf2f464d382b0bd746d06e264bc6951e7bfcd3a
*100644->100644 blob    
222bce21788308e1bf567304b474225b1681b03b->ad44415110ab63f1daa93e07dc496193d8006d81 
Makefile
*100755->100755 blob    
667f877ae836c418294ef085e91efcb48d30cabb->035a1f470003c8b0963d0eb5f0eb457155f415ad 
git
*100755->100755 blob    
fadd17e52845c5656ba344a9413b29b641c9ff5f->67e97fb71094693929f56d74bc13e572420d99d4 
gitcommit.sh
*100755->100755 blob    
7ea441e584d603463fb1b83991b88f63a3895cff->18478101980f630f0e9fd95365c6d9f46bf27bfd 
gitmerge.sh
*100755->100755 blob    
9bda6555a1dafc1db762bc46db60d2a9485dc523->8e016f7d3aeb0244c8a6524ddaa4b2cb1ff8015f 
gitpull.sh
+100755 blob    b6e318b31eb2ed6d2e137833a2064327331504b4        gitseek.sh
*100755->100755 blob    
30654380c10edde32def8e5fa2e2c956fbff3d58->ce44c1d4ce3b949b8ac99f1b90927da4e698e3de 
gittrack.sh
-100755 blob    2488078570c4a5709332d92d7a1b5b65036ff3a0        gitupdate.sh
Tracked branch, applying changes...
error: bad signature
error: verify header failed
read_cache: Invalid argument
error: bad signature
error: verify header failed
error: bad signature
error: verify header failed

At this point I moved the directory aside...

-- 

