From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 07/25] parse-options: make some arguments optional, add callbacks.
Date: Tue, 16 Oct 2007 10:45:10 +0200
Message-ID: <20071016084510.GI6919@artemis.corp>
References: <1192522616-16274-1-git-send-email-madcoder@debian.org> <1192523998-19474-1-git-send-email-madcoder@debian.org> <1192523998-19474-2-git-send-email-madcoder@debian.org> <1192523998-19474-3-git-send-email-madcoder@debian.org> <1192523998-19474-4-git-send-email-madcoder@debian.org> <1192523998-19474-5-git-send-email-madcoder@debian.org> <1192523998-19474-6-git-send-email-madcoder@debian.org> <1192523998-19474-7-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Rn7IEEq3VEzCw+ji";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 10:46:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihi3g-0007sH-OU
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 10:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759457AbXJPIpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 04:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759512AbXJPIpN
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 04:45:13 -0400
Received: from pan.madism.org ([88.191.52.104]:59845 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759375AbXJPIpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 04:45:11 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A0F902538C;
	Tue, 16 Oct 2007 10:45:10 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5A59132BAAF; Tue, 16 Oct 2007 10:45:10 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <1192523998-19474-7-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61120>


--Rn7IEEq3VEzCw+ji
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This bit is to allow to aggregate options with arguments together when
the argument is numeric.

    +#if 0
    +		/* can be used to understand -A1B1 like -A1 -B1 */
    +		if (flag & OPT_SHORT && opt->opt && isdigit(*opt->opt)) {
    +			*(int *)opt->value =3D strtol(opt->opt, (char **)&opt->opt, 10);
    +			return 0;
    +		}
    +#endif

I'm not a huge fan, but people may like it. Feel free to keep the
chunk, drop it, or enable it to your liking.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Rn7IEEq3VEzCw+ji
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHFHoWvGr7W6HudhwRAoIvAJ9jKgrw/XHIrJaMwboobtLfT8m+rQCfbPr/
fafxjumiLHqjVY0Pb0Af9Ik=
=076u
-----END PGP SIGNATURE-----

--Rn7IEEq3VEzCw+ji--
