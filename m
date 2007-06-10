From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 10 Jun 2007 12:49:01 +0200
Message-ID: <20070610104901.GE4084@efreet.light.src>
References: <20070603114843.GA14336@artemis> <20070609121244.GA2951@artemis> <46a038f90706092359i43a6e834rc096e53a28fbee51@mail.gmail.com> <20070610083754.GC4084@efreet.light.src> <46a038f90706100155q1da663d7le3bf0345c68e47ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 12:49:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxKz1-0005Hb-Lm
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 12:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbXFJKtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 06:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbXFJKtI
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 06:49:08 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:51506 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904AbXFJKtH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 06:49:07 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 8659C573D3;
	Sun, 10 Jun 2007 12:49:04 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HxKyk-0000jI-0b; Sun, 10 Jun 2007 12:49:02 +0200
Content-Disposition: inline
In-Reply-To: <46a038f90706100155q1da663d7le3bf0345c68e47ae@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49709>


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 10, 2007 at 20:55:21 +1200, Martin Langhoff wrote:
> On 6/10/07, Jan Hudec <bulb@ucw.cz> wrote:
> >I don't know about any *distributed* bug tracker, which is the point her=
e.
>=20
> As an end user, I suspect I _don't_ want to have to report a bug in a
> distributed bug tracker ;-)

As an end user, you would just post the bug report to a mailing list. The b=
ug
tracker would take care of adding it to the "master repository".

> In that space, the Malone guys (canonical)
> have their fingers on one of the most serious issues, and perhaps it's
> interesting to see what they've done there. It's really useful, even
> if I don't think I want to have to maintain it :-/

I don't think they even have a mail interface. You have to register to post
a bug, just as with most of the crappy web-based bug trackers out there.

They have some nice integration with bazaar, but AFAIK the branch has to be
mirrored on launchpad, to which the whole thing is really tied too much.
Also I can find download link anywhere there, nor anywhere they'd state it's
license (and from what I heard it is NOT open-source).

So while they might have some nice features, it's not that suitable for
general public.

> >We have several distributed version control tools, but no other distribu=
ted
> >tools for the other tasks in configuration management.
>=20
> Bugtrackers are co-owned by developers, users and (where they exist)
> project managers.

I agree that branches don't make that much sense in bug trackers. Except in
rare cases like when the project is forked or such. The bug tracker is there
so the people stay in sync. However I think trying to design a distributed
bug tracker can bring useful insignts into the problems involved.

> > - The web interface is usually not a good match for the problem. Email
> >   interface is better in many respects, but it still does not cut it.
>=20
> I agree. I love/hate debbugs too.

=2E.. there's a related issue of what the mail user agents can do. If my ma=
il
client was really good as personal task manager, mail-based bug trackers
would work quite well. But the MUAs are not all that good.

> > - You can't really use the ability of version control to work=20
> > disconnected,
> >   when you don't also have the bug information.
>=20
> A cache fixes the reading part  - see my other post, and imagine being
> able to have a local sqlite cache of the BT key data indexed by
> referenced SHA1, showing up with your commits in gitk.
>=20
> The write part is solved (in part) by committing to git the fix -- if
> you mentionm the bug ID, the central BT will pick it up when your
> commit appears in the branches/repos that the BT can see.
>=20
> For "just adding a comment", the write part is solved by the "email"
> interface, like with debbugs.
>=20
> > - Distributed version control is designed to decrease the workload of t=
he
> >   central maintainer(s) while keeping him in control. But with centrali=
zed
>=20
> And to provide a single place for users to report a problem and track
> its status.

Just like there is the "master" repository, there would be the "master" bug
tracker.

> >If it uses git as it's database, which it probably will,
>=20
> Well - hmmm. Git's database is great at tracking _content identity_.
> But a bug's content identity (description+comments+status) changes all
> the time. I don't think it's naturally a good match.
>=20
> Perhaps it makes sense to mix git's storage model with something else...?

You are right here. Git can be used to store the data bits, but they need to
be glued together somehow (with tags or something). So we can as well store
them in some other kind of database and it might be even better.

> >Yes. But for many people current bug tracking tools do NOT work 99%.
>=20
> Hmmm. I agree in that "does not work disconnected" is a big issue with
> web tools, but debbugs works disconnected, and is good. Git's
> bugtracker (git@vger) works disconnected too ;-) And googlegears might
> help the rest of us. Is there any other problem with current BTs?

Well, there is no BT that would satisfy all the points above ;-). Debbugs h=
as
a good email interface, but it's a huge beast and tied with the Debian
archive logic quite a lot. The rest -- except maybe gnats (I'll have to look
at that -- it looks interesting) -- does not seem to have much sensible ema=
il
support.

Following up on the note about MUAs above, one interesting idea to create
a bug tracker (that would not be git specific nor actually use git for
anything) would be to:
 - Create a mailing list bot, that would watch for bug reports either on
   dedicated address or by watching for [BUG] or something, and replies to
   them.
 - Export the bug database via read-only imap (or pop3 or webdav). There are
   already tools to create local cache for such protocols, which would
   resolve the disconnected issue and give good query speed, because the da=
ta
   would be local.
 - The server would make sure that all the messages applying to a particular
   issue are correctly linked with In-Reply-To: headers to form a single
   thread.
 - Status of the bug could be expressed with mailbox it is in (backwards
   compatible way) or some kind of tags (which would need to be supported by
   the mail client -- I really think it's about time for something like
   that).
 - Other metainformation about the bug could be added as a special message
   inserted at the begining of the thread, or added into the first message
 - Than support for todo management could be improved in some mail clients.
   It is not precondition for this kind of bug tracking to be useful and on
   the other hand would be useful on it's own.
 - It could even be done as another interface to an existing web-based BT,
   though I would prefer if the web interface would not have to be running
   then.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGa9cdRel1vVwhjGURAh58AJwKmjyhHeZ8uoRTXzR5IjHDIlMyygCfWJJu
fkOd9bL+OnlMNsdfe4xjgi4=
=4BYB
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--
