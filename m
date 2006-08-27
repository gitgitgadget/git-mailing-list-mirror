From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-daemon: more powerful base-path/user-path settings, using formats.
Date: Sun, 27 Aug 2006 12:28:09 +0200
Organization: Polytechnique.org
Message-ID: <200608271228.09718.madcoder@debian.org>
References: <7vmz9vgqlm.fsf@assigned-by-dhcp.cox.net> <115637597423-git-send-email-madcoder@debian.org> <7vfyfiyaex.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1628198.1UQ8gvmWH5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 12:28:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHHsI-0007nH-DI
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 12:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWH0K2P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 06:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWH0K2O
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 06:28:14 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:37818 "EHLO
	mx1.polytechnique.org") by vger.kernel.org with ESMTP
	id S1750722AbWH0K2O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 06:28:14 -0400
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id DE1F93327F;
	Sun, 27 Aug 2006 12:28:12 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vfyfiyaex.fsf@assigned-by-dhcp.cox.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Sun Aug 27 12:28:13 2006 +0200 (CEST))
X-Spam-Flag: No, tests=bogofilter, spamicity=0.000774, queueID=0E268332E8
X-Org-Mail: pierre.habouzit.2000@polytechnique.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26089>

--nextPart1628198.1UQ8gvmWH5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le dim 27 ao=FBt 2006 08:12, Junio C Hamano a =E9crit :
> Pierre Habouzit <madcoder@debian.org> writes:
> > Allow a form of virtualhosting, when %h format is used.
> >
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >
> >     This is intended to be a more flexible solution, that also
> > gives virtual hosting as a bonus.
>
> Nicely done, almost.
>
> Having to have the distinction between %p and %P formats feels
> somewhat unwieldy, though.  Not that I have a better suggestion.
>
> > +int is_base_path_fmt;
> > +int is_user_path_fmt;
>
> I prefer these to be of type "static int".

omg, how did I missed that.

> Although I am not an authority of variable naming, these sound
> funny to me.  "is_XXX()" as a function name feels natural,
> "is_XXX" as a variable name does not --- it is not clear what
> the predicate is talking about.
>
> Maybe "use_fmt_for_base_path" is easier to understand?  I dunno.
> Or "user_path_is_fmt"?  That's more logical but still somewhat
> feels funny.

agreed.

There is also a second patch that never made it to the list that fixes:
 * some indentation problems due to a bad vimrc
 * --default-hostname switch (to handle virtual hosts even with older
   clients)
 * possible overflow in the formatting method.

I'll recompute a new patch that superseeds that one, and merge your=20
comments and my never sent patch too.

=2D-=20
=B7O=B7  Pierre Habouzit
=B7=B7O                                                madcoder@debian.org
OOO                                                http://www.madism.org

--nextPart1628198.1UQ8gvmWH5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE8XO5vGr7W6HudhwRAuLiAJwKeEi+8hlBCZHkbWELMkkG7RmsjQCgieP0
DKXwpCyrQqCKowVlBGJ9EL0=
=shMo
-----END PGP SIGNATURE-----

--nextPart1628198.1UQ8gvmWH5--
