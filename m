From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] completion: Replace config --list with --get-regexp
Date: Sun, 13 Sep 2009 14:29:37 -0400
Message-ID: <20090913182937.GR2582@inocybe.localdomain>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
 <20090911133313.GF2582@inocybe.localdomain>
 <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com>
 <20090911141730.GA384@coredump.intra.peff.net>
 <20090911143651.GE1033@spearce.org>
 <20090911150934.GB977@coredump.intra.peff.net>
 <20090911232344.GH2582@inocybe.localdomain>
 <20090912183139.GO1033@spearce.org>
 <36ca99e90909130351m7ad5a641t8adb3ade3d2ec5ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="nrXiCraHbXeog9mY"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	james bardin <jbardin@bu.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 20:29:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmtpm-0007uw-Rs
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbZIMS3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbZIMS3t
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:29:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbZIMS3t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:29:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B5ABB310C3;
	Sun, 13 Sep 2009 14:29:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=knoSyt0ErxJBPVWidiDRsy1x648=; b=T57pQ+f
	GgWPr8XlvCy0BIXPw9SjnwC4hcTg2kraYPg9RBvwYIs6rzviQtG1eQKN6QO+VyrJ
	6PbryLVPQrBA76ms4gRyRG3s3VYe8NbnlLqq4swElMSvfBWQJ0qM0yLXYXbHjnN1
	4Z0xuxG6cRC1bKPZ5InwFrXcB0hWkmLb9l7k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=gJCOku5LjMoKngMPASxJeVhICOcKFuybF
	fP7RTZ4BSXv6vBVgFrAo2K9VevozEQzFtSjtGvaGlPOZfVV4DboOlHO1EGVcOJFm
	8InzyHdvmpJHMf6xXUOBSdG/cS4D86ZyOxdaFOhLihPpkbQH3VjN/QbTPb7GkG0B
	e6pCEcu2VY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 75612310C1;
	Sun, 13 Sep 2009 14:29:45 -0400 (EDT)
Received: from inocybe.localdomain (unknown [98.117.9.179]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D017E310C0; Sun, 13 Sep
 2009 14:29:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <36ca99e90909130351m7ad5a641t8adb3ade3d2ec5ca@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: 6946274C-A093-11DE-958E-A13518FFA523-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128380>


--nrXiCraHbXeog9mY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Bert Wesarg wrote:
> I have not looked into this, but what about pushurl?

Is it reasonable to expect someone to have remote.<name>.pushurl and
not have remote.<name>.url set?  If not, then we should be fine, as
all the old code and this new code do is extract <name>.

OTOH, if there are some cases where setting pushurl and not url make
sense, extending the regex to catch pushurl as well is a simple matter
of changing 'remote\..*\.url' to 'remote\..*\.(push)?url' and, I
believe, using 'echo "${i/.*url*/}"' to strip off everything after the
remote <name>.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Fleas can be taught nearly anything that a Congressman can.
    -- Mark Twain


--nrXiCraHbXeog9mY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJKrToKJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjvKgH/3OdIlpWyE08/ATnf+XrFxD1cr18957Jq//X
mtVqnExLf1T5oTYrj9QLLl2CI/muH5g7E8yrfM713Igna0BkdwSjaDDzLDSs51Rb
pHKJOnDAPudm42vyCErjsyn/cePbET61J2V8T1UWIAvxwI3tnrCWxliRSS+SIQal
3LGTNGQ1oAKN3Ov42WMHuavmjZwGymtchHeSsBqgdlrieypXHuBXmHk1jYBrbH9G
AD8qp1HIlC/BIBySpVYOtEH4LLmEPmErOZW1gAprvqrdeRWeVEIw1wouWBq4aiqb
zUIYDW/CBp8qBLRZbPBtYMVj4lRc+Rg/NJUNlWNghJS0siAZ8dY=
=g3gm
-----END PGP SIGNATURE-----

--nrXiCraHbXeog9mY--
