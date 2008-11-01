From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git reset --hard w/o touching every file
Date: Sat, 01 Nov 2008 12:05:29 +0100
Message-ID: <20081101110529.GC3819@artemis.corp>
References: <gegn38$lku$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="1SQmhf2mF2YjsYvc";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 12:06:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwEJZ-0006c8-6W
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 12:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbYKALFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 07:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbYKALFc
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 07:05:32 -0400
Received: from pan.madism.org ([88.191.52.104]:37532 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbYKALFc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 07:05:32 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 078913B19B;
	Sat,  1 Nov 2008 12:05:30 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id B119C5EE243; Sat,  1 Nov 2008 12:05:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <gegn38$lku$1@ger.gmane.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99731>


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2008 at 04:48:38AM +0000, Edward Z. Yang wrote:
> I was wondering if there was any way to run `git reset --hard $revlike`,
> or a command with the same effect, without having Git touch every file?

git checkout HEAD -- <list of the files>

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkMN/kACgkQvGr7W6HudhxM1ACeIEuHzm1AcWwFXglRSXDrW9Oz
ex0An2bd6XxwdOP5diYEOiaTGj2pbCgn
=6GpB
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
