From: Mike Galbraith <efault@gmx.de>
Subject: Re: pulling Already up-to-date linux-2.6 repo takes ~8 minutes?
Date: Thu, 18 Oct 2007 07:42:54 +0200
Message-ID: <1192686174.7390.23.camel@Homer.simpson.net>
References: <1192678865.20353.14.camel@Homer.simpson.net>
	 <20071018045001.GA14735@spearce.org>
	 <1192684150.7390.15.camel@Homer.simpson.net>
	 <1192685971.7390.21.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 07:43:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiOA1-0006T2-SN
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 07:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563AbXJRFm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 01:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbXJRFm7
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 01:42:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:53784 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751902AbXJRFm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 01:42:58 -0400
Received: (qmail invoked by alias); 18 Oct 2007 05:42:56 -0000
Received: from p54B5BA2B.dip0.t-ipconnect.de (EHLO [192.168.178.23]) [84.181.186.43]
  by mail.gmx.net (mp014) with SMTP; 18 Oct 2007 07:42:56 +0200
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX18cTesNvwUcHR/7++WMY0ehOyr+AOou2OostrLK0W
	Mje/UJGQwY8YZB
In-Reply-To: <1192685971.7390.21.camel@Homer.simpson.net>
X-Mailer: Evolution 2.8.2 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61482>

On Thu, 2007-10-18 at 07:39 +0200, Mike Galbraith wrote:
> On Thu, 2007-10-18 at 07:09 +0200, Mike Galbraith wrote:
> 
> > > I'd suggest making your life a little bit easier.  Consider creating
> > > a remote that points to Linus:
> > > 
> > >   $ git remote add linus git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> > >   $ git checkout -b master   ; # or any other branch
> > >   $ git config branch.master.remote linus
> > >   $ git config branch.master.merge refs/heads/master
> 
> Dang.  git was happy with everything above except the checkout -b
> master, so I can't get off the dangling limb I'm on, and onto a solid
> branch.

Pff.  -f.

Thanks, ~4 second pull is MUCH better :)

	-Mike
