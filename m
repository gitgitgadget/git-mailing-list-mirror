From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: single-word commit messages - Re: git-svn performance
Date: Sat, 25 Oct 2014 20:44:37 +0100
Message-ID: <1414266277.18652.YahooMailBasic@web172303.mail.ir2.yahoo.com>
References: <20141025060116.GA5629@dcvr.yhbt.net>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 21:44:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xi7GY-0001Xj-MY
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 21:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbaJYTol convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Oct 2014 15:44:41 -0400
Received: from nm14-vm1.bullet.mail.ir2.yahoo.com ([212.82.96.189]:34896 "EHLO
	nm14-vm1.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752457AbaJYTok convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2014 15:44:40 -0400
Received: from [212.82.98.59] by nm14.bullet.mail.ir2.yahoo.com with NNFMP; 25 Oct 2014 19:44:38 -0000
Received: from [212.82.98.94] by tm12.bullet.mail.ir2.yahoo.com with NNFMP; 25 Oct 2014 19:44:38 -0000
Received: from [127.0.0.1] by omp1031.mail.ir2.yahoo.com with NNFMP; 25 Oct 2014 19:44:38 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 198471.34257.bm@omp1031.mail.ir2.yahoo.com
Received: (qmail 45501 invoked by uid 60001); 25 Oct 2014 19:44:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414266278; bh=l8pr5s+nEYLmGoLnHPqENF/XwX034xkaPtXEsychwpU=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=5txSh2Kuvt2jqWvKPbQeTZhzS/N7ximQEB+MNobeKUPpgL9hrtZrrpzMuh+2UKRMVMx6ZdCaR9Hq/Cbr/D4JtoOr37rlyPYtoMTdWC32Xp5mU5eLdLMr+eS7BFApc4O0p2EHspd1N2qfGtNNukBb5qDhfJAv4k0CnUQGn2dSzqU=
X-YMail-OSG: KpOSpeMVM1lGvCStLufKcFTM5b2ZItVsWJ1iYZY_3tP8dxC
 ZYy39kcjub2jttIB5Xef2gmqdHw4PnAnGE4Fs2gbZ7X86f9OKoaJS92MyPdh
 IpmjlR1O69KZitJc7si.5ZZeqbY7fbxdK4qfyNxA38.WjfjpeYZ99t73YVzi
 3InKkTp9SlpkPVtztKLfx9j7ksTZMuYMh7ZbUVZf5_LJ_RrPmFyr6UZZUkq_
 Lrzn01x3dEh1UEbXleCHeckrREax3RkXHgv8gLpDDUhjeWh9ybO8IAEO2U3J
 bbvoDZR032iwoeRatvbT7kpzoszLi6BbtChP0ns6DoMO1se__1ASVqkJtdT7
 7mwSTIQ_jofsshHenSNKRjCEg9wLmf9nAy911Y6L_lCblDQTn5FRAu3bd8fc
 IjE_xrnikXlGrknAHd3hoUjxg7UtfAbMOwZ17NXLKpz3ZpcHfUl1opMSQGOn
 i3rmIILt5fUPViFG_eXqKl04Eu.lk9fc_pLByIT0LtGg0bb1hnG5HL.ktiIL
 biYv28Zb8bWYECF8ArWpXXeVdcLWba.eYFGlMj2jNEQcNPkrKBYLHiRo4FWB
 q6CVc9c2cq6MzcGHL2Fn_yLkTY21ed_FKQ0utc7hx3hZkXlvREoDof32z4W3
 VASSUOYB8CGkYr8cfV.YFnX28o9D0wjkk48eZ_em1ZZOyvDBm0EDRDpj2Gtb
 q8A--
Received: from [86.30.137.134] by web172303.mail.ir2.yahoo.com via HTTP; Sat, 25 Oct 2014 20:44:37 BST
X-Rocket-MIMEInfo: 002.001,DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KT24gU2F0LCAyNS8xMC8xNCwgRXJpYyBXb25nIDxub3JtYWxwZXJzb25AeWhidC5uZXQ.IHdyb3RlOg0KDQo.ICBQcm9iYWJseSBhbiBTVk4gaG9vayBwcmV2ZW50aW5nIGl0LsKgIGdpdC1zdm4NCiB0ZXN0IGNhc2VzIHN1Y2ggYXMNCiB0L3Q5MTE4LWdpdC1zdm4tZnVua3ktYnJhbmNoLW5hbWVzLnNoIGRvIHNpbmdsZQ0KIHdvcmQgY29tbWl0cy4NCiANClRoYW5rcyAtIEkgc2VlIGluZGVlZCAtIGF0IGxlYXN0IHRoYXQgY2wBMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/810 YahooMailWebService/0.8.203.733
In-Reply-To: <20141025060116.GA5629@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--------------------------------------------
On Sat, 25/10/14, Eric Wong <normalperson@yhbt.net> wrote:

>  Probably an SVN hook preventing it.=A0 git-svn
 test cases such as
 t/t9118-git-svn-funky-branch-names.sh do single
 word commits.
=20
Thanks - I see indeed - at least that clears that up.
