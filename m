X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 18:14:20 +0100
Message-ID: <20061201171420.GF18810@admingilde.org>
References: <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org> <45703174.8000609@op5.se> <20061201134610.GW18810@admingilde.org> <457041AD.4010601@op5.se> <20061201150045.GZ18810@admingilde.org> <45705A94.2070509@op5.se> <Pine.LNX.4.64.0612010844380.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7phR3qVEw/4Cnor3"
NNTP-Posting-Date: Fri, 1 Dec 2006 17:14:59 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>, sf <sf@b-i-t.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612010844380.3695@woody.osdl.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32948>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqBxz-00019m-3K for gcvg-git@gmane.org; Fri, 01 Dec
 2006 18:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031650AbWLAROX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 12:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031654AbWLAROX
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 12:14:23 -0500
Received: from agent.admingilde.org ([213.95.21.5]:9149 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1031650AbWLAROW
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 12:14:22 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqBxt-0007zS-0B; Fri, 01 Dec 2006 18:14:21 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org


--7phR3qVEw/4Cnor3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 08:49:20AM -0800, Linus Torvalds wrote:
> Think of it this way: one common use for submodules is really to just=20
> (occasionally) track somebody elses code. The submodule should be a=20
> totally pristine copy from somebody else (ie it might be the "intel drive=
r=20
> for X.org" submodule, maintained within intel), and the supermodule just=
=20
> refers to it indirectly (ie the supermodule might be the "Fedora Core X=
=20
> group" which contains all the different drivers from different people).

Yes, but it is not only about tracking, also about distributing
submodules.

One Fedora X developer fixes a bug in the intel driver, commits that to
the submodule and then updates the supermodule to the new version (by
calling "git-update-index drivers/intel && git-commit" or something).  Then
another Feora X developer updates his X repository.  By pulling the
supermodule he also gets a new version of the submodule.
And this new version of the submodule is stored in a branch which can be
accessed by the submodule.

> A supermodule can never "contain changes" to a submodule.

The supermodule always contains _the_entire_ submodule with its complete
history, so it also does contain changes.  But it does not per-se
contain changes, only indirectly (i.e. the commits in the submodule are
not part of the supermodule commit chain).

> A supermodule would always just point to the submodule, and not have
> any changes what-so-ever of its own. The submodule is self-sufficient,
> and always contains all its _own_ changes.

Yes.

--=20
Martin Waitz

--7phR3qVEw/4Cnor3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcGLsj/Eaxd/oD7IRAg4lAJ9BMkFcAaUfTsTIo7OH70w7hnl4iACeLCmB
Ho1a9xf237tjqrIQW6lbB08=
=uNyc
-----END PGP SIGNATURE-----

