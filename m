From: Evan Driscoll <driscoll@cs.wisc.edu>
Subject: Feature suggestion: new 'git add -i' command to discard working copy
 changes
Date: Tue, 18 Dec 2012 15:03:21 -0600
Message-ID: <50D0DA19.5030606@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2808A5C3D374118485723F1B"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 22:12:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl4SJ-0002TL-Cu
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 22:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678Ab2LRVLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 16:11:45 -0500
Received: from sandstone.cs.wisc.edu ([128.105.6.39]:34430 "EHLO
	sandstone.cs.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab2LRVLp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 16:11:45 -0500
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Dec 2012 16:11:45 EST
Received: from hank.cs.wisc.edu (hank.cs.wisc.edu [128.105.14.80])
	by sandstone.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id qBIL3QTS012614
	for <git@vger.kernel.org>; Tue, 18 Dec 2012 15:03:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.11) Gecko/20121116 Thunderbird/10.0.11
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211786>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2808A5C3D374118485723F1B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

It's not infrequent that I want to discard changes I've made locally to
files ('git checkout file.txt') and find myself wishing that this was an
action available from the 'git add --interactive' UI; it feels like it
would fit in.

Does this sound like it would be useful? I might even be able to try my
hand at adding it if it seems like something that might be accepted
upstream and someone can point me at the places in the code to look.

Evan



--------------enig2808A5C3D374118485723F1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJQ0NoeAAoJEAOzoR8eZTzgtxIH/0+mpCQyVHt/mR0V4KpvwJ+/
9DwLdsoXpgdtmZ+UYqZFmSOSbo0m9/+eHgtMaZChJCC+aw0euDUU3e4le3q/fR6Z
23MQJdN8nmlSQwNd/LC9GZFeOPXsATOudkwgTpTrtcCbiBvJuFSpe/NFDPLv6CTp
Z27OQdHT0wZppZR7KkxORp7Q11J4O0XLSG7p+rSwnTn6rNZ4J6TZ2fytD9tfJDO8
e6kSqBHTCZ3150kwdCe8a0Q6/nIFejcmckxd1N+wks7NH4GBpV5xolVNdXtWEBnF
PA0UP0YToNe1Wo2P6GJdb1Du5fFIBND9vaOX3DyYC54fRcddb9bbzX/5T8Jmuhg=
=ooEp
-----END PGP SIGNATURE-----

--------------enig2808A5C3D374118485723F1B--
