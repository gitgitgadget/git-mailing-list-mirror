From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deprecation/Removal schedule
Date: Tue, 6 Feb 2007 16:33:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702061632180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net> <45C896F3.5000007@op5.se>
 <81b0412b0702060726o17cd3521u633a6c4deb07b9d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 06 16:33:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HESK5-0007Sj-26
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 16:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbXBFPda (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 10:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbXBFPda
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 10:33:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:35332 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932518AbXBFPd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 10:33:29 -0500
Received: (qmail invoked by alias); 06 Feb 2007 15:33:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 06 Feb 2007 16:33:28 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0702060726o17cd3521u633a6c4deb07b9d3@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38850>

Hi,

On Tue, 6 Feb 2007, Alex Riesen wrote:

> On 2/6/07, Andreas Ericsson <ae@op5.se> wrote:
> > Junio C Hamano wrote:
> > >
> > > * git-lost-found
> > >
> > >   Although it has served us well, I think it is about to outlive
> > >   its usefulness, thanks to the recent "reflog by default"
> > >   change.
> > >
> > 
> > Nonono. Please no. This has saved me more times than I can even care
> > to remember. Especially whenever I'm teaching newcomers how to git.
> > I really wouldn't want to not have it there in case its needed and
> > some schmuck upgrades git and then loses something vital because he
> > forgot to enable the reflog on an old repo.
> 
> It's functionality is superseded by "git fsck --unreachable",
> see this discussion.

AFAICT lost-and-found _connects_ the objects to files, and as such is 
easier to browse after running the command (which is expensive).

If you _have_ to lose lost-and-found, why not resurrect the functionality 
as an option to fsck?

Ciao,
Dscho
