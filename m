From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 22:52:11 +0300
Message-ID: <20080828195211.GA3545@mithlond.arda.local>
References: <38B725C0-40C3-496C-AAD4-4EA65E3085F5@cs.indiana.edu> <48B5BC5F.4070209@kernel.org> <alpine.DEB.1.10.0808271717190.19923@gandalf.stny.rr.com> <7vd4jukphm.fsf@gitster.siamese.dyndns.org> <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu> <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu> <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jeff King <peff@peff.net>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Thu Aug 28 21:54:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYnZm-0005vX-H0
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 21:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbYH1TxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 15:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753482AbYH1TxI
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 15:53:08 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:41915 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753967AbYH1TxH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 15:53:07 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 488F1534015D52AE; Thu, 28 Aug 2008 22:52:16 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KYnXP-0002cr-MR; Thu, 28 Aug 2008 22:52:11 +0300
Content-Disposition: inline
In-Reply-To: <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94125>

Perry Wagle wrote (2008-08-28 12:24 -0700):

> Is is really only that I
> 
>     sed s/git-/git<SPACE>/g
> 
> on the scripts?  I'm doubting it, given the quality of reasoning and
> lack of respect for upward compatibility on this thread.

I have come to understand that "git " has quite long time been more 
robust and portable way of writing scripts. They work in both 
configurations so I'd definitely suggest doing "s/git-/git /g" for every 
script. Of course in an interactive shell everyone can use whatever they 
prefer and works at the moment.
