From: Joey Hess <joey@kitenet.net>
Subject: Re: out of memory error with git push and pull
Date: Thu, 2 Jun 2011 00:46:03 -0400
Message-ID: <20110602044603.GB5081@gnu.kitenet.net>
References: <BANLkTin3-XnVsVd1-CAiWDBzQG6m=a4Rvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Cc: git@vger.kernel.org
To: Qingning Huo <qingninghuo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 06:46:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRznU-0004hM-Kg
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 06:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab1FBEqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 00:46:11 -0400
Received: from wren.kitenet.net ([80.68.85.49]:38010 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542Ab1FBEqK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 00:46:10 -0400
Received: from gnu.kitenet.net (dialup-4.152.108.216.Dial1.Atlanta1.Level3.net [4.152.108.216])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 9FF1011914F;
	Thu,  2 Jun 2011 00:46:08 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id CD820401C9; Thu,  2 Jun 2011 00:46:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <BANLkTin3-XnVsVd1-CAiWDBzQG6m=a4Rvw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174926>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Qingning Huo wrote:
> I tried to use git to manage my digital photos but encountered some
> problems. The typical file sizes are hundreds of KB or a few MB. In
> total, about 15GB data in about 10,000 files. My intention is to get
> them into a git repository and cloned into a few computers. Probably I
> will make some occasionally changes like editing and deleting. But I
> think most of the files would stay at version one.

I try not to mention git-annex too much here, but this is a perfect
use-case for it. http://git-annex.branchable.com/=20

Well, it would be more perfect if you had enough data in your repo that
you didn't necessarily want to clone it all to every computer. Like so:

# git annex status
local annex size: 58 megabytes
total annex keys: 38158
total annex size: 6 terabytes

:)

> I wonder whether anyone has tried using git in a similar scenario. Is
> git capable of handling this kind of data? And, are there any settings
> and/or command line options that I should use? I had a quick look of
> git help push (and pull/fetch) but cannot see anything obvious.

There is a tunable you can use to improve things, see core.bigFileThreshold

That originally came from this project.
http://caca.zoy.org/wiki/git-bigfiles -- it may have some other
improvements that have not landed in git, I'm not sure.

--=20
see shy jo

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTecVi8kQ2SIlEuPHAQhD+w/8DLHYft2QjmQ65f1Y3F89v9isvFXc+W1T
iFnPxbPFvwgayxOyBkx65KVCUMoKGdZWj3g5OC4uU/4mfKnEHdF9x9X3EguI7NUp
h0DnJZo4VachfOTf5KIKXuvbA6bodIMY1w3wVStVhtetBfLDXs9BMAX7Ly7eyxkT
WjlVC1EHmLj5PcYKcv09oKfPN3Xh+NAzFJ33f7t4vGDugHbFhxvcKVsGLNwdrgIp
TKpohOoEgsFFnmGx9hbTb5Fe57W8k+4rItAKg7Uz9MWvwDha6j5SFhvd3EeJL7t4
MUnggBMHcEwx41QxigMCBVIryXlk+WwYdz+3j+9fecd8wvmI88cR4aERkGGzmMyh
jbZ1n/4FHIZ76/R6HdsZ5PHnpBqXf93nMV123LYGJIm2GbUZgA4JtycgXVia1Wif
iFsuQ1rNspT7B/ZJzysJPbu+8b9IxLvVY/A9ysjtAFS7QlDGTbcsHrohO7yCRgzJ
s69vBjRSZpdLX3qVnK5iC8zAhybNsnrtzQDuf2+8SVkbZYl71mTgbH0TIIO4GN3T
1jcHxXYz3+ihk2bziRqvvhDllSdAKnRlVp8OP5nqhr4KZguKzUrBvGM6oVL/fB5N
lg/BSnKlawxgIgDSDv4Yv2Fv+Fa9N9hAtJYRGNt57lqt7t2mUPL6gfHwNxQ8yE79
/E+Qin3USFY=
=EasA
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
