From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] nice ftplugin for vim, that shows the commited diff in a split'ed buffer.
Date: Tue, 17 Oct 2006 13:04:38 +0200
Organization: Polytechnique.org
Message-ID: <200610171304.39131.madcoder@debian.org>
References: <11610450702261-git-send-email-madcoder@debian.org> <200610171238.04372.madcoder@debian.org> <802d21790610170359v3f17438dn8009ae9a55b2405c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3586685.MAJqzr5EZG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 17 13:04:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZmkX-0004nx-E9
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 13:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422852AbWJQLEm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 07:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423029AbWJQLEm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 07:04:42 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:30646 "EHLO
	mx1.polytechnique.org") by vger.kernel.org with ESMTP
	id S1422852AbWJQLEl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 07:04:41 -0400
Received: from mad.intersec.eu (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id 49D50332F4;
	Tue, 17 Oct 2006 13:04:40 +0200 (CEST)
To: "Peter Baumann" <peter.baumann@gmail.com>
User-Agent: KMail/1.9.5
In-Reply-To: <802d21790610170359v3f17438dn8009ae9a55b2405c@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Tue Oct 17 13:04:40 2006 +0200 (CEST))
X-DCC-xorg-Metrics: djali 32702; Body=3 Fuz1=3 Fuz2=3
X-Spam-Flag: No, tests=bogofilter, spamicity=0.000411, queueID=710F633301
X-Org-Mail: pierre.habouzit.2000@polytechnique.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29057>

--nextPart3586685.MAJqzr5EZG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le mar 17 octobre 2006 12:59, Peter Baumann a =C3=A9crit :
> 2006/10/17, Pierre Habouzit <madcoder@debian.org>:

> > because for me, wherever I'm from, the cwd is .git/ but it's maybe
> > due to the fact that I use autochdir, I don't know.
>
> Wouldn't it make sense to use something like 'git-rev-parse
> --git-dir' or 'git-rev-parse --show-cdup' to get to the root of the
> repository?

Yes it does, SungHyun Nam already sent a patch to me about that, that is=20
quite interesting. I've merged it partly, and will make that commit=20
plugin slightly better, so that people can:
 1/ trig it by hand
 2/ chose if the split is vertical or horizontal (I always have very big
    terms with a lot of vertical splits in vim, so I like the latter,
    other prefer the former)
 3/ chose via a let g:gitcommit_diff_mode or sth like that in the vimrc
    if that has to spawn automatically (0: none, 1: horiz split, 2: vert
    split)

and that time, I'll send that to the git contrib/vim maintainer so that=20
I won't bother the list too much :)

a corrected version of the commit file wrt the cwd is on my site=20
already, with a bit of SungHyun changes[1].


 [1] http://madism.org/~madcoder/dotfiles/vim/ftplugin/git.vim
=2D-=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--nextPart3586685.MAJqzr5EZG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFNLjHvGr7W6HudhwRAsQoAJ97Kh7sHlJVB9DTKTo0oDYTz5YD+QCffnlx
oV9SJwLMp+PTfxWGDvOGTrg=
=Uikh
-----END PGP SIGNATURE-----

--nextPart3586685.MAJqzr5EZG--
