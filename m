From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] provide better committer information to commit-tree.c
Date: Mon, 18 Apr 2005 19:51:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504181949540.15725@ppc970.osdl.org>
References: <20050419001126.GB21170@kroah.com> <Pine.LNX.4.58.0504181730130.15725@ppc970.osdl.org>
 <20050419004548.GA21623@kroah.com> <20050419014738.GA13602@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 04:46:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNikp-0007Qo-68
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 04:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVDSCuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 22:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVDSCuN
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 22:50:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:49804 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261279AbVDSCt4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 22:49:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3J2nns4025938
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 19:49:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3J2nmi3020080;
	Mon, 18 Apr 2005 19:49:49 -0700
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <20050419014738.GA13602@taniwha.stupidest.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, Chris Wedgwood wrote:
>
> On Mon, Apr 18, 2005 at 05:45:48PM -0700, Greg KH wrote:
> 
> > But if you really don't like it, and you don't want anyone trying to
> > hide anything, at least allow for a proper domainname.  On my boxes,
> > the domainname doesn't show up at all without that patch (just the
> > getdomainname() part).  I'll split it out if you want.
> 
> there are plenty of times you need this... internal domain names
> usually have the MTA rewrite addresses as needed, i don't see how this
> is all the different
> 
> we have internal/private state that's not globally useful and need to
> replace it with something that is, how else could we do this?

Guys, I ended up applying Greg's patch, since it's clear that many people 
want to do this.  So ..

		Linus
