From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] fix compare symlink against readlink not data
Date: Fri, 6 May 2005 10:19:51 -0700
Message-ID: <20050506171950.GA20132@kroah.com>
References: <20050506134501.GA11430@vrfy.org> <20050506160359.GB6904@kroah.com> <1115396614.32065.23.camel@localhost.localdomain> <20050506163603.GA17766@kroah.com> <Pine.LNX.4.58.0505061009340.2233@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 19:14:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU6O7-0003wQ-Pj
	for gcvg-git@gmane.org; Fri, 06 May 2005 19:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVEFRT7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 13:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVEFRT7
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 13:19:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:62103 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261218AbVEFRT4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 13:19:56 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j46HJoi06832;
	Fri, 6 May 2005 10:19:50 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DU6UR-5FS-00; Fri, 06 May 2005 10:19:51 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505061009340.2233@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2005 at 10:11:49AM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 6 May 2005, Greg KH wrote:
> > 
> > Odd.  If I reclone the whole tree from the udev kernel.org tree, then it
> > works just fine.  If I create a new copy of my local tree, I still have
> > the same problem.  Diffing the trees shows no difference in the objects
> > at all...
> 
> You've not updated your cache.
> 
> Guys, remember this command:
> 
> 	git-diff-files
> 
> Just like that, with no arguments. It shows you what is different in your 
> cache. If you get a lot of output, it means that your index file isn't 
> up-to-date.
> 
> The other magic command is
> 
> 	git-update-cache --refresh

Damm, I still was using update-cache and checkout-cache from an old git
version.  That was my problem.

Sorry for the noise, it works just fine.

thanks,

greg k-h
