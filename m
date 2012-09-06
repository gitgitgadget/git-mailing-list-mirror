From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH 1/2] notes get-ref: --expand expands the output notes ref.
Date: Thu, 06 Sep 2012 02:11:48 -0400
Message-ID: <20120906061147.GA11770@odin.tremily.us>
References: <cover.1346848834.git.wking@tremily.us>
 <4eea4f3eab8ee827a40802a50aa2cda9e4b43943.1346849556.git.wking@tremily.us>
 <CALKQrgem2KM07vA0LeVgD6HkM1yMDBSfThKUZ7aBaxpbcC49hA@mail.gmail.com>
 <7v4nnb67x1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=oyUTqETQ0mS9luUI
Cc: Johan Herland <johan@herland.net>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 09:12:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9WGM-000709-V4
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 09:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727Ab2IFHMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 03:12:21 -0400
Received: from vms173003pub.verizon.net ([206.46.173.3]:43088 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab2IFHMF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 03:12:05 -0400
X-Greylist: delayed 3603 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Sep 2012 03:12:05 EDT
Received: from odin.tremily.us ([unknown] [72.68.85.126])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M9W00KT7ZVPSQ40@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 06 Sep 2012 01:11:50 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id BA3075C38C2; Thu,
 06 Sep 2012 02:11:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1346911908; bh=ABFHuLBW3fJBpcgr/+in7JfPozuqSlcM2pOX2SlH9Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nxNE450yC70QZsGr+lKfjRuf68MhXt6xRj7l2ceMzVFZSXMWgkjLWlOeCINMcwzxY
 obelv5Ou5+QjAatmmPetoxfdyRiuJz2lL2/8s9Ivw/4ZtpYPaGLysWehhzIRzKvToz
 f3fvSwA/6BHDYQT8zfBioJwSdSQmTbN2nJ1SHNFI=
Content-disposition: inline
In-reply-to: <7v4nnb67x1.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204868>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2012 at 10:23:54PM -0700, Junio C Hamano wrote:
> Really?  Would "git log --expand master" be useful?

I'm clearly not an expert on this, but isn't that what

  git show-ref master

is for?  Or is the fact that show-ref returns hashes the more
important feature?

There was a lot of "ambiguous refs" discussion in the follow-up for

  http://thread.gmane.org/gmane.comp.version-control.git/165885
  Subject: [1.8.0] Provide proper remote ref namespaces

For example:

On Mon, Feb 07, 2011 at 03:25:51PM -0500, Jeff King wrote:
> Will the same apply to refs/heads/foo versus refs/remotes/*/foo? Will it
> also apply to refs/heads/foo versus refs/remotes/*/tags/foo? In the
> final case, that does matter to "git push" (should the destination be in
> the head or tag namespace?). So the actual names of the ref can matter,
> and should probably be taken into account when deciding what is
> ambiguous.

So it seems like having a way to figure out how Git is interpreting a
shorthand ref would be useful, especially while those of us with less
experience are learning to think like Git.

The expansion command doesn't have to be notes-specific, but since the
current ref expansion is role specific (e.g. branch/tag/note/=E2=80=A6), it
seemed like the best place to put it.  With more consistent ref
interpretation, I'd be less interested in this expansion command ;).

Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQSD6iAAoJEEUbTsx0l5OMvLUQAKNq9AXwxjsn9BeM2di4cAA6
NNq4YQXzzrmW+8UIZYAoT77rU0+qbnJ7pX7dsqwlqhY3Imj2wIg8drTdnyirB4xV
OybNA80yFTvSmza/2KGH+Qz8tbZsXCfWdJohlsanTRlgxB8igf7oYGE8VzPH/of2
94g+ew2xBzLn3qVVp2DEA7UHWhoSiW4x53zg1maSV8iJmf7AOFp3mZN4XyWe5hxp
qj46jjC4NbQ7x2hdOKxpvifFC5qZ98k5RjfZ9iEdI5LKEAAEpB8b7i5TVw7EtdQ8
J+WC9C4p2IEsXQh7qqmyf5/bjorzH3u88OThsqbpNYAaNWbifXg17no7CEDgyrOD
xBSMwWPEL+N6idFLJcHPM51DS2MNSuAJWw3ML7QRcxz9bHPNQKAsKmu2RVBC3x2E
EciHaDTBQt9FRe7IUNADh3VrKpsKefrGEppMcqtK4mRMPu0VxZ188D5bKvsEdOXU
SVSCAk8eqUXyhRAAiPNU1+L1BsHJz/2XGpZgpFKsUXzXhEMe8wZWaOWjwxiGMnmt
uBAItrivdM6iP98r70rnXXOi1PYgBe2dA5i4YutAtNJEEE2fjs/B/WD1j5ZyNToZ
tBCbmFtrjjS2mO5qLsAtbeTiKF7f4aycITTNLYCq6pubGU3fzIsXJ+uk7eSzMcN+
ZhqrTVkU1kHZ7FrRS2ot
=DDbR
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
