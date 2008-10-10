From: "Michael P. Soulier" <msoulier@digitaltorque.ca>
Subject: Re: git confused by rename
Date: Fri, 10 Oct 2008 18:08:39 -0400
Message-ID: <20081010220839.GA38499@kanga.digitaltorque.ca>
References: <fb6605670810100741k7cff25c7y4df66834cf7482a0@mail.gmail.com> <7vabdcmp4n.fsf@gitster.siamese.dyndns.org> <7v3aj4momt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 00:10:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoQCC-0006NM-F0
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 00:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080AbYJJWJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 18:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755772AbYJJWJk
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 18:09:40 -0400
Received: from mail.storm.ca ([209.87.239.66]:60563 "EHLO mail.storm.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560AbYJJWJk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 18:09:40 -0400
Received: from kanga.digitaltorque.ca (hs-216-106-102-70.storm.ca [216.106.102.70])
	by mail.storm.ca (8.14.2+Sun/8.14.2) with ESMTP id m9AM8jHk016413;
	Fri, 10 Oct 2008 18:08:50 -0400 (EDT)
Received: by kanga.digitaltorque.ca (Postfix, from userid 1001)
	id 24D9E152; Fri, 10 Oct 2008 18:08:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v3aj4momt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.3i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97955>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10/10/08 Junio C Hamano said:
> The above observation of mine is correct, but I forgot that "git status"
> (and the comment in the commit template from "git commit") is generated
> internally with "diff-index -B -M".  So if
>=20
>  (0) had A but not B in the HEAD commit;
>  (1) you created B that is very similar to the original A; and
>  (2) you modified A beyond recognition;

Which, FTR, is what I did.=20

I copied A -> B for its boilerplate, and then hacked them both up, although=
 B
consisted mostly of content that I removed from A (a refactoring exercise).

> This however makes me wonder if "diff-index -B -M" should say B is copied
> (instead of being renamed) from A and A is modified in such a case.  I do
> not think we would want to make such a change without thinking things,
> through.

Gotcha. Indeed though, I did cp A -> B, and if A still exists then it
obviously was not renamed.

Thanks,
Mike
--=20
Michael P. Soulier <msoulier@digitaltorque.ca>
"Any intelligent fool can make things bigger and more complex... It
takes a touch of genius - and a lot of courage to move in the opposite
direction." --Albert Einstein

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (FreeBSD)

iD8DBQFI79JnKGqCc1vIvggRAqSCAJ4oXmyQtb/rwVKgXyGJJj1pLJ+dEQCeLE1U
rfXoOS2Udq8xRElaiHrEzKU=
=fGMN
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
