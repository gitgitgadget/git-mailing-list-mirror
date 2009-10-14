From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-commit feature request: pass editor command line options
Date: Wed, 14 Oct 2009 19:23:38 +0200
Message-ID: <20091014172337.GE6115@genesis.frugalware.org>
References: <25885354.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Cc: git@vger.kernel.org
To: Matthew Cline <matt@nightrealms.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 19:34:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My7kB-0004Dh-RQ
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 19:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975AbZJNRYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 13:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbZJNRYw
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 13:24:52 -0400
Received: from virgo.iok.hu ([212.40.97.103]:43600 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753580AbZJNRYw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 13:24:52 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id DF93558082;
	Wed, 14 Oct 2009 19:24:14 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CFBE244906;
	Wed, 14 Oct 2009 19:24:14 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 1B81811F002B; Wed, 14 Oct 2009 19:23:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <25885354.post@talk.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130308>


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2009 at 09:58:51PM -0700, Matthew Cline <matt@nightrealms.c=
om> wrote:
>=20
> I'd like to be able to have git-commit pass the commit-message editor com=
mand
> line options which aren't passed to the editor for other usages.  Right n=
ow
> I have "co" aliased to "!sh -c 'GIT_EDITOR=3Dgit-commit-editor git commit=
'",
> where git-commit-editor is a wrapper around my editor-of-choice which pas=
ses
> the editor the command line options I want, but it'd be simpler and clean=
er
> if I could just set "commit.editor_options=3D-BAR".  Or even let there be=
 a
> separate editor for commits, so I could do "core.editor=3Dfoo" and
> "commit.editor=3Dfoo -BAR".

Hmm, what is the use-case when using an option --foo is useful when
creating a commit, but not useful when crating a tag?

Apart from introducing inconsistency...

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrWCRkACgkQe81tAgORUJZIYgCggdmsMVcBiUpeLFNwpfpjmiHc
oHMAoJIH5qikSCil0xBYdJ6jrbE+Iwpl
=JjtX
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
