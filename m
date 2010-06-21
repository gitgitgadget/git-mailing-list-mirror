From: Todd Zullinger <tmz@pobox.com>
Subject: Re: Upgradin git
Date: Mon, 21 Jun 2010 16:22:09 -0400
Message-ID: <20100621202209.GO12888@inocybe.localdomain>
References: <1277145270235-5205581.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="Q935UqjMul3XuJv7"
Cc: git@vger.kernel.org
To: jhapk <pradeep.kumar.jha@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 21 22:22:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQnVd-00032p-Fd
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 22:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758051Ab0FUUWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 16:22:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945Ab0FUUWP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 16:22:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B7AA417A9;
	Mon, 21 Jun 2010 16:22:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=o85ifzt5TAezZg83hP9yK8EbvYo=; b=a/enz/1
	0MLvkzL0bbyB5hvA0KhOKe0rkwk+mYdVRtVZ9pXFKiX/gJLOzKIvzoEDz0DgdT6a
	v9g+z4G5qSzIra0v7cUIWmG3UVM+m3oyRycOFqVs4d8u22kkFYg/9C+XUzG7XsZZ
	apO1+5qNMIJWqoy+Svw/xw95uRjlzuvJroAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=jWyWlz5soC8t5ThybZ7R/JlvNUDdLDQ1Z
	DTeErjFg7+MwmM7LippP1ilB5t32HTFd/OVD0isl1N4xMitgTUD1yi3REMS+QhEo
	3qzELW196ncWj7atxk777rW2qPCNPDPTHNFjunSvsYdC+OIBSHUnsGh+Twfce0yh
	QQUSRwemWI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A296117A8;
	Mon, 21 Jun 2010 16:22:12 -0400 (EDT)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4AFBE17A5; Mon, 21 Jun
 2010 16:22:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1277145270235-5205581.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: ACFC8B9A-7D72-11DF-9220-9056EE7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149437>


--Q935UqjMul3XuJv7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

jhapk wrote:
> I am using fedora and I don't have the root access. The git
> installed on the system is 1.5.2.2 and I want to upgrade it to 1.7.1

Ouch, you must be using a really ancient version of Fedora.  Fedora 11
is the oldest release currently supported and it contains 1.6.2.5.
1.7.1 is in updates-testing for both Fedora 12 and 13.

Perhaps it's also worth mentioning for the archives that the fedora
packages are designed to cleanly build in mock=B9 for RHEL/CentOS >=3D 4 as
well as previous Fedora releases.

=B9 mock is fedora's main build tool, usable with little to no
  configuration on RHEL/CentOS/Fedora systems.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Einstein argued that there must be simplified explanations of nature,
because God is not capricious or arbitrary. No such faith comforts the
software engineer.
    -- Fred Brooks


--Q935UqjMul3XuJv7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJMH8niJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzje3IH/1MJUWIsTdzXTUojn/k75JrM3eRypVVYXM0i
0AUzCX9Ju9zUknYDBkfDhjYEcSgo5HFjdUIqOskzF0KAvqZQ+wUAPx/3BCQAA3u+
VEfQs4SI6YQBg21Eab176jCmpn3wbwWVQFXJQzKMREFRESD3dWMPkqywUF9QDT4Q
rlNwg8vdxIovSE/HGdidMslM5Xqk2PlnR+/ZypU2cHsvl6uGolfNzJlPJUWI6+ZI
zUBje+7l9sBLfVhXDkwoSlv/5E4ie3E9nPXmWRbKqRm8U7YCZ/xH+yKI3GH1UlIt
E5zzLAhiNcf10WNY3V3Tqm0NS/O/jnWQ/dGPOpmh6R7wT/Ymy40=
=3e72
-----END PGP SIGNATURE-----

--Q935UqjMul3XuJv7--
