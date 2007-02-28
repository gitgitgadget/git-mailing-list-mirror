From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: defaults for where to merge from
Date: Wed, 28 Feb 2007 16:46:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <es450f$d58$1@sea.gmane.org> <200702281522.14965.andyparkins@gmail.com>
 <Pine.LNX.4.64.0702281526270.15314@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Paolo Bonzini <bonzini@gnu.org>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Feb 28 16:46:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMR0m-0006h6-UN
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 16:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbXB1Pqf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 10:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbXB1Pqf
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 10:46:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:42322 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750817AbXB1Pqe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 10:46:34 -0500
Received: (qmail invoked by alias); 28 Feb 2007 15:46:33 -0000
X-Provags-ID: V01U2FsdGVkX1+pu5NYTFypN4GaccvB/VnL5Jz1NZNuWD11Nj8uB2
	dNWg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702281526270.15314@reaper.quantumfyre.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40947>

Hi,

On Wed, 28 Feb 2007, Julian Phillips wrote:

> On Wed, 28 Feb 2007, Andy Parkins wrote:
> 
> > On Wednesday 2007 February 28 14:53, Paolo Bonzini wrote:
> > > As can be seen from my other messages, I'm experimenting a little with
> > > git and trying to understand how its workflow compares with arch.  Right
> > > now, my procedure for branching off a remote archive is:
> > > 
> > >    git checkout -b branchname remote/upstreambranch
> > >    git config --add branch.branchname.remote remote
> > >    git config --add branch.branchname.merge refs/heads/upstreambranch
> > > 
> > > Is there a reason why "git branch" and "git checkout -b" should not
> > > automatically do the two "git-config --add"s when the source branch is
> > > remote?
> > 
> > I can see why that would be handy, but I often make short lived 
> > branches off a remote; and I wouldn't want my config cluttered up with 
> > branch defintions.
> 
> How about adding an option to tell checkout/branch that a tracking 
> branch is wanted (-t perhaps) - or perhaps a way to say that you don't 
> want to track the remote (depending on which is more popular)?

I don't think that you should be forced to do it explicitely. If you want 
to merge in another branch, you can do that _explicitely_. So, defaulting 
to what most people want anyway is A Good Thing.

Just my 2 cents,
Dscho
