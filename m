From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: fixing workdirs
Date: Fri, 9 Jul 2010 09:49:58 +0200
Message-ID: <20100709074958.GC2304@madism.org>
References: <20100708110842.GC12789@madism.org>
 <20100708183714.GR2480@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Tait <git.git@t41t.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 09:50:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX8Lq-00036c-N8
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 09:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907Ab0GIHuE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jul 2010 03:50:04 -0400
Received: from pan.madism.org ([88.191.52.104]:38879 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544Ab0GIHuB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 03:50:01 -0400
Received: from madism.org (unknown [94.228.180.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id A0F5F4F056;
	Fri,  9 Jul 2010 09:49:59 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 70A728C9BF; Fri,  9 Jul 2010 09:49:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100708183714.GR2480@ece.pdx.edu>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150645>

On Thu, Jul 08, 2010 at 11:37:14AM -0700, Tait wrote:
>=20
> Pierre Habouzit <madcoder_madism.org> said (on 2010/07/08):
> > ...                                    The workdir HEAD reflog is t=
hen a
> > symlink to the masters.
>=20
> #include <std-symlink-rant>
>=20
> On programs (like git) pretending to be cross-platform, symlinks shou=
ld
> be avoided. They are to varying degrees, painful on non-*nix operatin=
g
> systems.
>=20
> Windows is an especially compatibility-breaking example, not only on =
the
> programming side, but also in relation to user interface, and compati=
bility
> with other programs. Programming-wise, documentation is sparse and
> would require lots of platform-specific work-arounds. The user-interf=
ace
> support is worse than terrible. And even if git does everything right=
,
> there's no guarantee a copy, backup/restore, antivirus program, etc. =
won't
> come along and corrupt the environment git so carefully created. Many=
 of
> those other programs don't properly handle Windows reparse points. Fo=
r
> those interested, http://shell-shocked.org/article.php?id=3D284 gives=
 a
> reasonable-looking overview of the details on Windows.

Well that's how git-new-workdir works, and you don't /need/ git
new-workdir to do actual git work. Note that git is cross compatible to
all POSIX conformant filesystems, it's just windows that I can think of
that won't work with it... They don't provide any sane replacement for
the feature, so I don't see what we can do about it anyways.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
