From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: Now What?
Date: Thu, 3 Nov 2005 09:38:40 +0100
Message-ID: <20051103083840.GA28300@ebar091.ebar.dtu.dk>
References: <E1EXTw5-00063o-Gt@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 09:59:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXawK-0004XU-2C
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 09:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVKCI7R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 03:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVKCI7R
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 03:59:17 -0500
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:24787 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S1751246AbVKCI7R
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 03:59:17 -0500
Received: (qmail 28427 invoked by uid 5842); 3 Nov 2005 08:38:40 -0000
To: Jon Loeliger <jdl@freescale.com>
Mail-Followup-To: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <E1EXTw5-00063o-Gt@jdl.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11070>

On Wed, Nov 02, 2005 at 07:30:37PM -0600, Jon Loeliger wrote:
...
> I think one of the most crucial aspects that needs to be
> covered well is the "Merge Failed" problem.  So, for starters,
> I'd like to get your suggestions on this particular issue.
> I know when I see the dreaded "merge by hand" message I
> often sit and stare, pondering "Now what?"

Here's one I've done too many times:

~/git/git-core]cat .git/remotes/origin
URL: git://git.kernel.org/pub/scm/git/git.git
Pull: master:origin

~/git/git-core]git-checkout maint
~/git/git-core]git pull
Unpacking 222 objects
 100% (222/222) done
* committish: 9534f40bc42dd826cc26c8c8c84f6a8a5fc569f6
  branch 'master' of git://git.kernel.org/pub/scm/git/git
* refs/heads/origin: storing branch 'master' of
* git://git.kernel.org/pub/scm/git/git
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Trying simple merge.
Simple merge failed, trying Automatic merge.
Auto-merging Documentation/tutorial.txt.
Auto-merging Makefile.
merge: warning: conflicts during merge
ERROR: Merge conflict in Makefile.
Auto-merging apply.c.
Auto-merging cache.h.
merge: warning: conflicts during merge
ERROR: Merge conflict in cache.h.
Auto-merging clone-pack.c.
Auto-merging connect.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in connect.c.
Auto-merging daemon.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in daemon.c.
Auto-merging debian/changelog.
merge: warning: conflicts during merge
ERROR: Merge conflict in debian/changelog.
Auto-merging fetch-pack.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in fetch-pack.c.
Auto-merging git-branch.sh.
Auto-merging git-checkout.sh.
Auto-merging git-clone.sh.
Auto-merging git-cvsimport.perl.
merge: warning: conflicts during merge
ERROR: Merge conflict in git-cvsimport.perl.
Auto-merging git-fetch.sh.
Auto-merging git-parse-remote.sh.
Auto-merging git-tag.sh.
Auto-merging quote.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in quote.c.
Auto-merging quote.h.
merge: warning: conflicts during merge
ERROR: Merge conflict in quote.h.
Auto-merging refs.c.
Auto-merging rev-list.c.
Auto-merging send-pack.c.
Auto-merging sha1_name.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in sha1_name.c.
Auto-merging upload-pack.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in upload-pack.c.
fatal: merge program failed
Automatic merge failed; fix up by hand

Indeed, what now?

Regards,

Peter
