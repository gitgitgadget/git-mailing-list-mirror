From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: rebasing trouble
Date: Thu, 29 Jun 2006 16:22:34 -0400
Message-ID: <20060629202234.GE14287@fieldses.org>
References: <20060629194723.GD14287@fieldses.org> <7vd5crranq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 22:23:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw327-0003Bx-DA
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 22:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWF2UWg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 16:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWF2UWg
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 16:22:36 -0400
Received: from mail.fieldses.org ([66.93.2.214]:27037 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932380AbWF2UWf
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 16:22:35 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1Fw322-00080a-8F; Thu, 29 Jun 2006 16:22:34 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5crranq.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22901>

On Thu, Jun 29, 2006 at 01:04:25PM -0700, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > I must be missing something obvious:
> >
> > bfields@puzzle:linux-2.6$ git checkout -b TMP nfs-client-stable^^^
> > bfields@puzzle:linux-2.6$ git-describe
> > v2.6.17-rc6-g28df955
> > bfields@puzzle:linux-2.6$ git-rebase --onto v2.6.17 origin
> > Nothing to do.
> > bfields@puzzle:linux-2.6$ git-describe
> > v2.6.17
> >
> > So the git-rebase just reset TMP to v2.6.17.  But I know that nfs-client-stable
> > isn't a subset of origin, so this doesn't make sense to me.
> >
> > The tree in question is actually at git://linux-nfs.org/~bfields/linux.git, if
> > it matters.
> 
> It matters of course.  Where is the "origin"?

I realized after I sent that that "origin" in that public repository actually
isn't the same as "origin" in the local repo that I'm working on.  So I just
ran a GIT_DIR=. git-fetch there, and now both branches agree.

--b.
