From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: deprecating more
Date: Fri, 16 Sep 2005 21:58:24 -0400
Message-ID: <200509170158.j8H1wOVh027636@inti.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 04:02:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGoUt-0000sI-1q
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 04:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVIRCBg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 22:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbVIRCBg
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 22:01:36 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:62156 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751268AbVIRCBg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Sep 2005 22:01:36 -0400
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j8H1wOVh027636;
	Fri, 16 Sep 2005 21:58:24 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Fri, 16 Sep 2005 18:31:54 MST." <7vzmqceayd.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8774>

Junio C Hamano <junkio@cox.net> wrote:

[About axing programs]

> Among them, I could be talked into keeping git-export on the
> condition that we will add a counterpart git-import that can
> read git-export output and recreate an identical repository
> [*1*]; without something like that, I doubt its usefulness,
> especially since "git-whatchanged" is far more useful for
> everyday use.
> 
> [Footnote]
> 
> *1* which I think actually is impossible without fixing
> git-export first so that it exports the initial commit.  I may
> be mistaken.

Given that you can just tar the whole repository up and handle it that way,
all that work makes little sense.

Note that bk export (and cg-export) copy the current snapshot into a
directory or tarball, so this doesn't do what I'd expected.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
