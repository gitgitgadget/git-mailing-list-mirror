From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] propagate --quiet to send-pack/receive-pack
Date: Sat, 30 Jul 2011 16:15:24 -0400
Message-ID: <20110730201524.GD20477@zaya.localdomain>
References: <20110730121014.GA899@toss.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="ZljC5FVPx7rxDQQ8"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	jkeating@redhat.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Jul 30 22:19:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnG0r-0006HG-K8
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 22:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab1G3UPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 16:15:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64724 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752404Ab1G3UP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 16:15:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7172F4109;
	Sat, 30 Jul 2011 16:15:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=EMhNNGll1yuy/pCPyw5qcxzQgJE=; b=hFFXZmo
	uHxAyNBOE8kpZvbwbTxQAzit92mbfNMgeAL06Y3pdg9mE8Y6LP2Ld5gUmu/wLqAf
	8Cq/1gseCG3OyBJmbfYtJVFIYWZqZy89EWvcEz+wYGWOgyuT3+dVFsEgFE+eUmDJ
	0NA0FcSqX1UHRxWXOLXztGbMipmJvLsgw4f4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=qOxp4BFq/X8bRX/ZDre+p1yNWDOIHA5I4
	8JJdR1792fvQo2hu6NJssXGj2fm9ipI2UpFIei2KC0WtaT2jo4L5UUK9ojaCgpvn
	Idf6iHX3pP4TMUeuS4QT7qrMGZYawUhsJCxs+9yV9Bzi1QWemdNRHpY1B72IpOAX
	2GzOJFR8Kc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6845D4108;
	Sat, 30 Jul 2011 16:15:26 -0400 (EDT)
Received: from zaya.localdomain (unknown [74.99.146.246]) (using TLSv1 with
 cipher DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 177F74105; Sat, 30 Jul
 2011 16:15:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110730121014.GA899@toss.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Pobox-Relay-ID: A99BBAC0-BAE8-11E0-A1CD-1DC62E706CDE-09356542!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178219>


--ZljC5FVPx7rxDQQ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Clemens Buchacher wrote:
> Currently, git push --quiet produces some non-error output, e.g.:
>
>  $ git push --quiet
>  Unpacking objects: 100% (3/3), done.
>
> Add the --quiet option to send-pack/receive-pack and pass it to
> unpack-objects in the receive-pack codepath and to receive-pack in
> the push codepath.
>
> This fixes a bug reported for the fedora git package:
>
>  https://bugzilla.redhat.com/show_bug.cgi?id=3D725593

Thank you very much for the patch Clemens.  I've done some light
testing and it seems to fix the issue that Jesse reported.  I'll leave
it up to the more compentent folks here to comment further.

Thanks again,

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Never argue with an idiot. First, they drag you down to their level,
then beat you with experience.
    -- Ben Adams


--ZljC5FVPx7rxDQQ8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQFDBAEBCAAtBQJONGZcJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjcWQH/3vy2G+6vvR7aFFgUuMhmPLM6xRaLFyI2c6M
qenegxMbMzo9jfoHIuWTLRor1A+otZdxmmtjmZHQuwSgw+Ds7pfqrjmqqLjbxN/W
nEBWVVx1xeN/3nr9/jg7bYGIapL93TPwLnvD/ftZt7dCIGx9aUw/kQ1ci7zfetZJ
+EEpBEYLO6UUg47jad3guKjNomq9uh2pOiCtILC4FyBT8VQsv6fUDnGATG+GHved
Or3bmvsaJkQ978HMehTXq7JRGw1pmUYVeqOAJirW1Gnmyuaa5/ppQV2dIbLpC5uL
nOFBFktEeew8tB6/37PGxD3aKHnPOBlXBPHEuaSg8jDXWLoo6lM=
=yKgW
-----END PGP SIGNATURE-----

--ZljC5FVPx7rxDQQ8--
