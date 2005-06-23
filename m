From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Thu, 23 Jun 2005 10:31:57 -0400
Message-ID: <200506231431.j5NEVvpK004472@laptop11.inf.utfsm.cl>
References: <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 16:27:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlSeq-00041C-O3
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 16:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVFWOc2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 10:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbVFWOc2
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 10:32:28 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:27806 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262547AbVFWOcW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 10:32:22 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j5NEVwnd020420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Jun 2005 10:31:58 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j5NEVvpK004472;
	Thu, 23 Jun 2005 10:31:57 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: Message from Jeff Garzik <jgarzik@pobox.com> 
   of "Thu, 23 Jun 2005 01:16:33 -0400." <42BA45B1.7060207@pobox.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 23 Jun 2005 10:31:58 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> said:
> Linus Torvalds wrote:
> > 	rsync -r --ignore-existing repo/refs/tags/ .git/refs/tags/
> > 
> > See? What's your complaint with just doing that?
> 
> No complaint with that operation.  The complaint is that it's an 
> additional operation.  Re-read what Greg said:
> 
> > Is there some reason why git doesn't pull the
> > tags in properly when doing a merge?  Chris and I just hit this when I
> > pulled his 2.6.12.1 tree and and was wondering where the tag went.
> 
> Multiple users -- not just me -- would prefer that git-pull-script 
> pulled the tags, too.
> 
> Suggested solution:  add '--tags' to git-pull-script 
> (git-fetch-script?), which calls
> 	rsync -r --ignore-existing repo/refs/tags/ .git/refs/tags/

I don't think either is really a solution. IMHO there should be a
distinction between "official tags" (that get passed around together with
everything else) and "private tags" for everybodys own home use (that could
be passed around, but only explicitly). Plus the possibility to erase,
move, &c private tags, and perhaps upgrade them to official status (thus
setting them in stone).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
