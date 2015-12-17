From: Alexander Skrinnik <askrinnik@amtoss.com.ua>
Subject: RE: CruiseControl.NET hangs on git-submodule bad file descriptor
Date: Thu, 17 Dec 2015 12:32:26 +0000
Message-ID: <HE1PR08MB089122D0784C67685EAF5A76F8E00@HE1PR08MB0891.eurprd08.prod.outlook.com>
References: <HE1PR08MB089107ED02BEA428A6BB37A5F8E00@HE1PR08MB0891.eurprd08.prod.outlook.com>
 <alpine.DEB.2.20.1512171045230.6483@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 17 13:32:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9XjZ-0002kJ-4j
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 13:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933305AbbLQMcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 07:32:32 -0500
Received: from mail-db3on0080.outbound.protection.outlook.com ([157.55.234.80]:44914
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755978AbbLQMcb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2015 07:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amtoss.onmicrosoft.com; s=selector1-amtoss-com-ua;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jHT1beQ/RqkxQ9JM/14OdW1RzGro9MnYelClBEGyHaE=;
 b=d9RVavqk+XkbZPLMnQC/k4jdYeEbsfs1HPtcQWgz/9bfqCMx5PbrLMNmesqcVPLsuLwAhvJ7p+jYqbTr6z52CcnkS58r7bF2HDVi2utJ2UNFpJDFbPfVuiJW1Ir7yocNXbVNFQY5MqP+yK7azMIg1edHFza0jRFXy/umJEFvXEc=
Received: from HE1PR08MB0891.eurprd08.prod.outlook.com (10.164.53.29) by
 HE1PR08MB0889.eurprd08.prod.outlook.com (10.164.53.27) with Microsoft SMTP
 Server (TLS) id 15.1.355.16; Thu, 17 Dec 2015 12:32:26 +0000
Received: from HE1PR08MB0891.eurprd08.prod.outlook.com ([10.164.53.29]) by
 HE1PR08MB0891.eurprd08.prod.outlook.com ([10.164.53.29]) with mapi id
 15.01.0355.012; Thu, 17 Dec 2015 12:32:26 +0000
Thread-Topic: CruiseControl.NET hangs on git-submodule bad file descriptor
Thread-Index: AdE4o1uEu2TGfefDQfCy4zvcOMHAYQADGDIAAAK4n8A=
In-Reply-To: <alpine.DEB.2.20.1512171045230.6483@virtualbox>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=askrinnik@amtoss.com.ua; 
x-originating-ip: [94.27.36.22]
x-microsoft-exchange-diagnostics: 1;HE1PR08MB0889;5:EJHBTOHY8YTG+l4Piph01su4lZZ7ibCjP2cc6296BBwR3s5bSfhSt3WC79a06FPUqUO4x0n1zL32P65vDkDd7GHMMKXxha0vSWMVJWxFKe4DezHzsxY2EPAcCrQRWqNDof0W2o1972hg+w7B7Ezrkw==;24:qVBTK5f3cvkDOaJaAC4YQthboVJ6klddGUosjAg0UZoKGRyiknbTaE5yugyf27G7gxLTeKLkUtfYnj0AwO5yt5NYBN2NrD6QH/VBMHu58IY=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB0889;
x-microsoft-antispam-prvs: <HE1PR08MB0889F7D1FFA4FC5C81FAC81CF8E00@HE1PR08MB0889.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(2401047)(520078)(5005006)(8121501046)(3002001)(10201501046);SRVR:HE1PR08MB0889;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB0889;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(199003)(189002)(5001960100002)(110136002)(74316001)(81156007)(97736004)(189998001)(5002640100001)(54356999)(105586002)(106356001)(33656002)(66066001)(76176999)(5003600100002)(50986999)(87936001)(86362001)(77096005)(10400500002)(11100500001)(74482002)(5008740100001)(1220700001)(19580405001)(2950100001)(15975445007)(2900100001)(76576001)(19580395003)(122556002)(3846002)(40100003)(6116002)(586003)(5004730100002)(1096002)(102836003)(92566002)(101416001)(7059030);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR08MB0889;H:HE1PR08MB0891.eurprd08.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: amtoss.com.ua does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
X-OriginatorOrg: amtoss.com.ua
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2015 12:32:26.1568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3a059e38-2ff1-46cc-b231-299d17307f39
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB0889
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282651>

Hi Johannes,

Thank you for your answer.
Yes, this is the same issue. I found workaround, CC.NET invokes bat-file with command:
git submodule foreach git checkout "myBranch" <NUL

It works fine. But looks like the issue is in git. Not in CC.NET :)
If you have a chance, could you look into it, please?

Thanks a lot
--
Alexander Skrinnik


-----Original Message-----
From: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de] 
Sent: Thursday, December 17, 2015 11:46 AM
To: Alexander Skrinnik
Cc: git@vger.kernel.org
Subject: Re: CruiseControl.NET hangs on git-submodule bad file descriptor

Hi Alexander,

On Thu, 17 Dec 2015, Alexander Skrinnik wrote:

> I had installed CruiseControl.NET 1.8.5 and Git-1.9.5-preview20150319 
> CC.NET invokes bat-file which invokes git submodule foreach git 
> checkout "myBranch"
> 
> It worked good.
> Today I upgraded git to 2.6.4 and CC.NET fails on this command with
> error: C:\Program Files
> (x86)\Git\mingw32/libexec/git-core\git-submodule: line 544: 0: Bad 
> file descriptor

This sounds very similar (maybe identical) to this bug report:

	https://github.com/git-for-windows/git/issues/181

Ciao,
Johannes
