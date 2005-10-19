From: John Ellson <ellson@research.att.com>
Subject: Wanted - a file browser interface to git
Date: Tue, 18 Oct 2005 20:58:30 -0400
Message-ID: <dj45np$e88$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Oct 19 03:02:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES2Kk-0001yg-EV
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 03:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVJSBB1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 21:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVJSBB1
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 21:01:27 -0400
Received: from main.gmane.org ([80.91.229.2]:35258 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750740AbVJSBB0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 21:01:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ES2J3-0001Ys-Bf
	for git@vger.kernel.org; Wed, 19 Oct 2005 02:59:49 +0200
Received: from h-135-207-24-103.research.att.com ([135.207.24.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Oct 2005 02:59:49 +0200
Received: from ellson by h-135-207-24-103.research.att.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Oct 2005 02:59:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h-135-207-24-103.research.att.com
User-Agent: Mail/News 1.4.1 (X11/20051008)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10250>

I know that Linus thinks that files are less important than commits, but we are 
finding a real need to be able to browse though old versions of files and we 
have not yet found an efficient way to do it with git.

An example is:  "I know that file xxx contained algorithm yyy at some point in 
the past and now I'd like to browse back through the history of xxx to find the 
exact details."

I think what I'd like is a file browser on git that:

- can navigate the directory tree, starting by default with the HEAD
tree, but able to browse the state of the tree at any time in the history.

- can select any file from the tree, and then view the state of that file at any 
time in its history by stepping forward or back through commits that have 
affected that file.
	
- can view the difference between any pair of states of the file, with 
annotations as to the source of the changes.

- can search for a string across the complete history of a file.

- can invoke the users choice of editor on the file.


Neither gitk nor qgit provide tree browsing, so it can be hard to get at a
specific file.

qgit has nice file browser that annotates all changes, but I think I'd prefer a 
two panel diff view.

Neither qgit not gitk provide links to an editor so that a file can be worked on 
once found.


Am I out in left field here, or does anyone else feel the need for something 
like this?

John
