From: Taylor Hedberg <tmhedberg@gmail.com>
Subject: Re: Bug report - local (and git ignored) file silently removed after
 checkout
Date: Sun, 20 Nov 2011 17:19:30 -0500
Message-ID: <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
 <7vehx2ijf8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
Cc: Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 20 23:28:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSFsT-0000bw-Bq
	for gcvg-git-2@lo.gmane.org; Sun, 20 Nov 2011 23:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110Ab1KTWTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Nov 2011 17:19:34 -0500
Received: from tmh.cc ([173.230.128.92]:39724 "EHLO elara.tmh.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753588Ab1KTWTd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2011 17:19:33 -0500
Received: by elara.tmh.cc (Postfix, from userid 1001)
	id B771C3420A; Sun, 20 Nov 2011 22:19:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on elara.tmh.cc
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,FREEMAIL_FROM
	autolearn=unavailable version=3.3.2
Received: from foodlogiq3-xp-d620.thebe.ath.cx (cpe-069-134-223-189.nc.res.rr.com [69.134.223.189])
	by elara.tmh.cc (Postfix) with ESMTPSA id E68CB341B5;
	Sun, 20 Nov 2011 22:19:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vehx2ijf8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185728>


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Junio C Hamano, Sun 2011-11-20 @ 13:16:27-0800:
> We do not have "not tracked, but precious (e.g. your TODO)" category;
> from time to time we have discussed possibilities of adding such to
> enrich the categorization, but nobody stepped up to actually do the
> work of designing let alone coding such a beast.

If I'm not mistaken, files ignored by .git/info/exclude rather than
.gitignore do exhibit this behavior. That is, Git will refuse a checkout
with an error message if it would overwrite a path listed in that file.

I don't know if that's actually intended behavior, but I've noticed it
before and made use of it.

--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOyXzxAAoJEDTWeng2oxKKPM4QALXbegyw/vXI+RdfXKCCp37v
Ir5Uwk91z0h2XXLzIhtvlZAlYX0IWtNoajBHDFZ1RiWPJLHUW2vTD8gAb0T0xqWM
auN0x3VYx93Ja9vlbTOU7NtF3eSRHtJ4QaHe97gqoNvSRok0KNhWxmoQODcmPVMh
4sOsDCcOe6QCZeUlMOrw8BrqKopFY459HBSiDEMwJ0TKzW3iS1FOst62DdBkdAyP
LIS76RgNMnzYraJtVmVd5+ZlWPJbuqjrQAr7mQ+hSWpwDOGrYrreLyBeWUdzDNNU
suIJfA0JToWgfsW/a/Fcbd5JzqY7MS5/8iqsVYwDEupVsQjbuqvy/AsFx4nsUPqN
RFSKfdaEjFV/wDOjXuDocWyreqz76GcTSNEHbKh0YlZ8vAXLwe9/RMW7HL+SHFfX
xDsLGTNOr8uI9KTGCGeOqia0UUGmRAF2yhriSDJ+N4CmLCO2TOMaOpgHygDH34ue
vP4V1XDav6sWXvmVGEGK+vhYHwxdQkfYwgYL0zyd9+Re9do90EI8yVdqZOWa45Ut
/MJ9vR7dzisWxp5ijeHy6g8ntAd/n7AqPO7PI9UGdvWvCfPJxE3i+ysUaBKsv9yJ
YQnEjJgEM3cwIk9Qrn0gf6fTNNdWhPOa7AzAXpvX7rvRo6ta36uDel78XtdSQ+2E
p71zIWfk6dqbxL3mp5h4
=kG9P
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--
