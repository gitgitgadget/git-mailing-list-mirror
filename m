From: Josh Triplett <josh@freedesktop.org>
Subject: Re: most commonly used git commands?
Date: Wed, 27 Jun 2007 19:30:10 -0700
Message-ID: <46831D32.4090900@freedesktop.org>
References: <20070625064017.GA2839@mellanox.co.il>	 <7vlke833wr.fsf@assigned-by-dhcp.pobox.com>	 <20070625071752.GB15343@mellanox.co.il>	 <7vodj41nm6.fsf@assigned-by-dhcp.pobox.com> <46a038f90706271917j7abb4bddu21debafe3461c695@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig35E41CAE9790D9B591824CA5"
Cc: Junio C Hamano <gitster@pobox.com>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 04:31:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3jnB-0003Al-PS
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 04:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759293AbXF1Cb2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 22:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761487AbXF1Cb2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 22:31:28 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:59180 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761478AbXF1Cb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 22:31:27 -0400
Received: (qmail 31717 invoked from network); 28 Jun 2007 02:31:26 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail8.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <martin.langhoff@gmail.com>; 28 Jun 2007 02:31:26 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.4 (X11/20070622)
In-Reply-To: <46a038f90706271917j7abb4bddu21debafe3461c695@mail.gmail.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51073>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig35E41CAE9790D9B591824CA5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Martin Langhoff wrote:
> On 6/25/07, Junio C Hamano <gitster@pobox.com> wrote:
>> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
>>>> Quoting Junio C Hamano <gitster@pobox.com>:
>>>> Perhaps they are most commonly used by the person who came up
>>>> with that list first ;-)?
>>>>
>>>> I think "add" deserves to be there, I am not sure "apply" is.
>>> git add is supposed to be rare, no?
>>> That's why git commit lists file additions/removals ...
>> No.  You are talking in terms of pre-1.5 git.  The semantics of
>> "git add" has been clarified since then --- it adds contents,
>> and is not about telling git that there are new files it did not
>> know so far.
>=20
> In other words - git-add is also a (semantically good) alias for
> git-update-index.
>=20
> So you "add" files to the next commit. Whether they are "new" to git
> or just changed it doesn't matter that much in that situation. And
> git-commit will look at those files that have been "added".
>=20
> Makes things a whole lot easier to explain. I didn't understand it
> initially, now I'm completely sold on the concept.

Agreed; this change converted me from a "git commit -a" user to a big fan=
 of
the index.

- Josh Triplett


--------------enig35E41CAE9790D9B591824CA5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGgx0yGJuZRtD+evsRAjNbAKCJAP7RcCa8nEuUQdlBdqIjffN/RgCfSWRR
MnjE4/fKFnegJe3pNvh9RXA=
=voou
-----END PGP SIGNATURE-----

--------------enig35E41CAE9790D9B591824CA5--
