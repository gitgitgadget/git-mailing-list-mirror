From: pbGit <pblakeley@gmail.com>
Subject: Re: Problems pushing???
Date: Sun, 8 Jul 2012 08:43:36 -0700 (PDT)
Message-ID: <1341762216101-7562707.post@n2.nabble.com>
References: <1341738766823-7562695.post@n2.nabble.com> <4FF97463.90002@ira.uka.de> <1341759063006-7562705.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 08 17:44:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnteV-0000T8-Di
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jul 2012 17:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab2GHPni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jul 2012 11:43:38 -0400
Received: from sam.nabble.com ([216.139.236.26]:55068 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859Ab2GHPng (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2012 11:43:36 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <pblakeley@gmail.com>)
	id 1Snte4-0004pZ-3V
	for git@vger.kernel.org; Sun, 08 Jul 2012 08:43:36 -0700
In-Reply-To: <1341759063006-7562705.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201182>

Just tried starting again on my local machine because when I tried pushing,
git said that it local was also set to bare init.  When I looked this was
the case.  Silly me.  

So I deleted on my local and added a single file and when I try pushing this
I get the following:
 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to 'paul@localhost:/Users/paul/<prject>'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')
hint: before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.

When I try and pull I then get the following:
fatal: No remote repository specified.  Please, specify either a URL or a
remote name from which new revisions should be fetched.

I then addded my repo with the following command, but  this is the wrong
syntax!!!
git pull --repo=<project>

What the hell am I doing wrong???

--
View this message in context: http://git.661346.n2.nabble.com/Problems-pushing-tp7562695p7562707.html
Sent from the git mailing list archive at Nabble.com.
