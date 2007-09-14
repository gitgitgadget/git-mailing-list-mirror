From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove duplicate note about removing commits with
 git-filter-branch
Date: Fri, 14 Sep 2007 23:05:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709142305180.28586@racer.site>
References: <a1b6cb1b0709130857qf3ef0e9h5ad11ba57a1d495@mail.gmail.com>
 <7vk5qteqto.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: ulrik <ulrik.sverdrup@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 00:07:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJJ6-0003li-De
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745AbXINWGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 18:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756244AbXINWGc
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:06:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:41022 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753588AbXINWGc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:06:32 -0400
Received: (qmail invoked by alias); 14 Sep 2007 22:06:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 15 Sep 2007 00:06:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/SZB08fTvSRJnPsW2uNXDWeM+s/p01REHa4zY2fh
	KCnmME9E4xwjcq
X-X-Sender: gene099@racer.site
In-Reply-To: <7vk5qteqto.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58190>

Hi,

On Thu, 13 Sep 2007, Junio C Hamano wrote:

> ulrik <ulrik.sverdrup@gmail.com> writes:
> 
> > A duplicate of an already existing section in the documentation of
> > git-filter-branch was added in commit
> > f95eef15f2f8a336b9a42749f5458c841a5a5d63.
> > This patch removes that redundant section.
> >
> > Signed-off-by: Ulrik Sverdrup <ulrik.sverdrup@gmail.com>
> > ---
> >  Documentation/git-filter-branch.txt |    5 -----
> >  1 files changed, 0 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/git-filter-branch.txt
> > b/Documentation/git-filter-branch.txt
> > index 29bb8ce..c878ed3 100644
> > --- a/Documentation/git-filter-branch.txt
> > +++ b/Documentation/git-filter-branch.txt
> > @@ -220,11 +220,6 @@ git filter-branch --commit-filter '
> >  	fi' HEAD
> >  ------------------------------------------------------------------------------
> >
> > -Note that the changes introduced by the commits, and not reverted by
> > -subsequent commits, will still be in the rewritten branch. If you want
> > -to throw out _changes_ together with the commits, you should use the
> > -interactive mode of gitlink:git-rebase[1].
> > -
> >  The function 'skip_commits' is defined as follows:
> 
> Hmph, sharp eyes.  I suspect that this could have been my
> screwup.

Yep, I confirm this was my screwup.  Thanks for fixing this, Ulrik!

Ciao,
Dscho
