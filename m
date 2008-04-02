From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: undocumented git pack-objects --unpacked=file
Date: Wed, 02 Apr 2008 09:35:38 +0300
Message-ID: <873aq4sr0l.fsf@Astalo.kon.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 02 09:09:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgx6F-0001f2-4W
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 09:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756986AbYDBHIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 03:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756700AbYDBHIw
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 03:08:52 -0400
Received: from 85-23-34-109-Rajakyla-TR1.suomi.net ([85.23.34.109]:58762 "EHLO
	Astalo.kon.iki.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752888AbYDBHIv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 03:08:51 -0400
X-Greylist: delayed 1977 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Apr 2008 03:08:51 EDT
Received: from Kalle by Astalo.kon.iki.fi with local (Exim 4.52)
	id 1JgwZc-0005QD-Fp; Wed, 02 Apr 2008 09:35:52 +0300
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.0.51 (gnu/linux)
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78686>

--=-=-=

A child process of "git repack -a -d -f" was doing:

  PID TTY      STAT   TIME COMMAND
20178 pts/3    R+   491:31 git pack-objects --non-empty --all --reflog --unpacked=pack-41dbbd4c9b63110b8122f9d78a15668aa6b2b273.pack

The git-pack-objects(1) manual page describes:

| git-pack-objects [-q] [--no-reuse-delta] [--delta-base-offset] [--non-empty]
|         [--local] [--incremental] [--window=N] [--depth=N] [--all-progress]
|         [--revs [--unpacked | --all]*] [--stdout | base-name] < object-list
...
| --unpacked
|         This implies --revs. When processing the list of revision
|         arguments read from the standard input, limit the objects
|         packed to those that are not already packed.

However, it does not say what
--unpacked=pack-41dbbd4c9b63110b8122f9d78a15668aa6b2b273.pack
might mean.  grep unpacked= Documentation/* did not find anything
either.  Could you please document the meaning of this option?

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH8ylIHm9IGt60eMgRAsc3AKCleMc0cJg/6a0Lx03zZcmOesdp0gCcCmUo
5n/3jmI2fXeiZVg/BUjnBjU=
=nsxO
-----END PGP SIGNATURE-----
--=-=-=--
