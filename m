From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: What to expect after 0.99.8
Date: Mon, 03 Oct 2005 17:39:06 -0400
Message-ID: <200510032139.j93Ld6xg026499@laptop11.inf.utfsm.cl>
References: <alan@chandlerfamily.org.uk>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 23:41:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMY1y-0006KD-WB
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 23:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbVJCVj2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 17:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbVJCVj1
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 17:39:27 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:46223 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932697AbVJCVj1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2005 17:39:27 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j93Ld79A027865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Oct 2005 17:39:07 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j93Ld6xg026499;
	Mon, 3 Oct 2005 17:39:06 -0400
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: Message from Alan Chandler <alan@chandlerfamily.org.uk> 
   of "Mon, 03 Oct 2005 20:48:37 +0100." <200510032048.37363.alan@chandlerfamily.org.uk> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 03 Oct 2005 17:39:07 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9655>

Alan Chandler <alan@chandlerfamily.org.uk> wrote:
> On Monday 03 Oct 2005 01:14, Junio C Hamano wrote:
> ...
> >
> > Technical (heavier)
> > -------------------
> ...
> > * Look at libified GNU diff CVS seems to use, or libxdiff.

> I did wonder today in response to a discussion at work about version control 
> of documentation, whether git could in some way understand OpenDocument 
> format and allow some form of merging of concurrent changes to the same 
> document.  I am not sure if just unzipping the files and applying standard 
> merge strategies the resultant xml would be good enough.

A student of mine worked on layering SCM under a code design tool that uses
XML as its representation of the project it is working on. He started with
CVS, and ended up grafting a problem-specific merge strategy on top. The
standard merge from CVS just messed everything up. Dunno if this is very
relevant for OASIS, but I suspect you'd see the same.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
