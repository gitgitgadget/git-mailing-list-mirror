From: Pirate Praveen <praveen@debian.org>
Subject: Re: support git+mosh for unreliable connections
Date: Mon, 20 Apr 2015 14:09:57 +0530
Message-ID: <5534BB5D.4000802@debian.org>
References: <552E628C.7040809@debian.org> <20bd52de595018f49eeeea64128e3a77@www.dscho.org> <552E7927.5030803@debian.org> <20150415202647.GA29170@LK-Perkele-VII>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gw3rbtIMC718S5XMe7lKMx4Bpk5pAu1J8"
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Apr 20 10:40:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk7Fk-0005MA-9t
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 10:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbbDTIkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 04:40:10 -0400
Received: from latitanza.investici.org ([82.94.249.234]:58363 "EHLO
	latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570AbbDTIkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 04:40:09 -0400
Received: from [82.94.249.234] (latitanza [82.94.249.234]) (Authenticated sender: praveen@autistici.org) by localhost (Postfix) with ESMTPSA id 27CE3121F96;
	Mon, 20 Apr 2015 08:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debian.org;
	s=stigmate; t=1429519205;
	bh=JzHkeYJwO9uZlZz1Z4R2zO9rjyahfa+sif/2Qi7tBeg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Kk99WLiUhu3pFp7aB6sVkQ+2w0H78RQYsSgg6xrzRgrpqfzu0Yofu8cMKOV4sFoy7
	 flpfmEcY3vPx3M5AMwQrmnrgkMgjt2I0zUjyEixfTGpyQIliLhlr1dRR4UtQIl/EHh
	 H154FxKOLNFiCusL0RBTBjNfmMVvk865eUzA4Hgo=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20150415202647.GA29170@LK-Perkele-VII>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267457>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gw3rbtIMC718S5XMe7lKMx4Bpk5pAu1J8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday 16 April 2015 01:56 AM, Ilari Liusvaara wrote:
> On Wed, Apr 15, 2015 at 08:13:51PM +0530, Pirate Praveen wrote:
>>
>> Q: Are the mosh principles relevant to other network applications?
>>
>>     We think so. The design principles that Mosh stands for are
>> conservative: warning the user if the state being displayed is out of
>> date, serializing and checkpointing all transactions so that if there
>> are no warnings, the user knows every prior transaction has succeeded,=

>> and handling expected events (like roaming from one WiFi network to
>> another) gracefully.
>>
>> Can the ideas be used to resume a pull, push or clone operation?
>> Especially serializing and checkpointing.
>=20
> Well, it is possible to write a remote helper and serverside program
> that internally handles connection unreliability, so Git itself
> (upload-archive, upload-pack, receive-pack, archive, fetch-pack
> and send-pack) sees a reliable (full-duplex, half-closeable, stream)
> channel.
>=20
> Suitably done, that can "resume" (from Git POV, nothing special
> happened) across things like IP address changes.
>=20
> However, that is quite difficult to do in practice. Not because
> interface to Git is complicated, but because the transport problem
> itself is complicated (however, it still seems way easier than
> making Git internally be able to resume interrupted operations).
>=20
> Mosh needs to solve at least most of that, it just doesn't provode
> the right kind of interface.

I have requested mosh team to fix these issues
https://github.com/keithw/mosh/issues/597



--gw3rbtIMC718S5XMe7lKMx4Bpk5pAu1J8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJVNLtdAAoJEM4fnGdFEsIqXsQP/1KIX8fONIBbC8BQZiXWjlRe
dqP9nWHMrIBUW+mB1GFUu39MCi/nO6aR/XN1GxhWv7tu2mgWVrLMZGG65JeQ8C1I
+r/Ha4W3FOwCGFzMH+MKV0IL0f3F3Tu0Jk/do8DPVfHWY4Y8Jz7Gwi+0M7WwUilc
LFrQcRr2HsOxqLinDa2A0aTGdu5mKl12sT2Zee8pMitNPmqe2lexy6eqnbH6ayjp
8v8WONzoeytVaQCHK24MSTg1vMgaiA3w3ZL/cdcCJ5holgpWolWOe4X++cIPBeXr
REIZbMIb/Y5kFvF3keVAUGOPershwr7gMWC6G1DSIxQPvrLy5tBACXfz9T44oTRM
IxenzDf+smIoQd4PfiMFliBcdXQj5tAcMD2crOtdFzTIgmqnTxxiKiefuZIUtV3G
869TlHfcYLsFpoUbBTL73oxmPf3Gcetn8fTk4UJyBI07JR2J009xsnX+vpk5QVws
d+6lbIBpEY4Av3Nst2Ur4qUj6QJKf51sWpL8Hus3mGnfx/Q3s/uszVqIuKAOR3gN
Nx0w3Z4BEM/OjsM9uCxIj54JZY2+KmYoNNSHIqUEVKNl2oGQFYXntdVZPSd7a11Q
OI7VqOMiZO3+f/CqkWqDxWF23plnqhY2oNYDVYxDBlvisyjmHIY0DVd2ItA+2Oe2
jagIQsWaERF4AgLgqeSq
=LITd
-----END PGP SIGNATURE-----

--gw3rbtIMC718S5XMe7lKMx4Bpk5pAu1J8--
