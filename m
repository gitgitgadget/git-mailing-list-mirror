From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 07/13] Add a config option for remotes to specify a
 foreign vcs
Date: Wed, 5 Aug 2009 17:46:51 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908051724120.2147@iabervon.org>
References: <alpine.LNX.2.00.0908050055500.2147@iabervon.org> <alpine.DEB.1.00.0908052251430.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051658530.2147@iabervon.org> <alpine.DEB.1.00.0908052319210.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:47:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYoK3-0004bZ-0f
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 23:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbZHEVqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 17:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbZHEVqv
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 17:46:51 -0400
Received: from iabervon.org ([66.92.72.58]:49339 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbZHEVqu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 17:46:50 -0400
Received: (qmail 21864 invoked by uid 1000); 5 Aug 2009 21:46:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 21:46:51 -0000
In-Reply-To: <alpine.DEB.1.00.0908052319210.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124998>

On Wed, 5 Aug 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Wed, 5 Aug 2009, Daniel Barkalow wrote:
> 
> > On Wed, 5 Aug 2009, Johannes Schindelin wrote:
> > 
> > > On Wed, 5 Aug 2009, Daniel Barkalow wrote:
> > > 
> > > > If this is set, the url is not required, and the transport always 
> > > > uses a helper named "git-remote-<value>".
> > > 
> > > I wonder what's wrong with saying "git config remote.origin.url p4:" 
> > > instead of having two different code paths that do essentially the 
> > > same.
> > 
> > I believe some cases will want to use a URL which is "http://something" 
> > and have some other option cause the code to use "git helper-svn".
> 
> I actually would rather have "svn-http://something" because it tells me 
> right away and in red letters what is happening.

I think it's much more useful to have the URL that git uses for a 
subversion repo be identical to the URL that svn uses for the same repo.

Of course, users should also be able to use something like 
"svn-http://something" or "svn:http://something", but I think we'd get a 
lot of confusion if we don't support a remote.*.url of exactly what a 
svn-using project webpage says their repo url is.

	-Daniel
*This .sig left intentionally blank*
