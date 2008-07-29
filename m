From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Mon, 28 Jul 2008 20:29:59 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807282023290.3334@nehalem.linux-foundation.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org> <200807260512.40088.zippel@linux-m68k.org> <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain> <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 05:34:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNfyV-00089T-NK
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 05:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbYG2DdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 23:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752824AbYG2DdL
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 23:33:11 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49819 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752297AbYG2DdK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2008 23:33:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6T3WwCq007336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Jul 2008 20:32:59 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6T3Ww6x011968;
	Mon, 28 Jul 2008 20:32:58 -0700
In-Reply-To: <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.411 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90558>



On Tue, 29 Jul 2008, Roman Zippel wrote:
> 
> Right now you're giving me the choice between a crappy incomplete history 
> or a crappy history full of useless information. That's it? As long as 
> your challenge involves being compared to crappy history, I'm not 
> interested.

No, my challenges have not been about "crappy history" but about 
performance and about getting it right. The reason I pointed you to 
lib/vsprintf.c had nothing to do with crappiness, and had everythign to do 
with just picking a random example of something where you absolutely 
*HAVE* to simplify history.

The fact that it simplifies to a linear one is totally immaterial. You 
continue to miss the point. Over and over AND OVER again!

> Can we please get past this and look at what is required to produce the 
> correct history?

I'm not even going to bother with this argument.

You dismiss all my issues, and then you continue to talk about "correct", 
even though it isn't a correctness thing - it's a difference of opinion. 
Me, I *much* prefer the simplified history. That _is_ the correct one for 
me.

And the sad part is, what you want is there. It's a command line switch 
away. You were told in the very first message what the switch was. If you 
don't want to use "--full-history", you can actually use "git whatchanged" 
instead of "git log", and it implies the switch without you even having to 
type it.

So it's all there. Use it. Just don't bother adding me to the cc to your 
inane flames, because I'm fed up with the fact that you can't actually be 
bothered to read my emails, and just want to flame.

And quite frankly, I've seen that behaviour from you before, when it comes 
to other things. So go away. Write the code. Come back with patches. In 
the meantime, we've told you what to do: use --full-history if you really 
want it.

			Linus
