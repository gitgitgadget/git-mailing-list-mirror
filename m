From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] git commit --branch
Date: Mon, 29 May 2006 23:22:50 +0200
Message-ID: <20060529212249.GF14325@admingilde.org>
References: <20060529202851.GE14325@admingilde.org> <20060529204158.GC28538@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 23:23:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkpCX-00050s-TU
	for gcvg-git@gmane.org; Mon, 29 May 2006 23:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWE2VWw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 17:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWE2VWw
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 17:22:52 -0400
Received: from admingilde.org ([213.95.32.146]:28878 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751313AbWE2VWv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 17:22:51 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FkpCM-0000Bc-38; Mon, 29 May 2006 23:22:50 +0200
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20060529204158.GC28538@spearce.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20974>


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 29, 2006 at 04:41:58PM -0400, Shawn Pearce wrote:
> Interesting.  I have been kicking around doing the very same
> thing myself but just have not gotten around to it.  Its complex,
> especially if the current HEAD isn't strictly the merge commit
> between the topic branch and the previous value of HEAD; in that
> case you may want to replay the commits which are on HEAD but are
> post the merge commit using a form of git-rebase.  Except you would
> want to preserve any merges which happened by remerging them rather
> than simply exporting a massive patch and reapplying it.

Perhaps something like merge-recursive makes sense, except that
I have no clue how it works ;-)

But then an operation as important as commit has to be bullet-proof
and I don't like to do anything complex in there.

In any case, this functionality needs a lot of testing.
Any contributions to the test case are welcome :)

> > +		git update-ref "$onto_branch" $commit2 &&
>=20
> If this is going into next perhaps you would like to considering adding
> the -m flag to your git-update-ref calls and include a log message
> in the reflog (if the user has it enabled for the current branch and
> the topic branch)?

Makes sense.

> Also shouldn't this be 'git-update-ref'?

Yes, all the rest uses git-*, too.
If the move to buildin commands continues at the same speed we
may soon be able to remove some "-"s, but it's not time for that yet.

--=20
Martin Waitz

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQFEe2Ypj/Eaxd/oD7IRAhF8AJ9VIDnJ6mIqJalqaqRRenfpSM+D4gCYgreU
BjuGNJtY/suamRCYfZCY0A==
=2AGz
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
