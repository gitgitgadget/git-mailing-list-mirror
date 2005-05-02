From: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] add git.spec and adapt Makefile for RPM build
Date: Mon, 2 May 2005 11:39:02 -0700
Message-ID: <20050502183902.GD5324@shell0.pdx.osdl.net>
References: <kay.sievers@vrfy.org> <20050502145255.GA26439@vrfy.org> <200505021741.j42HfUZx013620@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 02 20:34:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSfjg-0001bC-Gd
	for gcvg-git@gmane.org; Mon, 02 May 2005 20:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVEBSjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 14:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVEBSjV
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 14:39:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:23718 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261618AbVEBSjK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 14:39:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j42Id2s4027290
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 2 May 2005 11:39:02 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j42Id2Fe011837;
	Mon, 2 May 2005 11:39:02 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j42Id287011836;
	Mon, 2 May 2005 11:39:02 -0700
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200505021741.j42HfUZx013620@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Horst von Brand (vonbrand@inf.utfsm.cl) wrote:
> Kay Sievers <kay.sievers@vrfy.org> said:
> > On Mon, May 02, 2005 at 12:23:03PM +0200, Kay Sievers wrote:
> > > Add support for building the rpm package directly from the git tree.
> > 
> > This version creates the git.spec from a git.spec.in with the version
> > number from the Makefile.
> 
> Please don't. The spec file /controls/ the building of the package, it can't
> be generated as part of the build process.

It certainly can.  It simply means a structured release process.  IOW,
the git.spec would be generated for a release tarball.

thanks,
-chris
