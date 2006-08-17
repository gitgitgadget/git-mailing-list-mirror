From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: use action dispatcher for non-project actions, too.
Date: Thu, 17 Aug 2006 21:43:32 +0200
Message-ID: <20060817194332.GC11477@admingilde.org>
References: <11557673213372-git-send-email-tali@admingilde.org> <11557673212235-git-send-email-tali@admingilde.org> <1155767325181-git-send-email-tali@admingilde.org> <11557673263081-git-send-email-tali@admingilde.org> <11557673262714-git-send-email-tali@admingilde.org> <11557673281583-git-send-email-tali@admingilde.org> <7vk65815h1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 21:43:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDnmD-00053W-DT
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 21:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWHQTne (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 15:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWHQTne
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 15:43:34 -0400
Received: from agent.admingilde.org ([213.95.21.5]:35035 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751269AbWHQTnd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 15:43:33 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GDnm8-0003lk-6e; Thu, 17 Aug 2006 21:43:32 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk65815h1.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25609>


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Aug 16, 2006 at 07:06:02PM -0700, Junio C Hamano wrote:
> Martin Waitz <tali@admingilde.org> writes:
>=20
> > Allow to use the global action dispatcher for all actions by introducing
> > "/actions".  If no project directory is given then a / is prepended to =
the
> > action and the normal dispatcher is called.
> > Project list and OPML generation are now hooked into the list as "/summ=
ary"
> > and "/opml".
> >
> > As "/" is not an allowed character in actions accepted through the CGI
> > parameters, it is still ensured that no normal action can be called wit=
hout
> > giving a valid project directory.
> >
> > Signed-off-by: Martin Waitz <tali@admingilde.org>
> > ---
> >  gitweb/gitweb.perl |   17 ++++++++---------
> >  1 files changed, 8 insertions(+), 9 deletions(-)
>=20
> You completely lost me.  What are you trying to achieve here?

I just want to separate all the URL generation/parsing from the rest
of the code.
So I removed the opml/project list calls from the parsing code.

The target is to be able to be able to replace it without influencing
other parts of the code.

> I suspect this kind of funkies (and PATH_INFO) might be easier
> to do in mod_rewrite() outside gitweb, but that is probably just
> me.

Well, I think that the URL shown in the browser is one important
part of the user interface of a web page. So we should not rely
on the system administrator to implement it on his own.

--=20
Martin Waitz

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE5Mbkj/Eaxd/oD7IRAkSlAJ0U05jFD2HOCf1K+9HF3nSIRE3NFwCeLUBH
hzz/Mksq2A5ISqQoJ7He3Ek=
=fPHX
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
