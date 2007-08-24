From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Fri, 24 Aug 2007 11:55:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708241154410.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi>
 <20070823203246.GB3516@steel.home> <6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi>
 <7v8x81s7d1.fsf@gitster.siamese.dyndns.org> <9B94A29F-AF61-46C0-8497-C7372DF73250@pp.inet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
X-From: git-owner@vger.kernel.org Fri Aug 24 11:55:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOVtM-00089m-LB
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 11:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762073AbXHXJzp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 05:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760816AbXHXJzp
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 05:55:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:57540 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758578AbXHXJzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 05:55:44 -0400
Received: (qmail invoked by alias); 24 Aug 2007 09:55:42 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp021) with SMTP; 24 Aug 2007 11:55:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zMmpVFSxzChguHIKRQjbLcKh4+9ckE0POVr2pfw
	4hhve6WPQp5AXV
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <9B94A29F-AF61-46C0-8497-C7372DF73250@pp.inet.fi>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56568>

Hi,

On Fri, 24 Aug 2007, V?in? J?rvel wrote:

> On Aug 24, 2007, at 10:46, Junio C Hamano wrote:
> 
> > V?in? J?rvel? <v@pp.inet.fi> writes:
> > 
> > > The way I see the flag used is: A user runs "git status", sees that
> > > there is too much untracked files and not enough scrollback, so he
> > > runs "git status --only-tracked" to filter the results.
> > 
> > Why?
> > 
> > Just set up .gitignore once then (1) you do not have to worry
> > about them ever again, and (2) you _will_ still be able to
> > notice if you accidentally added more cruft, or more
> > importantly, if you forgot to tell an important file to git.
> > 
> > I think the latter is more important point.  If you train a
> > naive user to use --only-tracked to ignore "Untracked" list, you
> > are doing him or her a great disservice.  Mistake to forget "git
> > add" a new file before commiting will bound to happen.
> 
> I also think that maintaining a proper .gitignore is imporant, and more
> productive than using --only-tracked instead. But when I have cruft that can't
> be put in .gitignore, or it would ignore files that are supposed to be shown
> and tracked, I use --only-tracked.

Would it not be better to imitate the "-x" and "-X" options of ls-files, 
then?  You could achieve the effect you desire by "git status -x \*" then.

Ciao,
Dscho
