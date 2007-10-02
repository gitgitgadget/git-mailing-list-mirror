From: martin f krafft <madduck@madduck.net>
Subject: Re: metastore
Date: Tue, 2 Oct 2007 21:39:41 +0100
Message-ID: <20071002203941.GA18008@lapse.madduck.net>
References: <20070915145437.GA12875@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <20070916060859.GB24124@piper.oerlikon.madduck.net> <20070919191607.GE13683@hardeman.nu> <20071002195301.GB14171@lapse.madduck.net> <20071002195816.GA6759@hardeman.nu> <85lkalz3iv.fsf@lola.goethe.zz> <Pine.LNX.4.64.0710021314370.24697@asgard.lang.hm> <20071002202333.GB16010@lapse.madduck.net> <Pine.LNX.4.64.0710021327371.24697@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
To: david@lang.hm, David Kastrup <dak@gnu.org>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <J
X-From: git-owner@vger.kernel.org Tue Oct 02 22:41:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcoYi-0005PD-OP
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 22:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbXJBUl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 16:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbXJBUl3
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 16:41:29 -0400
Received: from clegg.madduck.net ([82.197.162.59]:43583 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828AbXJBUl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 16:41:28 -0400
Received: from lapse.madduck.net (213-202-173-105.bas504.dsl.esat.net [213.202.173.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 94F83C01B;
	Tue,  2 Oct 2007 22:40:59 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 0E7C73FDED; Tue,  2 Oct 2007 21:39:41 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710021327371.24697@asgard.lang.hm>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4456/Tue Oct  2 17:11:59 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59729>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach david@lang.hm <david@lang.hm> [2007.10.02.2129 +0100]:
> 1. you do want to be able to manipulate them
>
> 1a. how do you reconcile a conflict during a merge?

How could there be a conflict if you can't make local changes
because you can't represent the attributes locally/natively?

> 2. git is a series of snapshots, what does it mean to 'stay unchanged'?

In simple terms, let (content,A,B) be an object with content
"content" and extended attributes A,B, and B cannot be represented
locally, but a new object is committed with a change to attribute
A (content2,A2), then the result is (content2,A2,B), as B simply
comes from the (corresponding object of the) parent.

Or am I totally misunderstanding?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
when compared to windoze, unix is an operating system.
=20
spamtraps: madduck.bogus@madduck.net

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHAqyNIgvIgzMMSnURAjg6AJ0c7CRg0rrYunrgfI2VqilC+VDdOACgyx9L
Gwf2hs3rxxukzcY7jEuIY6Q=
=J7zL
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
