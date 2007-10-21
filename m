From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] On error, do not list all commands, but point to
	--help option
Date: Sun, 21 Oct 2007 12:09:21 +0200
Message-ID: <20071021100921.GD8887@efreet.light.src>
References: <bqaujirk.fsf@blue.sea.net> <ir51if2y.fsf@blue.sea.net> <20071021033318.GD14735@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 12:09:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjXkd-00033A-LY
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 12:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbXJUKJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 06:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbXJUKJc
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 06:09:32 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:39650 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbXJUKJa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 06:09:30 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 47D86573CA;
	Sun, 21 Oct 2007 12:09:29 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id kPo8h5Oo-TXT; Sun, 21 Oct 2007 12:09:26 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 1338B573C5;
	Sun, 21 Oct 2007 12:09:25 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IjXkH-0007wV-Gm; Sun, 21 Oct 2007 12:09:21 +0200
Content-Disposition: inline
In-Reply-To: <20071021033318.GD14735@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61896>


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 20, 2007 at 23:33:18 -0400, Shawn O. Pearce wrote:
> Jari Aalto <jari.aalto@cante.net> wrote:
> > - Remove out call to list_common_cmds_help()
>=20
> Even if the list is against this change (which I'm in favor of)...=20

I didn't get the impression that the _whole_ list is against. I think that
the rather longish list should only be shown for 'git help' and when no
command was specified (but that is handled by implying help, so this change
does not apply to that case), so I am in favor of this.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHGyVRRel1vVwhjGURAuqqAJ9kIQ7DapArVknJ+sIhEzJDOsG4KQCgjPii
ma+cdBCMCrabQO3A4lhuiyo=
=NkRi
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
