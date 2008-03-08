From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Fix dcommit, rebase when rewriteRoot is in use
Date: Sat, 8 Mar 2008 13:52:48 -0800
Message-ID: <20080308215248.GB30702@hand.yhbt.net>
References: <1205006470-18882-1-git-send-email-jgoerzen@complete.org> <7v3ar1sz8x.fsf@gitster.siamese.dyndns.org> <200803081528.21295.jgoerzen@complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Sat Mar 08 22:53:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY6yx-0004No-5X
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 22:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbYCHVwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 16:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbYCHVwv
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 16:52:51 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58798 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbYCHVwu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 16:52:50 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 6E4417F4153;
	Sat,  8 Mar 2008 13:52:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200803081528.21295.jgoerzen@complete.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76590>

John Goerzen <jgoerzen@complete.org> wrote:
> On Saturday 08 March 2008 3:05:18 pm Junio C Hamano wrote:
> > John Goerzen <jgoerzen@complete.org> writes:
> > > Problem described here:
> > >
> > > http://thread.gmane.org/gmane.comp.version-control.git/76561
> > >
> > > Signed-off-by: John Goerzen <jgoerzen@complete.org>

for the actual code, not the commit message:

Acked-by: Eric Wong <normalperson@yhbt.net>

> > While I am sure Eric and git-svn users would appreciate a fix, please do
> > not write a commit log message like this.
> >
> > Having a pointer to additional material is a very good practice, and will
> > be appreciated by the readers, but giving a pointer and nothing else means
> > that you are forcing your readers to hunt for out-of-line information.
> 
> Thanks for the note.  Some projects really hate long commit messages, and 
> some love them, and I wasn't sure what type of project this is.

We are the latter :)

One thing I've found with distributed VCS is that it's easier and
convenient to write very detailed commit messages as documentation so I
can go back and reference them easily.

Also, the commit messages are written in the heat of the moment so the
code is fresh in my mind rather than going back at the end and then
writing more documentation/comments later on.  With this synchronous
behavior, the commit message will always valid for that particular
changeset.

Probably due to my workflow, I've always found asynchronously maintained
code and documentation to be quite difficult and documentation always
dragged behind.

> Would you like me to rewrite and re-submit this, or are you editing and 
> committing?

I'd prefer it'd be straight from the patch author's mouth/fingers :)

Thanks John,

-- 
Eric Wong
