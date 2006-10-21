From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 14:04:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610211353070.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> 
 <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>  <45345AEF.6070107@utoronto.ca>
 <200610171030.35854.jnareb@gmail.com>  <vpqejt76vgz.fsf@ecrins.imag.fr> 
 <20061017073839.3728d1e7.seanlkml@sympatico.ca>  <20061021141328.GE29843@artax.karlin.mff.cuni.cz>
  <BAYC1-PASMTP116A2EE9056E50B25534D5AE020@CEZ.ICE>
 <845b6e870610210919i6d086654g3881343e6a3c9f84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1023987002-1161464696=:3962"
Cc: Sean <seanlkml@sympatico.ca>, Jan Hudec <bulb@ucw.cz>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 23:05:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbO1w-0001c0-BK
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 23:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423433AbWJUVFR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 17:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423428AbWJUVFR
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 17:05:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161062AbWJUVFO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 17:05:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9LL4vaX009669
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 21 Oct 2006 14:04:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9LL4u4T001323;
	Sat, 21 Oct 2006 14:04:57 -0700
To: =?ISO-8859-1?Q?Erik_B=E5gfors?= <zindar@gmail.com>
In-Reply-To: <845b6e870610210919i6d086654g3881343e6a3c9f84@mail.gmail.com>
X-Spam-Status: No, hits=-0.48 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29676>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1023987002-1161464696=:3962
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Sat, 21 Oct 2006, Erik Bågfors wrote:
> 
> bzr is a fully decentralized VCS. I've read this thread for quite some
> time now and I really cannot understand why people come to this
> conclusion.

Even the bzr people agree, so what's not to understand?

The revision numbers are totally unstable in a distributed environment 
_unless_ you use a certain work-flow. And that work-flow is definitely not 
"distributed" it's much closer to "disconnected centralized".

Now, you could be truly distributed: BK used the same revision numbering 
thing, but was distributed. But BK didn't even try to claim that their 
revision numbers were "simple" and that fast-forwarding is sometimes the 
wrong thing to do.

So BK always fast-forwarded, and the revision numbers were just randomly 
changing numbers. They weren't stable, they weren't simple, and nobody 
claimed they were.

So bzr can bite the bullet and say: "revision numbers are changing and 
meaningless, and we should just fast-forward on merges", or you should 
just admit that bzr is really more about "disconnected operation" than 
truly distributed.

You can't have your cake and eat it too. Truly distributed _cannot_ be 
done with a stable dotted numbering scheme (unless the "dotted numbering 
scheme" is just a way to show a hash like git does - so the numbering has 
no _sequential_ meaning).

Btw, this isn't just an "opinion". This is a _fact_. It's something they 
teach in any good introductory course to distributed algorithms. Usually 
it's talked about in the context of "global clock". 

Anybody who thinks that there exists a globally ticking clock in the 
system (and stably increasing dotted numbers are just one such thing) is 
talking about some fantasy-world that doesn't exist, or a world that has 
nothing to do with "distributed".

			Linus
--21872808-1023987002-1161464696=:3962--
