From: Carl Baldwin <cnb@fc.hp.com>
Subject: [Question] Fetching a new branch from remote
Date: Mon, 28 Nov 2005 09:33:56 -0700
Organization: Hewlett Packard
Message-ID: <20051128163356.GA8300@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 28 17:37:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eglx2-00073C-6I
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 17:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVK1Qd6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 11:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVK1Qd6
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 11:33:58 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:58048 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751241AbVK1Qd5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 11:33:57 -0500
Received: from smtp2.fc.hp.com (smtp2b.fc.hp.com [15.15.136.253])
	by atlrel9.hp.com (Postfix) with ESMTP id D5263186B4
	for <git@vger.kernel.org>; Mon, 28 Nov 2005 11:33:56 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP id 93F6441E6BB
	for <git@vger.kernel.org>; Mon, 28 Nov 2005 16:33:56 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 83CD13BB9; Mon, 28 Nov 2005 09:33:56 -0700 (MST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12894>

Greetings,

I have a short question about git fetch.  Say there is a new branch,
call it 'new-branch' in a remote repository.  I am interested in this
branch and want to fetch it to 'new-branch' in my local to track its
progress.

I would expect this to do it:

% git fetch -f <url> new-branch

But, it doesn't.

Actually, I just noticed that this accomplishes the desired result...

% git fetch <url> new-branch:new-branch

I also just noticed that the man pages only says that '-f' works on
tags.  Should it work on branches?  Either way, it wasn't clear to me
how to fetch a new branch from a remote and store it under the same name
locally.  In my opinion, git fetch -f should do this if given a
branchname from the remote.

Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
