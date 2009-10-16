From: Todd Zullinger <tmz@pobox.com>
Subject: Re: Moving git
Date: Fri, 16 Oct 2009 14:42:51 -0400
Message-ID: <20091016184251.GG19511@inocybe.localdomain>
References: <25926819.post@talk.nabble.com> <25928820.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Cc: git@vger.kernel.org
To: Richard Lee <richard@webdezign.co.uk>
X-From: git-owner@vger.kernel.org Fri Oct 16 20:43:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyrlY-0000ee-JS
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 20:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbZJPSmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 14:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754154AbZJPSmz
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 14:42:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53504 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbZJPSmy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 14:42:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 782C25BAD4;
	Fri, 16 Oct 2009 14:42:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=XO2/maerkgKvWq1xejMY9QOdtFA=; b=CuSMXF0
	EWIlzStUgNz1QH6WslFH3bje0bGAA43tSE9sTt0Ld/6qBs3qvxpJ83ROG0iEgiLY
	589rt+/cskxETTxuozYXtBhjkQF/YqlnuBMEbs2muCTO+SUqa9+lX46Jmtvc3iaq
	AyEh6Q+ObEr8kLygFkd/+42Ogs0fG8MFTKiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=Y7tYimJYImi/a1N86bArY6MavmY2q+sWy
	m/kwUG4npyaRHhL+ORniAtCB4Iyuv3dGTWT1fsIam233cM6YFmuZGtEGvgHg2Zh6
	tTSYJ5FRJcQfzgCmyo2mMld+2VPfPraoQUR5r5tx134sJryHPW9/+zNX8hCqz5BZ
	xc8DxS9pks=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6562D5BAD1;
	Fri, 16 Oct 2009 14:42:54 -0400 (EDT)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12B185BAD0; Fri, 16 Oct
 2009 14:42:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <25928820.post@talk.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: B7241F8C-BA83-11DE-ABD2-1B12EE7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130519>


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Richard Lee wrote:
> The reason I had problem with git remote rm was because I was using
> version 1.5.2 as I installed it from yum. (This is what I hate about
> CentOS, all the repositories are old as dirt.)

Not that it's much newer, but if you use the EPEL repository, 1.5.5.6
is available.

> I compiled version 1.6.5 and the command was there.

And if it helps, the Fedora package is intended to be able to build
cleanly on CentOS as well -- though it depends on some macro settings
available in the buildsys-macros package found at:

    http://buildsys.fedoraproject.org/buildgroups/rhel5/

=2E..in the proper directory for your architecture.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Every time I close the door on reality, it comes in through the
windows.


--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAABCAAtBQJK2L6mJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjKMQH/2NHrNb/+MRBCFPrZ6URVWOcX7hecmKGTaKm
0sn1182NPUqero99pTELUpsg8F6ex0iujnJ962lrTwAj7uAg/T6hJ/dfnX0jN3+q
1laFG5VgoY2TWCFT4lGcFB07v7lwo90I+n0I0l7eQultZ+6WP++te5NvlJFOUZXJ
mCQJSBQjoPTq8UUM3XUl53aI5HraLUIgiXUn1976N1YRcPdVRAWvIIM0KoNdLmT4
W/CAl9DXv/mGA5B6Psln0CJgBIQ4N2L9MEWReNfy4WMwRCjfSR8q7kC2m9+jQLkk
QE+RwlhBDwY7ShiHDX+v08HRQa1m1ax43LOSzWJWjkRjyC3ad3o=
=Ftwv
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--
