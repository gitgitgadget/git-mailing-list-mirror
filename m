From: Petr Baudis <pasky@suse.cz>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 22:44:18 +0200
Message-ID: <20080828204418.GY10360@machine.or.cz>
References: <alpine.DEB.1.10.0808271717190.19923@gandalf.stny.rr.com> <7vd4jukphm.fsf@gitster.siamese.dyndns.org> <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu> <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu> <20080828090421.GQ10360@machine.or.cz> <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
X-From: git-owner@vger.kernel.org Thu Aug 28 22:45:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYoMw-0007GW-5I
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 22:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660AbYH1UoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 16:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752913AbYH1UoV
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 16:44:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53037 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437AbYH1UoV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 16:44:21 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B9B983939B57; Thu, 28 Aug 2008 22:44:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94137>

On Thu, Aug 28, 2008 at 01:23:50PM -0700, Perry Wagle wrote:
>
> On Aug 28, 2008, at 12:52 PM, Teemu Likonen wrote:
>
>> I have come to understand that "git " has quite long time been more
>> robust and portable way of writing scripts. They work in both
>> configurations so I'd definitely suggest doing "s/git-/git /g" for every
>> script. Of course in an interactive shell everyone can use whatever they
>> prefer and works at the moment.
>
> Sure.  Its an extra fork in git command intensive scripts (and git is racey 
> still maybe), but *shrug*.

Do you have any details on the races in Git you know about?

This does not mean an extra fork, only extra exec. In case of builtin
commands (which is actually a large majority by now), not even that.

> Even as of March 2008 (our last sync with git before the git scripting was 
> completed and we got on to other things), the sample scripts and gitweb 
> still used the git<DASH> form.  If this has been brewing for two years, 
> there shouldn't have been a git<DASH> form in the scripts in the standard 
> source *anywhere* for those two years.

I agree that this is a problem. Even now, the documentation is using
git- at plenty of places. Patches are welcome, I'm sure.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
