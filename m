From: Jan Hudec <bulb@ucw.cz>
Subject: Re: pushing changes to a remote branch
Date: Wed, 11 Jul 2007 21:34:44 +0200
Message-ID: <20070711193444.GD3069@efreet.light.src>
References: <20070710143614.GA29681@piper.oerlikon.madduck.net> <20070710173401.GB5032@sigill.intra.peff.net> <844FC382-DFB3-4762-93C2-6512612136AC@silverinsanity.com> <a2e879e50707102044l864b9dcre5b6fa5893ff4803@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Cc: git@vger.kernel.org
To: Sean Kelley <svk.sweng@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 21:35:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8hxv-0001Hu-1i
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 21:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933960AbXGKTeu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 15:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933566AbXGKTet
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 15:34:49 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:49087 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934061AbXGKTer (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 15:34:47 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id D57765734C;
	Wed, 11 Jul 2007 21:34:46 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 2PtevocR8MqA; Wed, 11 Jul 2007 21:34:45 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 68BAA57348;
	Wed, 11 Jul 2007 21:34:45 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I8hxU-0002lR-S8; Wed, 11 Jul 2007 21:34:44 +0200
Content-Disposition: inline
In-Reply-To: <a2e879e50707102044l864b9dcre5b6fa5893ff4803@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52194>


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2007 at 22:44:58 -0500, Sean Kelley wrote:
> If you then do a push from that new_branch_name will it create a new
> branch on the remote?  I am struggling with just being able to add a
> remote.  Create a local branch that maps to the remote.  Then
> committing and pushing changes to the remote - all without creating a
> new branch on the remote.

git push takes a refspec, which is local-branch:remote-branch. So you can
push from local branch of any name to remote branch of any other name. You
can also define the relationships in the config, but you'll have to look up
what exactly you should specify in the manuals (of git-push and git-config).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGlTDURel1vVwhjGURAnzfAJ0TAubJzp+0M9qusiWl7aYs3OYiXwCfWnzL
Aw4dBRws3UTGDvLVct6AIqU=
=9Kez
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
