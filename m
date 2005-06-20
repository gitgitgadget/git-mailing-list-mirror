From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git merging
Date: Mon, 20 Jun 2005 14:15:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506201410050.2268@ppc970.osdl.org>
References: <20050617181156.GT6957@suse.de> <Pine.LNX.4.58.0506171132390.2268@ppc970.osdl.org>
 <20050617183914.GX6957@suse.de> <Pine.LNX.4.58.0506171142500.2268@ppc970.osdl.org>
 <42B357D7.6030302@pobox.com> <Pine.LNX.4.58.0506171629320.2268@ppc970.osdl.org>
 <42B36207.3020209@pobox.com> <Pine.LNX.4.58.0506171700200.2268@ppc970.osdl.org>
 <20050620123053.GI15021@suse.de> <Pine.LNX.4.58.0506200844420.2268@ppc970.osdl.org>
 <20050620203821.GC7712@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 23:30:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkTqQ-0007dj-Kx
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 23:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVFTVUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 17:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVFTVPp
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 17:15:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23693 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261609AbVFTVPR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2005 17:15:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5KLDrjA006547
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 20 Jun 2005 14:13:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5KLDqhM020175;
	Mon, 20 Jun 2005 14:13:53 -0700
To: Jens Axboe <axboe@suse.de>
In-Reply-To: <20050620203821.GC7712@suse.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 20 Jun 2005, Jens Axboe wrote:
> 
> I pulled with rsync manually from kernel.org, and that did fix things up
> for me. The main tree is rsync'ed, but the development tree gets the
> changes with /opt/kernel/git/linux-2.6/.git/ as the url given to
> git-pull-script.

Ok, that explains it. Since you're using a regular local filename, the
pull will be using "git-local-pull", which will only fetch the objects
directly needed. And doesn't understand the tag-to-tree thing, so doesn't 
fetch the tree (or possibly you just copied the tags by hand totally 
outside of the regular pull?)

		Linus
