From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild
 bug)
Date: Mon, 31 Oct 2005 12:32:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510311230290.27915@g5.osdl.org>
References: <43652934.8000308@zytor.com>  <7vy84ajl4c.fsf@assigned-by-dhcp.cox.net>
  <20051031064105.GV8041@shell0.pdx.osdl.net>  <43663EEA.5050102@zytor.com>
 <7v4q6xfpqg.fsf@assigned-by-dhcp.cox.net> <46a038f90510311213n565010d6g5586a7484b25da7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org, Sebastian Kuzminsky <seb@highlab.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 21:32:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWgKe-0004wX-3z
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 21:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVJaUch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 15:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVJaUch
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 15:32:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932493AbVJaUch (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 15:32:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9VKWRsC008739
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 12:32:27 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9VKWMDb025419;
	Mon, 31 Oct 2005 12:32:25 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510311213n565010d6g5586a7484b25da7e@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10882>



On Tue, 1 Nov 2005, Martin Langhoff wrote:
> >
> > git-core::
> >         All the rest, plus man pages.  We could separate out
> >         commit walkers if we wanted to, but I do not think that
> >         is necessary.
> 
> git-gitk ;-)

I really really prefer gitk in the core, even if it means that there's 
that strange tcl/tk dependency.

It's very small, and having something that visualizes what git does for 
people who don't understand git is _invaluable_. 

It wouldn't have to be gitk, but that's the least pain right now. qgit 
needs QT, which is much more contentious than tcl/tk. 

		Linus
