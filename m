From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Who created a branch - reflog
Date: Tue, 8 Mar 2011 15:38:46 +0100
Message-ID: <20110308143846.GV3609@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCKkSrrNUaKEhaIQ"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 15:53:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwyHx-0002RE-0C
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 15:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305Ab1CHOxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 09:53:21 -0500
Received: from virgo.iok.hu ([212.40.97.103]:39238 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755295Ab1CHOxU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 09:53:20 -0500
X-Greylist: delayed 870 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Mar 2011 09:53:20 EST
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A836A580AC
	for <git@vger.kernel.org>; Tue,  8 Mar 2011 15:38:46 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A2E7744965
	for <git@vger.kernel.org>; Tue,  8 Mar 2011 15:38:46 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 812051358449; Tue,  8 Mar 2011 15:38:46 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168664>


--lCKkSrrNUaKEhaIQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We have a repo where multiple users have push access, they access the
repo via ssh. Now let's say one of the developers ("A") accidently create a
branch named "foo" in the shared repo. Of course the tip of "foo" may
not point to a commit authored by "A".

IIRC reflogs could be used in that case when the push is done via http,
as the HTTP username is recorded in the reflog, so we can know who to
blame.

Unfortunately - as far as I see - this is not true for ssh, there simply
the author of the tip commit is used.

Have I missed something? Would it be possible to have the username of
the user in the reflog, even when pushing via ssh?

Thanks.

--lCKkSrrNUaKEhaIQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk12P3YACgkQe81tAgORUJantQCfVqOGY7MlJdHhateBkJq+nx0a
ibMAoIhQNWcAE92M4cdzX/9/fm8dPqO+
=vlUD
-----END PGP SIGNATURE-----

--lCKkSrrNUaKEhaIQ--
