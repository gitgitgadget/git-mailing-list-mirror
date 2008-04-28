From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Mon, 28 Apr 2008 21:00:47 +0200
Message-ID: <20080428190047.GG26880@genesis.frugalware.org>
References: <alpine.DEB.1.00.0804281523040.5399@eeepc-johanness> <7vtzhmaqpd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281908290.19187@eeepc-johanness> <20080428182114.GF26880@genesis.frugalware.org> <20080428182917.GA4794@glandium.org> <alpine.DEB.1.00.0804281937240.19187@eeepc-johanness>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Y7d0dPL928TPQbc"
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:02:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqYbw-0000T4-Pl
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 21:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966202AbYD1TAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 15:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936427AbYD1TAu
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 15:00:50 -0400
Received: from virgo.iok.hu ([193.202.89.103]:52629 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966156AbYD1TAs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 15:00:48 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8406C1B253A;
	Mon, 28 Apr 2008 21:00:47 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 276F244659;
	Mon, 28 Apr 2008 20:57:07 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2807E1190AC9; Mon, 28 Apr 2008 21:00:47 +0200 (CEST)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804281937240.19187@eeepc-johanness>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80587>


--1Y7d0dPL928TPQbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2008 at 07:37:54PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> > Isn't the problem that git-daemon loses its connection to the syslog=20
> > daemon when logrotate sighups syslog?

Right, but logrotate could send SIGHUP to git-daemon as well.

> I have no idea, but other programs must have the same problem.  I should=
=20
> have shown some diligence and researched that.  Will do so now.

I don't say that just one example justifies me, but here is an example:
icald (google://openlog+sighup 2nd result) does this.

--1Y7d0dPL928TPQbc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkgWHt8ACgkQe81tAgORUJYaAwCgnu7m/srJVtXql2gOgsdL0GeO
zacAnA+LlOfLobMFyeNtn661BaXxV0kJ
=G+XP
-----END PGP SIGNATURE-----

--1Y7d0dPL928TPQbc--
