From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/13] Add a config option for remotes to specify a
 foreign vcs
Date: Wed, 5 Aug 2009 23:53:20 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908052352110.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0908050055500.2147@iabervon.org> <alpine.DEB.1.00.0908052251430.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051658530.2147@iabervon.org> <alpine.DEB.1.00.0908052319210.8306@pacific.mpi-cbg.de>
 <alpine.LNX.2.00.0908051724120.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:53:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYoQT-0007Kb-34
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 23:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbZHEVw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 17:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752697AbZHEVwz
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 17:52:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:57603 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752744AbZHEVwz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 17:52:55 -0400
Received: (qmail invoked by alias); 05 Aug 2009 21:52:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp018) with SMTP; 05 Aug 2009 23:52:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PYI43DUEPhG1aD/Hkt06zTesjtk5qWh01OwE/Lv
	LfHyKoLflOiHuz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0908051724120.2147@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125002>

Hi,

On Wed, 5 Aug 2009, Daniel Barkalow wrote:

> On Wed, 5 Aug 2009, Johannes Schindelin wrote:
> 
> > Hi,
> > 
> > On Wed, 5 Aug 2009, Daniel Barkalow wrote:
> > 
> > > On Wed, 5 Aug 2009, Johannes Schindelin wrote:
> > > 
> > > > On Wed, 5 Aug 2009, Daniel Barkalow wrote:
> > > > 
> > > > > If this is set, the url is not required, and the transport always 
> > > > > uses a helper named "git-remote-<value>".
> > > > 
> > > > I wonder what's wrong with saying "git config remote.origin.url p4:" 
> > > > instead of having two different code paths that do essentially the 
> > > > same.
> > > 
> > > I believe some cases will want to use a URL which is "http://something" 
> > > and have some other option cause the code to use "git helper-svn".
> > 
> > I actually would rather have "svn-http://something" because it tells me 
> > right away and in red letters what is happening.
> 
> I think it's much more useful to have the URL that git uses for a 
> subversion repo be identical to the URL that svn uses for the same repo.
> 
> Of course, users should also be able to use something like 
> "svn-http://something" or "svn:http://something", but I think we'd get a 
> lot of confusion if we don't support a remote.*.url of exactly what a 
> svn-using project webpage says their repo url is.

And I will _constantly_ be confused when the URL looks the same for Git 
and for SVN repositories.

Adding another config option to specify which helper processes the URL is 
not helping me in any way.  Rather the opposite.

Ciao,
Dscho
