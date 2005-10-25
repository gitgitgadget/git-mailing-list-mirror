From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: The MIT error
Date: Tue, 25 Oct 2005 10:40:16 -0300
Message-ID: <200510251340.j9PDeGGt006248@laptop11.inf.utfsm.cl>
References: <mwelinder@gmail.com>
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 25 15:45:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUP2R-0001Du-1P
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 15:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVJYNkY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 09:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVJYNkY
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 09:40:24 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:3465 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932140AbVJYNkX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 09:40:23 -0400
Received: from laptop11.inf.utfsm.cl (laptop11.inf.utfsm.cl [200.1.19.198])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j9PDeGwk021244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Oct 2005 10:40:16 -0300
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j9PDeGGt006248;
	Tue, 25 Oct 2005 10:40:16 -0300
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: Message from Morten Welinder <mwelinder@gmail.com> 
   of "Mon, 24 Oct 2005 14:57:15 EDT." <118833cc0510241157j39d5ff2cib2ccea50d15210d4@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 25 Oct 2005 10:40:16 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10587>

Morten Welinder <mwelinder@gmail.com> wrote:
> After the isspace/BSD conflict I looked into what reserved symbols are
> being used by git.  Quite a few, it turns out.

[...]

> Just as isspace is reserved by the C implementation...
> 
>        7.26.2  Character handling <ctype.h>
> 
>        [#1]  Function  names that begin with either is or to, and a
>        lowercase letter (possibly followed by  any  combination  of
>        digits,  letters,  and  underscore)  may  be  added  to  the
>        declarations in the <ctype.h> header.

There go is_space(), etc as suggested by the relevant patches... in any
case, if you /don't/ #include <ctype.h>, you are safe (standardwise),
aren't you? [Yes, idiots who #include that in system headers are way
broken, but...]
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
