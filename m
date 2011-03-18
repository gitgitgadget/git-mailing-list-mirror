From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [RFD] Gitweb: Source configuration from file separate from the
 CGI script
Date: Fri, 18 Mar 2011 11:38:28 -0400
Message-ID: <20110318153827.GF26236@inocybe.localdomain>
References: <1300285582.28805.25.camel@drew-northup.unet.maine.edu>
 <m3lj0e59ps.fsf@localhost.localdomain>
 <1300361067.3010.1.camel@drew-northup.unet.maine.edu>
 <201103171641.29021.jnareb@gmail.com>
 <1300457243.12245.13.camel@drew-northup.unet.maine.edu>
 <20110318145147.GA26236@inocybe.localdomain>
 <1300461702.12245.27.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="x9uCfsizvaabZDbV"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Mar 18 16:38:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0blI-0000f1-1l
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 16:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756885Ab1CRPil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 11:38:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756694Ab1CRPij (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 11:38:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A3062EC3;
	Fri, 18 Mar 2011 11:38:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=YGjVpY8DSn2R7Mmvi5nJHob9oXs=; b=eafEGG/
	6383lD6KS25tDG01zRibtWKAux/acnedZPwNsrwFLEU1qj10te+oesgsnri3mxn8
	c+F/ArL8c9R3k1qjYveRDJlVGzMQHWU0NLZbQY6UT11MNg9DiqwEJNNaWimEQiuk
	Q6YmtgBWabHGU7DV3AmMS9umRBvGk9P5XO3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=uc6OWVkrpcP4KYF+bFAgEsMphXtWfoTX7
	Y0wKz0r0SwbrtlMWpnZG8ma2r3Blqb6mIyIcdEK5tEnbf3Z+Dszlb1OK4Kp1vfVW
	0167ykO0wkJvmAcTQfjPu37PaxbVLEZR8pRLNpG+u1WUlst4Jdf0EjMY0I359bkb
	R7tEc3kW3U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EE442EC1;
	Fri, 18 Mar 2011 11:38:34 -0400 (EDT)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7896C2EBD; Fri, 18 Mar 2011
 11:38:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1300461702.12245.27.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Pobox-Relay-ID: C8A317CE-5175-11E0-9374-C1F4E168B6F2-09356542!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169336>


--x9uCfsizvaabZDbV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Drew Northup wrote:
> The main thing that annoyed me was that EPEL and git's "make rpm"
> seem to still have very different ideas about where stuff belongs on
> a machine. I wish I had more time to read the "epel-testing" release
> notes, but that wouldn't have actually helped me in this case.

Yeah, for the EPEL-5 packages, we chose to keep gitexecdir =3D /usr/bin,
so that people updating wouldn't find any scripts broken by the change
to /usr/libexec/git-core.  This should be good for folks updating from
older EPEL packages but not as hot for anyone that had rolled their
own from git.git, unfortunately.  On the upside, I think that should
affect relatively few commands.  If you have particular examples,
perhaps they are things we can provide better work-arounds for in the
EPEL packages?

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The worth of a state, in the long run, is the worth of the individuals
composing it.
    -- John Stuart Mill


--x9uCfsizvaabZDbV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJNg3xzJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjwREIALqwwfBZ3EHIy7S38Ne/n2SFGaEal/gYb0se
/B1GE+eAL+SE68DFMn02dVjUu6hi9cQ0YDhIVSO3bRKvFFqmMINa6xVemfwW4Wqo
JWkRSpvxHUAR8XIMicnePnviz38AjLlv7NUlJAe1fRqjHmwdf7AZvEbHJB2xN11r
3SfVLOmXvG1J+ul7DyA2+1DXMZtXnWSb7fd4LgV2BsTU0LClTYZ3a3V5aVk2CiCP
zAKofMmDRVnrzNrE2fKEtUWw+rroDIjRULfNvEDhECZMHu68/fhbsHU+KxnoX0hj
SNenkVjD29Mt7eeMZs6Wp/haYHOmGKI3R76FXwp6WdG9hhGMZTk=
=iYER
-----END PGP SIGNATURE-----

--x9uCfsizvaabZDbV--
