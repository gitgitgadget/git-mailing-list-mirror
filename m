From: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] Update cogito.spec.in
Date: Fri, 16 Sep 2005 08:46:31 -0700
Message-ID: <20050916154631.GJ8041@shell0.pdx.osdl.net>
References: <20050916064720.GI8041@shell0.pdx.osdl.net> <20050916110605.GC25169@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 17:51:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGIQG-0006rt-Gf
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 17:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161165AbVIPPqi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 11:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbVIPPqi
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 11:46:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30369 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161165AbVIPPqh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 11:46:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8GFkWBo026220
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Sep 2005 08:46:32 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8GFkVcI029959;
	Fri, 16 Sep 2005 08:46:31 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j8GFkVaY029958;
	Fri, 16 Sep 2005 08:46:31 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20050916110605.GC25169@pasky.or.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8689>

* Petr Baudis (pasky@suse.cz) wrote:
> Dear diary, on Fri, Sep 16, 2005 at 08:47:24AM CEST, I got a letter
> where Chris Wright <chrisw@osdl.org> told me that...
> > e0ca49e6c375a68b3e4b3edfff752fef2cf585f6
> > diff --git a/cogito.spec.in b/cogito.spec.in
> > --- a/cogito.spec.in
> > +++ b/cogito.spec.in
> > @@ -1,15 +1,14 @@
> >  Name: 		cogito
> >  Version: 	@@VERSION@@
> >  Release: 	1
> > -Vendor: 	Petr Baudis <pasky@suse.cz>
> >  Summary:  	The Cogito Version Control System
> >  License: 	GPL
> >  Group: 		Development/Tools
> >  URL: 		http://kernel.org/pub/software/scm/cogito/
> >  Source: 	http://kernel.org/pub/software/scm/cogito/%{name}-%{version}.tar.gz
> > -BuildRoot:	%{_tmppath}/%{name}-%{version}-root
> > -Prereq: 	sh-utils, diffutils, rsync, rcs, mktemp >= 1.5, git-core >= 0.99.3
> > -BuildArchitectures:	noarch
> > +BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
> > +Requires: 	git-core >= 0.99.3
> > +BuildArch:	noarch
> 
> Why did you remove all the stuff from Requires? They actually are ending
> up adding even trivial stuff like less to it in GIT.

Primary reason is it now requires git, which has those prereqs.

thanks,
-chris
