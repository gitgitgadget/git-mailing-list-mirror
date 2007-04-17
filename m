From: Peter Baumann <peter.baumann@gmail.com>
Subject: Re: Any objectsions to enhancing git-log to show tags/branch heads?
Date: Tue, 17 Apr 2007 07:07:04 +0200
Message-ID: <20070417050704.GA19925@xp.machine.xx>
References: <E1HdQah-0008Q2-7E@candygram.thunk.org> <20070416181352.GB29569@xp.machine.xx> <20070416182749.GG23764@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 07:07:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdfuw-0003rF-7S
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 07:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031092AbXDQFHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 01:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753990AbXDQFHH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 01:07:07 -0400
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:54096 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1753975AbXDQFHF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2007 01:07:05 -0400
Received: (qmail 31197 invoked by uid 0); 17 Apr 2007 05:07:03 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 17 Apr 2007 05:07:03 -0000
Mail-Followup-To: "J. Bruce Fields" <bfields@fieldses.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070416182749.GG23764@fieldses.org>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44729>

On Mon, Apr 16, 2007 at 02:27:49PM -0400, J. Bruce Fields wrote:
> On Mon, Apr 16, 2007 at 08:13:52PM +0200, Peter Baumann wrote:
> > I'll do this gitk jump very often, too. Just to get the big picture where my
> > branches are (inside the commit graph). As they stay normaly on the tip, I
> > exit gitk long before it reached the root commit. What I'd like to have is
> > something which shows me _visually_ the the branches, e.g.
> > 
> > master
> > | next			commit comment for next
> > o  |		commit comment for master~1
> > |  o			commit comment for next~1
> > o  |	[ ... guess whats next :-)		you get the idea ...]
> > |  o
> > |  |
> > o /
> > |
> 
> git show-branch?
> 
> --b.

No. git-show-branch produces output like the snippet below, which is totally
non obious to me. Yes, I could figure out what it means, but why the hell
_should_ I if there are tools for which you have to look just for a second
on the ouput to _fully_ understand whats happening?

-Peter

xp:~/src/git (master)$ git show-branch
! [editpatch] Merge branch 'maint'
 * [master] Merge branch 'jc/index-output'
  ! [pu] Merge branch 'jc/diff' into pu
---
 -  [master] Merge branch 'jc/index-output'
 *  [master^2] git-read-tree --index-output=<file>
 *  [master^2^] _GIT_INDEX_OUTPUT: allow plumbing to output to an alternative index file.
 *  [master^^2] Makefile: Add '+' to QUIET_SUBDIR0 to fix parallel make.
 *  [master~2^2] git-bisect: allow bisecting with only one bad commit.
 *  [master~2^2^] t6030: add a bit more tests to git-bisect
 *  [master~2^2~2] git-bisect: moderni
...
