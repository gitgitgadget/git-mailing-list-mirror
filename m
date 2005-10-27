From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [TENTATIVE PATCH] Complain loudly, dying, when a ref is invalid
Date: Thu, 27 Oct 2005 18:13:05 -0300
Message-ID: <200510272113.j9RLD5ho017717@laptop11.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 23:14:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVF3q-0005NO-Dr
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 23:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVJ0VNT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 17:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVJ0VNS
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 17:13:18 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:23021 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932269AbVJ0VNR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2005 17:13:17 -0400
Received: from laptop11.inf.utfsm.cl (di-ip198.inf.utfsm.cl [200.1.19.198])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j9RLD635001244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 27 Oct 2005 18:13:06 -0300
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j9RLD5ho017717;
	Thu, 27 Oct 2005 18:13:05 -0300
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Thu, 27 Oct 2005 12:01:37 PDT." <7vacgu3hta.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 27 Oct 2005 18:13:06 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10728>

Junio C Hamano <junkio@cox.net> wrote:

[...]

> Not that the current loop is any better for that purpose.  We
> silently ignore not just dangling ref and ref not storing
> 40-byte hex, but files starting with a period '.',  names longer
> than 255 bytes, and unreadable ones, all of which we would
> probably want to warn about in such a tool.

I have yet to come across a filesystem allowing names of more than 255
characters... 
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
