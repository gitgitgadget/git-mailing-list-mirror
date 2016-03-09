From: Barry Warsaw <barry@python.org>
Subject: GIT_CEILING_DIRECTORY
Date: Wed, 9 Mar 2016 11:02:42 -0500
Organization: Damn Crazy Followers of the Horn
Message-ID: <20160309110242.04d8d480@anarchist.wooz.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AIDP6n3F=p++RBq/RRiERbK"; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 17:10:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adggj-0005YN-L8
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 17:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933156AbcCIQKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 11:10:12 -0500
Received: from mail.wooz.org ([216.15.33.194]:53277 "EHLO mail.wooz.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932401AbcCIQKK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 11:10:10 -0500
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Mar 2016 11:10:10 EST
Received: from localhost (localhost [127.0.0.1])
	by mail.wooz.org (Postfix) with ESMTP id 7D699140497
	for <git@vger.kernel.org>; Wed,  9 Mar 2016 11:02:44 -0500 (EST)
Received: from mail.wooz.org ([127.0.0.1])
	by localhost (carnies.wooz.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k8ZTBU7QuETu for <git@vger.kernel.org>;
	Wed,  9 Mar 2016 11:02:44 -0500 (EST)
Received: from anarchist.wooz.org (freewill.wooz.org [192.168.11.53])
	by mail.wooz.org (Postfix) with ESMTPSA id 69C54140496
	for <git@vger.kernel.org>; Wed,  9 Mar 2016 11:02:44 -0500 (EST)
X-Mailer: Claws Mail 3.13.1 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288487>

--Sig_/AIDP6n3F=p++RBq/RRiERbK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I put my home directory under git (recently converted from bzr), but since I
have some subdirectories under $HOME that are not under git (and some that
are) I want to stop e.g. `git status` from traversing up into $HOME.  For
example, I have a ~/projects directory with lots of subdirectories so when =
I'm
in e.g. my CPython Mercurial checkout (~/projects/python), I don't want git=
 to
go higher than ~/projects

GIT_CEILING_DIRECTORIES seems like exactly the thing I want, so I set it to
::$HOME/projects and this works great... unless I'm actually in ~/projects =
in
which case `git status` shows me the status of the $HOME repository.

I tried setting this to just $HOME, but that has the undesired side-effect =
of
blocking $HOME status when I'm in a subdirectory that *is* part of the base
repo, e.g. ~/env.  IOW, with GIT_CEILING_DIRECTORIES=3D$HOME and I cd into
~/env, I don't get any status.

So I'm wondering whether this should be considered a bug in git, or if ther=
e's
some other way to handle this corner case, or whether it's working as inten=
ded
and I just have to live with it.

Cheers,
-Barry

--Sig_/AIDP6n3F=p++RBq/RRiERbK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4EkiAAoJEBJutWOnSwa/82MP/2JhX7wkd3Eo0gpLYi7J/saG
01P8d0V/k3JDEThyW/hu4tGXM7pzkRzHg+YU6By0WnxJz+EJHpAF/x0OS0jp8cdH
7Zf3G0chLkaXWIgBjmtKDSdmlbihNZlGXva/kq4a+Gag/HGwAkxgpV4GmOj7hYKx
i2s1Yms5R2x5H1ym75EzU/6q2+E1blWSlDeF82A+KYBRFpXmufCf43/SOkdLwbdI
9CnwZ4ZL/V7tIUusZpX4I8LRHFXp4QivebZSTZHoHrGpqZeyIs2py1CzQ2YHLaZP
mkw5Yrjg+N5cRnw6/bwMYR1mRjYSuU7wYelEInZNV1eIIBcmR4K6BWkjgw17XjUf
FWP7K6rHtYg6vo0T6Y70c4d7ghv9Hag4CghBKM7hVRMime7Gd8768ySXdpP+uDxq
QCinBD/Ej54x7GmyKPRS5fUm5fZO5RZuoGNDFUXx7sl63O9OLkbo7QNGJAyT7ddP
tWykCutY6fT9pbf3hJFDe+U+xGoceE1VXAmhuDXmJyDdhw/kb9avFhjCDSZQTY9w
3ZvN9cuAv6EfjpWOMT33lKUBly84F177xhpjdiSRyVhkYVrnBxuNhR0IXZinglQN
MjncqxXBNhj1DwqASyVjCRMbxyP56wqHB3L51GL90Wh9bnaRSMNmpJwL8VNOvuMa
Bf6hA0hq1i8Ywn7BUOV+
=zCCl
-----END PGP SIGNATURE-----

--Sig_/AIDP6n3F=p++RBq/RRiERbK--
