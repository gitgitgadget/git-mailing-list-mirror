From: Petr Baudis <pasky@suse.cz>
Subject: Re: extra headers in commit objects
Date: Wed, 3 Feb 2010 20:26:59 +0100
Message-ID: <20100203192658.GP9553@machine.or.cz>
References: <20100203174041.GC14799@spearce.org>
 <alpine.LFD.2.00.1002031311010.1681@xanadu.home>
 <9b18b3111002031101p3385ecdfo638433bc269791aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 20:27:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcksZ-0003tJ-4H
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 20:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757364Ab0BCT1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 14:27:06 -0500
Received: from w241.dkm.cz ([62.24.88.241]:38053 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756024Ab0BCT1E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 14:27:04 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 1CCFF86208C; Wed,  3 Feb 2010 20:26:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <9b18b3111002031101p3385ecdfo638433bc269791aa@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138867>

On Wed, Feb 03, 2010 at 08:01:17PM +0100, demerphq wrote:
> Shouldn't an old git just ignore headers from a new git?
> 
> I mean, forget about the fact that somebody is doing something naughty
> with the git protocol, ask youself if you want this rule to basically
> prevent any backwards compatible changes with older gits.

We have done similar changes in the past and if there would be such
a change, we can phase-in it over the course of several releases.
I think the fall-out would not be that bad; we have some experience
with even making Debian-stable Git compatible with new stuff. ;-)
Also, what if any extra header would be essential and we _wanted_
non-compatible Git to break down on it?

On the other hand, allowing this preventively would apparently have
the immediate effect of alternative implementations users happily
starting to use it, and then to get to the data, people would demand
git-core support as well. _And_ so far everyone seems really really
fairly sure we don't want the headers and it's not likely to change.


P.S.: On the other hand, I think that change was probably just
misguided, not malicious. And I wouldn't be that hard on Dulwich,
it's an early-0.x software after all, it's allowed to crash and have
protocol issues. ;-)

-- 
				Petr "Pasky" Baudis
If you can't see the value in jet powered ants you should turn in
your nerd card. -- Dunbal (464142)
