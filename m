From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 09:17:39 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808280912510.3300@nehalem.linux-foundation.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net>
 <7vr68b8q9p.fsf@gitster.siamese.dyndns.org> <20080827001705.GG23698@parisc-linux.org> <7v63pmkozh.fsf@gitster.siamese.dyndns.org> <1219907659.7107.230.camel@pmac.infradead.org> <7vtzd5fta0.fsf@gitster.siamese.dyndns.org>
 <1219912327.7107.245.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	users@kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 18:22:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYkFo-0002Ey-1M
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 18:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbYH1QUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 12:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbYH1QUn
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 12:20:43 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53518 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752043AbYH1QUm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2008 12:20:42 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7SGIFoJ025218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Aug 2008 09:18:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7SGHdWE001831;
	Thu, 28 Aug 2008 09:17:40 -0700
In-Reply-To: <1219912327.7107.245.camel@pmac.infradead.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.927 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94080>



On Thu, 28 Aug 2008, David Woodhouse wrote:
> 
> I'm not asking you to make another change in upstream git. You've told
> us the workaround (gitexecdir=/usr/bin)

No.

That's your _personal_ workaround.

Others DO NOT WANT IT.

I, for example, no longer want git-xyzzy in my path.

So the real workaround is 

 - you compile YOUR OWN VERSION instead of trying to force your stupid 
   opinion on everybody by forcing the default for distros to be 
   _idiotic_, and then you can do that gitexecdir=/usr/bin and wallow in 
   your own shitty inability to teach yourself not to do the dash.

 - or you do - in a _personal_ file - that

	PATH="$PATH:$(git --exec-path)"

   thing, and forget about it, and never ever have to worry about how git 
   was compiled and installed.

The second is obviously the much superior model, exactly because it allows 
those people who do _not_ want to see git-xyzzy to work on the same 
machine.

> Since I believe you're building the git packages used on kernel.org, I
> was just asking you to apply the workaround when you build _those_
> packages, that's all.

Don't be silly. Why are you grand poo-bah? Why cannot you just add your 
PATH to your .bash_profile?

Get over it already. Why the hell are you _still_ whining, after I have 
told you to do that PATH thing at least ten times already?

		Linus
