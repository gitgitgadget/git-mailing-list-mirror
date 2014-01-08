From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Preferred local submodule branches
Date: Tue, 7 Jan 2014 20:06:27 -0800
Message-ID: <20140108040627.GD29954@odin.tremily.us>
References: <20140107235208.GC29954@odin.tremily.us>
 <20140108034708.GG26583@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 05:06:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0kPc-0005ev-7Z
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 05:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbaAHEGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 23:06:33 -0500
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:37716
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753865AbaAHEGb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 23:06:31 -0500
Received: from omta15.westchester.pa.mail.comcast.net ([76.96.62.87])
	by QMTA11.westchester.pa.mail.comcast.net with comcast
	id BG421n0041swQuc5BG6WgH; Wed, 08 Jan 2014 04:06:30 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta15.westchester.pa.mail.comcast.net with comcast
	id BG6U1n00L152l3L3bG6VHD; Wed, 08 Jan 2014 04:06:30 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 72E53EACE00; Tue,  7 Jan 2014 20:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389153987; bh=VjXu2UmQ86zHBqkof378Ttbv+og/8/sbQU9C39REsFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FbPQGcu+yF+klVlkXD+4rUhrRKRcxPtA+dc3xzkIBM/8UrDyQz4Qi42GGlSbMKdrm
	 HBXDjcjOtRpmcBMf3OcCI68O0jGcZgpHmv0qiw7d/sV8Hg5iSH8b0hVl6zcOpdcwih
	 gXQrxzLIHQEnBLSpoIUTPGe6/r5bsse4LgeG/TFk=
Content-Disposition: inline
In-Reply-To: <20140108034708.GG26583@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389153990;
	bh=d+vBbDZOCryLadX5G3hKm4gBoxvora9mJUGiKl+AR90=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=JCGeHGXnv3VP30rqyj9PiwMut4000upPdCAdYBwlgNxWEUFKPChXsI3QZjRSr7eYi
	 fkqn5AUB9sSmv8img8nw6g4KQtQGmynf0lgTBirYGQdSsaDI88TeP/X239J5Sy5v9p
	 PDLVqfppN44vn7wXPNI0dyYd5lqTZWKnAYxcTMpjzuOyYCdWIkiAFqGbbYB0fV/gTg
	 PBbZXp14ashre3UqPt+BeZiJZOn9ZltukyzMuKQivRqhNWOsm6X6YUmVCwpyb7DUjt
	 JX3Gp+sw9M15D4lzehMvhNr4v/Tu61qB3P9MA7KT4oKh9Ys6NnjMe3wrzoG4cvKJXT
	 dkpNOlJ5Pu9TQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240194>


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 07:47:08PM -0800, W. Trevor King wrote:
>     #git checkout --recurse-submodules master
>     ( # 'git checkout --recurse-submodules' doesn't exist yet [2,3].
>       # Even with that patch, 'git checkout' won't respect
>       # submodule.<name>.local-branch without further work.
>       git checkout master &&
>       cd submod &&
>       git checkout master  # don't pull in our my-feature work
>     )
>     git submodule update --remote &&
>     git commit -am 'Catch submod up with Subproject v2' &&
>     # update the my-feature branch
>     git checkout my-feature
>     ( # 'git checkout' doesn't mess with submodules
>       cd submod &&
>       git checkout my-feature
>     )

Oops, the my-feature checkout block should have been:

    #git checkout --recurse-submodules my-feature
    ( # 'git checkout --recurse-submodules' doesn't exist yet...
      git checkout my-feature &&
      cd submod &&
      git checkout my-feature
    )

mirroring the earlier master checkout block.  Sorry for the sloppy
editing.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzM7AAAoJEKKfehoaNkbtUoQP/i0h58m4Iu9K4vnCjmu+FMxu
S0LSs5du77ETQusFBnPrvW+oKCPmnS7bFRTXkMkXdZBJZEYYZxB2H23G36MCU+x2
ys9pQmKQ0Gk9wJ+6CUmOD0JD+FECPXA1Yu6hM+SWS31/ljiOtw8JtHlc5yfMU4T0
AssBGVIDVg6qEQNnpe7QmL2UmhlaUqAwEvs2M5LXD/bXdcUmBteYNhnFjnocUBTj
BuzhfTH+zlrmA3zlYBk9uRYEWIbP3W1lUOa9a6fPCttE7BC/xERnAeiKgwoju929
+8A1IlnO+F1RRgmLFdqDp0Ob9mARt2EKdIjD7y51iethRS+1JsXvi1uq4/RJDIzR
0/aAAMLQS+QhjRG5oVBjsdF8nckmHqukPK7DcEk4IGA6S7HLvgiotiMyd+z01RyA
DmMEderz8ZH7nzlylkedt/eUH2CRZpt5AabRy3re7RAfPRGPVMwRfd7eRzyedC9p
6fJGgItIy/6xJr0VwfLifiLQwqLCzKF1T27tLBMc2ImPJUXZHNYInWUZliCj0IFE
B6mLUmX4H23EHBEIdTDjEnZVVhy5GQw4rMyJvuO7ysBj4JhLj0Eljsmq22LibA5i
tYp1KWwlxnv87wTKGHP7ypKYyxxaw/UNoR6bAvouwJ8nhnHJJXPK6ZRWpe1P4HxW
HbFRa8fF1/aUdUjEa7Ij
=B8jK
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
