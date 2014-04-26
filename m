From: luc.linux@mailoo.org
Subject: Re: gitignore vs. exclude vs assume-unchanged?
Date: Sat, 26 Apr 2014 09:52:45 +0200
Message-ID: <20140426075245.GA4123@luc-arch>
References: <b3f480af1c362c615ad9ce85296e2be2@bellandwhistle.net>
 <xmqqy4z5go1y.fsf@gitster.dls.corp.google.com>
 <dee7ee673c8c4d81fb5aaecea25e9709@bellandwhistle.net>
 <20140416234555.GA4309@google.com>
 <4dd8389939fbf3dc77b58adcca7b17c1@bellandwhistle.net>
 <CAH5451k+GGGdHXkwne2O-h2m2AyWg7K+5reNRG64+eF891pVUA@mail.gmail.com>
 <xmqqtx9l5jxn.fsf@gitster.dls.corp.google.com>
 <35592507346991e5c286144fcbd04097@bellandwhistle.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
To: alex@bellandwhistle.net, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 10:08:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdxeU-00050r-5R
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 10:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbaDZIGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 04:06:51 -0400
Received: from arnold.mailoo.org ([212.83.147.198]:54806 "EHLO mailoo.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750756AbaDZIGr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 04:06:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by arnold.mailoo.org (Postfix) with ESMTP id 0CE8A159;
	Sat, 26 Apr 2014 10:06:45 +0200 (CEST)
Received: from localhost (174.158.92.79.rev.sfr.net [79.92.158.174])
	by arnold.mailoo.org (Postfix) with ESMTPSA id 6C108158;
	Sat, 26 Apr 2014 10:06:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <35592507346991e5c286144fcbd04097@bellandwhistle.net>
X-Info: Keep It Simple, Stupid.
User-Agent: Mutt/1.5.22.1-rc1 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247150>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2014 at 04:09:47PM -0700, alex@bellandwhistle.net wrote:
> >Andrew Ardill <andrew.ardill@gmail.com> writes:
> >
> >As a data point, I have seen people add ".gitignore" to their
> >.gitignore file, as they don't want to share the file.
>=20
> Right, I've seen that too.
That something I am actually doing in my projects, because I didn't
know they were other way to exclude files like .gitignore.

> It confused the heck out of me. It only lends
> credence to my point about the docs. Those users want the functionality o=
f a
> pattern in '$GIT_DIR/info/exclude', but haven't been able to figure it out
> easily enough. They've just heard about .gitignore, so they're using that.
> Yes, it's all there in the docs if you read it several times, and you
> already know what you're looking at, but not in a terribly accessible, be=
st
> practices, "advice from a smart friend who's been through it all already"
> kind of way.
 Well documentation can be useful when you know what you're looking for,
 but I won't go read it just for discovering new features I didn't know.

> Well, yes: semantics. Since they do slightly different things, they should
> have different names. It makes reference and teaching much easier. In fac=
t,
> if a renaming were to occur, I would actually prefer even better semantic=
s:
>=20
>     .gitignore -> .shared-ignore
>=20
>     $GIT_DIR/info/exclude -> $GIT_DIR/info/local-ignore
>=20
> These suggested names could perhaps be improved on. But if anything, the
> names need to be more different, not less. Users should be able to instan=
tly
> know what a speaker is talking about without having to doublecheck and ask
> if by "git-ignore", the speaker really meant "git ignore" or
> "dot-gitignore".
I agree with a new name for .gitignore. A name like shared-ignore would
make explicite the fact it is shared, and then the user would look for
another way to locally exclude files. This would be a good approach, but
changing it won't be easy as most people already use .gitignore.

Would it be acceptable to have git display a warning when it detects
that .gitignore is excluding itself, with eventually a link to the
documentation or the path to $GIT_DIR/info/exclude ?


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEbBAEBAgAGBQJTW2XNAAoJEIcYFL//CHl9GJMH9iiaEuq14U7m2zotOzzvaPKi
jd9EmnuUvZm/5OUV57XfbG2YNq2xuDs4Gxp+geiLMrlHJNVdeH7q1J4lPxYrGiLH
HDQU21khF/1zwCI8yPXFxymCKeV+aL84t1Gc3PTsRoU79VBem2qI25TPzRItEDa8
pzIRcbxxXCuw3TxVLU/CbUGlDqs+IgTUAv3IvQSnchS56Ruy+e1ML6q3YBhs1P8c
QfEoSn3p6e0ZPnKzV4t7NNnLFVsdFfIYM53bgMa6/TDdpyIaSHc9yROnH431/MD9
SO36k1TMS5FJEray/B1YXkoVdvrtZz7xVP4nRydlQpOAqkM5RIsYs8BAMX23ww==
=QZfy
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
