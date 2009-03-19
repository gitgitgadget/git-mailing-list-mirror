From: William Morgan <wmorgan-git@masanjin.net>
Subject: question about conflict resolution across multiple branches
Date: Thu, 19 Mar 2009 10:56:54 -0700
Message-ID: <1237483813-sup-5631@entry>
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 19:33:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkN3x-0007M0-6U
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 19:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652AbZCSScV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 14:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754372AbZCSScU
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 14:32:20 -0400
Received: from masanjin.net ([209.20.72.13]:59701 "EHLO entry.masanjin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754299AbZCSScU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 14:32:20 -0400
X-Greylist: delayed 2123 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2009 14:32:20 EDT
Received: from w by entry.masanjin.net with local (Exim 4.69)
	(envelope-from <w@masanjin.net>)
	id 1LkMUB-0005Tj-3L
	for git@vger.kernel.org; Thu, 19 Mar 2009 10:56:55 -0700
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113805>

Hi all,

I have a git usage question about topic branches and conflicts.

I maintain a project that I believe follows the standard topic branch
model. It has two "version" branches, master and next. When a new
feature is introduced, I create a topic branch off of master, commit,
and merge the topic into next. Users can check out next to play with all
the latest goodies. If a topic branch has problems, I add bugfix commits
to it, and re-merge into next. Once it seems stable, I merge it into
master. (Branching topic branches from master is necessary in order to
be able to merge them into master without pulling everything else that's
in next.)

So this is nice, because I can pick and choose which features to have in
master, more or less independently of each other. The one thing I
haven't been able to figure out is this:

Sometimes those topic branches are remote branches on someone else's
repo. What happens when merging a remote topic branch into next creates
a conflict? Ideally I'd like for the topic branch author to deal with
resolving the conflict, and leave me to my carefree maintainer existence
of eating icecream on the couch. In the no-conflict case, I merge their
remote branch directly into my local next. But in the case of conflicts,
it seems like me only way to acquire their resolution is to merge their
next branch entirely into mine. Is that true?

Likewise, what happens when someone sends a patch against master to the
mailing list, and applying that patch to next creates a conflict? Is
there any way for them to resolve the conflict, and pass that resolution
to me?

Thanks for any help.
-- 
William <wmorgan-git@masanjin.net>
