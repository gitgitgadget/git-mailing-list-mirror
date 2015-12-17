From: Alexander Skrinnik <askrinnik@amtoss.com.ua>
Subject: RE: CruiseControl.NET hangs on git-submodule bad file descriptor
Date: Thu, 17 Dec 2015 14:07:11 +0000
Message-ID: <HE1PR08MB089115A3232C83713A4E3859F8E00@HE1PR08MB0891.eurprd08.prod.outlook.com>
References: <HE1PR08MB089107ED02BEA428A6BB37A5F8E00@HE1PR08MB0891.eurprd08.prod.outlook.com>
 <alpine.DEB.2.20.1512171045230.6483@virtualbox>
 <HE1PR08MB089122D0784C67685EAF5A76F8E00@HE1PR08MB0891.eurprd08.prod.outlook.com>
 <alpine.DEB.2.20.1512171453140.6483@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 17 15:07:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9ZDH-000700-D2
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 15:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934720AbbLQOHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 09:07:18 -0500
Received: from mail-db3on0094.outbound.protection.outlook.com ([157.55.234.94]:20400
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755996AbbLQOHR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2015 09:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amtoss.onmicrosoft.com; s=selector1-amtoss-com-ua;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WSRMIMpMiVu+sSTDMg1ZXl1Mi77+3jcNGcNRRUhpbv0=;
 b=EEQ8CsEV1MzzATA/my53zoynCuy7Bo17H+KBnohNDWBPNZZObscOpXPoVgsoXhxLz1Mx2bQ3fdQ5Fxd+qr69ZhXrLlNc87IY+zCS1pLTK+wMg93LdzYTzgb+VCH4Uh6nV+9zH0AausGjVt0DBgnfyEITWr0moMXlaGjTkRYu6SU=
Received: from HE1PR08MB0891.eurprd08.prod.outlook.com (10.164.53.29) by
 HE1PR08MB0890.eurprd08.prod.outlook.com (10.164.53.28) with Microsoft SMTP
 Server (TLS) id 15.1.355.16; Thu, 17 Dec 2015 14:07:12 +0000
Received: from HE1PR08MB0891.eurprd08.prod.outlook.com ([10.164.53.29]) by
 HE1PR08MB0891.eurprd08.prod.outlook.com ([10.164.53.29]) with mapi id
 15.01.0355.012; Thu, 17 Dec 2015 14:07:12 +0000
Thread-Topic: CruiseControl.NET hangs on git-submodule bad file descriptor
Thread-Index: AdE4o1uEu2TGfefDQfCy4zvcOMHAYQADGDIAAAK4n8AABflQAAAAZm1Q
In-Reply-To: <alpine.DEB.2.20.1512171453140.6483@virtualbox>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=askrinnik@amtoss.com.ua; 
x-originating-ip: [94.27.36.22]
x-microsoft-exchange-diagnostics: 1;HE1PR08MB0890;5:h5a3S0TqXuTAd+v1npiT/neX37riOEVXvOYOuZU0vrjSrXgDDXvvGdP2GDdFU1auV5rTSz/OTnM/DiLSAuO6c0RE6mo7HGiqzJDEm9dNQ+B0Rr8rWSRRVGmg4tAAsPFBtYg8mE9jwyZe1Zp4c/X+7w==;24:/YXQEDJcrRWbZEiVgATwUnFh4y3lbE0P4QWgLbQf1pTsWote99do71XxxOiLzyaKj+qPyeIeYxn/XzfF6mfVxeRYUYKMQOr1wzKACidk5qM=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB0890;
x-microsoft-antispam-prvs: <HE1PR08MB08900950179C8EF3288A0A9DF8E00@HE1PR08MB0890.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(2401047)(520078)(5005006)(8121501046)(3002001)(10201501046);SRVR:HE1PR08MB0890;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB0890;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(377454003)(199003)(189002)(24454002)(13464003)(66066001)(33656002)(11100500001)(5001960100002)(2950100001)(105586002)(2900100001)(1220700001)(1096002)(106356001)(92566002)(19580395003)(5008740100001)(5004730100002)(86362001)(102836003)(6116002)(586003)(74482002)(87936001)(110136002)(5002640100001)(189998001)(10400500002)(81156007)(5003600100002)(97736004)(3846002)(19580405001)(101416001)(93886004)(122556002)(40100003)(77096005)(50986999)(74316001)(76176999)(76576001)(54356999)(7059030);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR08MB0890;H:HE1PR08MB0891.eurprd08.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: amtoss.com.ua does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
X-OriginatorOrg: amtoss.com.ua
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2015 14:07:11.9935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3a059e38-2ff1-46cc-b231-299d17307f39
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB0890
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282654>

OK, no problem 
I have workaround :)

Thanks a lot for your help

Best wishes
--
Alexander Skrinnik


-----Original Message-----
From: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de] 
Sent: Thursday, December 17, 2015 3:55 PM
To: Alexander Skrinnik
Cc: git@vger.kernel.org
Subject: RE: CruiseControl.NET hangs on git-submodule bad file descriptor

Hi Alexander,

you might want to refrain from top-posting on this list in the future.
Just sayin' ;-)

On Thu, 17 Dec 2015, Alexander Skrinnik wrote:

> I found workaround, CC.NET invokes bat-file with command:
> git submodule foreach git checkout "myBranch" <NUL
> 
> It works fine. But looks like the issue is in git. Not in CC.NET :) If 
> you have a chance, could you look into it, please?

Unfortunately, this is one of those problems where the bug reporter expects me not only to fix the problem, but also to come up with an easy way to reproduce the issue.

And even more unfortunate is the fact that I am really pressed on some other, more critical issues.

Is there really no chance for you to have a crack at resolving this issue?

Ciao,
Johannes
