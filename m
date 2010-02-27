From: Reinier Lamers <tux_rocker@reinier.de>
Subject: ANNOUNCE: darcs 2.4
Date: Sat, 27 Feb 2010 13:17:44 +0100
Message-ID: <201002271317.55681.tux_rocker@reinier.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5790135786107631935=="
To: "darcs-users@darcs.net" <darcs-users@darcs.net>, haskell@haskell.org,
	bazaar@lists.canonical.com, git@vger.kernel.org
X-From: darcs-users-bounces@darcs.net Sat Feb 27 13:18:07 2010
Return-path: <darcs-users-bounces@darcs.net>
Envelope-to: gcvdu-darcs-users@gmane.org
Received: from whitealder.osuosl.org ([140.211.166.138])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <darcs-users-bounces@darcs.net>)
	id 1NlLcU-0001sd-Vd
	for gcvdu-darcs-users@gmane.org; Sat, 27 Feb 2010 13:18:07 +0100
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A38BB1C829B;
	Sat, 27 Feb 2010 12:18:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 22JYUlwYyN5D; Sat, 27 Feb 2010 12:18:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by whitealder.osuosl.org (Postfix) with ESMTP id 88E8F1C819D;
	Sat, 27 Feb 2010 12:18:01 +0000 (UTC)
X-Original-To: darcs-users@lists.darcs.net
Delivered-To: darcs-users@osuosl.org
Received: from hemlock.osuosl.org (hemlock.osuosl.org [140.211.166.133])
	by ash.osuosl.org (Postfix) with ESMTP id 6ACB38FAFD
	for <darcs-users@lists.darcs.net>; Sat, 27 Feb 2010 12:18:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 644B3A01A4
	for <darcs-users@lists.darcs.net>; Sat, 27 Feb 2010 12:18:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rqGBu4LslAFd for <darcs-users@lists.darcs.net>;
	Sat, 27 Feb 2010 12:17:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ew0-f225.google.com (mail-ew0-f225.google.com
	[209.85.219.225])
	by hemlock.osuosl.org (Postfix) with ESMTP id F3211A017A
	for <darcs-users@darcs.net>; Sat, 27 Feb 2010 12:17:58 +0000 (UTC)
Received: by ewy25 with SMTP id 25so548063ewy.19
	for <darcs-users@darcs.net>; Sat, 27 Feb 2010 04:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:sender:from:to:subject:date
	:user-agent:mime-version:content-type:content-transfer-encoding
	:message-id; bh=NcTUV/JQz9KyahNGAJf2YsR5PCyyl2a82zNv2LJ5EQc=;
	b=ee4vztPVy1iTgoSlSwdnZeQwomtP4iPv3RmlGoc31GkNkS7gu3vVtYpn2k8xCFV3Kt
	YoqhKthQbb2AFjvCmxV5aGE01ZGD/V0gytrTeuDPI3zDt3xReuR7tEs52ZDpHHBHTk65
	hkKeg65DJ3O00FusemPz8WgSqSZbznN6SlGMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=sender:from:to:subject:date:user-agent:mime-version:content-type
	:content-transfer-encoding:message-id;
	b=l+orMZCtAGim4MwM4chICmDVVJaKDdhq+8WRr9kr3RUa3123Wy3H0i4f4fBqruEmGb
	Onu++g/L6Cxg0DdXWiSNIqDpeS0bu16po1nKpJr/fcvb48rSQTbOnIsiyGFkT5iXm5Eh
	Nor5pRjNYgo47AnY1sYScPo+5jijNviiDwMVw=
Received: by 10.213.98.138 with SMTP id q10mr872986ebn.38.1267273077699;
	Sat, 27 Feb 2010 04:17:57 -0800 (PST)
Received: from adim.localnet (ip4da4654f.direct-adsl.nl [77.164.101.79])
	by mx.google.com with ESMTPS id 28sm4806089eye.5.2010.02.27.04.17.56
	(version=SSLv3 cipher=RC4-MD5); Sat, 27 Feb 2010 04:17:57 -0800 (PST)
User-Agent: KMail/1.12.4 (Linux/2.6.31-17-generic; KDE/4.3.5; x86_64; ; )
X-BeenThere: darcs-users@darcs.net
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: A list for users of darcs <darcs-users.darcs.net>
List-Unsubscribe: <http://lists.osuosl.org/mailman/options/darcs-users>,
	<mailto:darcs-users-request@darcs.net?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/darcs-users>
List-Post: <mailto:darcs-users@darcs.net>
List-Help: <mailto:darcs-users-request@darcs.net?subject=help>
List-Subscribe: <http://lists.osuosl.org/mailman/listinfo/darcs-users>,
	<mailto:darcs-users-request@darcs.net?subject=subscribe>
Sender: darcs-users-bounces@darcs.net
Errors-To: darcs-users-bounces@darcs.net
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141197>

--===============5790135786107631935==
Content-Type: multipart/signed; boundary="nextPart1585039.ynu7Lh21ie";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1585039.ynu7Lh21ie
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

The darcs team is proud to announce the immediate availability of darcs 2.4=
=2E=20
darcs 2.4 contains many improvements and bugfixes compared to darcs 2.3.1.=
=20
Highlights are the faster operation of record, revert and related commands,=
=20
and the experimental interactive hunk editing. This makes darcs 2.4 the lat=
est=20
and greatest in easy version control.

The easiest way to install darcs is using the Haskell Platform [1]. If you=
=20
have installed the Haskell Platform or cabal-install, you can install this=
=20
beta release by doing:

  $ cabal update
  $ cabal install --reinstall darcs

Alternatively, you can download the tarball from=20
http://darcs.net/releases/darcs-2.4.tar.gz , and build it by hand as=20
explained in the README file.

Interactive hunk editing
=2D-----------------------

To try out interactive hunk editing, press 'e' when you are prompted with a=
=20
hunk patch by 'darcs record'. You will then be shown an editor screen in wh=
ich=20
you can edit the state you want to record between the last two ruler lines.

You can find more information about the hunk editing feature on=20
http://wiki.darcs.net/HunkEditor .

What's New
=2D---------

A list of important changes since 2.3.1 is as follows:
   * Use fast index-based diffing everywhere (Petr)
   * Interactive patch splitting (Ganesh)
   * An 'optimize --upgrade' option to convert  to hashed format in-place
     (Eric)
   * Hunk matching (Kamil Dworakowski, tat.wright)
   * Progress reporting is no longer deceptive (Roman)
   * A 'remove --recursive' option to remove a directory tree from revision
     control (Roman)
   * 'show files' accepts arguments to show a subset of tracked files (Luca)
   * A '--remote-darcs' flag for pushing to a host where darcs isn't called
     darcs
   * Many miscellaneous Windows improvements (Salvatore, Petr and others)
   * 'darcs send' now mentions the repository name in the email body (Joach=
im)
   * Handle files with boring names in the repository correctly (Petr)
   * Fix parsing of .authorspellings file (Tom=C3=A1=C5=A1)
   * Various sane new command-line option names (Florent)
   * Remove the '--checkpoint' option (Petr)
   * Use external libraries for all UTF-8 handling (Eric, Reinier)
   * Use the Haskell zlib package exclusively for compression (Petr)

A list of issues resolved since 2.3.1:
   *  183: do not sort changes --summary output
   *  223: add --remote-darcs flag to specify name of remote darcs executab=
le
   *  291: provide (basic) interactive patch splitting
   *  540: darcs remove --recursive
   *  835: 'show files' with arguments
   * 1122: get --complete should not offer to create a lazy repository
   * 1216: list Match section in ToC
   * 1224: refuse to convert a repo that's already in darcs-2 format
   * 1300: logfile deleted on unsucessful record
   * 1308: push should warn about unpulled patches before patch-selection
   * 1336: sane error message on --last "" (empty string to numbers parser)
   * 1362: mention repo name in mail send body
   * 1377: getProgname for local darcs instances
   * 1392: use parsec to parse .authorspelling
   * 1424: darcs get wrongly reports "using lazy repository" if you ctrl-c=
=20
           old-fashioned get
   * 1447: different online help for send/apply --cc
   * 1488: fix crash in whatsnew when invoked in non-tracked directory
   * 1548: show contents requires at least one argument
   * 1554: allow opt-out of -threaded (fix ARM builds)
   * 1563: official thank-you page
   * 1578: don't put newlines in the Haskeline prompts
   * 1583: on darcs get, suggest upgrading source repo to hashed
   * 1584: provide optimize --upgrade command
   * 1588: add --skip-conflicts option
   * 1594: define PREPROCHTML in makefile
   * 1620: make amend leave a log file when it should
   * 1636: hunk matching
   * 1643: optimize --upgrade should do optimize
   * 1652: suggest cabal update before cabal install
   * 1659: make restrictBoring take recorded state into account
   * 1677: create correct hashes for empty directories in index
   * 1681: preserve log on amend failure
   * 1709: fix short version of progress reporting
   * 1712: correctly report number of patches to pull
   * 1720: fix cabal haddock problem
   * 1731: fix performance regression in check and repair
   * 1741: fix --list-options when option has multiple names
   * 1749: refuse to remove non-empty directories

Performance
=2D----------

darcs in its current form does not perform very well on huge repositories. =
In=20
order to systematically address this issue, and to catch performance=20
regressions, we have started a darcs benchmarking project. You can find=20
benchmarks of darcs performance in many different situations on=20
http://wiki.darcs.net/Benchmarks . On http://wiki.darcs.net/Benchmarks/Quas=
ar
you will find graphs of the benchmark results on a Windows Vista machine.

On that page, you will also find instructions on how to run your own darcs=
=20
benchmarks.

Reporting bugs
=2D-------------

If you have an issue with darcs 2.4, you can report it via the web on=20
http://bugs.darcs.net/ . You can also report bugs by email to bugs@darcs.ne=
t.


Kind Regards,
the darcs release manager,
Reinier Lamers

[1]: You can download the Haskell platform from
     http://hackage.haskell.org/platform/      =20

--nextPart1585039.ynu7Lh21ie
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkuJDWgACgkQR3bgBiWODBemrQCfWdc2dpAPBf5sci55cEG93tOd
zUcAnRQZVYsoFOXWYZZEq7WB7E+iJA9R
=bcTG
-----END PGP SIGNATURE-----

--nextPart1585039.ynu7Lh21ie--

--===============5790135786107631935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
darcs-users mailing list
darcs-users@darcs.net
http://lists.osuosl.org/mailman/listinfo/darcs-users

--===============5790135786107631935==--
