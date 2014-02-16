From: Ingo Rohloff <lundril@gmx.de>
Subject: Ambiguous branch names...
Date: Sun, 16 Feb 2014 21:34:39 +0100
Message-ID: <20140216203439.GA15538@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 16 21:34:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF8QK-0005Yt-PP
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 21:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbaBPUep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 15:34:45 -0500
Received: from mout.gmx.net ([212.227.15.19]:62958 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753300AbaBPUeo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 15:34:44 -0500
Received: from flatline.chipnet ([178.26.78.197]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LrqNe-1XIlaw3102-013gmn for <git@vger.kernel.org>;
 Sun, 16 Feb 2014 21:34:41 +0100
Received: by flatline.chipnet (sSMTP sendmail emulation); Sun, 16 Feb 2014 21:34:39 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:YrO8mXpfTZfhELuaq6yOPswKrp1beUhTXMr8V+abNb7VACTX9Dp
 TxCFTy1PlXNre1jpYiBBhqjv1IJmxG8BKpbnz91AmH31f+CI3rjV1NTq8xy2wnV3j5Plysg
 ZvD/3dDe547rjc0g5jpZbQkB7MyQ1D08ezrwyj6wMtQCgd1WO/FiSE3PX/uf3p4iSk4v9DW
 TrPHU1sOBgPlRJiJ/p2vA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242242>

Hello,

while trying out git (version 1.7.9.5), I did this:

git clone -- ssh://myserver/~rohloff/git/w1.git w1

So I just cloned a test repository.
The in the cloned "w1" repository I executed:

git branch origin/master
git branch remotes/origin/master
git branch refs/remotes/origin/master

I now have got three *local* branches with the above names, which
now seems to make it impossible to refer to the master branch
from the "origin" *remote* repository.

Wouldn't it make sense to forbid such names for local branches ?
For example to enforce some rules like a local branch name *must not*
start with "remotes/" or "refs/" ?

so long
  Ingo
