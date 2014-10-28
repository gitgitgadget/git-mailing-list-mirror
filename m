From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: differences between old clone and new  Re: git-svn performance
Date: Tue, 28 Oct 2014 23:59:02 +0000
Message-ID: <1414540742.41763.YahooMailBasic@web172305.mail.ir2.yahoo.com>
References: <20141028074104.GA7762@dcvr.yhbt.net>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 29 00:59:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjGfN-0000V7-Tz
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 00:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbaJ1X7F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Oct 2014 19:59:05 -0400
Received: from nm28-vm5.bullet.mail.ir2.yahoo.com ([212.82.97.65]:52053 "EHLO
	nm28-vm5.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750858AbaJ1X7E convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 19:59:04 -0400
Received: from [212.82.98.50] by nm28.bullet.mail.ir2.yahoo.com with NNFMP; 28 Oct 2014 23:59:02 -0000
Received: from [212.82.98.109] by tm3.bullet.mail.ir2.yahoo.com with NNFMP; 28 Oct 2014 23:59:02 -0000
Received: from [127.0.0.1] by omp1046.mail.ir2.yahoo.com with NNFMP; 28 Oct 2014 23:59:02 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 337548.88986.bm@omp1046.mail.ir2.yahoo.com
Received: (qmail 82645 invoked by uid 60001); 28 Oct 2014 23:59:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414540742; bh=Bq//bbXL0IAlk9nL4XC309cyzYZZf7RKgo5emKQMxpA=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=U8deQM1sOkVsDh7cd78oeFVGe+pQOUC1JBEVj0kTWqpdDkyXKSavMLfAzAlZrl86Ah4XyPOLpGpuhsXGt3y8gOSI3jBN6WsM47Nq5MM9KaSZ1KG0jkVMBQN+PphfJZclQzGI2OchDtHojVdNxnZSwuD0KndOqnger45LNGnOVso=
X-YMail-OSG: noxdJsgVM1m6F..6GBSkf.FNj6vk3OsL9SBUYw21x0i0gfg
 Ao33PlxwQc6RBWLFqh.kRKaBndginiIvag3.fUVLPXtnGByHiu455t2UMJB.
 Q7.Ezws_mabJW1mR.Vzfgfai0k4vSFkAga91lgY3KIGj2Znrnsl40447BtEx
 JLR7Jzqoqbh2Ydz_l4TPdZmosTwNVrxNCx66N.k0QhjFcHjXKw3glwL0K51B
 NQsBybzz5dE.C1NNb1Ft71Cq3bIQA6V08AjUm_Plmie452kQdei6ZMlYz0jf
 2XstoUNaLJBG8i7Y0PVHqLIqyfV61k_GY_UqLm8DWWU_eI0Jzh9pTslFDVym
 RU8UgOVqOKiqBCSB9z4QJWVqZ8VJoy2Z1cP.zBVNwDb0PSUEli2Q2wSLpk5w
 4dll4qV6zqjbp0LAbqshDbg_6qU53fv8wwz_h6AzrwLLvRmFlogLOd_EGEOe
 vP8fXjrF1UV949NALROOgSMDusO9yqi6mA9sJNJGrgtMq0Uz6dG1SCquJW.U
 Eiz.U_ZPtO41XsHEZ2Cx1_qDPuMlhOBDzX6hM3Zl77cq1289wQ2p0sZ9vkkZ
 cKMXTETH.t.abIrdoOi7l7vbUhfA_._pReLU61D4bi4VoXD5B1rmDDwdVkO6
 GrCAXvkXtdGF0bH4AfXoOXlxwmY7WLqCwyZlg6mmLd24kCQ0-
Received: from [86.30.137.134] by web172305.mail.ir2.yahoo.com via HTTP; Tue, 28 Oct 2014 23:59:02 GMT
X-Rocket-MIMEInfo: 002.001,T24gVHVlLCAyOC8xMC8xNCwgRXJpYyBXb25nIDxub3JtYWxwZXJzb25AeWhidC5uZXQ.IHdyb3RlOg0KDQo.IFNvIGJvdGggbWVyZ2VzDQogYXJlIGNvcnJlY3QsIGJ1dCB3ZSBsb3NlIG9uZSwgYW5kIGdhaW4gb25lPw0KIEknbGwgdHJ5IHRvIGNoZWNrIG1vcmUgY2xvc2VseSB0b21vcnJvdy7CoA0KIENhbiB5b3UgcG9pbnQgb3V0DQogdGhlIGV4YWN0IHJldmlzaW9ucyBpbiB0aGUNCiBSIHJlcG8_wqAgVGhhbmtzLg0KDQoNClRoZSBtaXNzaW5nIG1lcmdlIG9uIGJyYW5jaCAiUi0yLTE0LWJyYW5jaCIgaXMBMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/810 YahooMailWebService/0.8.203.733
In-Reply-To: <20141028074104.GA7762@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 28/10/14, Eric Wong <normalperson@yhbt.net> wrote:

> So both merges
 are correct, but we lose one, and gain one?
 I'll try to check more closely tomorrow.=A0
 Can you point out
 the exact revisions in the
 R repo?=A0 Thanks.


The missing merge on branch "R-2-14-branch" is:

commit 93af4d4cc3a5e0039944dd4e340d26995be8a252
Merge: 121990f 6ff1b87
Author: ripley <ripley@00db46b3-68df-0310-9c12-caf00c1e9a41>
Date:   Wed Feb 22 13:45:34 2012 +0000

    port r58453 from trunk

    git-svn-id: https://svn.r-project.org/R/branches/R-2-14-branch@5845=
4 00db46b3-68df-0310-9c12-caf00c1e9a41



121990f is R-2-14-branch@58449, 6ff1b87 is trunk@58453, but the two bra=
nches
are only identical  up to and including R-2-14-branch@57129  -=20
i.e. trunk@57130 appears in my old clone's  "R-2-14-branch" git log but=
 not in the new clone's.

The extra merge in the new clone is in branch "djm-parseRd":

commit 6d93330f7637eb4da81adaea58454c6b43da1c65
Merge: f503a9d 23deade
Author: murdoch <murdoch@00db46b3-68df-0310-9c12-caf00c1e9a41>
Date:   Thu Nov 13 14:24:17 2008 +0000

    Update from trunk to r46923
   =20
    git-svn-id: https://svn.r-project.org/R/branches/djm-parseRd@46925 =
00db46b3-68df-0310-9c12-caf00c1e9a41

You can look up f503a9d (djm-parseRd@46922) and 23deade (trunk@46923) y=
ourself.
The two branches' git log agree up to and including djm-parseRd@46659 .

Hmm, the new "djm-parseRd" branch actually have *two* extra merges,
the earlier extra is:

commit 1e8174c797ba8471d604e89e4d614ad969b93b72
Merge: 55a1d9b 72744ab
Author: murdoch <murdoch@00db46b3-68df-0310-9c12-caf00c1e9a41>
Date:   Tue Nov 11 21:17:06 2008 +0000

    Merge trunk changes to r46902
   =20
    git-svn-id: https://svn.r-project.org/R/branches/djm-parseRd@46906 =
00db46b3-68df-0310-9c12-caf00c1e9a41
