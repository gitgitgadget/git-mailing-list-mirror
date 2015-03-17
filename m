From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC] git submodule purge
Date: Tue, 17 Mar 2015 09:18:26 +0100
Message-ID: <20150317081826.GB354@pks-pc>
References: <20150316134407.GA31794@pks-tp.elego.de>
 <xmqqmw3drl7s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 09:19:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXmiV-00044D-L9
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 09:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbbCQITE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 04:19:04 -0400
Received: from sender1.zohomail.com ([74.201.84.155]:30259 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314AbbCQISx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 04:18:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; 
  b=tLSIPzIJvvApDp8Us+Iqmx+PWwQqQaWw1lvhyXd3F/j+wq2YrBjCxcfcJR2sa76sP7Plr/IeEVqf
    AzePQTtnoWARxy0jEBUKIwe7hZ9Psx9saPmLOZsr/kzPM9Ed7RmzK90T9wj6GtuPBXrjGmibAURo
    k9esPopwSAXMpNpxZds=  
Received: from localhost (g225000112.adsl.alicedsl.de [92.225.0.112]) by mx.zohomail.com
	with SMTPS id 1426580331306675.2598130269747; Tue, 17 Mar 2015 01:18:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqmw3drl7s.fsf@gitster.dls.corp.google.com>
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265621>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2015 at 08:55:03AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > I think there should be a command that is able to remove those
> > dangling repositories if the following conditions are met:
> >
> > - the submodule should not be initialized
> >
> > - the submodule should not have an entry in .gitmodules in the
> >   currently checked out revision
> >
> > - the submodule should not contain any commits that are not
> >   upstream
> >
> > - the submodule should not contain other submodules that do not
> >   meet those conditions
>=20
> I do not have a strong opinion on whether it is a good idea to make
> it possible to remove the .git/modules/*, but should it be a
> separate subcommand, or should it be an option to the 'deinit'
> subcommand?

See my response to Jonathan.

> Also, how would you apply the safety to a repository without
> "upstream", i.e. the authoritative copy?

Is it even possible to create a new submodule without any
upstream repository? At least `git submodule init` does not work
without a corresponding entry in .gitmodules which the user would
have needed to create himself manually. In this case one _could_
assume that the user knows what he is doing and expect him not to
call `submodule purge` (or whatever the command will be called)
on the authoritative copy. Other than that I've got no idea how
to assure safety.

Regards
Patrick

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVB+NSAAoJEBF8Z7aeq/EsnroP/1YKDiUPBkR6gEHDZmg8tNKS
b7HVvl+eGxH4i8NbrtSI+CPxkCVZrrWNHIJsR0ZYqKt+I0+PvQQWOTCBxDde7nZS
j4ycYllse5YTLl4FJhNdtcJA5KHYtB8MGdbx63RAW9nnkIK+7L/75UtxrsDlmkbJ
Z2TwL8NCsEViPFdClJ39hMxq2pkORXWknLtCtrsnYqNtxbnatgi1jJQz9D4abQql
2c3Rawy0S4bj+kNUF3F1vMZ1jrj9r/DhMOzDybM9x+7HAsIYJslSWX9f5VJ0Cj4B
AWkljVq95XeeFNaH5kZjDf/es+0NtKosfzbNGOqLLBLMqvArXvtAwZu+/Oznxnch
CqSdjeWxQHppfT3R2bf83vl44eh20I9etUeY4A/tFwP0I6dXzQeq53abdFW9X7Q6
aZLxoGlVO3QFyoZzOJvLzS/j9WlVSuoAwSCUdpyoTuXrzzRdL6PlpJv6BYwIqZ5q
7mj8AYaa/UmxBtFbw2H/mu0JBle8nIMhDdbXsW2y9mscDWgrX+0ps+c+8aLlTKrN
RqzPwsmt4rcw0jZ6u/omP1uw//xJdAi8CWfUhq2VY+HW1hn4AQ/GUYyFDC2Ad5MA
PmtIFEaCUbpdnpcgRXMBEPvizj3xEEqEmkCXc3uQRxxmdumg355690JoYRqK0i/Q
GECqKdeRYmAot/Vo3hIz
=WGPB
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
