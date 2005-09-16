From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Update cogito.spec.in
Date: Fri, 16 Sep 2005 15:44:45 -0400
Message-ID: <200509161944.j8GJijY3019186@inti.inf.utfsm.cl>
References: <chrisw@osdl.org>
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 22:11:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGMWo-0005nX-Jy
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 22:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161279AbVIPUJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 16:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161281AbVIPUJm
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 16:09:42 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:1517 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1161280AbVIPUJl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 16:09:41 -0400
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j8GJijY3019186;
	Fri, 16 Sep 2005 15:44:45 -0400
To: Chris Wright <chrisw@osdl.org>
In-Reply-To: Message from Chris Wright <chrisw@osdl.org> 
   of "Fri, 16 Sep 2005 08:46:31 MST." <20050916154631.GJ8041@shell0.pdx.osdl.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8726>

Chris Wright <chrisw@osdl.org> wrote:
> * Petr Baudis (pasky@suse.cz) wrote:
> > Dear diary, on Fri, Sep 16, 2005 at 08:47:24AM CEST, I got a letter
> > where Chris Wright <chrisw@osdl.org> told me that...

[...]

> > > -BuildRoot:	%{_tmppath}/%{name}-%{version}-root
> > > -Prereq: 	sh-utils, diffutils, rsync, rcs, mktemp >= 1.5, git-core >= 0.99.3
> > > -BuildArchitectures:	noarch
> > > +BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
> > > +Requires: 	git-core >= 0.99.3
> > > +BuildArch:	noarch

> > Why did you remove all the stuff from Requires? They actually are ending
> > up adding even trivial stuff like less to it in GIT.

> Primary reason is it now requires git, which has those prereqs.

It might be useful to say so in a comment.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
