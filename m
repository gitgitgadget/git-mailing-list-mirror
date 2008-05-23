From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH v2 07/24] Added findWorkTree method to Repository class.
Date: Fri, 23 May 2008 16:39:30 -0400
Message-ID: <20080523203930.GV29038@spearce.org>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <1210623222-24908-8-git-send-email-florianskarten@web.de> <20080513002409.GC29038@spearce.org> <4837090F.4000307@web.de> <20080523183151.GT27724@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian =?utf-8?Q?K=C3=B6berle?= <FloriansKarten@web.de>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri May 23 22:40:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jze3w-0007t5-4O
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759437AbYEWUjg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 May 2008 16:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759450AbYEWUjf
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:39:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53734 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759374AbYEWUje convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2008 16:39:34 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jze2t-0000Ap-EG; Fri, 23 May 2008 16:39:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E2DD820FBAE; Fri, 23 May 2008 16:39:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080523183151.GT27724@genesis.frugalware.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82757>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Fri, May 23, 2008 at 08:12:31PM +0200, Florian K=C3=B6berle <Flori=
ansKarten@web.de> wrote:
> > Also it is better extenable:
=2E..
> > if (a) {
> > 	something0():
> > +	something1();
> > }
> >=20
> > compared too:
> >=20
> > -if (a)
> > +if (a) {
> > 	something0();
> > +	something1();
> > + }
>=20
> Different programmers have different coding style. A standard is need=
ed,
> otherwise different parts of the code will have different style. It's
> quite normal if a contributor has to code in the project's coding sty=
le,
> rather than his own one, I think.
>=20
> Also I don't think "but this style is confusing for newbies" is a val=
id
> argument, newbies should learn to read code, rather than others need =
to
> write newbie-friendly code. ;-)

Right.

Basically Robin and I have settled on a style not too far from the
one that git.git itself uses, at least where they could pertain to
Java and its semi-C syntax rules.  Part of the reason is because
we (and others in the git community) are just used to this style.

Its shorter vertically, allowing more room for code and comments in
a single screen full.  It also minimizes the number of places where
"\t\t}\n" appear on a line by itself in the context of a patch,
reducing errors from patch hunks applying in the wrong position.

In a little over a month and a half I start a new job.  My new
employer apparently has really strict rules about how code should
be formatted, and everyone in the company has to adhere to them.
No exceptions.  The rules are supposedly quite strange, but the
entire code is at least consistent, and thus easier to follow.
So yea, I get to also go through some strange style thing soon.

When in Rome, do as the Romans do... :-|

--=20
Shawn.
