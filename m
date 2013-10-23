From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/2] Update documentation for http.continue option
Date: Wed, 23 Oct 2013 22:56:32 +0000
Message-ID: <20131023225632.GZ865149@vauxhall.crustytoothpaste.net>
References: <1381530945-90590-1-git-send-email-sandals@crustytoothpaste.net>
 <1381530945-90590-3-git-send-email-sandals@crustytoothpaste.net>
 <20131011235052.GV9464@google.com>
 <20131012002639.GE79408@vauxhall.crustytoothpaste.net>
 <20131018221535.GM865149@vauxhall.crustytoothpaste.net>
 <xmqqeh7csygy.fsf@gitster.dls.corp.google.com>
 <20131022233257.GA9464@google.com>
 <20131023013400.GB9464@google.com>
 <20131023030048.GX865149@vauxhall.crustytoothpaste.net>
 <CAJo=hJssxNtJSeLgwG5nON=Y-7HzZPULiwzH+0SXeU8tp3FC-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D8DPajcJO06Q0DF+"
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 24 00:56:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ7M0-0008N8-Eo
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 00:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559Ab3JWW4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 18:56:37 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33268 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753520Ab3JWW4g (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 18:56:36 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:d72:c0a:d498:7594])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A916D2807A;
	Wed, 23 Oct 2013 22:56:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAJo=hJssxNtJSeLgwG5nON=Y-7HzZPULiwzH+0SXeU8tp3FC-A@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-trunk-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236557>


--D8DPajcJO06Q0DF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2013 at 08:21:48PM -0700, Shawn Pearce wrote:
> From my perspective, it is OK to defaulting to use 100-continue if the
> server supports Negotiate. If the user is stuck behind a broken proxy
> and can't authenticate, they can't authenticate. They can either set
> the variable to false, or fix their proxy, or use a different server,
> etc.

I think Jonathan's suggestion was to get rid of the variable altogether
and simply make the code conditional on whether the server is offering
GSS-Negotiate.  I plan to make the use of 100-continue conditional on
large_request as well, so that it only covers the case where it would
otherwise fail.  People who have broken proxies or broken servers and
are using GSS-Negotiate (which, as I said, is probably very few people,
if any) will simply have to increase the postbuffer size as before.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--D8DPajcJO06Q0DF+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSaFQgAAoJEL9TXYEfUvaLfVIQAJy+v3VE35bNOfz22fGDtkq9
ONw/D3GO2nf4oVAZcm3oh7A1+1Q/P51xGdh1YyilsNnWh6sW2UT+ldbDyuKYF5zF
dDvKVicQcC0ASlF7753c7QClrjsxBso0sjP+bX94mfI9F+vfn57VQQrBxh98Psqu
Gz2q3ruMrjEDd8nAyfqPUtoZbFGlxgUJuBwzyU4kE+nFZyC96C9es7orUW11y2Lq
SmIlG9oN+8yHbbPu04HHJGAimDdXQINZrgmEkm2dIVSkQgPMrrvkBXg/VVUrK+Ek
+iVsVGu2F0smVx9NNekoI69Bu2/mWp2zbeBI4mKyF4i/wV4m8zv4lGVw8DHuvgqC
JWCDlAV44stIkLWOCbwXu6pjfzb6WUgUZAduRfJC+lITuDDTh7oS9YCvkdSzwxZ0
rxIqA8h9epGCOhzvw6/x+RFedm16dwYnN1Jl/7LJmm5D84HJHT8cmjTmtbwCH8a2
DRlEKqD/rTDROpKRop0cUcUta1nHE4lAUQajTVID+AJd5tezuWoJ2IlX68h1Thq6
6yFzBwXwyMZUfggY6xsV9m37TfZzzg9tYIs/a9RhFODK/U7w+RC/cCuVWSLuyNy9
C00vV4YZCOUVqFkvPslupYy2Fm74BSYfgq9PBtD8KmAEtlcllhZ13yrA6mpGXwy9
Emzxr6CdeXnrcb394bMx
=cmof
-----END PGP SIGNATURE-----

--D8DPajcJO06Q0DF+--
