From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Mark 'git stash [message...]' as deprecated
Date: Wed, 07 Nov 2007 09:23:45 +0100
Message-ID: <20071107082345.GA18057@artemis.corp>
References: <20071106085134.GD4435@artemis.corp> <1194395205-27905-1-git-send-email-bdowning@lavos.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="k+w/mQv8wyuph6w0";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, tsuna@lrde.epita.fr,
	aghilesk@gmail.com, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Wed Nov 07 09:24:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpgCi-00024w-6d
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 09:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862AbXKGIXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 03:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756778AbXKGIXs
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 03:23:48 -0500
Received: from pan.madism.org ([88.191.52.104]:36714 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756797AbXKGIXr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 03:23:47 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 33B32147;
	Wed,  7 Nov 2007 09:23:46 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 75382F9CD; Wed,  7 Nov 2007 09:23:45 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Brian Downing <bdowning@lavos.net>,
	Junio C Hamano <gitster@pobox.com>, tsuna@lrde.epita.fr,
	aghilesk@gmail.com, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1194395205-27905-1-git-send-email-bdowning@lavos.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63787>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2007 at 12:26:44AM +0000, Brian Downing wrote:
> Complain to STDERR unless 'git stash save' is explicitly used.
> This is in preparation for completely disabling the "default save"
> behavior of the command in the future.

  No arguments at all should not IMHO be deprecated, it's very useful,
and is not ambiguous. The issue with git stash <random> is that if you
thought you typed a command that doesn't in fact exists, you stash which
is not what you meant _at all_.

  When you type `git stash` you certainly want to stash, and it's what
it does.

Here is how it should work:

git-stash (list | show [<stash>] | apply [<stash>] | clear)
git-stash [save <message>]


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMXYRvGr7W6HudhwRAjGHAJ4s+7WWFyLBvO7pHXrjhGCH9NoS5wCfd6XM
U5LTDKCMv1nzPGeIIkoCvr4=
=9e4A
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
