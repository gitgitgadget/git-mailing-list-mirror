From: Jan Hudec <bulb@ucw.cz>
Subject: Re: preserving mtime
Date: Sun, 18 Nov 2007 10:40:38 +0100
Message-ID: <20071118094038.GA11861@efreet.light.src>
References: <473D63F9.4010201@inrim.it> <473D6DC6.8040804@op5.se> <20071117182236.GD23659@blorf.net> <20071118084511.GC16863@glandium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Cc: Wayne Davison <wayne@opencoder.net>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Nov 18 10:41:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItgeJ-0007mu-Aj
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 10:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbXKRJku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 04:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbXKRJku
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 04:40:50 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:41558 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbXKRJks (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 04:40:48 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 0E21A57390;
	Sun, 18 Nov 2007 10:40:47 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id HoGIW2Bf4dI6; Sun, 18 Nov 2007 10:40:44 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id BB6BB5738D;
	Sun, 18 Nov 2007 10:40:43 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1Itgdq-0003J2-MV; Sun, 18 Nov 2007 10:40:38 +0100
Content-Disposition: inline
In-Reply-To: <20071118084511.GC16863@glandium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65354>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 18, 2007 at 09:45:11 +0100, Mike Hommey wrote:
> On Sat, Nov 17, 2007 at 10:22:36AM -0800, Wayne Davison wrote:
> > On Fri, Nov 16, 2007 at 11:15:34AM +0100, Andreas Ericsson wrote:
> > >> is it possible to tell git to preserve the file modification time in
> > >> a checked out copy?
> >=20
> > > Fabrizio Pollastri wrote:
> > > No. Doing so would seriously break build-systems.
> >=20
> > I wish that the initial clone would set the modification time to the
> > commit time.  It would make the intial checkout have a more accurate
> > representation of when a file was last changed instead of all files
> > being set to the clone date.  Then, files that are being updated would
> > get their time set as they do now.  I supposed I'll just use the handy
> > git-set-file-times script (mentioned in another reply) every time I do
> > a clone.
>=20
> For completeness, it would make sense to do so every time you git
> checkout (like, when switching branches).

 - That would still screw-up make hard. You know, checking out does NOT
   delete any untracked files.

 - There is no such thing as last modification time in git. Because there is
   no file history in git. (Besides, what would be last modification time of
   a file that was last modified in two parents, for example?)

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHQAiWRel1vVwhjGURAqgnAJ4rv57mzf8bm21WXQm+AmLGSsb8WwCgnL7s
soUNjJWI0WpOL747KcqVADo=
=+Yn4
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
