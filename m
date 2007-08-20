From: Jan Hudec <bulb@ucw.cz>
Subject: Re: confused about preserved permissions
Date: Mon, 20 Aug 2007 22:27:08 +0200
Message-ID: <20070820202708.GH8542@efreet.light.src>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <20070820174142.GA7943@glandium.org> <867inqhyuk.fsf@lola.quinscape.zz> <20070820181357.GA8264@glandium.org> <86zm0mgicy.fsf@lola.quinscape.zz> <20070820184829.GA8617@glandium.org> <20070820194328.GE8542@efreet.light.src> <20070820195037.GA9774@glandium.org> <20070820200719.GE5544@steel.home> <20070820201042.GA9942@glandium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kHRd/tpU31Zn62xO"
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 22:28:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INDrg-0005Tc-4A
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 22:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763929AbXHTU1T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 16:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764437AbXHTU1S
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 16:27:18 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:33006 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764427AbXHTU1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 16:27:16 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 4DB7657277;
	Mon, 20 Aug 2007 22:27:15 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id OkzBIjVMRZ2H; Mon, 20 Aug 2007 22:27:12 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 390CD57407;
	Mon, 20 Aug 2007 22:27:12 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1INDq8-00073C-2k; Mon, 20 Aug 2007 22:27:08 +0200
Content-Disposition: inline
In-Reply-To: <20070820201042.GA9942@glandium.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56252>


--kHRd/tpU31Zn62xO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2007 at 22:10:42 +0200, Mike Hommey wrote:
> On Mon, Aug 20, 2007 at 10:07:19PM +0200, Alex Riesen <raa.lkml@gmail.com=
> wrote:
> > Mike Hommey, Mon, Aug 20, 2007 21:50:37 +0200:
> > > On Mon, Aug 20, 2007 at 09:43:28PM +0200, Jan Hudec <bulb@ucw.cz> wro=
te:
> > > > Git does not have tracking of file's history either.
> > >=20
> > > Well, it has ways to track file's history, with blame and log, for
> > > example. There is nothing similar for directories, though it could be
> > > possible to do.
> >=20
> > It would be not exactly "tracking". You can present the history of
> > changes which involved the said directory.
> >=20
> > And you could do it from day one: git log -- sub/dir
>=20
> It could be possible to really do tracking, too, like it is possible for
> files (including renames, moves, etc.)

It depends on what you imagine under tracking, but git does not track files
in a sense of knowing about renames, moves etc. Git can't tell you -- and by
design never will -- that file foo was moved to bar in revision abcdef01. A=
ll
it can tell you is "looking at the trees, I would guess that file foo was
moved to bar in revision abcdef01". That is not tracking in a sense keeping
track of anything. It is just digging out interesting similarities between
the individual trees.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--kHRd/tpU31Zn62xO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGyfkcRel1vVwhjGURAm4NAJ9Qi54cvm1VfdSbR5SkJL4hALJ+uwCgnKNA
WHh4ILQq47/87FdjMm25BMY=
=fwHd
-----END PGP SIGNATURE-----

--kHRd/tpU31Zn62xO--
