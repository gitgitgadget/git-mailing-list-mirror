From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/2] Update documentation for http.continue option
Date: Fri, 25 Oct 2013 20:56:46 +0000
Message-ID: <20131025205628.GA38426@vauxhall.crustytoothpaste.net>
References: <20131011235052.GV9464@google.com>
 <20131012002639.GE79408@vauxhall.crustytoothpaste.net>
 <20131018221535.GM865149@vauxhall.crustytoothpaste.net>
 <xmqqeh7csygy.fsf@gitster.dls.corp.google.com>
 <20131022233257.GA9464@google.com>
 <20131023013400.GB9464@google.com>
 <20131023030048.GX865149@vauxhall.crustytoothpaste.net>
 <CAJo=hJssxNtJSeLgwG5nON=Y-7HzZPULiwzH+0SXeU8tp3FC-A@mail.gmail.com>
 <20131023225632.GZ865149@vauxhall.crustytoothpaste.net>
 <20131025071706.GA17029@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Cc: Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 22:57:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZoRS-0008EV-RQ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 22:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318Ab3JYU5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 16:57:06 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33303 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755306Ab3JYU5F (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Oct 2013 16:57:05 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [99.69.156.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 009FB2807A;
	Fri, 25 Oct 2013 20:56:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131025071706.GA17029@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-trunk-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236715>


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2013 at 03:17:06AM -0400, Jeff King wrote:
> I think that makes sense. Would you also want to suppress the probe
> request in that case? It serves the same purpose, but would cause you to
> do an extra auth for no reason (which potentially means user input,
> which is annoying).

I actually need the probe request to determine what authentication is
available, since it isn't guaranteed that the info/refs request requires
authentication (in my case, it doesn't).

> Also, if I recall your original complaint correctly, the "Expect"
> handling was only half of the problem. Wasn't there also an issue where
> git prompts for a password, even though GSS-Negotiate doesn't use it? Do
> you have a plan for that?

It only does that if it fails.  I do plan to fix that, although
potentially in a separate patch.  It's really very minor, though silly
to have it prompt when that's not ever going to be useful.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSatsHAAoJEL9TXYEfUvaLNIQQAMeSlm3MAb2gmrhL6jZxM4IY
X9Mt3Rtd3gu0Pd8LM5uTa2Ooz/7FiUKIUkWFR8bnL+iByPSNUJpYkTwl+NxQFi9M
srwCLTvp7enpsNXSr2nTgCk000yCdudMwwH20hKhDvCstcRTS4VdeSG44mLU6kVY
gYMZJCVjvsJlUoBUq0cNy1M/n7uxy1FxuG2elt02Q6LNVKgRs3AufdMChJxvva/u
VkjiK3fL/FRjyWBWU/Kb4UQvvdWvWkjSdzU2bZ+IFIMchZWppOaZTxVSyQwR/OZs
/pvjOTcqoWA/MLva74wX7HFHmJaH+6bQTJxSfvHiqQDg8rN3k4yV+OGZ+9TimoZ7
QDTTvibhN+q0KElfEg7lE2qC15wdWrUErcBfkH0A47MvLzn8WMTqigR8UZrd+gJX
Oyl/Ts5nVTICLmL24rNK9nSuG9mkW1qDxEqfzf/pbHbdbWd8jI2Pw/L4Oj5bjiB1
6Ky9zP5AXrw4QoC9MyhGp+0EPxyia7OOQ/gKu0tinnr9/IXDeu1M+W3bxcqwjXM0
Ui74iU347xiNG7qYcc1rzLhYY+0vLRszauZq+bq4hjLkiE16nzUVl18XP4hjZr2E
NYoJbDE0sI9vcE6Ml1KjJHHLxWruuFY/VSDiyL8SGGAo4DmJSMKgwm/VBN1bAZaZ
XiZTiwLmAHtI/KgUH04m
=Ismd
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
