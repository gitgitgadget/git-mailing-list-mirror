From: Martin Geisler <mg@lazybytes.net>
Subject: Re: potential improvement to 'git log' with a range
Date: Wed, 23 Jun 2010 21:19:17 +0200
Message-ID: <877hlpimkq.fsf@hbox.dyndns.org>
References: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com>
	<m3tyrhfzg8.fsf@localhost.localdomain>
	<87bpb1issa.fsf@hbox.dyndns.org> <201006232002.18921.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	mercurial list <mercurial-devel@selenic.com>,
	git list <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Aghiles <aghilesk@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 21:19:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORVTw-0003ZZ-AX
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 21:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866Ab0FWTT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 15:19:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:8441 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab0FWTT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 15:19:26 -0400
Received: by fg-out-1718.google.com with SMTP id l26so459788fgb.1
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 12:19:25 -0700 (PDT)
Received: by 10.86.124.35 with SMTP id w35mr9992063fgc.49.1277320764473;
        Wed, 23 Jun 2010 12:19:24 -0700 (PDT)
Received: from hbox.dyndns.org (77-58-145-114.dclient.hispeed.ch [77.58.145.114])
        by mx.google.com with ESMTPS id 12sm12179627fgg.19.2010.06.23.12.19.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 12:19:23 -0700 (PDT)
In-Reply-To: <201006232002.18921.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 23 Jun 2010 20:02:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149533>

--=-=-=
Content-Transfer-Encoding: quoted-printable

Jakub Narebski <jnareb@gmail.com> writes:

> On Wed, 23 Jun 2010, Martin Geisler wrote:
>
>> This is fixed with Mercurial 1.6: we now have a query language where
>> 'X..Y' (or 'X::Y') is understood as the set of changesets that are
>> both descendents of X and ancestors of Y.
>
> Thanks. It looks like Mercurial's 'X::Y' is equivalent to Git's
> '--ancestry-path X..Y' (the --ancestry-path option is a new feature).

Yeah, it is equivalent to --ancestry-path. I had no idea Git's range
operator worked the way it does :-)

For mercurial-devel: 'X..Y' is a shorthand for '^X Y', which in turn
means ancestors of Y, excluding ancestors of X (and excluding X).

>>> [1]
>>> http://stackoverflow.com/questions/1598759/git-and-mercurial-compare-an=
d-contrast/1599930#1599930
>
> Fixed. Could you please take a look if it is correct, and if there are
> errors, either correct it yourself, or ask me to do it (either via
> comments for this question, or via email)? Thanks in advance.

Yes, its correct now. But would you object if I or someone else took out
all those personal opinions and rewrote it from a neutral point of view?

> P.S. Isn't mercurial-devel subscribe only?

No, not really -- you will be whitelisted the first time you post.

=2D-=20
Martin Geisler

Mercurial links: http://mercurial.ch/

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwiXjUACgkQ/GWFsD4LxSOQigCZAbDpRcY/9xtXbkmVRqZFxsFu
fnUAnRFNYTYticHPWZSJiz3HON7O2Rfn
=Md3s
-----END PGP SIGNATURE-----
--=-=-=--
