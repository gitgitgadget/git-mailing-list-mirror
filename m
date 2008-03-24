From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [ANNOUNCE] Stacked GIT 0.14.2
Date: Mon, 24 Mar 2008 19:39:52 -0400
Message-ID: <20080324233952.GD32221@josefsipek.net>
References: <b0943d9e0803241259s5280cdc1o255a4412b3fa7bfc@mail.gmail.com> <alpine.LNX.1.10.0803242113070.9368@fbirervta.pbzchgretzou.qr> <b0943d9e0803241624ne83602emc1fb4727402555d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Engelhardt <jengelh@computergmbh.de>,
	git <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 00:40:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdwHd-0000y7-5n
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 00:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbYCXXj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 19:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbYCXXj6
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 19:39:58 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:43389 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbYCXXj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 19:39:57 -0400
Received: from josefsipek.net (baal.fsl.cs.sunysb.edu [130.245.126.78])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id m2ONdpjS013750;
	Mon, 24 Mar 2008 19:39:51 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id EC1531C00124; Mon, 24 Mar 2008 19:39:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <b0943d9e0803241624ne83602emc1fb4727402555d3@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78128>

On Mon, Mar 24, 2008 at 11:24:20PM +0000, Catalin Marinas wrote:
> On 24/03/2008, Jan Engelhardt <jengelh@computergmbh.de> wrote:
> > On Monday 2008-03-24 20:59, Catalin Marinas wrote:
> >
> >  > Stacked GIT 0.14.2 release is available from http://www.procode.org/stgit/.
> >  >
> >  > StGIT is a Python application providing similar functionality to Quilt
> >  > (i.e. pushing/popping patches to/from a stack) on top of GIT.
> >
> >
> > I always wondered what the difference between stgit and guilt is.
> >  Does anyone have a comparison up?
> 
> There was a thread last year:
> 
> http://kerneltrap.org/mailarchive/git/2007/6/14/249310
> 
> I don't follow the guilt development to be able to comment. They are
> pretty similar regarding patch management but it's probably best to
> try both and see which tool you like. StGIT might have a few more
> features as it was around for longer (e-mail templates, patch
> synchronisation between branches etc.) but guilt seems actively
> developed as well.
 
Right. Try both and use whatever you're happier with.

> I might be wrong here but I'm not sure whether guilt uses three-way
> merging when pushing a patch or just a two-way diff apply. The
> three-way merging has several advantages in dealing with conflicts.

It's still using two-way diff apply, but I'd like to implement a three-way
merge as a fallback.

Josef 'Jeff' Sipek.

-- 
The box said "Windows XP or better required". So I installed Linux.
