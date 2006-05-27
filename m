From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: ~/.git/config ?
Date: Sat, 27 May 2006 08:52:35 -0400
Message-ID: <200605271252.k4RCqZhR003192@laptop11.inf.utfsm.cl>
References: <torvalds@osdl.org>
Cc: Petr Baudis <pasky@ucw.cz>, Pavel Roskin <proski@gnu.org>,
	Timo Hirvonen <tihirvon@gmail.com>,
	Anand Kumria <wildfire@progsoc.uts.edu.au>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 14:56:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjyLO-0006le-4M
	for gcvg-git@gmane.org; Sat, 27 May 2006 14:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWE0M4Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 08:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWE0M4Y
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 08:56:24 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:43950 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750796AbWE0M4X (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 08:56:23 -0400
Received: from laptop11.inf.utfsm.cl (laptop11.inf.utfsm.cl [200.1.19.198])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k4RCqaNO004727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 27 May 2006 08:52:36 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k4RCqZhR003192;
	Sat, 27 May 2006 08:52:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: Message from Linus Torvalds <torvalds@osdl.org> 
   of "Fri, 26 May 2006 20:20:14 MST." <Pine.LNX.4.64.0605262007230.5623@g5.osdl.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sat, 27 May 2006 08:52:36 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20853>

Linus Torvalds <torvalds@osdl.org> wrote:
> On Sat, 27 May 2006, Petr Baudis wrote:
> > 
> > ~/.gitrc might get useful for actually doing what ~/.cvsrc or ~/.cgrc
> > does, that is providing default options for git commands. ~/.gitconfig
> > would just give you per-user defaults for the repository config file.

Yep.

[...]

> So they would do "alias cvs git" in a desperate attempt to save themselves 
> from CVS, and then add
> 
> 	[alias "co"]
> 		cmd = commit -a

I don't like this syntax. What other stuff (beside "cmd") would be under
"[alias "co"]? Why not simply:

        [alias]
		co = commit -a
		publish = push public.site.com:/pub/scm/my-public-repo
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
