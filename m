From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Sat, 5 May 2007 21:32:14 +0200
Message-ID: <20070505193214.GD30511@admingilde.org>
References: <463BD40C.6080909@gmail.com> <Pine.LNX.4.64.0705050324580.4015@racer.site> <20070505033039.GD16538@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 05 21:32:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkPzR-0006Wi-JP
	for gcvg-git@gmane.org; Sat, 05 May 2007 21:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933213AbXEETcR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 15:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933219AbXEETcR
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 15:32:17 -0400
Received: from mail.admingilde.org ([213.95.32.147]:37083 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933213AbXEETcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 15:32:16 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HkPzK-0006Zb-T7; Sat, 05 May 2007 21:32:14 +0200
Content-Disposition: inline
In-Reply-To: <20070505033039.GD16538@spearce.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46282>


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2007 at 11:30:39PM -0400, Shawn O. Pearce wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Fri, 4 May 2007, Dana How wrote:
> >=20
> > > Most commands accept relative paths,  but this is
> > > not true of arguments in ent:path format.  This
> > > patch makes all of the following git-show commands
> > > work in the git source tree (not just the first):
> > >  % cd xdiff
> > >  % git-show v1.5.2-rc0:xdiff/xemit.h
> > >  % git-show v1.5.2-rc0:./xemit.h
> > >  % git-show v1.5.2-rc0:../sha1_name.c
> >=20
> > ACK.
>=20
> Double ACK.  I'm in complete agreement with every point Dscho has
> made in this thread, even if I haven't quoted it.  ;-)
>=20
> I *really* do not want to see "<tree-ish>:<path>" to mean include
> the current prefix, *especially* when a bare repository is involved.

we could also introduce "<tree-ish>/<path>" for absolute path entries.
This would make a lot of sense for submodules:

	git show "<tree-ish>/path/to/submodule/path/inside/submodule

with only : it would not look that nice ;-)
OK, we could simply say that submodules are special and that you
don't have to use : to separate a commit (the submodule entry) from
the path inside.


aside from that I would also really like to have both absolute and
relative ways to name objects.

--=20
Martin Waitz

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGPNu+j/Eaxd/oD7IRArWfAJ4r9ThtbEF6E2lMgsNVnHuNDEINwQCfRe9z
Glq3yim3Zm5JFyYk3pQyawU=
=TBv/
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
