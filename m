From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Mon, 23 Jul 2007 00:37:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707230033310.14781@racer.site>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222223460.14781@racer.site>
 <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222255010.14781@racer.site>
 <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk>
 <f80mbc$si1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 01:37:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICkzL-00084a-Qx
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 01:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbXGVXhS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 19:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbXGVXhS
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 19:37:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:60580 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765629AbXGVXhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 19:37:16 -0400
Received: (qmail invoked by alias); 22 Jul 2007 23:37:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 23 Jul 2007 01:37:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hI/o5kY9hT3NOovEg/oD3yY9UZW/J2GpSBKhHj6
	puxBAu4bZKg654
X-X-Sender: gene099@racer.site
In-Reply-To: <f80mbc$si1$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53368>

Hi,

[re Cc'ed Julian]

On Mon, 23 Jul 2007, Jakub Narebski wrote:

> Julian Phillips wrote:
> 
> > I just think that to a user it feels like a checkout operation ... and 
> > that would less confusing as an option to checkout. ?Trying to explain 
> > that branch just creates a new branch, unless you give this option 
> > then it creates a working copy over there seems more compilcated than 
> > saying the checkout updates/creates this working copy, unless you use 
> > this option to create one over there.
> 
> IMVHO git-checkout is characterized that it changes _current_ working 
> directory.

Actually, the name suggests that the important action is "checkout", so I 
agree with Julian here.

> But having this in git-checkout would mean that you can create new 
> workdir for _existing_ branch. git-branch is rather (except from 
> listing) for creating new branches.

Note that it is possible to checkout the current branch with "git checkout 
HEAD".  Indeed, you can get the same effect with "git checkout -f HEAD" as 
with "git reset --hard" AFAIK.

> It is a fact that functionalities of git-checkout (-b) and git-branch
> (--new-work-dir) intersect a bit.

Yes, I pointed that out, too.  But we're not Python, so we do not have to 
pretend that it is a bad thing to have several way to do the same.  Which 
allows us better to cater for user's expectations.

Ciao,
Dscho
