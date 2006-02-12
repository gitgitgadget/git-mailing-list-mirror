From: Keith Packard <keithp@keithp.com>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Sun, 12 Feb 2006 13:04:27 -0800
Message-ID: <1139778267.4183.66.camel@evo.keithp.com>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>
	 <7vwtg2o37c.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0602110943170.3691@g5.osdl.org>
	 <1139685031.4183.31.camel@evo.keithp.com>  <43EEAEF3.7040202@op5.se>
	 <1139717510.4183.34.camel@evo.keithp.com>  <43EF15D1.1050609@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EIy1k4bGp7DKPlewHyei"
Cc: keithp@keithp.com, Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Feb 14 00:50:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8nST-0007id-3n
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 00:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWBMXuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 18:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWBMXuM
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 18:50:12 -0500
Received: from home.keithp.com ([63.227.221.253]:57613 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1030304AbWBMXuK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2006 18:50:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 511C7130038;
	Mon, 13 Feb 2006 15:50:09 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06446-06-9; Mon, 13 Feb 2006 15:50:08 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id B3371130031; Mon, 13 Feb 2006 15:50:05 -0800 (PST)
Received: from evo.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id DE40F14003;
	Mon, 13 Feb 2006 15:50:05 -0800 (PST)
Received: from keithp by evo.keithp.com with local (Exim 4.60)
	(envelope-from <keithp@keithp.com>)
	id 1F8OOS-0004cP-QB; Sun, 12 Feb 2006 13:04:28 -0800
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43EF15D1.1050609@op5.se>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16089>


--=-EIy1k4bGp7DKPlewHyei
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-02-12 at 12:02 +0100, Andreas Ericsson wrote:

> Caching features have been discussed, but that means the daemon needs to=20
> have write-access to some directory within the repository.=20

Caching seems a bit dicey to me; security concerns and all. I would much
rather have it discover packs on disk that provided a subset of the
necessary objects; repository cloning would then be a process of
delivering any available packs and then packing up the remaining
objects. Clever administration of the repository could then construct a
single pack of 'historical' data followed by periodic packs of
incremental data.

Yeah, I know, I should just implement this and see how well it works in
practice. I apologize for thinking in public.    =20
     =20
--=20
keith.packard@intel.com

--=-EIy1k4bGp7DKPlewHyei
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD76LbQp8BWwlsTdMRApGtAKDPuEx7uDdWuYYN6Z/SlMafVUCjGQCfWeWz
X79xI4qg/fSH8YI4Bmd+Izo=
=vnvL
-----END PGP SIGNATURE-----

--=-EIy1k4bGp7DKPlewHyei--
