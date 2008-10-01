From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git grep: Add "-Z/--null" option as in GNU's grep.
Date: Wed, 01 Oct 2008 08:12:49 +0200
Message-ID: <20081001061249.GC22363@artemis.corp>
References: <1222816390-9141-1-git-send-email-killekulla@rdrz.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="iFRdW5/EC4oqxDHL";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: spearce@spearce.org, git@vger.kernel.org
To: Raphael Zimmerer <killekulla@rdrz.de>
X-From: git-owner@vger.kernel.org Wed Oct 01 08:14:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkuyK-0002yX-GL
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 08:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbYJAGMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 02:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbYJAGMy
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 02:12:54 -0400
Received: from pan.madism.org ([88.191.52.104]:47416 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603AbYJAGMx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 02:12:53 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id A48063BAE5;
	Wed,  1 Oct 2008 08:12:52 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D64DA94A270; Wed,  1 Oct 2008 08:12:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1222816390-9141-1-git-send-email-killekulla@rdrz.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97206>


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2008 at 11:13:10PM +0000, Raphael Zimmerer wrote:
> +	printf("%s%c", name, opt->null_following_name ? 0 : '\n');

I know I'm nitpicking and I don't know what the git custom on this
really is, but I tend to prefer '\0' when in the context of a char.
There is no confusion here of course, but I believe it to be a sane
habit. (In the same vein that it's ugly to use 0 for NULL ;p).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjjFOEACgkQvGr7W6HudhzS6wCeMj4c1xAvxr5X7AQF/BO1NZlB
TnoAn3F8ZF/CB0KAAw9sAGlJ9+75y5v5
=7Mzo
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
