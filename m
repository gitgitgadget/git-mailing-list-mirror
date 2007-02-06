From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deprecation/Removal schedule
Date: Tue, 6 Feb 2007 11:45:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702061144430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>  <eq6tj6$80m$2@sea.gmane.org>
  <81b0412b0702050750m5760ce61le34acc8adfdb8081@mail.gmail.com> 
 <20070205194508.GD8409@spearce.org>  <81b0412b0702051449l3951ee43s34bde4614c83612d@mail.gmail.com>
  <20070205225505.GA9222@spearce.org> <81b0412b0702060220l3887624ax762e5cba3f75fd0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 06 11:45:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HENpO-0006Xf-A1
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 11:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbXBFKp0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 05:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbXBFKp0
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 05:45:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:52709 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752011AbXBFKp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 05:45:26 -0500
Received: (qmail invoked by alias); 06 Feb 2007 10:45:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 06 Feb 2007 11:45:24 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0702060220l3887624ax762e5cba3f75fd0c@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38832>

Hi,

On Tue, 6 Feb 2007, Alex Riesen wrote:

> On 2/5/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Alex Riesen <raa.lkml@gmail.com> wrote:
> > > On 2/5/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > > >I use it daily.  Mainly `git log origin/master@{1}..origin/master`
> > > >to see what has come in from Junio since my last fetch.  The @{n}
> > > >syntax has (for me) been one of its best features.  (Thanks Junio!)
> > >
> > > It looks and smells like a useful feature. I just haven't found
> > > any use for it yet. Besides all the good, it's another part of a repo
> > > needing maintenance (constantly growing thing, like /var/log).
> > 
> > `git gc` is your friend.  It automatically trims the reflogs, keeping
> > only the last 90 days worth of entries.  You can tune this with the
> > `gc.reflogexpire` configuration parameter.
> 
> git gc (repack -d of it) is too dangerous in a shared repo: it breaks
> the repos which depend on the master repository, have sent (by some
> means) some objects over to the master, and accidentally removed
> the reference, and were pruned afterwards.

We no longer call git-prune automatically in git-gc. You have to say 
"git-gc --prune" to trigger that behaviour.

Happy?

Ciao,
Dscho
