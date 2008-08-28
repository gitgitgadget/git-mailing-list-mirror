From: Jeff King <peff@peff.net>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 17:23:47 -0400
Message-ID: <20080828212346.GA27867@coredump.intra.peff.net>
References: <alpine.DEB.1.10.0808271717190.19923@gandalf.stny.rr.com> <7vd4jukphm.fsf@gitster.siamese.dyndns.org> <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu> <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu> <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Thu Aug 28 23:25:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYoz9-0002Dn-Vf
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 23:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013AbYH1VXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 17:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754547AbYH1VXv
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 17:23:51 -0400
Received: from peff.net ([208.65.91.99]:1501 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753563AbYH1VXu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 17:23:50 -0400
Received: (qmail 7713 invoked by uid 111); 28 Aug 2008 21:23:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 28 Aug 2008 17:23:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2008 17:23:47 -0400
Content-Disposition: inline
In-Reply-To: <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94178>

On Thu, Aug 28, 2008 at 01:23:50PM -0700, Perry Wagle wrote:

> But, my problem is not git<DASH> vs git<SPACE>, but the slap-dash way  
> upward compatibility was broken and the "water over the dam" slippery  
> slope rationalizations that refuse to consider reverting.  "You" will do 
> it again in the future since you are declaring success here.  And "you" 
> have likely done it in the past 6 months.

I don't think Junio is declaring success. In fact, I think he has sent
several messages saying (paraphrasing of course):

  - this was obviously not done in the best manner possible, because of
    the number of people complaining

  - we will try to do better about notification next time such a change
    is made. Please make suggestions about how to do so.

  - since we have already released and already broken everybody, and
    these people are now complaining on the list, there is not much
    point in trying to notify people of _this_ change now

Junio (and others) have tried to be very careful about breaking
backwards compatibility, especially for scripting interfaces. We thought
sufficient steps were taken this time, but clearly some disagree.

So please stop making specious claims that there are crazy
backwards-incompatibility bugs lurking throughout new versions of git.
If there are, then please find and name them. If not, then I think the
git community would welcome suggestions about how better to notify users
about the rare changes like this one.

-Peff
