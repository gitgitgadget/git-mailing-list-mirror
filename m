From: Christoph Berg <myon@debian.org>
Subject: ciabot_git.pl fails to send notification for 1st ever commit to a
	repo
Date: Sat, 10 May 2008 23:09:39 +0200
Message-ID: <20080510210939.GA29888@df7cb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 23:35:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juwj6-0004M3-QD
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 23:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbYEJVeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 17:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752529AbYEJVeX
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 17:34:23 -0400
Received: from tesla.df7cb.de ([88.198.227.218]:54802 "EHLO tesla.df7cb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489AbYEJVeW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 17:34:22 -0400
X-Greylist: delayed 1479 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 May 2008 17:34:21 EDT
Received: from tesla.df7cb.de (localhost [127.0.0.1])
	by tesla.df7cb.de (Postfix) with ESMTP id DA63B536A8
	for <git@vger.kernel.org>; Sat, 10 May 2008 23:09:39 +0200 (CEST)
Received: by volta.df7cb.de (Postfix, from userid 1000)
	id 4FC1F32EC8; Sat, 10 May 2008 23:09:39 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV using ClamSMTP (tesla.df7cb.de)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81707>


--5/uDoXvLw7AC5HRs
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

[1] and [2] list the cogito repository as the canonical location for
ciabot.pl, the git cia client. As the Debian maintainer of the
cia-clients package, I got a bug report about that script. Petr
indicated he didn't have time anymore to maintain the script himself.
Would a kind soul pick it up as new author?

[1] http://cia.vc/doc/clients/
[2] http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-d03281480d2cc=
49776ae3bafef4942a7ebd80a7f

Thanks,
Christoph
--=20
cb@df7cb.de | http://www.df7cb.de/

--k+w/mQv8wyuph6w0
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <debbugs@bugs.debian.org>
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on tesla.df7cb.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FORGED_RCVD_HELO,UNPARSEABLE_RELAY autolearn=ham version=3.1.7-deb
X-Original-To: cb+myon=debian.org@df7cb.de
Delivered-To: cb+myon=debian.org@df7cb.de
Received: from tesla.df7cb.de (localhost [127.0.0.1])
	by tesla.df7cb.de (Postfix) with ESMTP id 127C629FD9
	for <cb+myon=debian.org@df7cb.de>; Thu, 11 Oct 2007 06:01:25 +0200 (CEST)
Received: from rietz.debian.org (rietz.debian.org [140.211.166.43])
	by tesla.df7cb.de (Postfix) with ESMTP id 725E028018
	for <cb+myon=debian.org@df7cb.de>; Thu, 11 Oct 2007 06:01:23 +0200 (CEST)
Received: from debbugs by rietz.debian.org with local (Exim 4.50)
	id 1IfpDQ-0003JA-Bm; Thu, 11 Oct 2007 04:00:04 +0000
X-Loop: owner@bugs.debian.org
Subject: Bug#446201: ciabot_git.pl fails to send notification for 1st ever commit to a repo
Reply-To: Joey Hess <joeyh@debian.org>, 446201@bugs.debian.org
Resent-From: Joey Hess <joeyh@debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: Christoph Berg <myon@debian.org>
Resent-Date: Thu, 11 Oct 2007 04:00:02 +0000
Resent-Message-ID: <handler.446201.B.119207515911078@bugs.debian.org>
X-Debian-PR-Message: report 446201
X-Debian-PR-Package: cia-clients
X-Debian-PR-Keywords: 
X-Debian-PR-Source: cia-clients
Received: via spool by submit@bugs.debian.org id=B.119207515911078
          (code B ref -1); Thu, 11 Oct 2007 04:00:02 +0000
Received: (at submit) by bugs.debian.org; 11 Oct 2007 03:59:19 +0000
Old-X-Spam-Checker-Version: SpamAssassin 3.1.4-bugs.debian.org_2005_01_02 
	(2006-07-26) on rietz.debian.org
Old-X-Spam-Status: No, score=-8.8 required=4.0 tests=BAYES_00,FORGED_RCVD_HELO,
	FOURLA,FROMDEVELOPER,HAS_PACKAGE,IMPRONONCABLE_2,MURPHY_SEX_L4 
	autolearn=no version=3.1.4-bugs.debian.org_2005_01_02
Received: from wren.kitenet.net ([80.68.85.49] helo=kitenet.net)
	by rietz.debian.org with esmtp (Exim 4.50)
	id 1IfpCh-0002pB-3h
	for submit@bugs.debian.org; Thu, 11 Oct 2007 03:59:19 +0000
Received: from kodama.kitenet.net (66-168-92-132.dhcp.kgpt.tn.charter.com [66.168.92.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Joey Hess", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTP id 5377631432D
	for <submit@bugs.debian.org>; Wed, 10 Oct 2007 23:59:13 -0400 (EDT)
Received: by kodama.kitenet.net (Postfix, from userid 1000)
	id 85434478A6D; Wed, 10 Oct 2007 23:59:11 -0400 (EDT)
Date: Wed, 10 Oct 2007 23:59:11 -0400
From: Joey Hess <joeyh@debian.org>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Message-ID: <20071011035911.GA4641@kitenet.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
X-Reportbug-Version: 3.39
User-Agent: Mutt/1.5.16 (2007-06-11)
Delivered-To: submit@bugs.debian.org
Resent-Sender: Debian BTS <debbugs@bugs.debian.org>
Resent-Date: Thu, 11 Oct 2007 04:00:04 +0000
X-Virus-Scanned: ClamAV using ClamSMTP (tesla.df7cb.de)
X-Label: #446201 cia-clients
X-TUID: bb73c4336d657ecc


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Package: cia-clients
Severity: normal

joey@wren:/srv/git/kitenet.net/mr>/usr/share/cia-clients/ciabot_git.pl 4cda=
4e5c360d4cd0cd33ef8b3bd2cd55eb50b583 master
Use of uninitialized value in concatenation (.) or string at /usr/share/cia=
-clients/ciabot_git.pl line 147.
error: Object 424f29da137f167aaaceddd53b25be2ba623c0e7 is a tree, not a com=
mit

I've only ever made one commit to this repo, and the program
looks for 'parent' keys in the git-cat-file output, which isn't there for t=
he
first commit..

-- System Information:
Debian Release: lenny/sid
  APT prefers unstable
  APT policy: (500, 'unstable'), (500, 'testing'), (1, 'experimental')
Architecture: i386 (i686)

Kernel: Linux 2.6.22-2-686 (SMP w/1 CPU core)
Locale: LANG=3Den_US.UTF-8, LC_CTYPE=3Den_US.UTF-8 (charmap=3DUTF-8)
Shell: /bin/sh linked to /bin/dash

--=20
see shy jo

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHDZ+Pd8HHehbQuO8RArIbAJ0dTlfJ7aKiqsiGa90+nvXx1LXmbACfUoUy
yRK+4nGW3Vz3ggKZbo2R048=
=NlIo
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--


--k+w/mQv8wyuph6w0--

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIJg8Txa93SlhRC1oRAgXCAKCAISCpoywxRQViEkVz67yvWxM90ACg/ESl
HHomk4j6dyJv0IELia1ys/I=
=RE9Q
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
