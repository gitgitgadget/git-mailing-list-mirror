From: ir0s <imirene@gmail.com>
Subject: Local branch ahead of tracked remote branch but git push claims
 everything up-to-date
Date: Wed, 20 Aug 2008 13:26:09 -0700 (PDT)
Message-ID: <1219263969579-736663.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 22:27:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVuGx-0005Ob-BB
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbYHTU0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 16:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754722AbYHTU0L
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:26:11 -0400
Received: from kuber.nabble.com ([216.139.236.158]:53911 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066AbYHTU0K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:26:10 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1KVuFt-0002PI-Ix
	for git@vger.kernel.org; Wed, 20 Aug 2008 13:26:09 -0700
X-Nabble-From: imirene@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93035>


Hello,

I've used git for quite some time now but haven't run into this kind of
issue before.

I created a new branch from a remote branch that me and another developer
share:
$ git checkout --track -b mybranch origin/remotebranch

I make some changes, commit them but then switch to another branch and do
some work there. 

I return to checkout my new branch to do some work:
$ git checkout mybranch 
Switched to branch "mybranch "
Your branch is ahead of the tracked remote branch 'origin/remotebranch' by 4
commits.
mybranch 

Accurately, it has 4 commits that I haven't pushed yet. I try to push them
but I get the following:
$ git push origin remotebranch
Everything up-to-date

Any ideas? This is really strange. Clearly I have missing commits, my
teammate doesn't see those 4 when he pulls and yet I can't add them.

>From my git config:

[branch "mybranch"]
	remote = origin
	merge = refs/heads/remotebranch
-- 
View this message in context: http://n2.nabble.com/Local-branch-ahead-of-tracked-remote-branch-but-git-push-claims-everything-up-to-date-tp736663p736663.html
Sent from the git mailing list archive at Nabble.com.
