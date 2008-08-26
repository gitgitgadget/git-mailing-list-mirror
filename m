From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 11:19:28 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net>
 <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <20080826180926.GA25711@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 20:22:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY3Bg-0005Ly-0f
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 20:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbYHZSVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 14:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753373AbYHZSVf
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 14:21:35 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51673 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752571AbYHZSVf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Aug 2008 14:21:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7QIJT3F027737
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Aug 2008 11:19:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7QIJSVM020306;
	Tue, 26 Aug 2008 11:19:28 -0700
In-Reply-To: <20080826180926.GA25711@isilmar.linta.de>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.928 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93793>



On Tue, 26 Aug 2008, Dominik Brodowski wrote:
> 
> But _why_ do they complain? Just whining or real reasons?

Well, considering that I think the people who complain about the 1.6.0 
behaviour are whining, what does it matter?

People always think their own concerns are so incredibly important. 

I always thought that git-xyzzy was fine. After all, I _did_ it that way 
to begin with. But people complained, and the whole alias thing meant that 
it couldn't be the primary interface _anyway_, so I changed my opinion.

I don't actually personally feel all that strongly, but I _do_ think that 
right now the git-xyzzy proponents are whining. All of their arguments are 
pure and utter CRAP, considering the triviality of

	PATH="$PATH:$(git --exec-path)"

Really. I repeat that mantra over and over, exactly because it makes all 
the whining so _pointless_.

Why do people still whine about this? Really? None of the whiners have 
answered that simple PATH mantra, BECAUSE THEY CANNOT.

So when you ask "why do they complain", look at both sides. Both sides 
complain about totally stupid things.

but the FACT is that git-1.6.0 can work either way. So the people who 
complain about having lost git-xyzzy are the ones that are being stupid. 

At least the ones who complained about "git-<tab><tab>" being scary had a 
_point_.

> Then release a 1.6.0.1. But the major problem is something else: it's that
> doing PATH="$PATH:$(git --exec-path) is also deprecated, i.e. that workaround
> is to go away in one of the next releases too.

NO, IT IS NOT DEPRECATED.

That was a plan. I think that plan got scuttled already. Stop whining!

Can't you understand that people can change plans based on feedback?

Effing whiners. 

		Linus
