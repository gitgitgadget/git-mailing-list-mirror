From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Wed, 31 Oct 2007 18:35:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710311823070.7357@iabervon.org>
References: <87d4uv3wh1.fsf@osv.gnss.ru> <20071031195702.GB24332@atjola.homenet>
 <874pg73u6h.fsf@osv.gnss.ru> <Pine.LNX.4.64.0710312111170.4362@racer.site>
 <20071031212923.GL4569@fieldses.org> <4728FC5C.30709@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 23:35:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InMAE-0006z4-TE
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 23:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbXJaWfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 18:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753750AbXJaWfl
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 18:35:41 -0400
Received: from iabervon.org ([66.92.72.58]:38635 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbXJaWfk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 18:35:40 -0400
Received: (qmail 17746 invoked by uid 1000); 31 Oct 2007 22:35:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Oct 2007 22:35:39 -0000
In-Reply-To: <4728FC5C.30709@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62892>

On Wed, 31 Oct 2007, Steven Grimm wrote:

> J. Bruce Fields wrote:
> > I ran into the same confusion as the original poster when starting to
> > use rebase, so I suspect it's common.
> >   
> 
> I've been using rebase just about every day for close to a year and it *still*
> annoys me when it happens. Especially the "Did you forget to git add?" part of
> the message. The thought that always goes through my head is, "No, Mr. Rebase,
> I did NOT forget to git add. I remembered to git add, then you were too stupid
> to do the right thing after that."
> 
> Just happened to me this morning, in fact: I had a quick hack in place to work
> around a bug, the bug got fixed for real, and I rebased. In the process of
> conflict resolution I saw that my workaround wasn't needed any more and
> accepted the upstream version of that particular part of the file. Ran git-add
> on it, then rebase --continue, and boom, was accused of forgetting to run
> git-add.
> 
> It is a minor annoyance and nowadays I just sigh a bit and run --skip instead,
> but it'd be nice if it didn't happen. I don't like having to care whether or
> not I happened to change other files in a particular commit after I resolve
> conflicts in one file in favor of the upstream version.

I think it's worth requiring you to say --skip in order to acknowledge 
that you won't have as many commits and you'll lose the commit message. On 
the other hand, the message should probably suggest that you might want to 
skip this commit instead of suggesting that you come up with some other 
change to include in it.

Certainly, if "git diff" returns no changes, "git add" is a bad 
suggestion, and it would be nicer to suggest something possibly correct.

	-Daniel
*This .sig left intentionally blank*
