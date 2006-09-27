From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Wed, 27 Sep 2006 04:41:12 -0400
Message-ID: <BAYC1-PASMTP059765F6CE0979DC2F8D5AAE1A0@CEZ.ICE>
References: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64N.0609262005150.520@attu4.cs.washington.edu>
	<7vmz8lj3pl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64N.0609262216390.12560@attu2.cs.washington.edu>
	<7vejtxhlv6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64N.0609262320260.9088@attu4.cs.washington.edu>
	<7vfyedg56m.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64N.0609270006020.9602@attu4.cs.washington.edu>
	<Pine.LNX.4.63.0609270948140.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP024D1DA4730F9DF93F857FAE1A0@CEZ.ICE>
	<Pine.LNX.4.63.0609271030180.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: David Rientjes <rientjes@cs.washington.edu>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 10:41:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSUym-0007CX-5B
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 10:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWI0IlP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 04:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWI0IlP
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 04:41:15 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:5661 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S964845AbWI0IlO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 04:41:14 -0400
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.94.249.130]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 27 Sep 2006 01:41:13 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GSUye-0005C2-Qr; Wed, 27 Sep 2006 04:41:12 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-Id: <20060927044112.cc170405.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0609271030180.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Sep 2006 08:41:14.0293 (UTC) FILETIME=[B0F66650:01C6E210]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Sep 2006 10:35:16 +0200 (CEST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> In this case, though, "English" is utterly, totally irrelevant. The 
> question is a mathematical one, and thus, the solution is a mathematical 
> one.

Well, no..  At least for me, I "think" in english, not mathematics.  And
thus I have to understand each condition in my native language.  And i'm
being honest with you when I tell you that my parser hiccups every time
I see such a construct.

> So, in essence, if you do not understand a conditional with a constant on 
> the left side, just because it happens to honour the mathematical view of 
> "left is small, right is large", you do not stand a chance of 
> understanding the formula, right?

It's not a matter of being able to understand, it's being able to digest
at a glance, almost without a thought as opposed to consciously having
to rearrange the arguments into something that "feels" right.

> Oh, come on! You cannot possibly spend even _seconds_ on this particular 
> construct!
> 
> 'nough said.

I'm telling you that it is disconcerting and annoying to have to rejig such
a construct.  Whereas when expressed in the opposite format it makes reading
simple and natural.  Making the code easier and more pleasurable to read.

And if you find it so easy to read either way, then why not bend for those
of us who have trouble reading it your way instead of just telling us to get
stuffed?

Sean
