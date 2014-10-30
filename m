From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: Regression and failure to clone/fetch with new code Re: git-svn performance
Date: Thu, 30 Oct 2014 00:06:10 +0000
Message-ID: <1414627570.41692.YahooMailBasic@web172306.mail.ir2.yahoo.com>
References: <20141029192352.GA32032@dcvr.yhbt.net>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 01:06:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjdFp-0002Pa-LU
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 01:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757587AbaJ3AGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2014 20:06:13 -0400
Received: from nm32.bullet.mail.ir2.yahoo.com ([212.82.96.57]:56269 "EHLO
	nm32.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755251AbaJ3AGM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 20:06:12 -0400
Received: from [212.82.98.57] by nm32.bullet.mail.ir2.yahoo.com with NNFMP; 30 Oct 2014 00:06:11 -0000
Received: from [212.82.98.64] by tm10.bullet.mail.ir2.yahoo.com with NNFMP; 30 Oct 2014 00:06:11 -0000
Received: from [127.0.0.1] by omp1001.mail.ir2.yahoo.com with NNFMP; 30 Oct 2014 00:06:11 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 115218.73892.bm@omp1001.mail.ir2.yahoo.com
Received: (qmail 49912 invoked by uid 60001); 30 Oct 2014 00:06:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414627571; bh=5CekxiNBajKtxb/bEhoVRJ4bNpus6a75gGCEk6SlO6s=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=rA3cjwrPRTPJi5O1HKMOm6vBeDOXSGFl3x2b1Lv0+fMJg0Yj77wZ23s55XT9poww4p4YRn6UptBg9e51ox0lrJlTWL7quabFJdBL++2/aiCiCy/tZOawmCiMuVZHCUEZxb9rhyUjZ34GRxHWYuoMClKJ/Fs3N8qK1oJLT4jQoXA=
X-YMail-OSG: VirZdTsVM1kyYVCqCUT2pNvgW70WJesF4YUZhZMG9IkaX99
 CyS2qdIbDSbB3auwLAOEk4JhJFSP.EnlUbpUb7HmgXIdo.nnzAeQWy_ql7zt
 e5W0o5hWNfQs9zSYH0rZmAd5DbWSgqeKTdlDots53EsRT5MNWrBDR7YBl3aH
 59cp5tx8NbPeKguXGSvoxFbb3vqnuq8NkTut8wYp7PJZB.nXeMkxTDcPhilu
 U8v3t330mgdr2NrRU2wyY6zjKPDorhBdgNxbGLjmcJ76Sbuscycv2YP6Gpt4
 zhc9PbrqKQIbLXYaVPrpf_1O78i7ZiljF_gPiDng_K5M76QmOPBPqtOWEw7A
 TIMlJD2memVRcJeqTah0HGmHoD.1vDJGSJ2SLSEi.8Wz0j5VIx3zGdHDZhMn
 1shChD9ZVe4vUzunBgRY7LoYHcp58VDm6AvzyTFfog6PiUD716sbbOXkvFGK
 7bOvUXK95KaiXMM1eKF41MhaE6R_VyhT22vgLjnn9vNeLL1z3ncuzPlgztP.
 GvUls0dOwqdHFRlYfOJ.siU8smfOwqkFqxWD5xkTmaGAsodxLUzm7.vrUaQc
 TMnOto7.LNSXjwoWxHJfL7iksuEyVVjNrq5EJ8YgSInZnfW73Rh9NMLjibgm
 05l_vdcRL6hSUyudOAzc2h91_WuMNjd5AiIWyqB.YZl22626RlJD0dvl95B3
 M
Received: from [86.30.137.134] by web172306.mail.ir2.yahoo.com via HTTP; Thu, 30 Oct 2014 00:06:10 GMT
X-Rocket-MIMEInfo: 002.001,QXJnaCwgc29ycnkuIEkgdGhvdWdodCBJIGluY2x1ZGVkIHRoZSBpbmZvIGJ1dCBJIGRpZG4ndC4NCg0KZ2l0IDIuMS4wICsgMTAgcGF0Y2hlcyBhYm9ydHMgYWZ0ZXIgdHJ1bmtAMjg5MjMgKGkuZS4gZmFpbGluZyB0byBmZXRjaCAyODkyNCk7DQppZiBJIHJldmVydCB0aGUgcGF0Y2hlcyBpbiB0aGF0IG9yZGVyICgjNSwjNCwjMiwgIzEpIGFuZCByZXRyeSBpbiB0aGUgbWlkZGxlLA0KSSBoYXZlIHRvIHJldmVydCBhbGwgNCB0byBnZXQgJ2dpdCBzdm4gZmV0Y2gnIHRvIGNvbnRpbnVlIG9uIHRvIDI4OTI0Lg0BMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/810 YahooMailWebService/0.8.203.733
In-Reply-To: <20141029192352.GA32032@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Argh, sorry. I thought I included the info but I didn't.

git 2.1.0 + 10 patches aborts after trunk@28923 (i.e. failing to fetch =
28924);
if I revert the patches in that order (#5,#4,#2, #1) and retry in the m=
iddle,
I have to revert all 4 to get 'git svn fetch' to continue on to 28924.

I tried --stdlayout (it seems that there were branches, but just merged=
 and "deleted"
according to the web code browsing interface) but it failed at the same=
 revision.

I'll try the data dump and see what it gives me...

What do you think were missing in my e-mails? The differences of new cl=
one against old
is a missing merge in at R-2-14-branch@58454 , and two extra merges at
djm-parseRd@46925  and djm-parseRd@46906 .

--------------------------------------------
On Wed, 29/10/14, Eric Wong <normalperson@yhbt.net> wrote:

 Subject: Re: Regression and failure to clone/fetch with new code Re: g=
it-svn performance
 To: "Hin-Tak Leung" <htl10@users.sourceforge.net>
 Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org, sa=
m@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de, amyrick@ap=
ple.com
 Date: Wednesday, 29 October, 2014, 20:23
=20
 Hin-Tak Leung <htl10@users.sourceforge.net>
 wrote:
 > Hi, I patched my system git with
 the recent git-svn improvements, and just use
 > it for general use; so theses are the
 patches, against 2.1.0.
 >=20
 >
 0001-git-svn-only-look-at-the-new-parts-of-svn-mergeinfo.patch
 >
 0002-git-svn-only-look-at-the-root-path-for-svn-mergeinfo.patch
 >
 0003-git-svn-reduce-check_cherry_pick-cache-overhead.patch
 >
 0004-git-svn-cache-only-mergeinfo-revisions.patch
 >
 0005-git-svn-remove-mergeinfo-rev-caching.patch
 >
 0006-git-svn.txt-advertise-pushurl-with-dcommit.patch
 >
 0007-git-svn-reload-RA-every-log-window-size.patch
 >
 0008-git-svn-remove-unnecessary-DESTROY-override.patch
 >
 0009-git-svn-save-a-little-memory-as-fetch-progresses.patch
 >
 0010-git-svn-disable-_rev_list-memoization.patch
 >=20
 > trying to do
 this:
 > git svn clone http://www.virtualbox.org/svn/vbox/trunk
 vbox
 >=20
 > (there
 is no publicly visible branches, so it is just a
 straight-forward single-branch clone).
 >
=20
 > aborts with=20
 >=20
 > ---------------
 >
 =A0=A0=A0 M=A0=A0=A0 src/VBox/Main/HostImpl.cpp
 > Incorrect parameters given: Could not
 convert '%ld' into a number at
 /usr/share/perl5/vendor_perl/Git/SVN.pm line 1711.
 >=20
 > $ git svn fetch
 --all
 > Index mismatch:
 d6c75bc195b1daad647322e2cc025bd31265c6b9 !=3D
 3927d05f6ab037fcf2b4d964c9633efade037d1b
 > rereading
 a65b5fc0077c2fa80a344833b65ac19ff4ae88b6
 > =A0=A0=A0 M=A0=A0=A0
 src/VBox/Main/HostImpl.cpp
 > Incorrect
 parameters given: Could not convert '%ld' into a
 number at /usr/share/perl5/vendor_perl/Git/SVN.pm line
 1711.
 > ----------------
 >=20
 > I have never seen
 such behavior before, and seeing as the lines indicated are
 in
 > a routine called
 "mergeinfo_changes", and recently added/changed
 by
 > quite a few of the patches, I
 started reverting from the back in this order: #5, #4, #2,
 #1=20
 > and tried again between each
 revert. And it finally allows me to fetch again after
 > reverting #1.
=20
 Me neither, this is new bug to me.=A0 I cannot
 reproduce it, either.=A0 Which
 revision did
 you hit this on?=A0 I completed your vbox trunk clone
 without
 any problems on my side (Debian
 i386, SVN 1.6.17).
=20
 Can you
 try the following to dump out the parameters passed to
 mergeinfo_changes?
=20
 --- a/perl/Git/SVN.pm
 +++
 b/perl/Git/SVN.pm
 @@ -1695,8 +1695,10 @@ sub
 parents_exclude {
  }
 =20
  # Compute what's new in svn:mergeinfo.
 +use Data::Dumper;
  sub
 mergeinfo_changes {
  =A0=A0=A0 my ($self,
 $old_path, $old_rev, $path, $rev, $mergeinfo_prop) =3D @_;
 +=A0=A0=A0 print STDERR Dumper(\@_);
  =A0=A0=A0 my %minfo =3D map {split ":",
 $_ } split "\n", $mergeinfo_prop;
=20
 =A0=A0=A0 my $old_minfo =3D {};
 =20
=20
 Btw, I missed part of your
 other email, but no, I never maintained any
 Chinese packages in Debian.
=20
 > I don't see any %ld close by, but
 presumably this is enough information for somebody else
 > to try. The platform is linux x86_64.
 (mostly fedora 20 but with a lot of additional
 > changes like a newer gnome than shipped,
 etc so probably not really fc20)=20
 >=20
=20
