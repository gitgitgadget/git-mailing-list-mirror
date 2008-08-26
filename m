From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 16:21:41 -0700
Message-ID: <23DFA9EC-9523-4179-BA3C-ACBDB82953DF@cs.indiana.edu>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <20080826180926.GA25711@isilmar.linta.de> <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	David Woodhouse <dwmw2@infradead.org>,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 01:48:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY8H5-0004sX-Er
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 01:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbYHZXra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 19:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbYHZXra
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 19:47:30 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:47344 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbYHZXra (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 19:47:30 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.85) with ESMTP id m7QNLpVk015787;
	Tue, 26 Aug 2008 19:21:52 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7QNLg71001436
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 26 Aug 2008 19:21:46 -0400
In-Reply-To: <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93836>


On Aug 26, 2008, at 11:19 AM, Linus Torvalds wrote:
> I don't actually personally feel all that strongly, but I _do_ think  
> that
> right now the git-xyzzy proponents are whining. All of their  
> arguments are
> pure and utter CRAP, considering the triviality of
>
> 	PATH="$PATH:$(git --exec-path)"

Scripts.  Remote scripts.  Scripts running as arbitrary users.

I'm trying to upgrade the git that our scripts use, and having the  
users modify their paths doesn't work.

Not that horrible to fix some other way, but still a rude thing to  
wake up to one day. (ie, today)

-- Perry Wagle (wagle@mac.com)
