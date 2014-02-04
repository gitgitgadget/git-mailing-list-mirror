From: Miklos Vajna <vmiklos@collabora.co.uk>
Subject: git log history simplification problem
Date: Tue, 4 Feb 2014 18:37:14 +0100
Message-ID: <20140204173713.GC17861@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 18:32:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAjqq-00009t-4x
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 18:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbaBDRbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 12:31:55 -0500
Received: from bhuna.collabora.co.uk ([93.93.135.160]:34443 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162AbaBDRby (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 12:31:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: vmiklos)
	with ESMTPSA id 2438C608CF5
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241532>


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

I was trying to understand the history of a piece of code in LibreOffice
and I'm facing a behaviour of git-log which is not something I can
explain. I'm not sure if this is a git bug or a user error. ;)

Here is the situation:

git clone git://anongit.freedesktop.org/libreoffice/core
cd core
git log --full-history -p -S'mnTitleBarHeight =' sd/source/ui/dlg/PaneDockingWindow.cxx

Here the first output I get from git-log is
b390fae1706b9c511158a03e4fd61f263be4e511, where you can see that the
commit *added* that string. So it should be there on master, I would
assume.

But then I run:

git grep 'mnTitleBarHeight =' sd

and it's not there. Am I missing something, as in e.g. even with
--full-history git-log does some simplification?

Thanks,

Miklos

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlLxJUkACgkQe81tAgORUJYNPwCeOfHZ+kVZfCtZO06NJvlVqCGN
fGMAoIMitgHPThV+QoPjIiIfTUNkxsxM
=CXVU
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
