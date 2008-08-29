From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Fri, 29 Aug 2008 11:24:51 -0400
Message-ID: <20080829152451.GA20629@yugib.highrise.ca>
References: <18219E52-E56F-43D9-B28D-0CC74E225CC5@cs.indiana.edu> <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu> <20080828212346.GA27867@coredump.intra.peff.net> <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu> <20080828215907.GE27867@coredump.intra.peff.net> <3DE083DB-ADFF-45E7-B3EB-A76985941271@cs.indiana.edu> <881C17DA-2FE2-49A7-A4A9-FACA7720599C@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Cc: Jeff King <peff@peff.net>, Teemu Likonen <tlikonen@iki.fi>,
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
X-From: git-owner@vger.kernel.org Fri Aug 29 17:27:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ5rL-0002My-Kd
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 17:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbYH2PYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 11:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbYH2PYy
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 11:24:54 -0400
Received: from yugib.highrise.ca ([205.150.199.213]:37988 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbYH2PYx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 11:24:53 -0400
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id D91D8111E39;
	Fri, 29 Aug 2008 11:24:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <881C17DA-2FE2-49A7-A4A9-FACA7720599C@cs.indiana.edu>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94305>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Perry Wagle <wagle@cs.indiana.edu> [080801 00:00]:
> Jeff King has convinced me that it's perfectly legitimate to introduce  
> non-upward compatibilities in minor version releases of "young"  
> software.

This is the gist of the problem.  You keep hammering about a
"non-upwards compatibilities in minor version releases", yet you have
*not* pointed out one such in-compatibility in a minor version release..

Remember, in git, 1.6 is a "major version" release, with release notes, etc.
1.5.X is a "minor version" release.
1.5.X.Y is a "patch" release.

It's a pretty normal versioning scheme.

Git 1.5.X -> Git 1.6.X is a major release upgrade.  And the Git 1.5
release notes have claimed for a while that git-<cmd> executibles are
going to be moved out of the default path for a while.  And the Git 1.6
release notes claimed they were...

*And* git developpers have admitted that communication about that
pending change was obviously insufficient...

But that's a hard problem...

How do developers make sure that users are reading release notes?
*Especially* in a world where software is packaged up by
systems/distros/etc.  It's a problem that hits software across the
board, linux kernel, PostgreSQL, glibc, gcc, X.org, HylaFAX, and yes,
git.

Git 1.5.4 has had the "git-exec-dir in path" deprecated for months.  How
can we do a better job of letting *users* know of the documented stuff
in the release notes?

Can you imagine the outcry if git was made to look for the config value
core.hasreadreleasenotes.<version> on every invocation, and if it wasn't
set, forced the releasenotes throught the pager?  That way, you woudl
have known 6 months ago that git had published release-notes saying that
git-exec-dir change was going to happen...

-- 
Aidan Van Dyk                                             Create like a god,
aidan@highrise.ca                                       command like a king,
http://www.highrise.ca/                                   work like a slave.

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFIuBTDuVxNPsxNPScRAnFEAJ0TfBY0ydS2mqlfEUR7wmywKpj30QCbBTKn
HdRYWjEScDhirtytgrbn018=
=nbdm
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
