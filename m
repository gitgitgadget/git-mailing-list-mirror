From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-commit feature request: pass editor command line options
Date: Thu, 15 Oct 2009 00:12:16 +0200
Message-ID: <20091014221216.GI6115@genesis.frugalware.org>
References: <25885354.post@talk.nabble.com>
 <20091014172337.GE6115@genesis.frugalware.org>
 <200910141303.01485.matt@nightrealms.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Cc: git@vger.kernel.org
To: Matthew Cline <matt@nightrealms.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 00:25:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyCHU-0007yt-1t
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 00:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762068AbZJNWNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 18:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754986AbZJNWNX
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 18:13:23 -0400
Received: from virgo.iok.hu ([212.40.97.103]:39170 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753193AbZJNWNW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 18:13:22 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 03B4E58083;
	Thu, 15 Oct 2009 00:12:43 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id DA8EB44906;
	Thu, 15 Oct 2009 00:12:42 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0269211F002B; Thu, 15 Oct 2009 00:12:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200910141303.01485.matt@nightrealms.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130342>


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2009 at 01:03:01PM -0700, Matthew Cline <matt@nightrealms.c=
om> wrote:
> On Wednesday 14 October 2009 10:23:38 am Miklos Vajna wrote:
>=20
> > Hmm, what is the use-case when using an option --foo is useful when
> > creating a commit, but not useful when crating a tag?
>=20
> In my case, it's using a commit template which starts with a comment, so =
I=20
> want to move the cursor down to the line below the comment.

Then rebase, tag, add -e and even commit --amend would use core.editor,
while commit alone would use commit.editor, right?

A minor confusion would be that git commit --amend would not use
commit.editor. ;-)

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrWTMAACgkQe81tAgORUJa9kwCfTUkV4kqR2kOCc1tL4ACIwtZv
0JcAn2wzF0w1lubsPFzNfx88aTdukENf
=cF81
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
