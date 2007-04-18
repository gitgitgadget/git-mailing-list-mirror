From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Wed, 18 Apr 2007 04:08:34 -0700
Message-ID: <20070418110834.GK31488@curie-int.orbis-terrarum.net>
References: <200704171041.46176.andyparkins@gmail.com> <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org> <46250175.4020300@dawes.za.net> <Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org> <20070417235649.GE31488@curie-int.orbis-terrarum.net> <87tzve9etj.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
To: David K??gedal <davidk@lysator.liu.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 13:08:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He81t-0007SE-Hg
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 13:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422838AbXDRLIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 07:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422843AbXDRLIe
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 07:08:34 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:38132 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422838AbXDRLId (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 07:08:33 -0400
Received: (qmail 28430 invoked from network); 18 Apr 2007 11:08:32 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Wed, 18 Apr 2007 11:08:32 +0000
Received: (qmail 3749 invoked by uid 10000); 18 Apr 2007 04:08:34 -0700
Content-Disposition: inline
In-Reply-To: <87tzve9etj.fsf@morpheus.local>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44886>


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2007 at 12:06:48PM +0200, David K??gedal wrote:
> > This is perhaps a reasonable wording of my requirement.
> > "Files from from the VCS should contain a stable machine-usable
> > identifier that is unique for that revision of the file, without
> > post-processing to insert the identifier."
> But what is the "revision of the file"?  The blob ID is just a hash of
> the contents, and doesn't say anything about where in the history of
> the project it appears.  It will usually appear in many "project
> revisions", i.e. commits.
The location/context in history of the file is not needed by the
requirement I wrote above.

Since the BlobID is the hash of the contents (taken with all keywords
collapsed obviously) - if the contents are identical, then the blobid is
identical.

Since the contents and blobid are the same, it doesn't matter which
commit you take the file from when you don't care about the history of
that point (eg cat-file, diff).

The file goes out, and when a user throws it (modified) back at us, we
just grab the $BlobId$ and use that to identify what it originally
looked like.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGJfwyPpIsIjIzwiwRAsMnAKCuorcZBk/ara9bdv5QqH9fG1/YvQCgi0SW
xZhEpknhELnO158IBV7sBSw=
=BskN
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--
