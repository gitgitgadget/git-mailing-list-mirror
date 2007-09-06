From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
	make stat use that implementation too.
Date: Thu, 6 Sep 2007 18:26:57 +0200
Message-ID: <20070906162657.GF2329@genesis.frugalware.org>
References: <46DACD93.9000509@trolltech.com> <200709022228.00733.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0709022133190.28586@racer.site> <200709022342.42733.robin.rosenberg.lists@dewire.com> <46DBB2BE.8030505@eudaptics.com> <20070903112110.GE14853@genesis.frugalware.org> <86y7fohtmw.fsf@lola.quinscape.zz> <20070905160206.GY14853@genesis.frugalware.org> <85abs1hr6t.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 18:28:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITKDL-0002PY-AP
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 18:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbXIFQ1G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 12:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbXIFQ1F
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 12:27:05 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:53280 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbXIFQ1E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 12:27:04 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1ITKC6-0004iU-9n
	from <vmiklos@frugalware.org>; Thu, 06 Sep 2007 18:27:02 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 44BC113A421D; Thu,  6 Sep 2007 18:26:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <85abs1hr6t.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-1.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57898>


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2007 at 09:01:46PM +0200, David Kastrup <dak@gnu.org> wrote:
> > the situation what triggers the 'no such file' problem is:
> >
> > ----
> > $ touch foo/Makefile
> > $ mkdir bar
> > $ ln -s foo/Makefile bar
> > $ cd bar
> > $ cat Makefile
> > cat: Makefile: No such file or directory
> > ----
>=20
> This is under Vista?  It would be the same under Unix.

no, i never stated that this is Vista ;-) this is Linux.

- VMiklos

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG4CpRe81tAgORUJYRAiPYAJ9N4IsY4FNr2MDyxm3lUNHWdaoItACeOems
x3fpuI7xO4wJqqyKd3fhJSw=
=csfW
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
