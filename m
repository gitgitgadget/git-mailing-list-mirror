From: Marco Costalba <mcostalba@yahoo.it>
Subject: [ANNOUNCE] qgit-0.93
Date: Sun, 21 Aug 2005 01:39:41 -0700 (PDT)
Message-ID: <20050821083941.4109.qmail@web26306.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Aug 21 10:40:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6lMq-00043j-3j
	for gcvg-git@gmane.org; Sun, 21 Aug 2005 10:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVHUIjn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 04:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbVHUIjn
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 04:39:43 -0400
Received: from web26306.mail.ukl.yahoo.com ([217.146.176.17]:46713 "HELO
	web26306.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750837AbVHUIjm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2005 04:39:42 -0400
Received: (qmail 4111 invoked by uid 60001); 21 Aug 2005 08:39:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=i9AbRFgqPpljry6R8ku7Prj8AWWQ/N4O4IQZ92BIuxUbrsC1yBt+aPLsd6cvLiidEHJR6Tq0BRrnEwayng4fDWhB41t63zxmfssze8wncMsnsT3EDW3Hf2VildwjZ/SC2CB9PP3G9MHOQe06/Hbz/FO6ZD+cv6yJSQiWfFYwcC8=  ;
Received: from [151.38.108.110] by web26306.mail.ukl.yahoo.com via HTTP; Sun, 21 Aug 2005 01:39:41 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi all,

On SF there is an update of qgit, a git GUI viewer (and lately also 
committer and patch exchanger ;-) )

	http://prdownloads.sourceforge.net/qgit/qgit-0.93.tar.bz2?download


This time I have added the interfaces to import and export patches by 
git-format-patch-script and git-applymbox.

As a side effect it is now possible to drag and drop a set of 
selected revisions between two instances of qgit (there is also the 
new menu entry 'open in a new window';-) )

Other updates include complete recursive search of refs under .git/refs/ and 
highlight according to type: current branch(HEAD), branch, tag, other.

And new is also graft support, thanks to Linus hint of --parents flag in git-rev-list 

Under the hood a reworked and much more powerful error handling and reporting 
code and a better commit.

As usual the shop is open for suggestions/requests and bug reports.


Marco



Complete ChangeLog from last announced release:

21/8/2005 qgit-0.93

- added drag and drop of selected revs between qgit instances: using  
  git-format-patch in dragging archive and git-applymbox in dropping 
  archive to transfer the revisions patches.
  Instances can be open with menu->file->'open in a new window' or simply 
  from the shell.

- added GUI interface to git-applymbox to import patches

- added refs highlight, now any reference found recursively under .git/refs/
  is highlighted according to its type: current branch(HEAD), branch, tag, other.

- added graft support using --parents flag in git-rev-list

- added custom options setting for commit dialog (interface to git-commit-script)

- added --signoff option to patch format

- reworked error reporting infrastructure, now much more powerful
  and informative in case of git command execution failure

- various small bug fixes and GUI tweaks


>From qgit-0.92
- fix a bad crash when running qgit --all on archives with
  branches.

- added 'Make Tag' menu entry

- a compile fix for Debian users, reported by Martin Langhoff

- various small tweaks to GUI

>From qgit-0.91
- fix a build problem on some platform, spotted and
  fixed by Bernhard Schiffner.

- added line and col number in commit viewer


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
