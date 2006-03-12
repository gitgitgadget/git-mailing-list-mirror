From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Trivial warning fix for imap-send.c
Date: Sun, 12 Mar 2006 17:51:42 -0400
Message-ID: <200603122151.k2CLpgt0008036@laptop11.inf.utfsm.cl>
References: <mdw@distorted.org.uk>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 16:51:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIpJ6-00081L-UZ
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 16:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWCMPt6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 10:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWCMPt6
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 10:49:58 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:19395 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751490AbWCMPt5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 10:49:57 -0500
Received: from laptop11.inf.utfsm.cl (laptop11.inf.utfsm.cl [200.1.19.198])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k2DFnDkR025134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 13 Mar 2006 11:49:30 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.5) with ESMTP id k2CLpgt0008036;
	Sun, 12 Mar 2006 17:51:42 -0400
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: Message from Mark Wooding <mdw@distorted.org.uk> 
   of "Sun, 12 Mar 2006 18:01:09 GMT." <slrne18of5.fr9.mdw@metalzone.distorted.org.uk> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 13 Mar 2006 11:49:30 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17567>

Mark Wooding <mdw@distorted.org.uk> wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> > So in modern C, using NULL at the end of a varargs array as a pointer is 
> > perfectly sane, and the extra cast is just ugly and bowing to bad 
> > programming practices and makes no sense to anybody who never saw the 
> > horror that is K&R.

> No!  You can still get bitten.

Only if the compiler is completely broken.

>                                 You're lucky that on common platforms
> all pointers look the same, but if you find one where `char *' (and
> hence `void *') isn't the same as `struct foo *' then, under appropriate
> circumstances you /will/ unless you put the casts in.

Show one platform where this is true...

> Now, maybe we don't care for GIT.  That's your (and Junio's) call.  My
> natural approach is to work as closely as I can to the specs (and then
> throw in hacks for platforms which /still/ don't work), though, which is
> why I brought the subject up.

If on the platform you use it doesn't work, change the compiler. Fast.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
