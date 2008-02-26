From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-email automatic --to detection?
Date: Tue, 26 Feb 2008 18:44:42 +0100
Message-ID: <20080226174442.GM31441@genesis.frugalware.org>
References: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org> <20080225183413.GA15131@sigill.intra.peff.net> <vpqoda43lva.fsf@bauges.imag.fr> <20080225205505.GY31441@genesis.frugalware.org> <slrnfs86qr.prc.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i1KFSYFbl/HTybMx"
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 18:46:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU3sx-0008Vl-Eq
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 18:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763968AbYBZRou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 12:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763369AbYBZRot
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 12:44:49 -0500
Received: from virgo.iok.hu ([193.202.89.103]:13286 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763978AbYBZRos (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 12:44:48 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 9B10F1B253C;
	Tue, 26 Feb 2008 18:44:46 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 1F18844668;
	Tue, 26 Feb 2008 18:42:11 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B3D631190217; Tue, 26 Feb 2008 18:44:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <slrnfs86qr.prc.jgoerzen@katherina.lan.complete.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75155>


--i1KFSYFbl/HTybMx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 26, 2008 at 07:59:55AM -0600, John Goerzen <jgoerzen@complete.org> wrote:
> Actually, both can do both, right?

right. afaik no commands read the remote git config atm, but it might be
possible.

>  darcs send -o will write the data
> to send out to a file on disk, and git-send-email will transmit the
> message.

true. what annoyed me is that i needed net access to generate the file,
ie i was not able to do a 'darcs send -o file', copy the file to an usb
stick and send it from some other box.

>  I don't so much care about the default as making it easy for
> people that do have a local sendmail or smtpd or (ugh) MAPI client to
> send patches automatically, if I tell them what flags to use.

but that's the case for git as well :) you should tell people (for
example): use "git format-patch origin"; send the created *.patch files
and use "git pull --rebase" to avoid an unnecessary merge.

- VMiklos

--i1KFSYFbl/HTybMx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHxFAKe81tAgORUJYRAoGAAJwIGMy7NTYJ5R55nyPz4I16ZqDHQgCfcIws
rbOhOrPp6SbiWSyjfoZaReM=
=icn1
-----END PGP SIGNATURE-----

--i1KFSYFbl/HTybMx--
