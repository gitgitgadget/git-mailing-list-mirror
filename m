From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild bug)
Date: Tue, 01 Nov 2005 20:11:16 -0300
Message-ID: <200511012311.jA1NBGii003792@inti.inf.utfsm.cl>
References: <torvalds@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Chris Wright <chrisw@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 03:13:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX87b-0003sB-Uk
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 03:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVKBCNA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 21:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVKBCNA
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 21:13:00 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:22996 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932211AbVKBCM7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 21:12:59 -0500
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id jA1NBGii003792;
	Tue, 1 Nov 2005 20:11:16 -0300
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: Message from Linus Torvalds <torvalds@osdl.org> 
   of "Mon, 31 Oct 2005 08:25:21 -0800." <Pine.LNX.4.64.0510310819290.27915@g5.osdl.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10992>

Linus Torvalds <torvalds@osdl.org> wrote:
> On Mon, 31 Oct 2005, H. Peter Anvin wrote:
> > The git-core RPM definitiely needs to be split.  Doubly ironic that it's
> > called "core".

> I don't think it's necessarily ironic. It's actually a good thing.
> 
> I think that what we want to have is one _project_ (called "git"), which 
> can generate multiple RPM's ("git-core", "git-svnimport", "git-docs", 
> whatever).

Better cut along outside requirements: git-svn, git-cvs, git-scm-du-jour,
git-gtk. Please _don't_ split out documentation.

> So I think it was good that we called the RPM "git-core". We've just not 
> yet done the obvious thing to create a few _other_ RPM's.

Right.

> Now, I'm not certain how happy RPM would be with having one source RPM 
> generate multiple binary RPM's,

Works fine. It is exactly what is used to build -devel packages. What
doesn't work is doing multiple architectures, e.g. creating
git-core-1.2.3.i386.rpm and git-gitk-1.2.3.noarch.rpm, in one go.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
