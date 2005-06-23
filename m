From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 22:16:08 -0400
Message-ID: <42BA1B68.9040505@pobox.com>
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com> <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org> <42B9FCAE.1000607@pobox.com> <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org> <42BA14B8.2020609@pobox.com> <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 04:12:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlHCd-0007aB-Kv
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 04:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVFWCRm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 22:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVFWCRe
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 22:17:34 -0400
Received: from mail.dvmed.net ([216.237.124.58]:38577 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261977AbVFWCQM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 22:16:12 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DlHGF-0002v1-I0; Thu, 23 Jun 2005 02:16:11 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 22 Jun 2005, Jeff Garzik wrote:
> 
>>With BK, tags came with each pull.  With git, you have to go "outside 
>>the system" (rsync) just get the new tags.
> 
> 
> You don't have to use rsync, and you don't have to go outside the system. 
> That was my point: you can use "git-ssh-pull" to pull the tags.

OK, understood.


> But yes, you have to explicitly ask for them by name, ie the other side 
> has to let you know: "Oh, btw, I created a 'xyz' tag for you". And having 
> another helper script to hide the details of how git-*-pull handles tags 
> is obviously also a good idea, although it's pretty low on my list of 
> things to worry about.

The problem is still that nothing says "oh, btw, I created 'xyz' tag for 
you" AFAICS?

IMO the user (GregKH and me, at least) just wants to know their set of 
tags and heads is up-to-date on local disk.  Wants to know what tags are 
out there.  It's quite annoying when two data sets are out of sync 
(.git/objects and .git/refs/tags).

Asking for the tag by name isn't useful at all, in that regard, because 
that requires that the user already know what tags are available.  To 
get that info, one must use rsync, gitweb, or a subscription to Psychic 
Friends Network.

	Jeff


