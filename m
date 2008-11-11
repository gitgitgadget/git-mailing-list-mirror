From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [ANNOUNCE] darcs-fast-export
Date: Tue, 11 Nov 2008 02:53:13 +0100
Message-ID: <20081111015313.GB24201@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8989743173931662555=="
Cc: bazaar@lists.canonical.com, mercurial@selenic.com, darcs-users@darcs.net
To: git@vger.kernel.org
X-From: darcs-users-bounces@darcs.net Tue Nov 11 02:54:34 2008
Return-path: <darcs-users-bounces@darcs.net>
Envelope-to: gcvdu-darcs-users@gmane.org
Received: from fraxinus.osuosl.org ([140.211.166.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KziSd-0003Qp-1o
	for gcvdu-darcs-users@gmane.org; Tue, 11 Nov 2008 02:54:31 +0100
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7C0523D96A;
	Tue, 11 Nov 2008 01:53:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XlLQpuys0tSG; Tue, 11 Nov 2008 01:53:18 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B6D493D96B;
	Tue, 11 Nov 2008 01:53:18 +0000 (UTC)
X-Original-To: darcs-users@lists.darcs.net
Delivered-To: darcs-users@osuosl.org
Received: from whitealder.osuosl.org (whitealder.osuosl.org [140.211.166.138])
	by ash.osuosl.org (Postfix) with ESMTP id 3AEA78F74E
	for <darcs-users@lists.darcs.net>; Tue, 11 Nov 2008 01:53:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2A3C41099EE
	for <darcs-users@lists.darcs.net>; Tue, 11 Nov 2008 01:53:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5+Z7JDGpu8nx for <darcs-users@lists.darcs.net>;
	Tue, 11 Nov 2008 01:53:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.4
Received: from virgo.iok.hu (virgo.iok.hu [193.202.89.103])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5E8601099B0
	for <darcs-users@darcs.net>; Tue, 11 Nov 2008 01:53:15 +0000 (UTC)
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 2C1BE5808F;
	Tue, 11 Nov 2008 02:53:14 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B31E04465E;
	Tue, 11 Nov 2008 02:53:13 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8F0F6119019E; Tue, 11 Nov 2008 02:53:13 +0100 (CET)
User-Agent: Mutt/1.5.17 (2007-11-01)
X-BeenThere: darcs-users@darcs.net
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: A list for users of darcs <darcs-users.darcs.net>
List-Unsubscribe: <http://lists.osuosl.org/mailman/listinfo/darcs-users>,
	<mailto:darcs-users-request@darcs.net?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/darcs-users>
List-Post: <mailto:darcs-users@darcs.net>
List-Help: <mailto:darcs-users-request@darcs.net?subject=help>
List-Subscribe: <http://lists.osuosl.org/mailman/listinfo/darcs-users>,
	<mailto:darcs-users-request@darcs.net?subject=subscribe>
Sender: darcs-users-bounces@darcs.net
Errors-To: darcs-users-bounces@darcs.net
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100610>


--===============8989743173931662555==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7w6n1xPQJploaIC9"
Content-Disposition: inline


--7w6n1xPQJploaIC9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm happy to announce a small project I recently stated to work on. It's
a darcs backend for fast importers.

This means that it allows you to export patches/commits from a darcs
repo and import to any version control system where a fast importer is
implemented.

Current features:

- According to its name, it tries to be really fast, even for large
  repos.

- Independent. It has been tested with git fast-import, hg fastimport
  and bzr fast-import. (Let me know if you know other fast-importers!)

- It supports both (darcs1 and darcs2) darcs repo formats.

- It supports incremental conversions.

More info on the homepage:

http://vmiklos.hu/project/darcs-fast-export/

Including a list of alternatives, where I try to compare them to
darcs-fast-export.

Any feedback or comment is appreciated.

I'm not on the bazaar and the mercurial list, so there please CC me.

Thanks.

--7w6n1xPQJploaIC9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkY5YkACgkQe81tAgORUJYH4wCfSUPneNWTPTcZiMNNoEa3yT0t
Fp8An3bH1C1OieJZAR9amFIbjiOQtqBw
=r1l0
-----END PGP SIGNATURE-----

--7w6n1xPQJploaIC9--

--===============8989743173931662555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
darcs-users mailing list
darcs-users@darcs.net
http://lists.osuosl.org/mailman/listinfo/darcs-users

--===============8989743173931662555==--
