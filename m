From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git-svn tags and branches
Date: Thu, 30 Aug 2007 14:25:14 +0200
Message-ID: <20070830122514.GF5050@xp.machine.xx>
References: <faulrb$483$1@sea.gmane.org> <20070830102115.GA17620@muzzle> <cb7bb73a0708300444q73e12d72o665a8266c2a90f61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 14:26:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQj5t-0000Qu-39
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 14:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbXH3MZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 08:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219AbXH3MZs
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 08:25:48 -0400
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:36104 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752929AbXH3MZs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Aug 2007 08:25:48 -0400
Received: (qmail 32313 invoked by uid 0); 30 Aug 2007 12:25:45 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 30 Aug 2007 12:25:45 -0000
Mail-Followup-To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <cb7bb73a0708300444q73e12d72o665a8266c2a90f61@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57034>

On Thu, Aug 30, 2007 at 01:44:35PM +0200, Giuseppe Bilotta wrote:
> On 8/30/07, Eric Wong <normalperson@yhbt.net> wrote:
> > As noted by other repliers, SVN tags can be moving targets just like
> > branches, and are treated as such by git-svn.
> >
> > I should note that tags in git can actually be updated like a branch
> > just the same way, too, it's just not as easy to "accidentally" do.
> >
> > So I'll add the ability to modify refs under the refs/tags/ namespace to
> > my git-svn TODO list (which is getting rather large).  I also plan to
> > support branches outside of the refs/remotes/ namespace so it's easier
> > to use (clone, browse from gitweb) from bare repositories.
> 
> Thank you very much, that would be very appreciated.
> 
> While we're at it: could you consider putting the svn-imported refs
> not directly under remote? something like refs/remote/svn would be
> rather cleaner.
> 

Did you have a look at the --prefix option mentioned in the manpage? I
think it does what you want.

-Peter
