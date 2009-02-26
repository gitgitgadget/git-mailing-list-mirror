From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: topgit patches
Date: Thu, 26 Feb 2009 15:15:48 +0100
Message-ID: <20090226141548.GA32439@pengutronix.de>
References: <20090225195856.GA12372@pengutronix.de> <20090225212309.GM12275@machine.or.cz> <20090225231550.GA19741@pengutronix.de> <20090226060652.GA16251@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Thu Feb 26 15:19:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lch4o-0005UD-Un
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 15:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757254AbZBZOQu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2009 09:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757323AbZBZOQs
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 09:16:48 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56464 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbZBZOPv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 09:15:51 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lch1g-0000F4-FZ; Thu, 26 Feb 2009 15:15:48 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lch1g-0005EA-5F; Thu, 26 Feb 2009 15:15:48 +0100
Content-Disposition: inline
In-Reply-To: <20090226060652.GA16251@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111563>

Hi Martin,

On Thu, Feb 26, 2009 at 07:06:52AM +0100, martin f krafft wrote:
> also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2009=
=2E02.26.0015 +0100]:
> > Well, I already wondered if there is someone using topgit apart
> > from me. :-)
>=20
> I use it and would like to actively maintain it, but time is short
> and I wanted to push out a new option parser with 0.6, but it's just
> not finished yet. As soon as I find a few hours, I'll try to revisit
> it. But if someone else has the time, maybe we can prepare a 0.6
> without a new option parser?
If you need help, I'm also interested to co-maintain the debian package=
=2E
Just an offer ...  (I don't know the exact way to become a maintainer,
if I need to meet a Debian developer, that's no problem, I know one.)
=20
> > Given this situation it probably doesn't make sense to describe
> > some problems I currently see using topgit :-|.
>=20
> Please do, I am interested.
Sometimes I get an error about being unable to delete a temp file, will
try to track that down when it happens next.

Having many topgit controlled patches it's hard to get the overview.
Updating patches with many interdependencies is hard and doing a merge
wrong is hard to detect and fix.  I don't have a good idea for that yet=
,
but I will investigate some thought here.

=46urther ideas and plans of mine in no particular order:
 1 move all or most topgit-topic-branches to a private namespace, say
   refs/top-heads because the patch branches pollute the output of git
   branch.

 2 export method that works like the existing linearize but creates
   branches for topgit branches living in refs/heads and merges these
   properly without linearisation.
   (obviously depends on 1)

 3 address topgit bugs on bugs.debian.org

 4 factor out some code to helper functions in tg.sh

 5 convice my colleagues that topgit is the right tool to gain world
   domination :)

 6 I'm sure I will find some more while doing 1 to 5. :)

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
