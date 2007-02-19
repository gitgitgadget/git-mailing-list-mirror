From: Raimund Bauer <ray007@gmx.net>
Subject: 2 things about branches
Date: Mon, 19 Feb 2007 19:13:59 +0100
Message-ID: <1171908840.10817.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 19:14:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJD1d-0000CS-Aw
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 19:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbXBSSOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 13:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbXBSSOF
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 13:14:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:41571 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932445AbXBSSOE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 13:14:04 -0500
Received: (qmail invoked by alias); 19 Feb 2007 18:14:01 -0000
X-Provags-ID: V01U2FsdGVkX1/lKld/nPDlSmwbp9HMPfAgac29nCNfJ3JCymHznN
	8NVQ==
X-Mailer: Evolution 2.8.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40135>

I think it's a good idea to not list remote branches in 'git branch'
output per default, but imho we should make an exception for the branch
the user is currently on.
Currently when I do 'git checkout origin/next' the checkout works fine
and I get the warning about the remote branch, but an informational
query 'git branch' right after that says

* (no branch)
  master

'git branch -r' also doesn't mark me as being on origin/next.
Maybe we could query the remote-branches for a matching ref this case?

And another wish about branches:
After a fresh clone of git, my .git/config contains a section

[branch "master"]
        remote = origin
        merge = refs/heads/master

so it's easy to keep the branch updated by just saying 'git pull' when
on branch master.

Doing 'git checkout -b next origin/next' gives me my own next-branch,
but short of editing .git/config there seems to be no way to get a
similar section [branch "next"] ... so I can follow next as easy as
master.
I'm not sure if there exists a sane default we could use automatically,
but maybe a switch to git-checkout to write a config entry would be
possible?

Thanks for listening to my rambling

-- 
best regards

  Ray
