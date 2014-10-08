From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [BUG?] `config branch.autosetuprebase true` breaks `rev-parse
 --is-inside-work-tree`
Date: Wed, 8 Oct 2014 20:09:36 +0000
Message-ID: <20141008200936.GA19492@vauxhall.crustytoothpaste.net>
References: <CAD77+gTuqbZimEK-=gXY8o4wFqOicFvnQ5MnV6Fq1npuckwYFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Cc: Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 22:09:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbxYT-000555-Jt
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 22:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956AbaJHUJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 16:09:45 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49139 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754774AbaJHUJn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Oct 2014 16:09:43 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B2D152808F;
	Wed,  8 Oct 2014 20:09:42 +0000 (UTC)
Mail-Followup-To: Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD77+gTuqbZimEK-=gXY8o4wFqOicFvnQ5MnV6Fq1npuckwYFQ@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2014 at 01:22:33PM +0200, Richard Hartmann wrote:
> Notwithstanding if the setting is correct, shouldn't rev-parse be
> resilient enough to at least be able to tell if we're in a work tree?
> I understand why `git status` and the like would need to parse the
> full config, but determining if you're in a work tree should be
> possible in most if not all cases.
> Unless detached work trees get you into a situation where you really
> need to parse the whole config...

I have seen similar problems where various git commands fail in the
middle if a config file is the subject of merge conflicts.  For example:

  vauxhall ok % git pull . master
  From .
   * branch            master     -> FETCH_HEAD
  Auto-merging .zshrc
  CONFLICT (content): Merge conflict in .zshrc
  Auto-merging .zshenv
  CONFLICT (content): Merge conflict in .zshenv
  Auto-merging .vimrc
  Auto-merging .gitconfig
  CONFLICT (content): Merge conflict in .gitconfig
  fatal: bad config file line 9 in .gitconfig

This tends to be one of the downsides of storing one's dotfiles in git.
I usually work around it by specifying HOME=3D/tmp before a command I
think might cause a conflict in .gitconfig.  I'm not sure there's any
good way around it, though.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUNZoAAAoJEL9TXYEfUvaLB08P/Aq8vygrZGP9L9Ohya7p6cJv
VPrkO56vXq1aVHekc1lIJZxunqCDvKveyMVeKsup9F0OidRjqepqcdY0h3H+ToTu
VFzU2BjnqghUw3RO3i9VrtLm0fH8+Q2SpkEUUA53swsf1hMvCaWTvZhOtanP6A5l
66AwvEr+512sVwc+JnH06eUkvOY6GXI3WLmyaWwLnYzW7wHGLBG2S/qFoJJ5vK9s
zm6acAabuHVUg3pw35hp1DgHpBRUMS62yhzwNPQxGz9PhsuussAZ+8yntMzvIUzW
9xCVs+SggC1kqHugBIuZi9lbVlmIxxeY0vPfS/RwNRuOh+iNqQdaeglbLyHLNSum
c+clMSHqfg314ZBkqAMMPU/DJwEB37geyM9KJeSouqQymSarRM4/Akf2HOHVzfLP
8OgDoA4KVM++j1VownlBILSevyiKPomSXtjtHe3aIVAfhmDhMttDeKViGq+eD5Ds
Nru3E9PDBvS0o0VH3RovCEOO2L1llMYAbkAyjhEaai6YyQadQNXvv/4OCZgYx7FD
u70O4fh/QE2hsCWmg76gSxbpKTViFZdkdpA+xTc3unProbMnS3PFR1+A+H28vkgm
FN/SJb1q9Kn3/fC2WYwlBdVowynt9kYnwGKqrgiN6Cyno22u5iL8/7z3x3O+JNEj
4UtOp6kDKufnS4J01h3h
=faDS
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
