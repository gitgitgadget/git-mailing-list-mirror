From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/3] git send-email: do not ask questions when  --compose is used.
Date: Sat, 01 Nov 2008 12:04:39 +0100
Message-ID: <20081101110439.GB3819@artemis.corp>
References: <20081031213338.GB21345@maintenance05.msc.mcgregor-surmount.com> <20081031213803.GB21799@artemis.corp> <20081031220149.GD21345@maintenance05.msc.mcgregor-surmount.com> <1225450632-7230-1-git-send-email-madcoder@debian.org> <1225456609-694-1-git-send-email-madcoder@debian.org> <1225456609-694-2-git-send-email-madcoder@debian.org> <1225456609-694-3-git-send-email-madcoder@debian.org> <20081031213338.GB21345@maintenance05.msc.mcgregor-surmount.com> <20081031213803.GB21799@artemis.corp> <20081101022649.GB17961@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="9zSXsLTf0vkW971A";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Ian Hilt <ian.hilt@gmx.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 12:05:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwEIk-0006Eg-Mj
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 12:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbYKALEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 07:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbYKALEm
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 07:04:42 -0400
Received: from pan.madism.org ([88.191.52.104]:37524 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbYKALEl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 07:04:41 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 645DF3B19B;
	Sat,  1 Nov 2008 12:04:40 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 292CE5EE243; Sat,  1 Nov 2008 12:04:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081101022649.GB17961@sys-0.hiltweb.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99730>


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2008 at 02:26:49AM +0000, Ian Hilt wrote:
> On Fri, Oct 31, 2008 at 06:01:49PM -0400, Ian Hilt wrote:
> > I've thought something like this would be a good thing.  An editor makes
> > things easier to fix than the command-line.
>=20
> Speaking of which, maybe let's add the To field to the list.

I didn't do it for a very good reason: the To field is tricker to parse
because very fast it's multiline, and must be split along the ',' when
parsed back and so on.

And even moreuseful than the To is the Cc list that git-send-email
bloats to death and that I would like to reduce very often.

But sadly that needs an expertise of perl I absolutely don't have. We
probably even want to depend on some MIME perl library that knows about
those kind of issues and do it for us well.

But yeah, I knew I left out those, and this was the reason.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkMN8cACgkQvGr7W6HudhxlQgCfbc2hDnHRHPeKLGflnAVlvxV3
QvYAn26An6q0qv/mrT+hwIro7d1Mlqxr
=mWSJ
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
