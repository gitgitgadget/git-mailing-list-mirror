From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/3] git-verify-pack.txt: fix inconsistent spelling of
 "packfile"
Date: Wed, 20 May 2015 07:13:59 +0200
Message-ID: <20150520051359.GA367@pks-pc.localdomain>
References: <1431845814-2541-1-git-send-email-ps@pks.im>
 <xmqqwq04745w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 07:48:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuwrP-0004VX-RQ
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 07:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbbETFri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 01:47:38 -0400
Received: from sender1.zohomail.com ([74.201.84.152]:25191 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbbETFri (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 01:47:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; 
  b=yElrqI9hnmBlxSxjlY9XRJS+ZWN22cSNSS2DKCFX7qKFgkGleodhWc8HFyWs2SJOsWclSBLRDPAU
    pKaLnU+RESarGiaiavMhfnTUlLAnOodD1v+MbrU+UFwFylVes46U8Zr8KZJ44BwylbkqLfa1SPgZ
    U7V/RYHZ1/gLXgfT904=  
Received: from localhost (x5ce0fbb5.dyn.telefonica.de [92.224.251.181]) by mx.zohomail.com
	with SMTPS id 14320988725341017.6367378186388; Tue, 19 May 2015 22:14:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqwq04745w.fsf@gitster.dls.corp.google.com>
X-Zoho-Virus-Status: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269439>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2015 at 12:34:03PM -0700, Junio C Hamano wrote:
> There still are a handful of "pack-file" remaining in the
> documentation set, even after applying these three that changes
> 6 instances of 'pack-file' to 'packfile'.
>=20
> git-index-pack.txt:'git index-pack' [-v] [-o <index-file>] <pack-file>
> git-index-pack.txt:                 [<pack-file>]
> git-index-pack.txt:	instead and a copy is then written to <pack-file>. If
> git-index-pack.txt:	<pack-file> is not specified, the pack is written to
> git-index-pack.txt:	<pack-file> is not specified consider using --keep to
> git-unpack-objects.txt:'git unpack-objects' [-n] [-q] [-r] [--strict] < <=
pack-file>
> technical/pack-heuristics.txt:    <linus> Anyway, the pack-file could eas=
ily be denser still, but
> technical/pack-heuristics.txt:    <linus> In particular, while the pack-f=
ile is then compressed,
> technical/pack-heuristics.txt:    <linus> Anyway: I'm not even trying to =
claim that the pack-files
> technical/pack-protocol.txt:  update-request    =3D  *shallow ( command-l=
ist | push-cert ) [pack-file]
> technical/pack-protocol.txt:  pack-file         =3D "PACK" 28*(OCTET)
> user-manual.txt:[[pack-files]]
>=20
> A quick "git grep packfile" vs "git grep pack-file" inside
> Documentation/ directory indicates that we seem to use 'packfile'
> primarily in the lower-level technical documents that are not
> end-user facing.  Almost half of them are in the release notes
> that we won't bother "fixing", so it might make sense to go the
> other way around, consistently using "pack-file" that may be more
> familiar to end-users.
>=20
> What do others think?

I was aware of the other instances of 'pack-file'. The only case
where 'pack-file' does occur after my patches, though,  was as
command line parameters, where I didn't want to change it. If
that's desired I can whip up another patch.

Patrick

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVXBgXAAoJEBF8Z7aeq/EsJnQQAJBNDQ9LBulEX4lAoDK3mxHq
6paKL15+wDnNZN37HW3I5XkCeRIwQoqwIGmtT+6kVc3JYtvO5AF7gLRcgMnXEjN5
SLqaMVoR9AUOzZv66tUgSULD6Bxoi+i5JVWSF++Bs5djjNdvIUhHDXyN2Xe0IzBm
+xYhVM2odAmI43w7n/Lq2invLjRkAtPFO1/51FDzjtDMeH/oC6L/U3BjfnSRpP0L
WfNzJdk6byQBuQhk5QX1HfCwfzr5qGbk8OFMeWXvNzZIEjGz4ucwbhcrJWLL2VtV
uHXVP+wlaF5jwDgEG9zKfOJgovLG3imvRuVNCMEdi6bKGb09KnqdSq9btMZXlZ+K
njvXSErF7Lyl575s0AU5ZA18fwxXKNE6JWO4c54zsoEdU2i8UDi8y3OWK/3qwJEJ
xdH17LxUel4LTAyn0N+v/lIhGvxIw+3fd5Vyvexo7BfUhV/iitvcKRB+x/bNqrzb
wL6wWfoi7ETXdY7OEVQ1X/Y0oB0KRoRkc6CWDMxrfNdayD/hPnTmdxo4acZbU/mw
fqHd89WGWuvQ3gZkDjlVacTnzeP96/vM1od3F/VCij+Bw1B7HcI9yMd6Zn28O7Sl
oPZWG4iSzGgQSYcWLjZ4XHL0LrXqwN8HZUAHyeQuyx2jGl2n6uPmLo8VJ0pYem2D
pvs28kImYy0uoSlv0SI/
=vXck
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
