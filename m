From: Michael Niedermayer <michaelni@gmx.at>
Subject: Re: suggestions for gitweb
Date: Sun, 13 May 2007 02:01:52 +0200
Message-ID: <20070513000151.GT14859@MichaelsNB>
References: <20070512205529.GS14859@MichaelsNB> <7v8xbtwtsy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hD4TXpRh/LvuDKsa"
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Petr Baudis <pasky@ucw.cz>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 02:06:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn1b3-0000AL-Vf
	for gcvg-git@gmane.org; Sun, 13 May 2007 02:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbXEMAFw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 20:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755306AbXEMAFw
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 20:05:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:50091 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751998AbXEMAFv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 20:05:51 -0400
Received: (qmail invoked by alias); 13 May 2007 00:05:49 -0000
Received: from chello080109116125.4.15.vie.surfer.at (EHLO localhost) [80.109.116.125]
  by mail.gmx.net (mp030) with SMTP; 13 May 2007 02:05:49 +0200
X-Authenticated: #3831892
X-Provags-ID: V01U2FsdGVkX1+UDR4zoIOUqfO+quJZCFlJpzgbm9G2KC/LDpIik9
	w3tEWgUMMbNaSF
Content-Disposition: inline
In-Reply-To: <7v8xbtwtsy.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.10i
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47113>


--hD4TXpRh/LvuDKsa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

On Sat, May 12, 2007 at 03:39:25PM -0700, Junio C Hamano wrote:
> Michael Niedermayer <michaelni@gmx.at> writes:
>=20
> > * gitweb uses many terms which are new to a non git user, and while
> >   devlopers who work on ffmpeg will very likely very quickly have
> >   figured out the meaning of all of them. i think simple users who just
> >   want to browse the ffmpeg code will have their problems, so i belive=
=20
> >   a small help text linked to from all pages which contains a short
> >   definition of all the git(web) specific terms would be very helpfull
> >   something like
> >     blob        - file      at a specific revission/date
> >     tree        - directory at a specific revission/date
> >     (short) log - project wide commit log
> >     history     - short log equivalent for a file or directory
>=20
> Coming fron non-CVS camp, I think changing this to non-git terms
> is very harmful than educating users who are migrating from
> other systems.

you must missunderstand me :(
i want to educate them, but i cannot as iam not speaking about ffmpeg
developers/contributors but rather random people who are curious and=20
want to take a look at the ffmpeg source

for them a simple help link similar to "ViewVC Help" which viewvc has
on the bottom right of its pages would be great IMHO
also the text above is a pure random suggestion by a svn user and was
not intended to redefine any git terms


>=20
> > * The color of adjacent blame "hunks" is so similar that its
> >   indistinguishable on my notebook TFT when iam looking at it from slig=
htly
> >   above
>=20
> This is more or less intentional to make the difference not too
> distracting.  I thought it was controlled via css which
> something you can use browser side tricks to suite your taste?

i sure can, i just thought the default was less than optimal


>=20
> > * The blame page shows the SHA1 for each hunk and IMHO thats the last t=
hing
> >   i would want to see first, id be much more interrested in by whom and
> >   when a given change was done, iam wondering in which case the SHA1 wo=
uld
> >   be usefull? copy-paste onto your command line git tools but then why
> >   use gitweb at all, 'git blame' would make more sense IMHO and a simple
> >   click would reveal the sha1 with more info anyway ...
>=20
> They serve no purpose other than showing something to click on,
> and allow you to hover over (some people argued in the past
> that they recognize certain commit object names, but honestly I
> would not believe them).  However, I do not think there are much
> better alternatives.  Try coming up with a different "label"
> string that is of uniform length across commits, and does not
> chew up too much screen real estate.

trivial
the first N chars of the username + YYMMDD

so for example:
michaeln070612

or with space:
michaeln 070612


[...]
> > * on the history page there are "blob", "commitdiff" and "diff to curre=
nt"
> >   the obvious missing one is "diff to previous" which would be the diff=
 to
> >   the previous blob of this file
>=20
> Isn't that commitdiff, or commitdiff on that page does not limit
> the diff to the blob?

commitdiff doesnt limit it to the blob ...

[...]
--=20
Michael     GnuPG fingerprint: 9FF2128B147EF6730BADF133611EC787040B0FAB

Observe your enemies, for they first find out your faults. -- Antisthenes

--hD4TXpRh/LvuDKsa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGRlVvYR7HhwQLD6sRAkxZAJ0QWnulvtWd0yDyyzYWnIZY1vu8GgCbB4xu
Cs7sN1ByVx0YoAIfKoyKsCM=
=pDfJ
-----END PGP SIGNATURE-----

--hD4TXpRh/LvuDKsa--
