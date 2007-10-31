From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Recording merges after repo conversion
Date: Wed, 31 Oct 2007 13:43:17 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710311340500.4362@racer.site>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
 <Pine.LNX.4.62.0710311048450.13264@perkele.intern.softwolves.pp.se>
 <Pine.LNX.4.64.0710311059020.4362@racer.site> <200710311343.58414.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Peter Karlsson <peter@softwolves.pp.se>,
	Lars Hjemli <hjemli@gmail.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 14:44:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InDrp-0007QZ-8n
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 14:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756615AbXJaNoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 09:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756532AbXJaNoB
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 09:44:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:37854 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755020AbXJaNoB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 09:44:01 -0400
Received: (qmail invoked by alias); 31 Oct 2007 13:43:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 31 Oct 2007 14:43:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rUfwzShor9UD47JEUQJtja3lhn7HqAUI+YVdYP2
	/x10/VNiAJVhsU
X-X-Sender: gene099@racer.site
In-Reply-To: <200710311343.58414.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62828>

Hi,

On Wed, 31 Oct 2007, Johan Herland wrote:

> On Wednesday 31 October 2007, Johannes Schindelin wrote:
> 
> > On Wed, 31 Oct 2007, Peter Karlsson wrote:
> > 
> > > Johannes Schindelin:
> > > 
> > > > Why should it?  This would contradict the whole "a commit sha1 
> > > > hashes the commit, and by inference the _whole_ history" 
> > > > principle.
> > > 
> > > Does it?
> > 
> > Yes!  Of course!  If what you want becomes possible, I could make an 
> > evil change in history long gone, and slip it by you.  You could not 
> > even see the history which changed.
> 
> Well, technically, if the grafts file was part of the repo, you wouldn't 
> be able to change the (in-tree) grafts file without affecting the SHA1 
> of HEAD. In other words, given a commit SHA1 sum, you can be sure that 
> someone else who checks out the same commit (and has no local 
> modification to their grafts file) will see exactly the same history as 
> you do.

All this does not change the fact that installing a graft and 'git gc 
--prune'ing gets rid of the old history.  D'oh.

Automatically installing grafts is wrong.

Ciao,
Dscho
