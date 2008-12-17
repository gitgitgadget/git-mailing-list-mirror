From: Gili Pearl <gili.pearl@yahoo.com>
Subject: Re: how to work in hirarchical git model?
Date: Wed, 17 Dec 2008 14:59:38 -0800 (PST)
Message-ID: <897592.56642.qm@web112219.mail.gq1.yahoo.com>
References: <703400.93370.qm@web112210.mail.gq1.yahoo.com> <4948AB14.8030004@viscovery.net> <753177.33978.qm@web112212.mail.gq1.yahoo.com> <200812170933.04080.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>
To: Johan Herland <johan@herland.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 00:09:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD5Vl-0001qW-04
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 00:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbYLQXHk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Dec 2008 18:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbYLQXHk
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 18:07:40 -0500
Received: from n6b.bullet.sp1.yahoo.com ([69.147.64.163]:43216 "HELO
	n6b.bullet.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752200AbYLQXHj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2008 18:07:39 -0500
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Dec 2008 18:07:39 EST
Received: from [69.147.84.144] by n6.bullet.sp1.yahoo.com with NNFMP; 17 Dec 2008 23:02:08 -0000
Received: from [209.73.164.86] by t6.bullet.mail.sp1.yahoo.com with NNFMP; 17 Dec 2008 23:02:08 -0000
Received: from [98.136.44.190] by t8.bullet.scd.yahoo.com with NNFMP; 17 Dec 2008 23:02:08 -0000
X-yahoo-newman-spamcop: yes
Received: from [216.252.122.219] by n65.bullet.mail.sp1.yahoo.com with NNFMP; 17 Dec 2008 22:59:39 -0000
Received: from [67.195.9.81] by t4.bullet.sp1.yahoo.com with NNFMP; 17 Dec 2008 22:59:39 -0000
Received: from [67.195.9.106] by t1.bullet.mail.gq1.yahoo.com with NNFMP; 17 Dec 2008 22:59:39 -0000
Received: from [127.0.0.1] by omp110.mail.gq1.yahoo.com with NNFMP; 17 Dec 2008 22:59:39 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 27185.66204.bm@omp110.mail.gq1.yahoo.com
Received: (qmail 67299 invoked by uid 60001); 17 Dec 2008 22:59:38 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=kRzGPIYWjeWs0yxLLyy//EzpSsYnhZbMAfMDCHXKsBJDUaDtGOQgxdp/LAKbKiu7Gwr6y3YVGVsMg5nMw/RPrNOfmMWZSHYWZEqEKAx6aEpoPlJzMQ/QBzfR7kMTKnbH3Vo3LyR9mz2qu0eD3B+G9PFAJZYMIs/1rvV0ZFzs7qE=;
X-YMail-OSG: kBYfGRAVM1k1tP3XczyJu8WRLcLJG8HLSLWG5bXUVgt1o0zSevf8uTEzmlAoCL7y2aRnSjAH.oE9b95sUPGJTGQgoHj9xWAL1iRLWQl_RaksD2JDK8fjDIQV9j886fmQ2j11kOChfZW8bQ2jr9bU7BLs79xk5XN2E_WetVXZfsEM7JWJqTvzhVqOsbf9y3E5iF1qavoP1mgFR4Ee1.tgf9p3P_igxnqzHoggBqDDtfWZCSwNvSkJp27Py23eX3lTfCHdkOJTtoIG.zRukHruy60-
Received: from [84.229.24.61] by web112219.mail.gq1.yahoo.com via HTTP; Wed, 17 Dec 2008 14:59:38 PST
X-Mailer: YahooMailRC/1155.45 YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103409>

> From: Johan Herland <johan@herland.net>
>=20
> On Wednesday 17 December 2008, Gili Pearl wrote:
> > ----- Original Message ----
> >
> > > From: Johannes Sixt=20
> > > Gili Pearl schrieb:
> > > > Here is one problem I saw when trying to work in the three-leve=
l
> > > > model. At some point, I had the following setup:
> > > >
> > > > top-level : A----B----C----D
> > > >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > > >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > > > mid-level1:=A0 =A0 =A0 =A0 K----L----M
> > > >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > > >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > > > low-level1:=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 X----Y
> > > >
> > > > The maintainer of mid-level1 has decided that commits K L M are=
 ready
> > > > to be merged into the top-level repo. So he rebased on top-leve=
l
> > > > before asking=A0'please pull', but after that the low-level was=
 not
> > > > able to rebase on the mid-level any more.
> > >
> > > In this model, the mid-level1 maintainer should *not* rebase agai=
nst
> > > top-level. Rather, he should ask the top-level maintainer to *mer=
ge*
> > > K-L-M.
> >
> > But what if K-L-M conflict with C-D? The one who should take care a=
bout
> > it is=A0 the mid-level1 maintainer (or possibly one of the low-leve=
l1
> > maintainers).
>=20
> If there is a merge conflict, mid-level1 maintainer will typically me=
rge D=20
> and M into a new merge commit N:
>=20
> top-level : A----B----C----D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 \=A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \=A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> mid-level1:=A0 =A0 K----L----M----N
>=20

There's one thing that still bothers me and I'd like to understand.=20
What if someone looks both on top-level repo and mid-level1 repo, and h=
e=20
want to=A0diff some local commit X against commit D. I didn't try it, b=
ut I=20
wonder how git knows against which=A0D to compare? On the top-level=A0D=
 means=20
A-B-C-D while on the mid-level1 C=A0means A-K-L-M-B-C-D (that is what g=
it-log=20
on mid-level shows). I'm probably missing something here... commit id=20
cannot represent two different histories, right?

> ...and then ask top-level maintainer to merge N (which should have no=
=20
> conflicts by now). The merge can also be done by low-level1 developer=
=2E
>=20


How can it be done by low-level1? you mean by bypassing mid-level and m=
erging=20
top-level directly?



     =20
