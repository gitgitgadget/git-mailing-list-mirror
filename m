From: Florian Mickler <florian@mickler.org>
Subject: Re: git-svn and repository hierarchy?
Date: Sun, 8 Mar 2009 21:33:40 +0100
Message-ID: <20090308213340.6784e685@schatten>
References: <20090227220512.GC14187@raven.wolf.lan>
	<49A97B7A.8010005@drmicha.warpmail.net>
	<20090303185108.GA11278@raven.wolf.lan>
	<eaa105840903031135o4cf72ed0oe3fffed69cb7ce03@mail.gmail.com>
	<20090303223600.GB11278@raven.wolf.lan>
	<eaa105840903031618s5e0b6f24j64aade8d752fb11@mail.gmail.com>
	<20090304192752.GC11278@raven.wolf.lan>
	<eaa105840903041406k36088763w5a70fe1d7458dfb1@mail.gmail.com>
	<20090305180529.GD11278@raven.wolf.lan>
	<eaa105840903051148s3515e8b7x9d7b8f9be12da735@mail.gmail.com>
	<20090306161026.GA14554@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ph8Jd+QU7bdL4kU6i=8h0c.";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: git@vger.kernel.org, Peter Harris <git@peter.is-a-geek.org>
To: Josef Wolf <jw@raven.inka.de>
X-From: git-owner@vger.kernel.org Sun Mar 08 22:09:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgQF7-0007cS-Ns
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 22:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbZCHVHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 17:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754270AbZCHVHh
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 17:07:37 -0400
Received: from ist.d-labs.de ([213.239.218.44]:43612 "EHLO mx01.d-labs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753542AbZCHVHg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 17:07:36 -0400
X-Greylist: delayed 1998 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Mar 2009 17:07:35 EDT
Received: from schatten (f053208153.adsl.alicedsl.de [78.53.208.153])
	by mx01.d-labs.de (Postfix) with ESMTP id 76E2E83E21;
	Sun,  8 Mar 2009 21:34:13 +0100 (CET)
In-Reply-To: <20090306161026.GA14554@raven.wolf.lan>
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.12.11; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112642>

--Sig_/ph8Jd+QU7bdL4kU6i=8h0c.
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Mar 2009 17:10:26 +0100
Josef Wolf <jw@raven.inka.de> wrote:

> On Thu, Mar 05, 2009 at 02:48:14PM -0500, Peter Harris wrote:
> > On Thu, Mar 5, 2009 at 1:05 PM, Josef Wolf wrote:
> > >
> > > Well, actually it allows the changes for a very limited user
> > > group (that is: only me 8-). =A0While I agree that author/date
> > > should not be changed, I like to be able to fix silly typos in
> > > the log. =A0After all, we all do typos now and then ;-)
> >=20
> > True, but in my experience it happens considerably less often with
> > git. I find and fix most of my typos when reviewing my change-set
> > before doing a "git push" or "git svn dcommit".
>=20
> So you are rewriting yourself but not accept rewrites by svn ;-)

the thing is: with git you don't ''rewrite history''.=20
you create a completely new history. that is because the
sha1-descriptions includes the meta-data.

that means, even if you want, you can't change ''published'' history.
because the history is unique'ly identified by the topmost sha-1.=20
if smth changes underneath the topmost sha-1 you have to rebase all
your other changes on the new sha-1 and thus altering them.=20

that is why the dcommitt'ed&svn-rebased changes have different sha-1s
and all your clone's work needs to be rebased onto the newly altered
committs.


Sincerely,

Florian



--Sig_/ph8Jd+QU7bdL4kU6i=8h0c.
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkm0K6oACgkQPjqCkyL3Kv3uBQCgoCcKl4w4ntS0x3LS3t3Xe9NH
KUEAn0F5Abf+YQ9ivY89taoWqh5CM1yy
=DfBp
-----END PGP SIGNATURE-----

--Sig_/ph8Jd+QU7bdL4kU6i=8h0c.--
