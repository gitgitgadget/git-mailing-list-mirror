From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
	make stat use that implementation too.
Date: Wed, 5 Sep 2007 18:02:06 +0200
Message-ID: <20070905160206.GY14853@genesis.frugalware.org>
References: <46DACD93.9000509@trolltech.com> <200709022228.00733.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0709022133190.28586@racer.site> <200709022342.42733.robin.rosenberg.lists@dewire.com> <46DBB2BE.8030505@eudaptics.com> <20070903112110.GE14853@genesis.frugalware.org> <86y7fohtmw.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HwY7O+GdaLKMYOv"
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 18:02:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISxKi-0002EW-Es
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 18:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757606AbXIEQCR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 12:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757540AbXIEQCR
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 12:02:17 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:60603 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757449AbXIEQCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 12:02:16 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1ISxKV-0007gb-Lo
	from <vmiklos@frugalware.org>; Wed, 05 Sep 2007 18:02:14 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id AC09013A41E5; Wed,  5 Sep 2007 18:02:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <86y7fohtmw.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.6 required=5.9 tests=BAYES_40,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	0.5 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.2939]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57718>


--+HwY7O+GdaLKMYOv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2007 at 01:32:07PM +0200, David Kastrup <dak@gnu.org> wrote:
> >> And if I understand the documentation correctly, then
> >
> >> $ mkdir foo && cd foo
> >> $ cat ../x
> >> x: No such file or directory
> >
> >> Right?
> >
> > correct.
>=20
> Have you tested this, or is this from reading the documentation?  In
> either case: brilliant, but the former would be funnier (depending on
> one's sense of humor, of course).

umm, thanks for the notice, i was wrong:

----
$ cat ../x
this is makefile
----

the situation what triggers the 'no such file' problem is:

----
$ touch foo/Makefile
$ mkdir bar
$ ln -s foo/Makefile bar
$ cd bar
$ cat Makefile
cat: Makefile: No such file or directory
----

- VMiklos

--+HwY7O+GdaLKMYOv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG3tL+e81tAgORUJYRAm6oAJ4/kfMDgDsXm06ld6BgiXKOM0HQOACcDRl/
SOEqeojRfZlDEnP+Hz8lybM=
=eZ+q
-----END PGP SIGNATURE-----

--+HwY7O+GdaLKMYOv--
