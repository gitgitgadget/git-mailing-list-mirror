From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] remote-curl: don't fall back to Basic auth if we haven't
 tried Negotiate
Date: Fri, 5 Feb 2016 20:58:35 +0000
Message-ID: <20160205205835.GB7403@vauxhall.crustytoothpaste.net>
References: <1454404284-2197-1-git-send-email-dmitry.a.vilkov@gmail.com>
 <xmqqegcusvb4.fsf@gitster.mtv.corp.google.com>
 <20160202232952.GA6503@vauxhall.crustytoothpaste.net>
 <CAHdYDCqtNQMoU3Gu2AcSEWM5wA0SbaMrivu3WV_-N+B-F67v1Q@mail.gmail.com>
 <xmqq60y3dout.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Cc: Dmitry Vilkov <dmitry.a.vilkov@gmail.com>, git@vger.kernel.org,
	daniel@haxx.se
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 21:58:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRnSn-0006qZ-CM
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 21:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbcBEU6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 15:58:41 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:54578 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751804AbcBEU6k (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2016 15:58:40 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3BED7282CA;
	Fri,  5 Feb 2016 20:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1454705917;
	bh=y9QNJqSaTNQc2huh1d89BHbPIBdwuWO4/GdgmENlf3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5OFDmHZIcHgqdihXtvxecr1+tuCcKOLy5/RDxGtAVstVNEJbrigiGD5yD9qe1C8n
	 IjbJ1dQMDuuX6+qi792WpzxN2nYNoJw31SGDUvvRTj7cQ4o/mVBn9leqYkNPx0jvSl
	 8oJhwb1krS8zbiyVzGhiNHHbKMPfSOlEYJSn2pgwqYTOIo9/Vd/znFXIuITgUbT1Dq
	 ExjhmTn6E9VTE/+vpbyDMokEfLlxUUVmD/yQuK0gTEN+UNpdJV5QDYFBaKV36nOVQx
	 pphQ0Cke1gPXOx0NT+Balc4u2fiXBPf70coDd6dPKHdwQuyUwoC7W8EnKay4h/PPY9
	 SU4PcD/J68bnjfCE8/mEHfolc9L/i2Xnyf1ssCokPECD5qGKoqfvVvUCneWWwefZW1
	 ZrHQMoW0xpeT3WTqjPzDwxle+YoIZ4sCKWN2D0fEWg1y0zGd6PC3DhF1rF4YJ9fKTY
	 FxUXbhhYtnoheDBF4/vwBrA1EwTT1SIueE88iT3OlpLSycqvNlH
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>, git@vger.kernel.org,
	daniel@haxx.se
Content-Disposition: inline
In-Reply-To: <xmqq60y3dout.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.3.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285630>


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 05, 2016 at 09:54:50AM -0800, Junio C Hamano wrote:
> OK, as Brian said, that use case would need to be in the log
> message, at least.  I am curious, though, if you can give just a
> random string to username, or at least that must match what the
> underlying authentication mechanism uses.

You can give any invalid credentials you like.  When using Kerberos, the
provided username and password are ignored, because all the
authentication information is in the ticket, and it's all encrypted.

I'm happy to send a documentation patch for this, as it seems to come up
a lot.

> Brian, I can see how this would work in that use case, but I haven't
> convinced myself that the change would not affect other existing use
> cases that are supported--do you think of any that would negatively
> affect the user expeerience?

I'd have to test how it works with Basic auth as a fallback.  I don't
normally use that on my servers, so I'd have to enable it and try it
out.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.11 (GNU/Linux)

iQIcBAEBCgAGBQJWtQz7AAoJEL9TXYEfUvaLvBUP/3d1OwudhXd8BqvtFjnSV890
8jK2nA748Oy1chYSUn8Oxvh4QuHZ2aYaL/0SQgBgbQyvYXgDv4fQIjMxV6vqgybG
EOmAap3QhtqhltVdKMk9hC/tyazLd0BOExgCI+oAXxH/DD1LPoji8hDGS7AFSi2Z
R3D9LIyAX4bynjdK7Yg470Ht2yFK7L3cYBbWUOPm3zUU38nMoStWZHwMQsdwq2tn
MQqeE0rK7C0ZcVp3Do/eANxiPZo85naWzpnv8SN0lOoOrcCaSSbUT9rHCQt5jzV7
AxCbLpt9i6zoyjgayf2vin8/asLUadqOS1cdR91KV5al5+ADb6TN6YEO78y9Kitb
5XRfZtNlS+I5zjkhnnedbAUqLTSa6Ay90oQnb27jBr45JTS7/Ih3yz1uAnsA4jXA
d5GxlZCh7bO7l88PISo0KC13El1kalSLeTqcPj1kfo/NIdykrQQ8RcQdHbuR5Sh5
CfIbM59eG9yQ3AsTgWTGhFaiHitYAPQDVLZXbg5WT0nswJqBD59dp9uKsyPKwVJG
ZrRmDGQR78pxex9bAXSCD1op28yXFxVAyB0ImxxuKH32Mkl1Ku8mzyIkf49CrP5w
kkwr/7hJnMrSrjdKZ2jranW4b315Rx1TR/nYPPjmWtreCPUUBlP9iyJ5/ZWA1jbF
c6UctQFpAKwtKqW8bVtS
=ULAB
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
