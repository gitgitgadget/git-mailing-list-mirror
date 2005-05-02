From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] add git.spec and adapt Makefile for RPM build
Date: Mon, 02 May 2005 13:41:30 -0400
Message-ID: <200505021741.j42HfUZx013620@laptop11.inf.utfsm.cl>
References: <kay.sievers@vrfy.org>
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 02 19:41:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSeu3-0005qC-Jj
	for gcvg-git@gmane.org; Mon, 02 May 2005 19:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVEBRp1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 13:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVEBRmv
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 13:42:51 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:64995 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261363AbVEBRlr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 13:41:47 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j42HdaAA006657
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 May 2005 13:39:36 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j42HfUf4013649;
	Mon, 2 May 2005 13:41:30 -0400
Received: from laptop11.inf.utfsm.cl (vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.4/8.13.4/Submit) with ESMTP id j42HfUZx013620;
	Mon, 2 May 2005 13:41:30 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: Message from Kay Sievers <kay.sievers@vrfy.org> 
   of "Mon, 02 May 2005 16:52:55 +0200." <20050502145255.GA26439@vrfy.org> 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 02 May 2005 13:39:36 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Kay Sievers <kay.sievers@vrfy.org> said:
> On Mon, May 02, 2005 at 12:23:03PM +0200, Kay Sievers wrote:
> > Add support for building the rpm package directly from the git tree.
> 
> This version creates the git.spec from a git.spec.in with the version
> number from the Makefile.

Please don't. The spec file /controls/ the building of the package, it can't
be generated as part of the build process.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
