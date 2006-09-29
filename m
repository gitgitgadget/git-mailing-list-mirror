From: Martin Waitz <tali@admingilde.org>
Subject: Re: Notes on Using Git with Subprojects
Date: Fri, 29 Sep 2006 09:04:35 +0200
Message-ID: <20060929070435.GA20011@admingilde.org>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <451AADC3.40201@gmail.com> <20060928073706.GE8056@admingilde.org> <451C30EF.8050305@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Cc: Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 09:04:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTCQM-0006ef-SQ
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 09:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbWI2HEj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 03:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWI2HEj
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 03:04:39 -0400
Received: from agent.admingilde.org ([213.95.21.5]:21686 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1030395AbWI2HEi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 03:04:38 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GTCQF-0005LW-7d; Fri, 29 Sep 2006 09:04:35 +0200
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <451C30EF.8050305@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28097>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Sep 28, 2006 at 01:30:39PM -0700, A Large Angry SCM wrote:
> If the submodule refs in the parent are the actual submodule refs then=20
> the submodule is not independent of the parent.

ok, it's not independent in that sense that you can move the directory
away and expect the submodule to work even when the parent does not
exist any more.

But you can do normal GIT work as before.
You can create new branches (they will be stored in the parent
but you have to "git add .gitmodule/..." explicitly in order
to track the branch in the parent), fetch/pull from other sides,
create commits, etc.
So in your normal workflow you do not have to do anything in the
parent while you work in the submodule.  That's what I've called
"independent".

I hope the intention is clear now, perhaps I've been sloppy
with words.

--=20
Martin Waitz

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFHMWDj/Eaxd/oD7IRAvcuAJ9h1SEBomD5CtlIF3NCVCUUkn6BNgCeN3MT
yUTE3jtOlgXZSZKxPu4K6rc=
=h9On
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
