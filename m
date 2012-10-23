From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Git submodule for a local branch?
Date: Tue, 23 Oct 2012 09:21:11 -0400
Message-ID: <20121023132111.GA26134@odin.tremily.us>
References: <20121022123714.GL25563@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=cNdxnHkX5QqsyA0e
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 15:21:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQeQO-0000U7-F5
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 15:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756927Ab2JWNV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 09:21:28 -0400
Received: from vms173013pub.verizon.net ([206.46.173.13]:11380 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147Ab2JWNV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 09:21:28 -0400
Received: from odin.tremily.us ([unknown] [72.76.145.253])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MCC0011JL3B4R40@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 23 Oct 2012 08:21:17 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 42D0F67DD7C; Tue,
 23 Oct 2012 09:21:11 -0400 (EDT)
Content-disposition: inline
In-reply-to: <20121022123714.GL25563@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208228>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2012 at 08:37:14AM -0400, W. Trevor King wrote:
> but cloning a remote repository (vs. checking out a local branch)
> seems to be baked into the submodule implementation.

Perhaps --local would set submodule.$name.url to '.', and ome
combination of GIT_WORK_TREE, GIT_DIR, and object references could be
used to setup and manage the local submodule.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQhpnEAAoJEEUbTsx0l5OMcY8P/3l0wSQwttkwCOiz33i25zoe
tMJBlVXQ9esig6HfcPaaN/wZWQCwpG0AFq9Yc4e2nNta/hODuOS4S0H+YWsRkrNB
CEMXyByb5EYDhk3dlm6tnSJQTP/6Y4vtj5fyU4/Cu1/P0CkDPBxUNirxi5CygUP2
HDw1s6X43yAZDODPFDe9ktynlexxvQRLsPYmCZTkV5JoUfTUEqQWeBoGpgeacswm
VBRS1FDXhcRDdgSzArRQ4dcqdJ7nFBXDeP0Cv0/PPnIEJck+M51uudBdBT+HNF3u
vtuTXuhPsIYrLHimIuTdIHrJvgnBMFMUpHWkyKWyKlL43yKX8TehrHXArYMWEPqa
y3p2PLAmbEeNR+xiqrY2FvCniMD2j88aI3BeoAdKQTHYrTFhczmQyWp5uz312yZ+
Cx8Tf2nr5aRYZN85kFMxSU+VygJ5ZUNHQQrVWF87W3MSQA0NhkJyjtYrHJUFRNpc
/Eno58bf0yV6N3+TW6tdBluV04vZt6ZulI+l7jUKmT6ZCpMzOlXyPVAuKE8izFpm
Kg0R4poLPobEUuwe13ypRMJ6pIF6MaDJpx077OhBBDJyHzIawZmEfD9+nVccONvt
+9NBr2dptYUX6ULxZKYmClEoYLqW5qlaAkkY6YC6DlE/h8UeD4ahUpANqiEl16eg
pPye7FyUKTw79PXl832N
=Hugu
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
