From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: Anomaly with the new code - Re: git-svn performance
Date: Mon, 27 Oct 2014 23:08:58 +0000
Message-ID: <1414451338.51943.YahooMailBasic@web172303.mail.ir2.yahoo.com>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Tue Oct 28 00:09:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XitPO-000214-Lx
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 00:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbaJ0XJB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 19:09:01 -0400
Received: from nm29-vm6.bullet.mail.ir2.yahoo.com ([212.82.97.75]:56235 "EHLO
	nm29-vm6.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751849AbaJ0XJA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 19:09:00 -0400
Received: from [212.82.98.125] by nm29.bullet.mail.ir2.yahoo.com with NNFMP; 27 Oct 2014 23:08:58 -0000
Received: from [212.82.98.96] by tm18.bullet.mail.ir2.yahoo.com with NNFMP; 27 Oct 2014 23:08:58 -0000
Received: from [127.0.0.1] by omp1033.mail.ir2.yahoo.com with NNFMP; 27 Oct 2014 23:08:58 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 777485.7342.bm@omp1033.mail.ir2.yahoo.com
Received: (qmail 7603 invoked by uid 60001); 27 Oct 2014 23:08:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414451338; bh=5EUSL8XVDPvvg2UMF6HNasXO7HpKn9kOvTPzdH/O/EM=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=TcjAMAdC7jICSn9+jxudDGTMUg0qsDVbZ9bA/j2vjzUs075psEv+lneaTnZKXzQegPf1cUu9asPWZnQInUzjxfNzlHRSCAKMm3OgVVK/s/d77aLJs6FhFrfvn2g3skl9D2wS2Mqlt2EnZzqlYJHw+b3sckg7/+8wsfQN+I7Py1Y=
X-YMail-OSG: I1.b.CoVM1lkUwk5G5NDq7OzzI59O20ohzgGhbMyu_g0Fch
 ro4W8Bpz5KNWzz3wMn5sZ2tH7vUOV.Ed4ffLJDJO5DLnb4kE0BI7WPgTutVV
 kRkJ_3CbZbYYr32NeZLhq6GWuM26xLbK5jidc.6QbJI2VAooAWwFG87g3pJS
 BoUDs0KOiaUjmc3xkyemv2M_mJ_4RY4GCOfm1DSo4eSlCZ7AsrmkVsG.S3ZY
 YpL7NZBfldkVYRoS5L4Es8dt_Y2H8lpTaASMtN5OzVVGFLQ9tQiKM.4I99oA
 vd0kYsXdzYLZem7qDXkRfj7HyOJmLCAmOwgaXzp_jIsLWmd9PVfNa7MAx1Xn
 l9tELAzRyv1I..g7IWebSkVinCdgyK5Fti8FmpfByqJBMWPRKva8buWu0cLK
 .ssNyIK0lrpfkzSBr0xT5TcotsdJQblI1s_gnjAfCikqdmqJTNdSkARTEAH3
 aq111UkhmjNEvZzrU1.bXMyCHLbY6jJhMzVmaWTeKIkHc5CuJCdQicISLohK
 GCqexu0ct5sFDvYUfVRA8EkWRT5RTjeFh_zrEMpWyLPwR.n3vVWpN3wc3IfU
 vZuIE.HrYFAxbYf612D_3mEi4B2RSCwScbHCOBMethlph_1wCyYS0KevQv4I
 p9CDzsbzRUBLVUoKRDLpaYah6_jb30jTDAdibM6uMLo5hXSjdm041.T52b8N
 zKN4KuUHCnW3ysHZS1ynwXR6R8OB4ubhxJLTDCcUU
Received: from [86.30.137.134] by web172303.mail.ir2.yahoo.com via HTTP; Mon, 27 Oct 2014 23:08:58 GMT
X-Rocket-MIMEInfo: 002.001,LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpPbiBNb24sIE9jdCAyNywgMjAxNCAwNjozOCBHTVQgRXJpYyBXb25nIHdyb3RlOg0KDQo.V2hpY2ggU1ZOIHZlcnNpb24gYXJlIHlvdSB1c2luZz_CoCBJJ20gY2xvbmluZyAoY3VycmVudGx5IG9uIHIzNzN4eCkNCj5odHRwczovL3N2bi5yLXByb2plY3Qub3JnL1IgdXNpbmcgLS1zdGRsYXlvdXQgYW5kDQo.dW5hYmxlIHRvIHNlZSBtZW1vcnkgZ3Jvd3RoIG9mIHRoZSBnaXQtc3ZuIFBlcmwgcHJvY2VzcyBiZXlvbmQgNDBNDQo.KG9uIGEgMzItYml0IHMBMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/810 YahooMailWebService/0.8.203.733
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

------------------------------
On Mon, Oct 27, 2014 06:38 GMT Eric Wong wrote:

>Which SVN version are you using?=A0 I'm cloning (currently on r373xx)
>https://svn.r-project.org/R using --stdlayout and
>unable to see memory growth of the git-svn Perl process beyond 40M
>(on a 32-bit system).
>
>I also tried http:// (not https), svn+ssh:// on my local (64-bit) syst=
em
>and did not see memory growth, either:
>
>=A0=A0=A0 http://mid.gmane.org/20141027014033.GA4189@dcvr.yhbt.net
>
>I'm using svn 1.6.17 on Debian stable in all cases.

The memory consumption does seem to go up a good deal after r48xxx -ish=
 (the total
being about 67xxx-ish now), when there are a fair number of branches. S=
eeing as
you seem to be able to make the memory consumption drops further,
I'll rebuild git with dropping/adding those patches now.

I also just realised "/usr/bin/time -v git svn fetch --all" also includ=
es the periodic auto-
garbage collection from git itself if fetching more than a number of co=
mmits,
so may not be accurate once git svn's memory consumption drops below
a certain level. Is there any way of coping with that?

I made a 3rd clone yesterday - it took 8 hours 15 minutes, and=20
	Command being timed: "git svn fetch --all"
	User time (seconds): 6897.80
	System time (seconds): 18853.08
	Percent of CPU this job got: 86%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 8:14:00
=2E..
	Maximum resident set size (kbytes): 675436

and fetching the next 8 commits:

$ /usr/bin/time -v git svn fetch --all
	M	doc/NEWS.Rd
r66871 =3D 0a7f50fc04dee174229513a0d80fecfcd12975ca (refs/remotes/trunk=
)
=2E..
	M	doc/manual/R-exts.texi
r66879 =3D ede68f65df714c3ba283579d85105393c1eccc80 (refs/remotes/trunk=
)
Auto packing the repository in background for optimum performance.
See "git help gc" for manual housekeeping.
	Command being timed: "git svn fetch --all"
	User time (seconds): 856.82
	System time (seconds): 29.78
	Percent of CPU this job got: 98%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 15:03.39
=2E..
	Maximum resident set size (kbytes): 791088

and quite similar against the 2nd clone, but against the first clone (w=
hich were created
by fetching every few days over a few years):

	Command being timed: "git svn fetch --all"
	User time (seconds): 518.00
	System time (seconds): 28.62
	Percent of CPU this job got: 98%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 9:16.84
=2E..
	Maximum resident set size (kbytes): 403160

So it seems the first clone is rather different from the recent ones. I=
 haven't got round to compare
the branches yet - it is actually easier than I thought, since I only n=
eed to compare
the branch HEADs. (I already mentioned that trunk is different, due to =
a blank vs 3 word
commit message about 2 years ago - I reckon I might see similar issues =
in the other branches
- I'll go and write a script to check that now).

All recent fetch were done with git 2.1.0 patched with the 6 patches I =
mentioned, on fedora 20
x86_64.

BTW, I have been meaning to ask - are you the same "Eric Wong" who main=
tained
some chinese packages on Debian some years ago? :-)
