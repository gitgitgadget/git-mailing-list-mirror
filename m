From: martin f krafft <madduck@madduck.net>
Subject: Re: merging .gitignore
Date: Tue, 2 Oct 2007 20:51:48 +0100
Message-ID: <20071002195148.GA14171@lapse.madduck.net>
References: <20071001130314.GA5932@lapse.madduck.net> <Pine.LNX.4.64.0710011457120.28395@racer.site> <20071001130314.GA5932@lapse.madduck.net> <200710011448.17701.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Cc: Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 21:53:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcnoE-0002is-3w
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 21:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbXJBTxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 15:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbXJBTxU
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 15:53:20 -0400
Received: from clegg.madduck.net ([82.197.162.59]:51859 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbXJBTxT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 15:53:19 -0400
Received: from lapse.madduck.net (213-202-173-105.bas504.dsl.esat.net [213.202.173.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id E624DBA383;
	Tue,  2 Oct 2007 21:53:06 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 0A1BA3FDED; Tue,  2 Oct 2007 20:51:48 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710011457120.28395@racer.site> <200710011448.17701.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59717>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Johannes Schindelin <Johannes.Schindelin@gmx.de> [2007.10.01.14=
57 +0100]:
> You might be interested in writing a merge driver.  See=20
> Documentation/gitattributes.txt.

This is an excellent idea; thanks.



also sprach Andy Parkins <andyparkins@gmail.com> [2007.10.01.1448 +0100]:
> Then, assuming the conflicts you get now occur for a reason, you
> will get conflicts within the .gitignore.d/ directory.  Let's say
> branchCignores adds *.o and branchFignores removes *.o from the
> ignores.  Who is right?  Who knows, and worse than that you didn't
> see the conflict when it happened so it wasn't resolved and the
> master branch was left with conflicts in it.

Well, with gitignore I am ready to say that merges should be
resolved in an additive way. Remember that I am talking about an
intergration branch, and if feature branches A and B used to ignore
=2Eo files, and now B suddenly does not ignore them anymore, the only
real reason I can think of is that it was rewritten in a languages
other than C*. So then you *still* want to ignore .o files in the
integration branch.

Basically I am saying that it should be

  cat $gitignore_files | sort -u

and obviously, this is something for a specific merge driver, as
Johannes suggested.

Thanks for the feedback,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
minchinhampton (n.): the expression on a man's face when he has just
zipped up his trousers without due care and attention.
                               -- douglas adams, the meaning of liff
=20
spamtraps: madduck.bogus@madduck.net

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHAqFUIgvIgzMMSnURAmWoAKCEkF8bDh3jASVssxwlVkZp/S3UPACcDCth
pZa868q7904pOVuKKUKo2qY=
=oy8U
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
