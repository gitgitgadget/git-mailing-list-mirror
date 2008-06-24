From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/2] Introduce leaky().
Date: Tue, 24 Jun 2008 22:16:49 +0200
Message-ID: <20080624201648.GE9189@artemis.madism.org>
References: <1214338474-16822-1-git-send-email-madcoder@debian.org> <1214338474-16822-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="HeFlAV5LIbMFYYuh";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 22:17:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBExY-0002Ib-AD
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 22:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbYFXUQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 16:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753205AbYFXUQw
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 16:16:52 -0400
Received: from pan.madism.org ([88.191.52.104]:52018 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858AbYFXUQw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 16:16:52 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id ACACA3830F;
	Tue, 24 Jun 2008 22:16:50 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 4E4F935560C; Tue, 24 Jun 2008 22:16:49 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <1214338474-16822-2-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86139>


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2008 at 08:14:33PM +0000, Pierre Habouzit wrote:
> +static void release_leaks(void)
> +{
> +	while (leaknb-- > 0)
> +		free(*leaks++);
crap I sent the wrong patch... this is supposed to be:
+		free(leaks[leaknb]);
> +	free(leaks);
> +}

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhhVjAACgkQvGr7W6Hudhwf5gCfe39H9dDsDMIzSoauNDJGwvrf
VjIAn1CSdMWtcNC/M5sRMWrAK2m7UaCu
=rTcR
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
