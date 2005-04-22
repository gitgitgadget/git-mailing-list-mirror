From: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] git-pasky spec file
Date: Thu, 21 Apr 2005 19:48:34 -0700
Message-ID: <20050422024834.GM493@shell0.pdx.osdl.net>
References: <20050422015521.GK493@shell0.pdx.osdl.net> <20050422024010.GE7443@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 04:44:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOo9I-0006mn-Rs
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 04:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVDVCsj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 22:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVDVCsj
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 22:48:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:42193 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261926AbVDVCsh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 22:48:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3M2mYs4025544
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 21 Apr 2005 19:48:35 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3M2mYxc006874;
	Thu, 21 Apr 2005 19:48:34 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j3M2mYV3006873;
	Thu, 21 Apr 2005 19:48:34 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050422024010.GE7443@pasky.ji.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Petr Baudis (pasky@ucw.cz) wrote:
> Dear diary, on Fri, Apr 22, 2005 at 03:55:21AM CEST, I got a letter
> where Chris Wright <chrisw@osdl.org> told me that...
> > Here's a simple spec file to do rpm builds.  It's against the
> > latest Makefile (which has the s/BINDIR/bindir/ change).  I've used
> > DESTDIR, although it's not clear it's meant to stay in the Makefile.
> > For now, there's no dynamic (git.spec.in, for example) update to the
> > Version, so it's set against 0.6.3 (expecting it to be forthcoming
> > shortly).  It installs to /usr/local/bin, and expects the tarball to be
> > named git-pasky-0.6.3.tar.bz2.  Creates a package named git, which seems
> > fine since Linus' isn't likely to be packaged directly.  Enjoy.
> 
> Thanks, applied. I'll gladly yet you maintain this file, but...

No problem...

> > --- /dev/null	1969-12-31 16:00:00.000000000 -0800
> > +++ git-pasky-0.6.3/git.spec	2005-04-21 18:42:18.000000000 -0700
> > @@ -0,0 +1,43 @@
> > +%install
> > +rm -rf $RPM_BUILD_ROOT
> > +make DESTDIR=$RPM_BUILD_ROOT/usr/local/ bindir=bin/ install
> 
> I doubt this is actually what you want. I suppose you want
> 
> make DESTDIR=$RPM_BUILD_ROOT prefix=/usr/local install

Yup, that makes more sense.  Feel free to update if you're so inclined.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
