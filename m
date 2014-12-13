From: Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 3/3] replace binary keyrings with armored keys
Date: Sat, 13 Dec 2014 20:30:21 +0100
Message-ID: <20141213203021.7bec320e@leda.localdomain>
References: <xmqq1to4d8bh.fsf@gitster.dls.corp.google.com>
	<1418416939-22171-1-git-send-email-mail@eworm.de>
	<xmqq1to4y1uy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bviSB/CPM93TrFz90XjQNFH"; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 20:30:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzsOq-0002GB-Th
	for gcvg-git-2@plane.gmane.org; Sat, 13 Dec 2014 20:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbaLMTag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2014 14:30:36 -0500
Received: from mx.mylinuxtime.de ([148.251.109.235]:47259 "EHLO
	mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbaLMTaf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2014 14:30:35 -0500
Received: from leda.localdomain (unknown [IPv6:2001:470:1f0b:a5b:c685:8ff:fe0e:b717])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id F14A224329;
	Sat, 13 Dec 2014 20:30:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.9.2 mx.mylinuxtime.de F14A224329
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
	t=1418499033; bh=ACiS1C6RT1RBB/bDeOcI12feEZfALiKx0OgaVusIS5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=xtBBBi6mVtdcT9ivnM7HQcxij6VhOAMUXD9tdCIEGmaInBLwk19eIQnkShOCy4qXE
	 dbGXukXeLYBj1uPiXVLomo1vr5c8yu6bd0xSgh0XFiky2+Bowx2iu5nz2ZUck5B7z0
	 GhbxMVYt7YRCHVOyr/JRp5NXXkeDUkBFCPS9X4x0=
In-Reply-To: <xmqq1to4y1uy.fsf@gitster.dls.corp.google.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; x86_64-unknown-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex
 /RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261394>

--Sig_/bviSB/CPM93TrFz90XjQNFH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> on Fri, 2014/12/12 13:50:
> Christian Hesse <mail@eworm.de> writes:
> > Last but not least git and patch can handle this a
> > lot better.
>=20
> Actually we can handle binary patch just fine ;-)

Ah, that was kind of misleading. :-p
Generating a patch with git including binary data and trying to apply with
patch results in something like "git binary diffs are not supported".

Anyway... Thanks for applying!
--=20
Best regards,
Chris

--Sig_/bviSB/CPM93TrFz90XjQNFH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUjJPOAAoJEFTtyRYJvJGD56oP/j+v9wskdJB5K+lulvZgPpWC
xd6VFb0VvkfNYyRilmnazzp6R6lxE333dvkUTOI5wfP8aBwK9l2SASZV2ZpRC5Xn
J1E19wQyKN5GHVH/+XF0dHYx74E4mFFBNaDLKwaOvDTPJhEengkfa/1FweFwlcQv
kE/BZ5KIfGlLDuf0/v6fg1/nimr8qGW3l/QvmUFxG7s4oG6GdDq7J2K/8cjvg74m
efrFbOHKkIXv11RX5Zy2WetfOBM739jhfmYjrejRUyY5GxYX9vu7Z+QDz4DArO5M
rkAFhziBkDmuKshQvl0w/qd8ysP8gIgHcBjMb6QM1KEPLreZ5LU+vp9PNLOr26Zt
Sg7SONmSvBao4B4viZvBAiXp9SZV3I7VTrDtRgzVhJhwkg93NR6PfqvIQmQGSVyp
TLzCDtXtvnpWABasxCjZULs5nQWVeFie1RsGN+5x3Q/qw0uRd5V5U46Wo18BKU0R
i4AgYDMXykUKXSQeFFALqglAI2UI6dgoTMucTic0VxsHtJnQKCiTvAgHNUx79iMu
XT2y/Ct5Z5CegzjLdhFpBP0Be2yitEc/IpLbnF8Te47ek99DAFjUbMq7Nkt+Dhyw
IhWMqZSE02g4AM7E3Xbh/Y0j52+V743Ewa3oUzghKe1nUgTIG4TK0nx/i1zmcu5S
bh+V+ZvSKHtsEvELMowq
=wzyC
-----END PGP SIGNATURE-----

--Sig_/bviSB/CPM93TrFz90XjQNFH--
