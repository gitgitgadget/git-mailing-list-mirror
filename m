From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: sparse fetch, was Re: [PATCH 08/12] git-clone: support --path
 to do sparse clone
Date: Fri, 25 Jul 2008 02:09:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807250208460.4140@eeepc-johanness>
References: <20080723145718.GA29134@laptop> <20080724171952.GB21043@sigill.intra.peff.net> <alpine.DEB.1.00.0807241837441.8986@racer> <20080724182813.GA21186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 25 02:09:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMAsB-00058R-QT
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 02:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbYGYAI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 20:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbYGYAI1
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 20:08:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:34795 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752224AbYGYAI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 20:08:27 -0400
Received: (qmail invoked by alias); 25 Jul 2008 00:08:25 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp061) with SMTP; 25 Jul 2008 02:08:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+98odLbAa9jjhucAJF02atqf9WK98yTeDdFjhf/R
	w9GO7KUP8bl74U
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080724182813.GA21186@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89980>

Hi,

On Thu, 24 Jul 2008, Jeff King wrote:

> On Thu, Jul 24, 2008 at 06:41:03PM +0100, Johannes Schindelin wrote:
> 
> > > As a user, I would expect "sparse clone" to also be sparse on the 
> > > fetching. That is, to not even bother fetching tree objects that we 
> > > are not going to check out. But that is a whole other can of worms 
> > > from local sparseness, so I think it is worth saving for a different 
> > > series.
> > 
> > I think this is not even worth of a series.  Sure, it would have 
> > benefits for those who want sparse checkouts.  But it comes for a high 
> > price on everyone else:
> 
> I agree there are a lot of issues. I am just thinking of the person who 
> said they had a >100G repository. But I am also not volunteering to do 
> it, so I will let somebody who really cares about it try to defend the 
> idea.

I never said that there were no benefits.  I argued that there are too 
many _downsides_ to those who _don't_ benefit.

Ciao,
Dscho
