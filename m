From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Cleanup git-send-email.perl:extract_valid_email
Date: Tue, 06 Jun 2006 18:48:16 -0400
Message-ID: <200606062248.k56MmGr6008515@laptop11.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 00:48:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnkLa-0007TV-S8
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 00:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWFFWsY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 18:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWFFWsY
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 18:48:24 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:49101 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751269AbWFFWsX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 18:48:23 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k56MmH6L032297
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Jun 2006 18:48:18 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k56MmGr6008515;
	Tue, 6 Jun 2006 18:48:17 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Tue, 06 Jun 2006 14:39:06 MST." <7vlksanev9.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 06 Jun 2006 18:48:18 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21410>

Junio C Hamano <junkio@cox.net> wrote:
> Horst von Brand <vonbrand@inf.utfsm.cl> writes:
> >> > OK, but be careful as this (?:...) is an extended regexp (needs /x on
> >> > match).
> >
> >> Are you sure about /x?
> >
> > The manual (perlop(1)) says you need /x to match extended regexps, and
> > (?...) is the marker for such (perlre(1)).

> I always had the impression that eXtended in the context to talk
> about /x was about ignoring whitespaces and forcing people to
> write \s (or perhaps \040) when they mean a whitespace and had
> nothing to do with (?...) stuff.  Let me look up the fine
> manual.

You might be right... and it even sounds sensible; but both (?...) stuff
and the ignoring of space is described as extended here.

Note that \s is a space character (' ', '\t', ...), which is not the same
as \040 (and that one assumes ASCII...).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
