From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Fwd: problem with a fork on repo.or.cz
Date: Fri, 16 Nov 2007 19:07:12 +0100
Message-ID: <9545AC22-487C-452E-AC1D-58EC66497E73@lrde.epita.fr>
References: <97E2BA6B-E66F-45BB-BA74-C73E7E2918FC@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-44-33383745"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 19:07:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It5bT-0005RA-Ta
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 19:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331AbXKPSH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 13:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755183AbXKPSH1
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 13:07:27 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:36127 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155AbXKPSH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 13:07:26 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1It5bB-0006iJ-3M
	for git@vger.kernel.org; Fri, 16 Nov 2007 19:07:25 +0100
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65237>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-44-33383745
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Hi list,
Petr did not reply to my email, so even though this is off-topic WRT  
Git (forgive me please :D), I guess someone on this ML may be able to  
have a clue.

Begin forwarded message:

> From: Benoit Sigoure <tsuna@lrde.epita.fr>
> Date: November 12, 2007 10:06:02 AM CEST
> To: Petr Baudis <pasky@suse.cz>
> Subject: problem with a fork on repo.or.cz
>
> Hi Petr,
>
> I'd like to use repo.or.cz to publish my patches for Autoconf.  I  
> created a new
> `autoconf' project that mirrors the GNU Autoconf Git repository.   
> Then I forked it as
> autoconf/tsuna (http://repo.or.cz/w/autoconf/tsuna.git).  Now I'm  
> trying to push my
> changes to that repo but, for some reason, it fails:
>
> $ git remote show repo
> * remote repo
>   URL: git+ssh://repo.or.cz/srv/git/autoconf/tsuna.git
> $ git push -v --all repo
> Pushing to git+ssh://repo.or.cz/srv/git/autoconf/tsuna.git
> updating 'refs/heads/bootclean'
>   from 0000000000000000000000000000000000000000
>   to   793c1b38a094f57e6218653719bca30881cca5d0
> updating 'refs/heads/docfix'
>   from 0000000000000000000000000000000000000000
>   to   e61c348bcd8036ab76deedf0952215d64a6cbfcb
> updating 'refs/heads/master'
>   from 0000000000000000000000000000000000000000
>   to   00865ec8426eed430d9a36c906d6ce7d307f8cf1
> updating 'refs/heads/mybootclean'
>   from 0000000000000000000000000000000000000000
>   to   8475204ea4094c864a40216a93f176a817906744
> Counting objects: 63, done.
> Compressing objects: 100% (45/45), done.
> Writing objects: 100% (45/45), done.
> Total 45 (delta 40), reused 0 (delta 0)
> error: unable to create temporary sha1 filename ./objects/ 
> tmp_obj_XTRbjJ: Permission denied
> fatal: failed to write object
> unpack unpacker exited with error code
> ng refs/heads/bootclean n/a (unpacker error)
> ng refs/heads/docfix n/a (unpacker error)
> ng refs/heads/master n/a (unpacker error)
> ng refs/heads/mybootclean n/a (unpacker error)
> error: failed to push to 'git+ssh://repo.or.cz/srv/git/autoconf/ 
> tsuna.git'
> $ git version
> git version 1.5.3.5.654.gdd5ec
>
>
> any idea?
>
> Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-44-33383745
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHPdxQwwE67wC8PUkRAkI0AJ4vzRluhyxSNJh4pNQfaNgRoczXGQCeMF0T
WMYQ6o0lWQk0Rrxgcb9MDYs=
=8VxT
-----END PGP SIGNATURE-----

--Apple-Mail-44-33383745--
