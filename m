From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: path-restricted gitk with tags showing up?
Date: Tue, 1 Aug 2006 23:13:29 +0400
Message-ID: <20060801231329.82d934a2.vsu@altlinux.ru>
References: <20060801174210.GA81699@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__1_Aug_2006_23_13_29_+0400_MXHEl7tD/x+nI0iC"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 21:14:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7zgu-0002TZ-Ds
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 21:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbWHATN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 15:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWHATN7
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 15:13:59 -0400
Received: from master.altlinux.org ([62.118.250.235]:52488 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1751816AbWHATN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 15:13:58 -0400
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id 998BEE34F2; Tue,  1 Aug 2006 23:13:56 +0400 (MSD)
Received: by procyon.home (Postfix, from userid 500)
	id D5145E56EE6; Tue,  1 Aug 2006 23:13:32 +0400 (MSD)
To: Olivier Galibert <galibert@pobox.com>
In-Reply-To: <20060801174210.GA81699@dspnet.fr.eu.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24608>

--Signature=_Tue__1_Aug_2006_23_13_29_+0400_MXHEl7tD/x+nI0iC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Aug 2006 19:42:10 +0200 Olivier Galibert wrote:

> I'd like to do a (f.i) gitk include/sound/asound.h but still see the
> commits which are in the DAG delimited by the alsa commits and have
> tags attached.  The aim is to know what changes where in what released
> kernel version.  Is there a way to do that?

Since git-1.4.0 gitk shows this information in the "Follows:" and
"Precedes:" lines for each commit (you need to enable "Display nearby
tags" in preferences).  In your case, the "Precedes" line will show the
first kernel version which included the change.

Note that loading this information takes some time; gitk tries to load
it in background, so you may see empty "Follows" and "Precedes" lines
for some time.

--Signature=_Tue__1_Aug_2006_23_13_29_+0400_MXHEl7tD/x+nI0iC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEz6fcW82GfkQfsqIRAiHlAJ92QY8wJJmqcftbLdXphOdG/tgMoACcCkh8
om7uvP7bNoa2GZgFNH2mlzI=
=anT5
-----END PGP SIGNATURE-----

--Signature=_Tue__1_Aug_2006_23_13_29_+0400_MXHEl7tD/x+nI0iC--
