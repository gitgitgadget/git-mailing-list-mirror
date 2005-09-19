From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Strange dependency problem installing GIT 0.99.7
Date: Mon, 19 Sep 2005 18:06:05 -0400
Message-ID: <200509192206.j8JM65xb030055@inti.inf.utfsm.cl>
References: <pwil3058@bigpond.net.au>
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 05:31:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHYq3-0000uj-Px
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 05:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVITDad (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 23:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbVITDac
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 23:30:32 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:19669 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964858AbVITDac (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 23:30:32 -0400
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j8JM65xb030055;
	Mon, 19 Sep 2005 18:06:06 -0400
To: Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: Message from Peter Williams <pwil3058@bigpond.net.au> 
   of "Mon, 19 Sep 2005 16:24:10 +1000." <432E598A.7020306@bigpond.net.au> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8965>

Peter Williams <pwil3058@bigpond.net.au> wrote:
> Sean wrote:

[...]

> > You need to install ShellQuote with rpm rather than installing it >
> > directly from CPAN.  You can pick up a rpm version of ShellQuote from
> > several places, here's one: http://tinyurl.com/7p7ey

> IMHO rpm shouldn't care how ShellQuote got there unless it (how it got
> there) is stated as an explicit dependency in the spec file (which it
> isn't).  So I still think this is a bug in rpm's (automatic)
> dependency mechanism that needs fixing.

If it needs ShellQuote, it is required. RPM does know only about things in
its database (i.e., rpm-installed).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
