From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to remove a specific hunk
Date: Fri, 26 Oct 2007 19:19:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710261917270.4362@racer.site>
References: <4722036E.5030204@wanadoo.fr> <472207AA.8030100@op5.se>
 <47220A05.4040705@wanadoo.fr> <2669F76D-6FF2-4CCF-9337-639D84EE65E8@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pascal Obry <pascal.obry@wanadoo.fr>,
	git list <git@vger.kernel.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Fri Oct 26 20:20:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlTnU-0005fV-Sl
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 20:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760288AbXJZSUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 14:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759406AbXJZSUI
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 14:20:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:59560 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760121AbXJZSUG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 14:20:06 -0400
Received: (qmail invoked by alias); 26 Oct 2007 18:20:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 26 Oct 2007 20:20:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19VsyxFDuxV50zuMhnkQWnZ2Ih3Y1gs/Huhanis2I
	pLHM/5GsmoIVqU
X-X-Sender: gene099@racer.site
In-Reply-To: <2669F76D-6FF2-4CCF-9337-639D84EE65E8@lrde.epita.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62435>

Hi,

On Fri, 26 Oct 2007, Benoit SIGOURE wrote:

> On Oct 26, 2007, at 5:38 PM, Pascal Obry wrote:
> 
> > Andreas,
> > 
> > > Once you've added the other two hunks, they'll no longer show up in
> > > git-diff, so you can do something like this:
> > > 
> > > $ git-add -i; # add the other two hunks to commit
> > > $ git-diff > middle-hunk.patch
> > > $ git-apply -R middle-hunk.patch
> > > test, test, test
> > > $ git-apply middle-hunk.patch
> > 
> > Thanks, this will clearly work. I was expecting something more
> > integrated like a "git reset --interactive" or something like that :)
> 
> That'd be great!  :)

I skipped over the beginnings of this thread because of time constraints, 
but would "git reset HEAD^ && git add -i" not helped you?  git add -i 
allows you to stage hunks, so by just _not_ staging _that_ hunk but 
everything else, should have worked for you, right?

There's also git-gui which does all that graphically for you (remember the 
right mouse button).

Ciao,
Dscho
