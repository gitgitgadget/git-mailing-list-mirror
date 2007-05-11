From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] user-manual: Use "git config --global" instead of editing ~/.gitconfig
Date: Fri, 11 May 2007 22:23:43 +0200
Message-ID: <20070511202343.GB13880@efreet.light.src>
References: <200705102353.31821.johan@herland.net> <20070510220253.GZ13719@fieldses.org> <20070510230045.GF4489@pasky.or.cz> <20070511034653.GB26896@fieldses.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Cc: Petr Baudis <pasky@suse.cz>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri May 11 22:24:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmbeg-0002hR-ME
	for gcvg-git@gmane.org; Fri, 11 May 2007 22:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832AbXEKUXw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 16:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757391AbXEKUXw
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 16:23:52 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:1701 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755653AbXEKUXv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 16:23:51 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.190837;
	Fri, 11 May 2007 22:23:43 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HmbeR-0007F6-Qb; Fri, 11 May 2007 22:23:43 +0200
Content-Disposition: inline
In-Reply-To: <20070511034653.GB26896@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46979>


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2007 at 23:46:53 -0400, J. Bruce Fields wrote:
> On Fri, May 11, 2007 at 01:00:45AM +0200, Petr Baudis wrote:
> > However, in that case I think this is not the good point to show
> > ~/.gitconfig. Your goal at that point should be to get the user able
> > to commit as simply as possible,
>=20
> Sure.

I would vote for telling users both ways to do it on that spot.
Something along the lines:

    git-config --global user.email ...
    git-config --global user.name ...

    Alternatively, you can edit ~/.gitconfig and add the following:
    {{{
    [user]
    email =3D ...
    name =3D ...
    }}}

I don't like the current description with cat or echo or what it is though.
It requires more thinking than necessary and especially as the mingw port
progresses there will be more Windows users to whom this will be totaly
confusing.

> > and having to manually edit some config file is unnecessary hassle
> > when you can just use these two simple commands;
>=20
> I don't get it; why are the two commands "simple", and editing a file a
> "hassle"?  In terms of, say, time required, or number of keystrokes, I
> suspect the two are about the same.  And it seems to me that:
>=20
> 	- As users of a tool designed mainly to track changes to text
> 	  files, git users are likely to be pretty proficient at editing
> 	  text files.
> 	- People also need to be able to view the configuration and
> 	  change it.  If they make a typo on the first try, they may
> 	  need to do this sooner rather than later.  With a config file,
> 	  this is trivial.  With git-config, you have to learn at least
> 	  one new thing (how to query values).
> 	- The config file is easier to read than the git-config output.
> 	- You're going to have to edit some text anyway to plug your
> 	  name in, so we can't make this a pure cut-n-paste from the
> 	  docs.

Well, I would not say editing the difference is that big, but I do think it=
's
easier to call two commands. Maybe it's psychological "I have to write
something to get it working", even though it's actually less keystrokes than
calling the commands.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGRNDPRel1vVwhjGURAkJ3AJ90gJTT0Dh+w4rq9Iix3mGxOHAifgCeKo47
RiZK4BEuWJEUxhf3eiuwzUI=
=zsAT
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
