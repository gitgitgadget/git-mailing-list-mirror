From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [RFC] cgit in git?
Date: Thu, 11 Dec 2008 19:15:46 -0500
Message-ID: <20081212001546.GV13722@inocybe.teonanacatl.org>
References: <8c5c35580812111348iceaf30dyb55183017cff5b1d@mail.gmail.com>
 <7vwse6bart.fsf@gitster.siamese.dyndns.org>
 <8c5c35580812111537v1144c9fdy19f2a3cc56e2a04f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="HACzHn9G0kmbdSJa"
Cc: Junio C Hamano <gitster@pobox.com>,
	Seth Vidal <skvidal@fedoraproject.org>,
	Git Mailing List <git@vger.kernel.org>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 02:36:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAwxS-0004F3-OT
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 02:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455AbYLLBf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 20:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754765AbYLLBf3
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 20:35:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbYLLBf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 20:35:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D8A1867D7;
	Thu, 11 Dec 2008 20:35:26 -0500 (EST)
Received: from inocybe.teonanacatl.org (unknown [69.248.23.23]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 29979867D6; Thu,
 11 Dec 2008 20:35:22 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <8c5c35580812111537v1144c9fdy19f2a3cc56e2a04f@mail.gmail.com>
X-Listening-To: Nothing
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Pobox-Relay-ID: 26CBD4A4-C7ED-11DD-A9B0-5720C92D7133-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102856>


--HACzHn9G0kmbdSJa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Lars Hjemli wrote:
> On Thu, Dec 11, 2008 at 23:35, Junio C Hamano <gitster@pobox.com>
> wrote:
>> Doesn't cgit bind git.git as a subproject at the source level?  I
>> would expect that the most natural release tarball for such a
>> project would be a single tarball that has both the superproject
>> itself _and_ the submodules it contains already extracted, iow, the
>> state of your tree after you run "make get-git".
>
> Your expectation makes sense to me, thanks for elaborating.
>=20
> Seth: would such a self-contained tarball solve the problems on your
> end?

(I'm not Seth, nor do I play him on TV -- though I have been offered
his role in a small town production of "How the Grinch Stole
Christmas"... ;)

The downside to this is that cgit would be duplicating the git
sources, and thus, so would any distribution packages.  If there is a
bug in git, both the git and cgit packages would need to be updated to
fix it.

Basically, Fedora tries hard to use system libraries rather than
having applications include their own local copies.  (I recall some
zlib vulnerabilities years back that required way too many packages to
be rebuilt, since they each included their own copy of zlib.)

Obviously, since git is not intended to be used as a library, this
doesn't exactly match that situation.  But cgit is using git as a
library at the moment and if we could find a way to only have one copy
of the git sources to maintain, that'd be ideal from a distribution /
packaging perspective.  I do understand that it might not be as ideal
=66rom either git or cgit developer / maintainer perspective, so the
consideration you're giving the issue is very much appreciated.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I never vote for anyone; I always vote against.
    -- W.C. Fields


--HACzHn9G0kmbdSJa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBAgAtBQJJQa0tJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjNgQIALH9O7dafqOEzT4fbyXNa1c20QdsoA/t2jkG
q0048Xsd+NKOiV3sgsmfoL9B4/0vOSrs0Ch593y3GNwi/J+MfnvMHso6K5gL5SIJ
7z9t3HuK7uWIXO46HVvV95s/JlPIQDRh7M/g+rkd5FHjk9MYt5aTuNpiWI5bc/o1
kalgdsh1h6HkQw8sqYZ0eYdrymi4frrQCEZWIog0Ykcdnkshgeohpf2C3LWSTAwo
5ZqHdn68EPGCwq5/Kaa53T6HlN7P0dyGfympTllMGL32DvxOadEatk1qVuqHa5sZ
M3weJRL4Tu9+PdRBWMODLKzwNcvKgruS0EsrW4FrMtGL3Y+ZK+s=
=q/G5
-----END PGP SIGNATURE-----

--HACzHn9G0kmbdSJa--
