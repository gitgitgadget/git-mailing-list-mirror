From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Fix segfault in diff-delta.c when FLEX_ARRAY is 1
Date: Tue, 18 Dec 2007 02:44:55 +0100
Message-ID: <20071218014455.GB14981@artemis.madism.org>
References: <1197941997-11421-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="JP+T4n/bALQSJXh8";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: gitster@pobox.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Dec 18 02:45:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4RWg-00028J-Ts
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 02:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937494AbXLRBo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 20:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937216AbXLRBo6
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 20:44:58 -0500
Received: from pan.madism.org ([88.191.52.104]:43918 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937078AbXLRBo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 20:44:57 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id B16513092B;
	Tue, 18 Dec 2007 02:44:56 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 895CB2A2253; Tue, 18 Dec 2007 02:44:55 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com,
	spearce@spearce.org, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1197941997-11421-1-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68686>


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 18, 2007 at 01:39:57AM +0000, Pierre Habouzit wrote:
> aka don't do pointer arithmetics on structs that have a FLEX_ARRAY member,
> or you'll end up believing your array is 1 cell off its real address.

  I wonder if we could teach sparse to prevent us from using pointer
arithmetics on some types=E2=80=A6 because I obviously didn't read all the =
git
code, and I wouldn't be surprised an instance of this still remains
somehwere.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZyYXvGr7W6HudhwRAqXWAKCVzWREMIKSt941xrqyxLBnIM9jiQCdHzP3
lClZn5k1LCNKhb5Mgvnezeg=
=zGam
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
