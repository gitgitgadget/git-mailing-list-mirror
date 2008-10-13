From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch: refuse to fetch into the current branch in a
 non-bare repository
Date: Mon, 13 Oct 2008 11:28:11 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810131050420.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vprm6iz6z.fsf@gitster.siamese.dyndns.org> <20081012184727.GE4856@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 13 11:22:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpJdW-0000iL-1r
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 11:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952AbYJMJVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 05:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755882AbYJMJVe
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 05:21:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:44615 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755814AbYJMJVe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 05:21:34 -0400
Received: (qmail invoked by alias); 13 Oct 2008 09:21:32 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 13 Oct 2008 11:21:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VFZMvqzqVEZ5wxKAOyeQwQMzhNxnLH0fihkfbZ0
	v42J9NUFENoHQ8
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081012184727.GE4856@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98098>

Hi,

On Sun, 12 Oct 2008, Shawn O. Pearce wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > Some confusing tutorials suggest that it would be a good idea to call
> > > something like this:
> > >
> > > 	git pull origin master:master
> > >
> > > While it might make sense to store what you want to merge, it typically
> > > is plain wrong.
> > 
> > I am somewhat confused.
> 
> The description is confusing, yes.  It should be about git fetch,
> not git pull.

However, it was a "git pull origin master:master" that was the issue.  
That's why I wrote it in the commit message.

> > This "confusion" has been there for very long time and (at least the 
> > scripted version of) git-pull/git-fetch pair has supported a 
> > workaround in the form of --update-head-ok option.

Good point.  I completely had forgotten about that feature.

> I think "git fetch url side:master" when master is the current branch 
> and we have omitted --update-head-ok is broken.  Specifically Dscho's 
> last hunk which adds this test.  The test fails on current master.

Thanks for testing; I ran out of my Git time budget yesterday.  Will send 
an updated patch as a reply to Daniel's reply.

Ciao,
Dscho
