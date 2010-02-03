From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: extra headers in commit objects
Date: Wed, 03 Feb 2010 15:03:42 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002031456510.1681@xanadu.home>
References: <20100203174041.GC14799@spearce.org>
 <alpine.LFD.2.00.1002031311010.1681@xanadu.home>
 <9b18b3111002031101p3385ecdfo638433bc269791aa@mail.gmail.com>
 <20100203192658.GP9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: demerphq <demerphq@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Feb 03 21:03:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NclS1-0006ll-3M
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 21:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757761Ab0BCUDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 15:03:44 -0500
Received: from relais.videotron.ca ([24.201.245.36]:31771 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757693Ab0BCUDn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 15:03:43 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KXA009S97Q6LC60@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 03 Feb 2010 15:03:43 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100203192658.GP9553@machine.or.cz>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138880>

On Wed, 3 Feb 2010, Petr Baudis wrote:

> On Wed, Feb 03, 2010 at 08:01:17PM +0100, demerphq wrote:
> > Shouldn't an old git just ignore headers from a new git?
> > 
> > I mean, forget about the fact that somebody is doing something naughty
> > with the git protocol, ask youself if you want this rule to basically
> > prevent any backwards compatible changes with older gits.
> 
> We have done similar changes in the past and if there would be such
> a change, we can phase-in it over the course of several releases.
> I think the fall-out would not be that bad; we have some experience
> with even making Debian-stable Git compatible with new stuff. ;-)

Heh...  That's because I was crazy enough to do that work so the new 
features I implemented in the latest version could be enabled by default 
sooner.  And incidentally those features weren't controvertial at all 
which sorta helped.


Nicolas
