From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: cg-mv
Date: Wed, 12 Oct 2005 19:32:14 -0300
Message-ID: <200510122232.j9CMWEhN003974@laptop11.inf.utfsm.cl>
References: <pasky@suse.cz>
Cc: Zack Brown <zbrown@tumblerings.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 13 15:13:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ2ri-0006TZ-KC
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 15:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVJMNLO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 09:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbVJMNLN
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 09:11:13 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:20953 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750771AbVJMNLN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2005 09:11:13 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j9DDAT3C004667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Oct 2005 10:10:31 -0300
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j9CMWEhN003974;
	Wed, 12 Oct 2005 19:32:14 -0300
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: Message from Petr Baudis <pasky@suse.cz> 
   of "Wed, 12 Oct 2005 12:07:57 +0200." <20051012100757.GM30889@pasky.or.cz> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 13 Oct 2005 10:10:31 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10070>

Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Fri, Oct 07, 2005 at 04:33:33PM CEST, I got a letter
> where Zack Brown <zbrown@tumblerings.org> told me that...

> > IIRC, file renaming is something we only care about at read time, we
> > don't actually need to track it while making the change, because git
> > allows us to track data from file to file without having to tell it
> > that the data is moving.

> > So, just to keep certain people happy, why not have the cg-mv command
> > defined to something like this:

What about git-rename(1)? For completeness, just wrap it into cg-mv.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
