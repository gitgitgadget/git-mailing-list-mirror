From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 16:15:13 -0400
Message-ID: <426AACD1.2090608@pobox.com>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>  <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>  <426A4669.7080500@ppp0.net>  <1114266083.3419.40.camel@localhost.localdomain>  <426A5BFC.1020507@ppp0.net> <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 22:11:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPQy9-00041G-GH
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 22:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVDWUPw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 16:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVDWUPw
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 16:15:52 -0400
Received: from 216-237-124-58.infortech.net ([216.237.124.58]:58050 "EHLO
	mail.dvmed.net") by vger.kernel.org with ESMTP id S261768AbVDWUP3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 16:15:29 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.50 #1 (Red Hat Linux))
	id 1DPR24-0002bo-20; Sat, 23 Apr 2005 20:15:17 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> That was my plan, at least. But I haven't set up any signature generation
> thing, and this really isn't my area of expertise any more. But my _plan_ 
> literally was to have the tag object look a lot like a commit object, but 
> instead of pointing to the tree and the commit parents, it would point to 
> the commit you are tagging. Somehting like
> 
> 	commit a2755a80f40e5794ddc20e00f781af9d6320fafb
> 	tag v2.6.12-rc3
> 	signer Linus Torvalds
> 
> 	This is my official original 2.6.12-rc2 release
> 
> 	-----BEGIN PGP SIGNATURE-----
> 	....
> 	-----END PGP SIGNATURE-----

> with a few fixed headers and then a place for free-form commentary, 

groovy



> If somebody writes a script to generate the above kind of thing (and tells 
> me how to validate it), I'll do the rest, and start tagging things 
> properly. Oh, and make sure the above sounds sane (ie if somebody has a 
> better idea for how to more easily identify how to find the public key to 
> check against, please speak up).

[tangent]

Any chance you'll have a tree tagged with older releases?
Is someone with access to BK working on that?

I do a lot of patch merges where someone sends me a 2.6.10 patch. 
Presuming the fix is still valid, I'll clone to 2.6.10, merge the patch, 
pull 2.6.latest into the 2.6.10-based repo, then push the whole she-bang 
into one of my for-upstream repos.

	Jeff


