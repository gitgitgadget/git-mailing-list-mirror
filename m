From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 09/25] Port builtin-add.c to use the new option parser.
Date: Tue, 16 Oct 2007 18:55:58 +0200
Message-ID: <20071016165558.GD13946@artemis.corp>
References: <1192523998-19474-1-git-send-email-madcoder@debian.org> <1192523998-19474-2-git-send-email-madcoder@debian.org> <1192523998-19474-3-git-send-email-madcoder@debian.org> <1192523998-19474-4-git-send-email-madcoder@debian.org> <1192523998-19474-5-git-send-email-madcoder@debian.org> <1192523998-19474-6-git-send-email-madcoder@debian.org> <1192523998-19474-7-git-send-email-madcoder@debian.org> <1192523998-19474-8-git-send-email-madcoder@debian.org> <1192523998-19474-9-git-send-email-madcoder@debian.org> <2209D123-A245-43C4-8DD9-A83386852556@mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="fXStkuK2IQBfcDe+";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:56:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhpiJ-0006co-6u
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 18:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbXJPQ4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 12:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760389AbXJPQ4D
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 12:56:03 -0400
Received: from pan.madism.org ([88.191.52.104]:43350 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760258AbXJPQ4A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 12:56:00 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2D8BC25542;
	Tue, 16 Oct 2007 18:55:59 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 9E68532BACD; Tue, 16 Oct 2007 18:55:58 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Michael Witten <mfwitten@MIT.EDU>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <2209D123-A245-43C4-8DD9-A83386852556@mit.edu>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61212>


--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On mar, oct 16, 2007 at 08:55:41 +0000, Michael Witten wrote:
>=20
> On 16 Oct 2007, at 4:39:42 AM, Pierre Habouzit wrote:
>=20
> >+	OPT_BOOLEAN('u', NULL, &take_worktree_changes, "update only files that=
=20
> >git already knows about"),
>=20
> "update only files in the current directory that git already knows about"

  As a general rule, as I'm not a native speaker, I'd be glad if someone
went through the diffs and made it better english. I'm not sure what the
more efficient way to merge those corrections is, as I'm not able to see
if it's any better or not. So the someone mergint it (Shawn ?) may have
to go through every OPTION_* and check the helps strings, and --amend
fixes on top of the patches if needed. It looks like the best way to me.

  Alternatively, a native speaker could propose a 26th patch that fixes
all of the bad strings on top of this series. But again, I won't do
that, not because of lazyness, just because I can't decide :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHFO0evGr7W6HudhwRAhdyAJ4orO/mUTo7o28INlfz743lry8I9gCdFcCG
6xQ32xTJKbe3RVXHdgODk6w=
=WaFI
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--
