From: Greg KH <greg@kroah.com>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 15:05:41 -0700
Message-ID: <20050418220541.GB19744@kroah.com>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org> <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org> <20050418150456.GC12750@kroah.com> <Pine.LNX.4.58.0504180840370.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russell King <rmk@arm.linux.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 00:03:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNeKL-0006iG-0I
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 00:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVDRWGl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 18:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVDRWGl
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 18:06:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:18057 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261182AbVDRWGj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 18:06:39 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3IM62i21879;
	Mon, 18 Apr 2005 15:06:02 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DNeNB-5Fd-00; Mon, 18 Apr 2005 15:05:41 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504180840370.7211@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2005 at 08:42:14AM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 18 Apr 2005, Greg KH wrote:
> >
> > On Sun, Apr 17, 2005 at 04:24:24PM -0700, Linus Torvalds wrote:
> > > 
> > > Tools absolutely matter. And it will take time for us to build up that 
> > > kind of helper infrastructure. So being newbie might be part of it, but 
> > > it's the smaller part, I say. Rough interfaces is a big issue.
> > 
> > Speaking of tools, you had a "dotest" program to apply patches in email
> > form to a bk tree.  And from what I can gather, you've changed that to
> > handle git archives, right?
> 
> Yup.
> 
> It's a git archive at 
> 
> 	kernel.org:/pub/linux/kernel/people/torvalds/git-tools.git
> 
> and it seems to work. It's what I've used for all the kernel patches 
> (except for the merge), and it's what I use for the git stuff that shows 
> up as authored by others.

Hm, have you pushed all of the recent changes public?  I get the
following when trying to apply a patch:
$ ../git-tools/dotest < ~/linux/patches/usb/usb-visor-tapwave_zodiac.patch 
 mailsplit <mbox> <directory>
$ 

I set my PATH to point to the git-tools/ directory:
$ which mailsplit
/home/greg/linux/git/git-tools/mailsplit

Any thoughts?

thanks,

greg k-h
