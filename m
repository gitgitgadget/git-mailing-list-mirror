From: =?ISO-8859-1?Q?Love_H=F6rnquist_=C5strand?= <lha@kth.se>
Subject: [ANNOUNCE] git2svn 0.1
Date: Wed, 16 Apr 2008 08:23:21 +0200
Message-ID: <940364D7-2A3E-414F-8FB6-2B866974F178@kth.se>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 16 08:52:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm1RH-0001Nc-2I
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 08:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbYDPGra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 02:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbYDPGra
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 02:47:30 -0400
Received: from smtp-2.sys.kth.se ([130.237.32.160]:60224 "EHLO
	smtp-2.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbYDPGra (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 02:47:30 -0400
X-Greylist: delayed 1441 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Apr 2008 02:47:30 EDT
Received: from localhost (localhost [127.0.0.1])
	by smtp-2.sys.kth.se (Postfix) with ESMTP id C531314D842
	for <git@vger.kernel.org>; Wed, 16 Apr 2008 08:23:26 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at kth.se
Received: from smtp-2.sys.kth.se ([127.0.0.1])
	by localhost (smtp-2.sys.kth.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id iavFb0by28h2 for <git@vger.kernel.org>;
	Wed, 16 Apr 2008 08:23:22 +0200 (CEST)
Received: from [192.168.1.3] (c80-216-47-167.bredband.comhem.se [80.216.47.167])
	by smtp-2.sys.kth.se (Postfix) with ESMTP id 9C55714D7D5
	for <git@vger.kernel.org>; Wed, 16 Apr 2008 08:23:22 +0200 (CEST)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79680>

Hello,

So you want to convert to git from svn but have an anonymous userbase
pulling from svn and/or tools that uses svn that you can't convert.

Use git2svn to convert the "git fast-export" dump into a svn dump
and load it into a new fresh svn repository. git2svn also supports
incremental updates.

git2svn was tested on heimdal/master and samba/v3-2-test during the
development so it should work on semi large repositories.

              http://repo.or.cz/w/git2svn.git

Please send any bug reports and comments to lha@kth.se

README:

     This program will convert a git branch to a svn ditto, it also
     support incremental updates.

     git2svn takes a git fast-export dump and converts it into a svn
     dump that is feed into svnadmin load.

     git2svn assumes its the only process that writes into the svn
     repository. This is because of the race between getting the to svn
     Revsion number from the svn, creating the dump with correct
     Revsions, and do the svnadmin load.

     git2svn also support incremental updates from a git branch to a
     svn reprositry. Its does this by setting a git tag
     (git2svn-syncpoint-branchname) where the last update was pulled
     from.



Love
