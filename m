From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] object name: introduce ':::<oneline prefix>' notation
Date: Sat, 24 Feb 2007 02:35:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702240229540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702231930290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702232347310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm741hfx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 24 02:35:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKlow-0004dM-7Z
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 02:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933319AbXBXBf1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 20:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933320AbXBXBf1
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 20:35:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:57364 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933319AbXBXBf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 20:35:26 -0500
Received: (qmail invoked by alias); 24 Feb 2007 01:35:25 -0000
X-Provags-ID: V01U2FsdGVkX1/uexcPoMPuK18JnwseswQ7jDvb5S0yeYFgxfxP/a
	CJxg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vzm741hfx.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40484>

Hi,

On Fri, 23 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 23 Feb 2007, Johannes Schindelin wrote:
> >
> >> To name a commit, you can now say
> >> 
> >> 	git rev-parse ':::Initial revision of "git"'
> >
> > Alex Riesen and Shawn Pearce suggested ":/" instead of ":::", to reflect 
> > the searching nature ("/" is the key to search in "less" output).
> >
> > Comments?
> 
> Sounds good.  "git show :/path" does not currently mean "find /path in 
> the index", so I do not see offhand it would interfere with anything.

That's also what Shawn said.

> However, it would be worthwhile to plant an escape hatch for future 
> extension.  Using short-and-sweet ":/" for the most common case such as 
> exact prefix match would be fine, but we might want to say:
> 
> 	':/!' syntax is reserved for future extension and does
> 	not look for a string that begins with "!".

Okay. Will rework.

> Obvious extension possibilities include:
> 
> 	":/!(r=regexp)"
>         ":/!(a=author)"
> 	":/!(d=2001-09-17)"
> 	":/!(p=Documentation/)"
> 
> or various combination of them e.g.
> 
> 	":!(p=Documentation/)!(a=Johannes)Update command list"

They are much harder to implement. So I'll leave that to others :-)

> By the way, where do you start digging from?  From all refs?

Yes, all refs. In order of the date.

Ciao,
Dscho
