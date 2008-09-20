From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] Use dashless git commands in setgitperms.perl
Date: Fri, 19 Sep 2008 20:48:14 -0400
Message-ID: <20080920004814.GM2939@inocybe.teonanacatl.org>
References: <20080919234234.GL2939@inocybe.teonanacatl.org>
 <gb1ej9$bg2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="peRj85VDUce1fu/0"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 02:49:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgqfG-0005Pl-QE
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 02:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbYITAsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 20:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbYITAsT
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 20:48:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65386 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbYITAsS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 20:48:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C4028623D7;
	Fri, 19 Sep 2008 20:48:17 -0400 (EDT)
Received: from inocybe.teonanacatl.org (c-69-248-23-23.hsd1.pa.comcast.net
 [69.248.23.23]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No
 client certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix)
 with ESMTPSA id 6F685623D6; Fri, 19 Sep 2008 20:48:16 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <gb1ej9$bg2$1@ger.gmane.org>
X-Listening-To: Nothing
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Pobox-Relay-ID: D0957DA4-86AD-11DD-8519-D0CFFE4BC1C1-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96330>


--peRj85VDUce1fu/0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jakub Narebski wrote:
> Todd Zullinger wrote:
>=20
>> =A0# To save permissions/ownership data, place this script in your .git/=
hooks
>> =A0# directory and enable a `pre-commit` hook with the following lines:
>> =A0# =A0 =A0 =A0#!/bin/sh
>> -# =A0 =A0 SUBDIRECTORY_OK=3D1 . git-sh-setup
>> +# =A0 =A0 SUBDIRECTORY_OK=3D1 . git sh-setup
>> =A0# =A0 =A0 $GIT_DIR/hooks/setgitperms.perl -r
>> =A0#
>> =A0# To restore permissions/ownership data, place this script in your .g=
it/hooks
>> =A0# directory and enable a `post-merge` and `post-checkout` hook with t=
he
>> =A0# following lines:
>> =A0# =A0 =A0 =A0#!/bin/sh
>> -# =A0 =A0 SUBDIRECTORY_OK=3D1 . git-sh-setup
>> +# =A0 =A0 SUBDIRECTORY_OK=3D1 . git sh-setup
>> =A0# =A0 =A0 $GIT_DIR/hooks/setgitperms.perl -w
>> =A0#
>=20
> The rest is probably O.K., but I don't think this change is good one.

I don't see git-sh-setup in /usr/bin with a default install of git
1.6, so without this change, wouldn't the comments be suggesting a
potentially broken hook configuration?

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Suppose I were a member of Congress, and suppose I were an idiot. But,
I repeat myself.
    -- Mark Twain


--peRj85VDUce1fu/0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBAgAtBQJI1EhJJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjqioIAInC9MDHgZ0xWcRxxvwNcNdJUQZCqzovcoJF
Jybp/22dk+wICPMPusbsH1mRK+P9LVE9+0f/hfDilnTxh/BuFiSyn4R2npumJ9Zq
3LwEtmNN5n0ZzeYWQHlOkYJbWa62Qy6rwn6SACtvz4KnDcRlZkff64TTATY7yGVZ
TjpvGaf+8bTTwZsE0PjX9R1HytOWwJANhHxoS7OBDDsm68kF0GK3E/Fg7QBfWTJo
f9j8mDG6zlQJB6TpCTOKttIng19TL8UpXmCVPTkL3yi3wvudnbo0ZSWAulHMaeyh
mufZhfEMtrHXuPxHRVVQ0RmnFLzjYzJrJmS5daQEH2q+a4uoAwI=
=SVD3
-----END PGP SIGNATURE-----

--peRj85VDUce1fu/0--
