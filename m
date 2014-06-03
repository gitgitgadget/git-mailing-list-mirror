From: NeilBrown <neilb@suse.de>
Subject: Re: [ANNOUNCE] Git v2.0.0
Date: Tue, 3 Jun 2014 12:08:32 +1000
Message-ID: <20140603120832.7235c706@notabene.brown>
References: <xmqqr43dbkni.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/vQA/ceXIEL_s5f5NbrsoJa5"; protocol="application/pgp-signature"
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 04:08:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wre9f-0000a2-7U
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 04:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbaFCCIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 22:08:43 -0400
Received: from cantor2.suse.de ([195.135.220.15]:58374 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441AbaFCCIm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 22:08:42 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 88DE3AD46;
	Tue,  3 Jun 2014 02:08:40 +0000 (UTC)
In-Reply-To: <xmqqr43dbkni.fsf@gitster.dls.corp.google.com>
X-Mailer: Claws Mail 3.9.2 (GTK+ 2.24.22; x86_64-suse-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250609>

--Sig_/vQA/ceXIEL_s5f5NbrsoJa5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 28 May 2014 15:31:13 -0700 Junio C Hamano <gitster@pobox.com> wrote:

> The latest feature release Git v2.0.0 is now available at the
> usual places.


>=20
> "git request-pull" lost a few "heuristics" that often led to mistakes.
>=20

I've installed git 2.0.0 and now when I

  git request-pull master git://neil.brown.name/md

after tagging the current commit as "md/3.15-fixes" and pushing out the tag,
I get

warn: No match for commit 2ac295a544dcae9299cba13ce250419117ae7fd1 found at=
 git://neil.brown.name/md
warn: Are you sure you pushed 'HEAD' there?

Yet=20
   git ls-remote git://neil.brown.name/md | grep 2ac29
shows

2ac295a544dcae9299cba13ce250419117ae7fd1	refs/tags/md/3.15-fixes^{}

Which seems clear and unambiguous.

Does this mean that the 'end' arg to 'git request-pull' is no longer option=
al
(i.e. the man page is wrong), or that too many heuristics were removed?

.... Looking through the change log a bit, it seems that if the 'end' arg is
omitted, then the current 'branch' name is used and must match the same name
at the git URL.  Could it also check the current 'tag' name?  As we are
encouraged to used signed tags, this seems sensible.
In fact, I would suggest checking for a tag first, and only considering the
branch name if there is no tag on the current commit.

Thanks,
NeilBrown


--Sig_/vQA/ceXIEL_s5f5NbrsoJa5
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIVAwUBU40uIDnsnt1WYoG5AQL8OQ//T26PpapgTfzKzvRICGEprZDgl73iq4XR
3gSWbZdQPWKVSn7aPu3iiOdWY/o1Dg9hY+vQrixWHiC+aIaiHmyBU1Emx977ByLx
a4PA43SNwAN0c2WbVld8eoMeHGOUs+pk5ijvvrtAV8i0Dp9lTXVlPtQQEB0KJH2e
YZ6JuPQuvTdasjce50uHjlX0AyoL83y0oRhALi6EE/NHxt2NDTVWz66aJHoRVAmL
EKthvj0tOuZmPQuPL1epkbxQnDT8V29lI9GLOlr/DKTomrs3UjfLCYGPiSeyYHz/
+XD6wYROTcn/F2asIUjvESaM92nwoodDUUwLBLTrqIlUDLX94ngvg4SFvsJkUD/B
bm6AV/Kznlhma+PBKrPFxS5qTWmtoXjBLx97Vd8i8bMgaxqeW1R3toVUvAx+ZegI
KmYJdnQg60c7khZZqDqarK43jdYB6lUZEyPLc+Iv+uKIfeE1SGYeRDSi+CSBhd8r
nTGlJLmcKfTIxe4kyw74DxYdjizlvmxPu1nV9r7+5FeqfgWz6tCOZAcmak9s6Pb3
jiIsaQH6WLtDjOyvmxDpropKbpGcomr6bzrilFlokndl06RvTxdxYilvp5AFBqyS
CzsDAyrJJIoSoK0uomO5k3Z9jTpMB7DqwONSnBZEt+0GjwYjh+xK4DO6ho6Qa9YI
A8LVfS7Hs1k=
=hA/J
-----END PGP SIGNATURE-----

--Sig_/vQA/ceXIEL_s5f5NbrsoJa5--
