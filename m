From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git:// protocol over SSL/TLS
Date: Sat, 28 Dec 2013 00:11:00 +0000
Message-ID: <20131228001100.GF451338@vauxhall.crustytoothpaste.net>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
 <20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
 <CAErtv25JGxEs3ytAB019yajQooNs4k=bzukSE9kuHWAbir9-BQ@mail.gmail.com>
 <87mwjm4c3s.fsf@igel.home>
 <vpqwqiqpe80.fsf@anie.imag.fr>
 <CAErtv25URyB3znN1CMd87374NUjaSFvg=cee_-c=s8bB2j052A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Git List <git@vger.kernel.org>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 01:11:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwhUp-0005BP-8A
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 01:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832Ab3L1ALK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 19:11:10 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50692 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754748Ab3L1ALJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Dec 2013 19:11:09 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:7933:e351:9ca4:8c22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0781628074;
	Sat, 28 Dec 2013 00:11:07 +0000 (UTC)
Mail-Followup-To: Sergey Sharybin <sergey.vfx@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Git List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAErtv25URyB3znN1CMd87374NUjaSFvg=cee_-c=s8bB2j052A@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239758>


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2013 at 08:25:16PM +0600, Sergey Sharybin wrote:
> Security in this case is about being sure everyone gets exactly the
> same repository as stored on the server, without any modifications to
> the sources cased by MITM.

Besides security, HTTPS is more likely to work across different
firewalls and proxies, since "odd" ports like 9418 are often blocked and
HTTPS usually isn't subject to the weirdness of proxies (since they
can't inspect it or modify it).

> As for "smart" http, this seems pretty much cool.However, we're
> currently using lighthttpd, so it might be an issue. We'll check on
> whether "smart" http is used there, and if not guess it wouldn't be a
> big deal to switch to apache.

You can use Lighttpd if you like.  See
Documentation/git-http-backend.txt (or git http-backend --help).

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSvhcUAAoJEL9TXYEfUvaLjBoP/3sUN1RA9EtDoLyK9qFgX+Pl
Dss2RDAlX5F6JBt/dtrYZypCj/BZ7B3kk8SaDEaMtp6g7F990Yn2aeJZiY93Fljo
ccRnKC6kYxbFyi8e4TiENCMuae6l4aRmPBGaftzeJfiTBMXfMRE8Tro8XSlexiCt
Ahcy9xYnz9nS6s84dXCBjse1+hZsR2uTEnlWHK1WbTf2AJhs19LlocPO6Mnq0kMf
wDRyuzw/ejWLm+bafQaUk0hZfqAV74v8EoZBjj+Wb0Zz83OW6UpKqc9qhCknGVR2
BKeR3TcMfSzmSNqu957LLB4OhJfnNBAM4DNm24R98EVkSoUkbuQyT1c/SLRJxWd+
VKFATpWqtQIiyq0j7x51T9YRTYBAj/1/6sUOANnLIbwhnhONiOlbu/wLJxtdLYik
IsTgZ0tu1BzwX3wHEbeexrQJWBPt1fCAkRWvE3vrnNJw0gzZ4N064fcLkYPU4/ME
delYjj47KV5ABl7feC5jyKGLAxsgtuEqsx9kL/1+fxHDhHlceUT+/zLT4IgFkBh8
b0nC7RhCvWH1w7opOyv8CuBZdH+j9dsJIgDyHZkvaSGqbGm1+eTD1fEozb7Pvf6c
YUjA6WSvRfBPs2R26z3a4D8EMip+/A48vbZY1E08LIT+h6W/VoBV4KV+RnY5pRNC
uX2wyfhrktCbaczVhzRI
=BxA0
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
