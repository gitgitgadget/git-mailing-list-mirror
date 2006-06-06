From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Cleanup git-send-email.perl:extract_valid_email
Date: Tue, 06 Jun 2006 17:24:53 -0400
Message-ID: <200606062124.k56LOroI007738@laptop11.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 23:25:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnj3B-0000yS-5p
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 23:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWFFVZS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 17:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWFFVZR
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 17:25:17 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45253 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751131AbWFFVZQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 17:25:16 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k56LOxdU023295
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Jun 2006 17:25:09 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k56LOroI007738;
	Tue, 6 Jun 2006 17:24:54 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Tue, 06 Jun 2006 09:58:23 MST." <7vlksate4w.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 06 Jun 2006 17:25:10 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21402>

Junio C Hamano <junkio@cox.net> wrote:
> Horst von Brand <vonbrand@inf.utfsm.cl> writes:
> > Junio C Hamano <junkio@cox.net> wrote:
> >>                                                     but I am
> >> inclined to do this instead:
> >> 
> >> 	my $domain_regexp = '[^.<>"\s@]+(?:\.[^.<>"\s@]+)+';
> >> 
> >> (i.e. still require at least two levels).
> >
> > OK, but be careful as this (?:...) is an extended regexp (needs /x on
> > match).

> Are you sure about /x?

The manual (perlop(1)) says you need /x to match extended regexps, and
(?...) is the marker for such (perlre(1)). But my perl here (5.5.8-6 on
Fedora rawhide) doesn't care...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
