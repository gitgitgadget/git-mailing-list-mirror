From: Greg KH <greg@kroah.com>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 16:26:08 -0700
Message-ID: <20050418232607.GA20907@kroah.com>
References: <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org> <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org> <20050418150456.GC12750@kroah.com> <Pine.LNX.4.58.0504180840370.7211@ppc970.osdl.org> <20050418220541.GB19744@kroah.com> <20050418221407.GA20290@kroah.com> <Pine.LNX.4.58.0504181613490.15725@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russell King <rmk@arm.linux.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 01:23:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNfaC-0006rE-7i
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 01:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVDRX0x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 19:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVDRX0x
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 19:26:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:40625 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261197AbVDRX0k (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 19:26:40 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3INQTi03499;
	Mon, 18 Apr 2005 16:26:29 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DNfd2-5Sp-00; Mon, 18 Apr 2005 16:26:08 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504181613490.15725@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2005 at 04:16:45PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 18 Apr 2005, Greg KH wrote:
> > 
> > Anyway, I try it this way and get:
> 
> You should update to the newest version anyway..
> 
> > $ dotest ~/linux/patches/usb/usb-visor-tapwave_zodiac.patch             
> > 
> > Applying USB: visor Tapwave Zodiac support patch
> > 
> > fatal: preparing to update file 'drivers/usb/serial/visor.c' not uptodate in cache
> > 
> > What did I forget to do?
> 
> The most common reason is that the scripts _really_ want the index to 
> match your current tree exactly. Run "update-cache --refresh". And if you 
> have any uncommitted information, make sure to commit it first.

Ah, that was the step I was missing, thanks, it's working now.

greg k-h
