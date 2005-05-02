From: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] add git.spec and adapt Makefile for RPM build
Date: Mon, 2 May 2005 12:08:52 -0700
Message-ID: <20050502190852.GH18917@shell0.pdx.osdl.net>
References: <20050502183902.GD5324@shell0.pdx.osdl.net> <200505021858.j42Iw4M1029427@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@osdl.org>, Kay Sievers <kay.sievers@vrfy.org>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 02 21:03:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSgC3-0002JK-6b
	for gcvg-git@gmane.org; Mon, 02 May 2005 21:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVEBTJC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 15:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVEBTJC
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 15:09:02 -0400
Received: from fire.osdl.org ([65.172.181.4]:3503 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261712AbVEBTI5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 15:08:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j42J8qs4029647
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 2 May 2005 12:08:53 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j42J8qtF013421;
	Mon, 2 May 2005 12:08:52 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j42J8qkh013420;
	Mon, 2 May 2005 12:08:52 -0700
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200505021858.j42Iw4M1029427@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Horst von Brand (vonbrand@inf.utfsm.cl) wrote:
> Chris Wright <chrisw@osdl.org> said:
> >                   It simply means a structured release process.  IOW,
> > the git.spec would be generated for a release tarball.
> 
> Come on, you have to fix the spec file for the changelog and version by
> hand anyway, autoconfiscating it doesn't help one iota there.

That's the point, you don't _have_ to do that.

> And yes, I've seen quite a few packages autogenerating the spec file. As a
> result, you /can't/ build the package from pristine sources, you have to
> unpack and configure to get enough for building. For me that just isn't
> acceptable, as it completely misses the point of RPM.
> 
> (You can go "rpmbuild -ta whatever-2.3.1.tar.bz2" if the tarball is set up
> correctly, your idea prevents that).

You just place the generated spec file in a release tarball.  IOW, your
'release' Makefile target depends on foo.spec, and creates a clean release
tarball with all you need to do an -ta build.

thanks,
-chris
