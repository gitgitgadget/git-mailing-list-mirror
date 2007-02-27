From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Replacement for cvs2cl, for generating ChangeLog
Date: Tue, 27 Feb 2007 17:40:35 +0300
Message-ID: <20070227174035.f85e8643.vsu@altlinux.ru>
References: <877iu3q13r.fsf@latte.josefsson.org>
	<Pine.LNX.4.63.0702271336050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__27_Feb_2007_17_40_35_+0300_0uM8qf2R+iR2H/DA"
Cc: Simon Josefsson <simon@josefsson.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 15:40:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM3Vc-0004Mm-Tl
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 15:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbXB0Oku (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 09:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbXB0Oku
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 09:40:50 -0500
Received: from mivlgu.ru ([81.18.140.87]:34940 "EHLO mail.mivlgu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777AbXB0Okt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 09:40:49 -0500
Received: from center4.mivlgu.local (center4.mivlgu.local [192.168.1.4])
	by mail.mivlgu.ru (Postfix) with SMTP
	id B0454804A; Tue, 27 Feb 2007 17:40:38 +0300 (MSK)
In-Reply-To: <Pine.LNX.4.63.0702271336050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.6; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40740>

--Signature=_Tue__27_Feb_2007_17_40_35_+0300_0uM8qf2R+iR2H/DA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2007 13:37:23 +0100 (CET) Johannes Schindelin wrote:

> On Tue, 27 Feb 2007, Simon Josefsson wrote:
>
> > Hi!  I'm considering switching to git for my projects (shishi, gsasl,
> > gnutls, libtasn1, opencdk, ...) and I have some questions:
> >
> > * How do I discard all locally modified or added files?  'cvs upd -C'
> >   does some of that, but I've been using a tool 'cvsco' which quickly
> >   restore a CVS checkout into a pristine state.
>
> The command in git is called "git reset --hard". Beware: this really,
> really loses _all_ local changes. And no need to worry when it completes
> much faster than you expected it to... See "git status" to see that it
> worked, indeed.

But "git reset --hard" won't touch untracked files (this command is
similar to "cvs update -C", but does not save old contents anywhere).
If what is really needed is to clean out build products, editor backups
and other files which are not tracked by git, "git clean -d -x" will do
it (but this command will keep local changes to tracked files - an
additional "git reset --hard" is needed to restore them to the last
committed state).

--Signature=_Tue__27_Feb_2007_17_40_35_+0300_0uM8qf2R+iR2H/DA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQFF5ELmW82GfkQfsqIRAgCXAKCSFj0l0LPSrOaSPQKzw+HQUtqu6QCfRQa7
G/gTqtFx95X/DCV5D/lcf38=
=9hNh
-----END PGP SIGNATURE-----

--Signature=_Tue__27_Feb_2007_17_40_35_+0300_0uM8qf2R+iR2H/DA--
