From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 01 Nov 2007 22:46:23 +0100
Message-ID: <20071101214623.GD7161@artemis.corp>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <20071101214131.GF4099@lavos.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="/unnNtmY43mpUSKx";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:46:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inhs7-0005qq-5q
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbXKAVqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbXKAVqZ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:46:25 -0400
Received: from pan.madism.org ([88.191.52.104]:47032 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753160AbXKAVqY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:46:24 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D2E5C27F93;
	Thu,  1 Nov 2007 22:46:23 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 5CC3332BD8E; Thu,  1 Nov 2007 22:46:23 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Brian Downing <bdowning@lavos.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071101214131.GF4099@lavos.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63017>


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2007 at 09:41:31PM +0000, Brian Downing wrote:
> On Wed, Oct 31, 2007 at 10:41:06PM -0700, Junio C Hamano wrote:
> > * jc/spht (Tue Oct 2 18:00:27 2007 -0700) 1 commit
> >  - git-diff: complain about >=3D8 consecutive spaces in initial indent
> >=20
> > This is a counterpart of an earlier patch from J. Bruce Fields
> > to change "git-apply --whitespace" to make SP{8,} at the
> > beginning of line a whitespace error.
> >=20
> > Personally, I am in favor of the stricter check, but I had to
> > reject the "git-apply" patch because there was no way to disable
> > the additional check without disabling the existing check for
> > trailing whitespaces.  We probably would want to revisit that
> > one (perhaps with a new option and/or config to selectively
> > enable different kinds of whitespace check).

> I don't want to get into another stupid holy war about the superiority
> of indent styles (the last one was quite enough, thank you), but there
> are real projects out there that have a spaces-only-indent policy and
> use Git, and this change as is isn't good for them.

  Seconded.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHKkkvvGr7W6HudhwRAgamAJ42JEhIqWlNYmb4SgHnbSNlt/ZVVQCdFhJs
9ZvUSOcHyk0Fqn2FRyIKN4s=
=WNJl
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
