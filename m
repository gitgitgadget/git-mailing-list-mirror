From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: packaging vs default pager
Date: Wed, 28 Oct 2009 11:21:03 -0400
Message-ID: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1256743266-893967-11738-2284-47-="; micalg="pgp-sha1"
Content-Transfer-Encoding: 8bit
To: GIT List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 16:21:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3AKp-0005y8-Gq
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 16:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373AbZJ1PVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 11:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754318AbZJ1PVD
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 11:21:03 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:57358 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292AbZJ1PVD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 11:21:03 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:46813 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1N3AKh-0008Lg-0o
	for git@vger.kernel.org; Wed, 28 Oct 2009 11:21:07 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1N3AKg-00053E-Ue
	for git@vger.kernel.org; Wed, 28 Oct 2009 11:21:06 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n9SFL6nt019416;
	Wed, 28 Oct 2009 11:21:06 -0400
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131471>


--=-1256743266-893967-11738-2284-47-=
Content-Type: text/plain; charset=UTF-8


Hi All,

I'd like to see what people think about providing a configure/Makefile
knob for overriding the default pager at build time.  Currently,
things use 'less' as the fallback and rely on the path to find
it.

On (old) solaris systems, /usr/bin/less (typically the first less
found) doesn't understand the default arguments (FXRS), which forces
users to alter their environment (PATH, GIT_PAGER, LESS, etc) or have
a local or global gitconfig before paging works as expected.

Would it be completely out of line to provide a knob so that the
fallback $pager could be set to something more specific/appropriate
during the build?  [I'll do the work but not if it's an undesirable
addition.]

Alternately, are packagers recommended to simply ship a global
gitconfig that sets core.pager?

Thanks
-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1256743266-893967-11738-2284-47-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFK6GFi8vuMHY6J9tIRAl5xAKDorh6RVVgbt6McHAMfuKgS5vivegCfQ8np
jl20Hmt4/N4Ra6eY6NjHtRQ=
=f6pm
-----END PGP SIGNATURE-----

--=-1256743266-893967-11738-2284-47-=--
