From: Todd Zullinger <tmz@pobox.com>
Subject: Re: error when installing 1.7.0.1: "ImportError: No module named
 distutils.core"
Date: Mon, 1 Mar 2010 11:15:41 -0500
Message-ID: <20100301161541.GM29188@inocybe.localdomain>
References: <20100301144000.GA17135@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="HBXo5IaYAxUG7vuS"
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Mon Mar 01 17:16:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm8Hq-00058W-Gk
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 17:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257Ab0CAQPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 11:15:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61896 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab0CAQPt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 11:15:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 60ED19EAD7;
	Mon,  1 Mar 2010 11:15:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=2SEvMo+lhvPpWiBjau8mD8WJKdY=; b=wmQWz43
	WY8So8xYmYr1eCkmm7h+o4deAnisA6o165WiwR2JpNTbUf3MmgbYZBCTkoE03vkR
	2w42LUx+GaIpvheFg8C/bYU6thgbKD4QZUllEScKQIxOONK+zugzvSL97LMzaIGl
	bZUxoe8YxBfnciBwG71ETY8m6TpjIWdDU4cY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=vtF+wuK7C1jz7oloahQaujaE9oWWbccKG
	vDLfiCEFyo7IxvOi8c+Ao3ha/uzlm76buvDxNykZrcSKILYCvGtSTADujyAcEhHd
	0V1LyUqWqNKuVyrfAJse8jK0u7HjBJN5cZV1j0ZxALWmHgRGx1rPuzox1hytiwF4
	1bDIl3KyHs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B0FA9EAD6;
	Mon,  1 Mar 2010 11:15:46 -0500 (EST)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40BC89EAD5; Mon,  1 Mar
 2010 11:15:44 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20100301144000.GA17135@cs-wsok.swansea.ac.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: B135F4D0-254D-11DF-9D47-D033EE7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141326>


--HBXo5IaYAxUG7vuS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Oliver Kullmann wrote:
> I've installed 1.6.6.2, but now when
> installing 1.7.0.1 (same machine) I get
>
> make[3]: Leaving directory `/home/csoliver/SAT-Algorithmen/OKplatform/Ext=
ernalSources/builds/Git/git-1.7.0.1/perl'
> make[2]: Leaving directory `/home/csoliver/SAT-Algorithmen/OKplatform/Ext=
ernalSources/builds/Git/git-1.7.0.1/perl'
> make[2]: Entering directory `/home/csoliver/SAT-Algorithmen/OKplatform/Ex=
ternalSources/builds/Git/git-1.7.0.1/git_remote_helpers'
> Traceback (most recent call last):
>   File "setup.py", line 5, in ?
>     from distutils.core import setup
> ImportError: No module named distutils.core
>
>
> I'm using
>
> make configure
> sh ./configure --prefix=3DInstallDir
> make all

If you have no need for the git_remote_helpers (and unless you are
working on adding a git remote helper in python, I don't think you
do), you can pass --without-python to configure.  I think that's the
right way using configure, I use make directly and pass NO_PYTHON =3D 1
for the time being.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
There are no differences but differences of degree between different
degrees of difference and no difference.
    -- William James, under nitrous oxide; 1882


--HBXo5IaYAxUG7vuS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJLi+goJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjRZkH/R5ZJtPYTpH+nX/hQ+SG+bTRY15RdZi/HvEp
YOuII5/99w4WEd1W9MgdM67+2hlOUnTD/Wt68+Ac74en0gRzmCchSvAaErElUaWS
kN1T0/1NzhpT4b4Pg87AIIMcSNKWqp/fV35DSXiRUe4CawlrnVqhGJxPN+IS8NnJ
pj/213f2uCjfySHAIAHCqz5+5zNhla41qXBUJFKWPBzWyvfbAwWNJ9jV4AS1qH3f
wpgZ6t+lcBHaL6Xj4T6dIT+YaK8Ypr/uRHPN0bhpPNdtFEywU8yEn7Ll6dEYaxxl
axkLQ6uOFNTUuMSP4syv7L3UzsrbEwrFdgKb/2SQn294vD2qn30=
=zXBb
-----END PGP SIGNATURE-----

--HBXo5IaYAxUG7vuS--
