From: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Wed, 20 Apr 2005 22:29:30 -0700
Message-ID: <20050421052930.GA27477@kroah.com>
References: <20050420205633.GC19112@pasky.ji.cz> <20050420211919.GA20129@kroah.com> <20050420215117.GJ19112@pasky.ji.cz> <Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org> <20050420222815.GM19112@pasky.ji.cz> <Pine.LNX.4.58.0504201710500.2344@ppc970.osdl.org> <Pine.LNX.4.58.0504201809170.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 07:25:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOUCI-0003Xt-0t
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 07:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVDUFaK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 01:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVDUFaK
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 01:30:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:18877 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261224AbVDUFaF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 01:30:05 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3L5Txi17286;
	Wed, 20 Apr 2005 22:29:59 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DOUFn-7gl-00; Wed, 20 Apr 2005 22:29:31 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504201809170.2344@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2005 at 06:12:34PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 20 Apr 2005, Linus Torvalds wrote:
> > 
> > Pasky,
> >  what do you think about this change to "git log"?
> 
> Here's a slightly updated version.
> 
> It's identical to the previous one, except that it also feeds the result 
> through "| ${PAGER:-less}" which makes it a lot more useful, in my 
> opinion.

Yeah!

I've gotten tired of counting how many times I forgot to pipe 'git log'
to less already.  Doesn't seem to want to be canceled either...

thanks for doing this.

greg k-h
