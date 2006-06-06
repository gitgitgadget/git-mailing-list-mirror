From: Jon Loeliger <jdl@freescale.com>
Subject: Re: New release?
Date: Tue, 06 Jun 2006 12:58:45 -0500
Message-ID: <1149616724.23938.85.camel@cashmere.sps.mot.com>
References: <Pine.LNX.4.64.0606052002530.5498@g5.osdl.org>
	 <7vodx6zus2.fsf@assigned-by-dhcp.cox.net>
	 <1149610100.23938.75.camel@cashmere.sps.mot.com>
	 <7v3beitdct.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jun 06 20:03:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnftT-00009r-HQ
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 20:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWFFSDE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 14:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWFFSDE
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 14:03:04 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:10161 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1750714AbWFFSDB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 14:03:01 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k56IJHUt028650;
	Tue, 6 Jun 2006 11:19:17 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k56I2Xoi016854;
	Tue, 6 Jun 2006 13:02:34 -0500 (CDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3beitdct.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21391>

On Tue, 2006-06-06 at 12:15, Junio C Hamano wrote:

> I think the virtual hosting of git-daemon is very important, and
> I do not want to have a half-baked one hurriedly cobbled
> together for 1.4.0 on the server side.

Agreed.

> I do agree it is a good idea to have the client-side support in
> 1.4.0; that would work well with the current git-daemon.  Since
> the extension is backward compatible, we can tell the users to
> use 1.4.0 or later clients when the daemon side is done.  That
> is much nicer than telling them to use what's on "master" that
> is later than such-and-such commit.

Exactly.

> > Any chance for that?  If you'd like, I work on resubmitting
> > just those bits with the connect function refactoring
> > that you outlined.
> 
> I appreciate the offer very much.

No problem.

>   Although I said port is
> something the server side can usually tell, I would throw in
> port there as well.

Can do.

>  Any reason to spell HOST in all uppercase by the way?

I would never suggest that it came to me from 
gittus in an IRC day-dream...? :-)

Consider it all lowercaseified instead.

jdl
