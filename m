From: AJ Rossini <blindglobe@gmail.com>
Subject: git-svn on a strangely configured (pathwise) subversion repository
Date: Mon, 12 Feb 2007 11:36:00 +0100
Organization: BlindGlobe Networks
Message-ID: <200702121136.06382.blindglobe@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2971984.k7758K6QWv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 12 11:38:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGYZm-0005uX-81
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 11:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbXBLKiX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 05:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbXBLKiX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 05:38:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:19360 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964851AbXBLKiW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 05:38:22 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2199898nfa
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 02:38:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:organization:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:message-id;
        b=U6YFgURElIHu6m9F6sZg2a1p/rhH8oe/QJdlG+GJHU3KU6RT+tRpwxOEQX8veDYMZAeWgYFvR+XTzBCQ0yqHy2PgR3h+h8Uo8YKQ+juB8/57aYAfhBji3wHIgHIZKvg/kc0ZoOD4RgYBGkGh/4+Yjth/oweaVL6YUCsIV6GIk/Y=
Received: by 10.48.48.1 with SMTP id v1mr4496812nfv.1171276700107;
        Mon, 12 Feb 2007 02:38:20 -0800 (PST)
Received: from servant.local ( [83.77.97.47])
        by mx.google.com with ESMTP id v20sm29222824nfc.2007.02.12.02.38.19;
        Mon, 12 Feb 2007 02:38:19 -0800 (PST)
User-Agent: KMail/1.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39389>

--nextPart2971984.k7758K6QWv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Greetings all -

(paths and names changed, but basically correct)

I'm trying to use git-svn as a svn client on a repository which is not quit=
e=20
configured in a standard way...  i.e.=20

$ git svn fetch                                                            =
                                                    =20
RA layer request failed: PROPFIND request failed on '/path/to': PROPFIND=20
of '/path/to': 403 Forbidden (https://dummy-host-name.com)=20
at /usr/bin/git-svn line 2861


where as from my working svn copy (no problems from svn, of course, sigh...=
),=20
I'm getting:

$ svn info                                                                 =
                                                   =20
Path: .
URL: https://dummy-host-name.com/path/to/projects/project
Repository Root: https://dummy-host-name.com/path/to
Repository UUID: 97840717-62f2-0310-bead-daafb7b60902
Revision: 554
Node Kind: directory
Schedule: normal
Last Changed Author: someone
Last Changed Rev: 514
Last Changed Date: 2007-01-25 14:20:44 +0100 (Thu, 25 Jan 2007)

The problem seems to be that the Repository Root directory is not readable,=
=20
while the URL is (at least for me, using HTTPS).

This is using
$ git --version                                                            =
                                                   =20
git version 1.4.4.4

(on debian unstable).

Here is what I'm considering:=20
#1 - upgrading to the 1.5.0 RC series
#2 - trying Eric Wong's git-svn branch at http://git.bogomips.org/git-svn.g=
it
#3 - getting a dump of the repository from the owner, loading it into a loc=
al=20
svn server, and doing a local conversion...

With respect to #1/#2, I'm a bit cautious with upgrading to something not r=
ock=20
solid (let's just say that except for this, git 1.4.4.4 has been excellent=
=20
for my needs...).

With respect to #3 - I'd prefer not to waste the admin's (personal) time if=
=20
not necessary!

Does any one have any thoughts?  =20

best,
=2Dtony

blindglobe@gmail.com
Muttenz, Switzerland.
"Commit early,commit often, and commit in a repository from which we can=20
easily roll-back your mistakes" (AJR, 4Jan05).

--nextPart2971984.k7758K6QWv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBF0EMWeKAfgkUpPRARAt97AKCbxokMnZsN/XJlU2fPb9u34Zq7owCfdBKD
Wl4fQIJojB1u4C2FCc6QqTk=
=XTl/
-----END PGP SIGNATURE-----

--nextPart2971984.k7758K6QWv--
