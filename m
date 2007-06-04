From: Martin Waitz <tali@admingilde.org>
Subject: Re: Improved git-gui blame viewer
Date: Mon, 4 Jun 2007 10:48:52 +0200
Message-ID: <20070604084852.GG16637@admingilde.org>
References: <20070602041723.GD7044@spearce.org> <f3rhme$2h9$1@sea.gmane.org> <20070604060720.GF4507@spearce.org> <20070604073827.GF16637@admingilde.org> <20070604082156.GI4507@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aYDVKSzuImP48n7V"
Cc: Matthijs Melchior <mmelchior@xs4all.nl>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 10:49:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv8FK-0002BT-Qp
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 10:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbXFDIsz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 04:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbXFDIsz
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 04:48:55 -0400
Received: from mail.admingilde.org ([213.95.32.147]:52683 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbXFDIsy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 04:48:54 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hv8FA-0007Xx-P8; Mon, 04 Jun 2007 10:48:52 +0200
Content-Disposition: inline
In-Reply-To: <20070604082156.GI4507@spearce.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49086>


--aYDVKSzuImP48n7V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Jun 04, 2007 at 04:21:56AM -0400, Shawn O. Pearce wrote:
> I think so, but its ugly.  The viewer is actually 4 text widgets
> crammed next to each other.  I can set the background color of a
> line by giving it a tag, so to do a gradient I have to assign a
> different background color to each line by giving each line its
> own tag (ick).  Worse, in a 3 line chunk I can only do 3 colors.
> That fails your "smooth" concept.  ;-)

yeah, if each line has a solid background that does not work :-(

> > Perhaps a simple small line between hunks is enough, too?
>=20
> That would be messy.  I can certainly cause a few pixels of spacing
> to show up between chunks, but I'm reading the data "live" from the
> blame engine and putting it on screen.  Adding space betwen chunks
> as I get it will cause the data to "reflow" while you are trying to
> read it.  I can probably account for it with the scrollbar and adjust
> it accordingly, but at some point you will wind up seeing the text
> in the viewer pane moving around and expanding as the padding gets
> tossed in.

Well, it would work if you could just draw a one-pixel line (in some
subtle gray) inbetween lines, without changing the layout.

> BTW, I just got the jump-to-original line and restore-view-on-back
> features that Matthijs was asking about working properly.  Apparently
> a call to Tk's "update" (basically just let Tk pump its event loop)
> is needed after I've finished reading the file content, but before I
> adjust the view.  Its in my pu branch now (gitgui-0.7.2-58-gf9e96fd).

nice :-)

--=20
Martin Waitz

--aYDVKSzuImP48n7V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGY9H0j/Eaxd/oD7IRAmcOAJsEdAYSvZguunsZJWrrIsQO6FtjTwCcCLqr
ZHPK+DG83/4Huvd0bIcpQco=
=xUaP
-----END PGP SIGNATURE-----

--aYDVKSzuImP48n7V--
