From: Greg KH <greg@kroah.com>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 23:20:45 -0700
Message-ID: <20050623062045.GA11638@kroah.com>
References: <42B9FCAE.1000607@pobox.com> <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org> <42BA14B8.2020609@pobox.com> <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org> <42BA1B68.9040505@pobox.com> <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org> <42BA271F.6080505@pobox.com> <Pine.LNX.4.58.0506222014000.11175@ppc970.osdl.org> <42BA45B1.7060207@pobox.com> <Pine.LNX.4.58.0506222225010.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 08:27:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlLB1-00055J-H8
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 08:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVFWG2e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 02:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVFWGXa
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 02:23:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:18827 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262363AbVFWGUy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 02:20:54 -0400
Received: from [192.168.0.10] (c-24-22-112-187.hsd1.or.comcast.net [24.22.112.187])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j5N6Koi12264;
	Wed, 22 Jun 2005 23:20:50 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DlL4v-33F-00; Wed, 22 Jun 2005 23:20:45 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506222225010.11175@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 22, 2005 at 10:58:13PM -0700, Linus Torvalds wrote:
> And I suggested that if you want that, then you pull on the TAG. You take 
> my modification, you test it, and you see if
> 
> 	git fetch tag ..repo.. tagname
> 
> works.

Hm, that doesn't work right now.  Both:
  git fetch rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.12.y.git tag v2.6.12.1
or
  git fetch tag rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.12.y.git v2.6.12.1

die.  Or am I just trying to take a point you were making about not
pulling all tags (which I can live with, just was not aware it was this
way, and I agree that it does offer up a lot of possiblities of me using
local tags in the future), and taking it literally?

thanks,

greg k-h
