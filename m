From: Jens Axboe <axboe@suse.de>
Subject: Re: git merging
Date: Tue, 21 Jun 2005 16:59:20 +0200
Message-ID: <20050621145919.GB12271@suse.de>
References: <20050617183914.GX6957@suse.de> <Pine.LNX.4.58.0506171142500.2268@ppc970.osdl.org> <42B357D7.6030302@pobox.com> <Pine.LNX.4.58.0506171629320.2268@ppc970.osdl.org> <42B36207.3020209@pobox.com> <Pine.LNX.4.58.0506171700200.2268@ppc970.osdl.org> <20050620123053.GI15021@suse.de> <Pine.LNX.4.58.0506200844420.2268@ppc970.osdl.org> <20050620203821.GC7712@suse.de> <Pine.LNX.4.58.0506201410050.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 16:53:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dkk6l-0002dZ-C3
	for gcvg-git@gmane.org; Tue, 21 Jun 2005 16:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVFUO6M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Jun 2005 10:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVFUO6M
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jun 2005 10:58:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17592 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261980AbVFUO6J (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2005 10:58:09 -0400
Received: from [62.242.22.158] (helo=router.home.kernel.dk)
	by virtualhost.dk with esmtp (Exim 3.36 #1)
	id 1DkkCL-0003gi-00; Tue, 21 Jun 2005 16:57:57 +0200
Received: from nelson.home.kernel.dk ([192.168.0.33] helo=kernel.dk)
	by router.home.kernel.dk with esmtp (Exim 4.22)
	id 1DkkCJ-0007zc-OE; Tue, 21 Jun 2005 16:57:55 +0200
Received: by kernel.dk (Postfix, from userid 1000)
	id 0EEF31E0E9; Tue, 21 Jun 2005 16:59:20 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506201410050.2268@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 20 2005, Linus Torvalds wrote:
> 
> 
> On Mon, 20 Jun 2005, Jens Axboe wrote:
> > 
> > I pulled with rsync manually from kernel.org, and that did fix things up
> > for me. The main tree is rsync'ed, but the development tree gets the
> > changes with /opt/kernel/git/linux-2.6/.git/ as the url given to
> > git-pull-script.
> 
> Ok, that explains it. Since you're using a regular local filename, the
> pull will be using "git-local-pull", which will only fetch the objects
> directly needed. And doesn't understand the tag-to-tree thing, so doesn't 
> fetch the tree (or possibly you just copied the tags by hand totally 
> outside of the regular pull?)

Isn't that a little 'end user' confusing from a usability point of view,
that it behaves differently depending on which pull script it ends up
using in the end?

I guess I can just always use rsync even for local trees. And use it
directly, so I always have everything :)

-- 
Jens Axboe

