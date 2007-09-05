From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Simplify strbuf uses in fast-import.c using the proper functions.
Date: Wed, 05 Sep 2007 21:21:05 +0200
Message-ID: <20070905192105.GA28129@artemis.corp>
References: <20070905085720.GD31750@artemis.corp> <11890199232110-git-send-email-madcoder@debian.org> <11890199232128-git-send-email-madcoder@debian.org> <11890199232646-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="zYM0uCDKw75PZbzx";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 21:21:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT0R9-0004iE-Lu
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 21:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981AbXIETVK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 15:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755868AbXIETVI
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 15:21:08 -0400
Received: from pan.madism.org ([88.191.52.104]:46586 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755010AbXIETVH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 15:21:07 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 5CBA31E1D9
	for <git@vger.kernel.org>; Wed,  5 Sep 2007 21:21:06 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CB681188B4; Wed,  5 Sep 2007 21:21:05 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11890199232646-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57751>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Sorry, this one is a false positive :|
  I should have been more careful.

On Wed, Sep 05, 2007 at 07:18:38PM +0000, Pierre Habouzit wrote:
>   This is just cleaner way to deal with strbufs, using its API rather than
> reinventing it in the module (e.g. strbuf_append_string is just the plain
> strbuf_addstr function, and it was used to perform what strbuf_addch does
> anyways).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG3wGhvGr7W6HudhwRAtIBAJ0Zl1sYnnE8pOfnzAfWW8le41Y9OQCffL4b
JiHiiFTkL7VY9IZN9VoUoDY=
=g8ea
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
