From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] Makefile: update defaults for modern Cygwin
Date: Mon, 05 Apr 2010 08:44:38 -0600
Organization: Red Hat
Message-ID: <4BB9F756.7030701@redhat.com>
References: <1270161834-9597-1-git-send-email-eblake@redhat.com> <7vaatmmju9.fsf@alter.siamese.dyndns.org> <4BB5F94F.3090403@redhat.com> <20100403074700.GA24176@progeny.tock> <4BB9E24E.4090206@redhat.com> <20100405143053.GA13093@progeny.tock>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6CD3A7A311689346C7E94685"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jon.seymour@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 16:46:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NynZY-0004if-Jl
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 16:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185Ab0DEOqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 10:46:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59057 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755166Ab0DEOqd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 10:46:33 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o35EjvvS027577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 5 Apr 2010 10:45:57 -0400
Received: from [10.11.9.20] (vpn-9-20.rdu.redhat.com [10.11.9.20])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o35Ejtoc016000;
	Mon, 5 Apr 2010 10:45:55 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Lightning/1.0b1 Thunderbird/3.0.4
In-Reply-To: <20100405143053.GA13093@progeny.tock>
X-Enigmail-Version: 1.0.1
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143986>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6CD3A7A311689346C7E94685
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/05/2010 08:30 AM, Jonathan Nieder wrote:
> Eric Blake wrote:
>=20
>> Cygwin 1.6 is on par with 1.5 feature-wise, so your cutoff of 1.6 as t=
he
>> last old version is correct.
>=20
> Thanks for explaining.
>=20
>> ifeq ($(shell case '$(uname_R)' in (1.[1-6].*) echo old;; esac),old)
>=20
> Looks good to me.

Junio mentioned he had already queued your first version of the patch;
are you going to re-submit it with this tweak?

>=20
> While I have your attention, do you know of a simple way to test
> Cygwin programs under Linux?  setup.exe does not work well under wine,
> so I am asking mostly in the hope that there is a .tar.gz or .zip
> binary distribution somewhere I could play with.

Sadly, the fact that wine is not yet able to run setup.exe is evidence
that wine is still lacking some emulation abilities, and while I am
aware that the situation is trying to be improved, I am not actively
participating in that effort.  For now, I am only aware of the ability
to run cygwin on native windows boxes (including virtual machines).  In
fact, I'm currently using a 240-day evaluation license of Windows Sever
2008 inside a VM to experiment with cygwin on my Linux box, without
having spent any extra money.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig6CD3A7A311689346C7E94685
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAku591kACgkQ84KuGfSFAYD0DACcDbio3yRqvv4M/eJYwP5Uh0ep
ZO4AoLUisKx8GdfKtVnIaAuIImBFwgPs
=RgvI
-----END PGP SIGNATURE-----

--------------enig6CD3A7A311689346C7E94685--
