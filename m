From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild bug)
Date: Tue, 01 Nov 2005 20:15:17 -0300
Message-ID: <200511012315.jA1NFHbH003838@inti.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 03:13:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX876-0003ke-UE
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 03:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVKBCMa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 21:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVKBCMa
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 21:12:30 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:20948 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932202AbVKBCMa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 21:12:30 -0500
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id jA1NFHbH003838;
	Tue, 1 Nov 2005 20:15:17 -0300
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Mon, 31 Oct 2005 11:31:03 -0800." <7v4q6xfpqg.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10993>

Junio C Hamano <junkio@cox.net> wrote:

[...]

> I do not know much about how things are done in the RPM world,
> but is there a concept of "the upstream" vs "packaging
> maintainer" there?  IOW, are the majority of RPM binary packages
> done by the upstream maintainer?

No, they aren't. RPM is set up so you can take the vanilla upstream package
and add local patches, special configuration, ... at will downstream.
> 
> I am currently generating i386 RPMs and i386 debs myself but I
> am not particularly proud of the current setup.  I do not have
> an RPM based machine that I can install the result myself to
> test (which is what started this thread).  Since I am not a
> Debian developer (and I do not particularly wish to become one
> myself), the debs I generate will not be official anyway.
> Personally I'd be happier if I can just lose rpm and deb targets
> from the "upstream" Makefile (git-core.spec file and debian/
> subdirectory as well while we are at it), ask "packaging
> maintainers" to pull from kernel.org/ tree and do RPMs and Debs
> outside.

Please keep the git-core.spec file, it is useful to be able to build RPMs
directly from the tarball.

[...]

> One thing we could do without breaking much of the current
> arrangement is to have a team of people to help porting for
> major packaging formats (RPMs and Debs mostly but I know we have
> OpenBSD and Darwin people here too), and ask them to feed me the
> updates to rpm/deb/whatever target in the Makefile as needed.
> Especially before a major release I could ask them to test
> things out and generate binary packages, perhaps taken out of
> the tip of the master branch, or even another "for-porters"
> branch for this purpose.

Good idea. Will build RPMs regularly then.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
