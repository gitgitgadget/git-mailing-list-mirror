From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Parseable commit header
Date: Sun, 17 Apr 2005 08:22:36 +0200
Organization: -no organization-
Message-ID: <20050417062236.GA3261@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 17 08:19:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN37T-0001wg-9S
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 08:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVDQGWo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 02:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVDQGWo
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 02:22:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.173]:56543 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261272AbVDQGWk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 02:22:40 -0400
Received: from [212.227.126.208] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DN3B1-0005lZ-00
	for git@vger.kernel.org; Sun, 17 Apr 2005 08:22:39 +0200
Received: from [84.134.24.93] (helo=scotty.home)
	by mrelayng.kundenserver.de with asmtp (TLSv1:EDH-RSA-DES-CBC3-SHA:168)
	(Exim 3.35 #1)
	id 1DN3B1-0002Ye-00
	for git@vger.kernel.org; Sun, 17 Apr 2005 08:22:39 +0200
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.4/8.13.4/Debian-1) with ESMTP id j3H6MboE004092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 17 Apr 2005 08:22:37 +0200
Received: (from hs@localhost)
	by scotty.home (8.13.4/8.13.4/Submit) id j3H6Mbfj004090
	for git@vger.kernel.org; Sun, 17 Apr 2005 08:22:37 +0200
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
To: git@vger.kernel.org
Content-Disposition: inline
X-Mailer: Mutt http://www.mutt.org/
X-Editor: GNU Emacs 21.2.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
User-Agent: Mutt/1.5.6+20040907i
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on scotty.home
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on scotty.home
X-Virus-Status: Clean
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:77aa76da759ebc9bab1cc524fc813130
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

after playing a while with git-pasky it is a crap to interpret the date of
commit logs. Though it was a good idea to put the date in a parseable format
(seconds since), but the format of the commit itself is not good parseable.

For easy converting the commit log header in readable format it should be in
another format, perhaps like mail header: 
- Every field should start al column zero wih filedname end up with a colon.
- Every fieldname starts with an upcase letter.
- The dates of author and committer should be fields of it own.
- The commit message itself is seperated by a blank line.


Example current log entry:

commit fe077e9d16819b72c275ea40b254f22b4d236f8b
tree 98b57b0310e0e2309fe4a6c24a6abea31a4d6c6d
parent f0adb6cf1bf603537afff5cf26b90e81321db225
author Petr Baudis <pasky@ucw.cz> 1113684324 +0200
committer Petr Baudis <xpasky@machine> 1113684324 +0200

s/me/commit/ in git log output.


Should be:

Commit: fe077e9d16819b72c275ea40b254f22b4d236f8b
Tree: 98b57b0310e0e2309fe4a6c24a6abea31a4d6c6d
Parent: f0adb6cf1bf603537afff5cf26b90e81321db225
Author: Petr Baudis <pasky@ucw.cz> 
Author-Date: 1113684324 +0200
Committer: Petr Baudis <xpasky@machine> 
Committer-Dater: 1113684324 +0200

s/me/commit/ in git log output.


This date entries are now easy parseable and convertable.

- Stefan

-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			

