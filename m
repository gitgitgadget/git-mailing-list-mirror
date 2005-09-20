From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: What shall we do with the GECOS field again?
Date: Mon, 19 Sep 2005 23:12:02 -0400
Message-ID: <200509200312.j8K3C2KZ002935@inti.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 05:29:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHYnn-0000W7-HM
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 05:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbVITD2L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 23:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbVITD2L
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 23:28:11 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:13013 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964854AbVITD2K (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 23:28:10 -0400
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j8K3C2KZ002935;
	Mon, 19 Sep 2005 23:12:03 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Mon, 19 Sep 2005 09:49:49 MST." <7vd5n5q9xu.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8963>

Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> > The Perl User::pwent module seems to agree, btw (also about '&'):
> >
> >    "Interpretation of the gecos field varies between systems, but
> >     traditionally holds 4 comma-separated fields containing the user's
> >     full name, office location, work phone number, and home phone number.  
> >
> >     An & in the gecos field should be replaced by the user's properly
> >     capitalized login name."
> 
> I vaguelly recall seeing that & somewhere and wondering what
> they do with mcdonalds ;-)

You can't use it in that case.

> > I still worry about names of the type "Torvalds, Linus", but maybe that's 
> > just not an issue.
> 
> Does not appear to be.  So I'd vote for us doing the "cut at
> first comma, substitute & with toupper(login[0])+login[1..]".

That is exactly the intent.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
