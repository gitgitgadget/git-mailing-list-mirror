From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] http: add option to try authentication without username
Date: Mon, 15 Feb 2016 21:51:57 +0000
Message-ID: <20160215215157.GD57185@vauxhall.crustytoothpaste.net>
References: <CAHdYDCq+MiAJoCPFd3Qn9VjAzoii8QgTOOV7HXEV8OdzW-dgPQ@mail.gmail.com>
 <1455561886-42028-1-git-send-email-sandals@crustytoothpaste.net>
 <CAPig+cTr1eW1KLsZGpY98hUhJ2EHdPopz9C_gTztZRdNPBQTmQ@mail.gmail.com>
 <20160215202937.GA57185@vauxhall.crustytoothpaste.net>
 <20160215203451.GA29705@sigill.intra.peff.net>
 <20160215203659.GB57185@vauxhall.crustytoothpaste.net>
 <xmqqsi0tpsa5.fsf@gitster.mtv.corp.google.com>
 <CAPig+cSphEu3iRJrkdBA+BRhi9HnopLJnKOHVuGhUqavtV1RXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 22:52:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVR3y-0000w1-3q
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbcBOVwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:52:05 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:40234 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752608AbcBOVwC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 16:52:02 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 94FA5282CA;
	Mon, 15 Feb 2016 21:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1455573118;
	bh=O9rGb/6loUiQwi0HH4jozevKTaZRq7bbQrJz97BpWp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEkwLsSxFoG0N/vEVh/MIZetTGTMCUwVxdM1/Wp3Y1HsYksxWmmRNnr0HC0ca9gzn
	 98RbPUuvwHwha5bTBNY5YNuekXrIvOC8h3qCvssW/IH+8SneGQ16WaUEC+Yshd/B/f
	 tWA+TRH7j55trj8VOW8Kqje3D/j6HiRBW8i1uExYgIrRguIVdbSObzHdMGCZjw07mr
	 CI+CjERbMEHbhhmz3w4KEl9+EgOUNXCpQKso1WhvBMBn7sSku+bhtitRv5uPNRGb0e
	 J/1TW/3kizYmsa/+JB3l2gsKiOfZSflfHQrGshYZoYbimnCuqCLuV9EOPMpfHXvpvp
	 TpVW9PNu6UFGHFd9nisWbNHMARceE0+iNVRNtKmhtbRWYxjKMsijY0QslKEbBgsnGx
	 tuapQeI1biWQ0t1MuI633TOurFSIs9PlUSRWazEIMa8GA+5e3HZLHSQv9AHwMZ4Lf3
	 Fi1e0Qj2eNAPNnPIL/wmXhVqAi/SFqcjA36d7X9V1DUokggCfJS
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
Content-Disposition: inline
In-Reply-To: <CAPig+cSphEu3iRJrkdBA+BRhi9HnopLJnKOHVuGhUqavtV1RXg@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.3.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286260>


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2016 at 04:46:43PM -0500, Eric Sunshine wrote:
> On Mon, Feb 15, 2016 at 4:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >> On Mon, Feb 15, 2016 at 03:34:51PM -0500, Jeff King wrote:
> >>> So I think this hack should remain purely at the curl level, and never
> >>> touch the credential struct at all.
> >>>
> >>> Which is a shame, because I think Eric's suggestion is otherwise much
> >>> more readable. :)
> >>
> >> Yes, I agree.  That would have been a much nicer and smaller change.
> >
> > Alright, reading all reviews and taking them into account, the
> > original, when a Sign-off is added, would be acceptable, it seems.
>=20
> One final question: Keeping in mind my lack of familiarity with this
> particular use-case, would it be possible to infer the need to employ
> this curl-specific workaround rather than making users tweak a config
> setting? Or would that be a security risk or an otherwise stupid idea?

It's not very easy to infer whether it's needed.  We'd need to know what
types of authentication are offered, and somehow we'd have to intuit
proper behavior when both GSS-Negotiate and Basic are enabled.  Some
sites do that because you can use Basic against the Kerberos database.
One user might legitimately want to always use Basic (e.g. with a
password manager) and another might always want to use Negotiate.
Setting this option is one way to ensure the latter.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.11 (GNU/Linux)

iQIcBAEBCgAGBQJWwkh8AAoJEL9TXYEfUvaL9AEP/16gbmxG9cCV5m8W4SBg/V/K
JXRUunCAL50OqR5llHca5MBANuMiMYgb1Ntt/Cilcq1lSbxl1HPxXL40vPnRolCz
1/aswwMTtsDYSFshWdwTzvw9TX5Fg7M5YjQPPIIrgtbrVs1JYnVI+opkWE/K2M8E
7KTegRH2p64PQa8ZzB6AD+ZGJIHfxcSDWgFN/vKFiyI9k8uHpgMVMu9zt4Miaa8v
xTQwcMXHIpcAINzsZ5bwVogEK1uiD5tbumlwNdSh4U4bup60x1KlXZuYj2B8eiLi
S1DpaLVjtxeOsrLD++BmM03kDQpYZYfExuP17EdmF5CuGbHWn4E3rSgBFZ7VR0bt
4KfOCQH4u5BosVhJMjAtMzkgwg1lY1QSH8Zn8cV70bPKgM5/GO9C6nQGZmR47kKQ
t3j9XJAz73bmCbi32xjs601UIEstoo5GrvhT4GYDbFFufS4mVttsBtcVVElV2dCi
O4ACEb8Yt0M3sRrrvXWf3vgwoc2yOILul9CWraICc/k/vxxrr7yYi1aZr1OCyM8i
n1jWWa/GiL3qyIuhjSfsPChy9vgKSPIWk9jY+nHiuc7e7EsajpdsD2GGXdqAdFT+
NJuSrrprKo1byAL0nk4f4atPaJBwrGx2lBg9UKZ66KZAOpreQGbvbIKEMtG4NVmX
ghoCbC2FkUHcQGUHDsQZ
=+rEG
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
