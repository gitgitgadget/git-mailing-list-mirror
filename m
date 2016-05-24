From: "Green, Paul" <Paul.Green@stratus.com>
Subject: Typo spotted in archive-tar.c
Date: Tue, 24 May 2016 00:44:24 +0000
Message-ID: <CO2PR0801MB599926424BC99D7DFC2622B8E4F0@CO2PR0801MB599.namprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 03:16:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b50xj-0003k1-0A
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 03:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbcEXBQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 21:16:42 -0400
Received: from mail-bn1bn0101.outbound.protection.outlook.com ([157.56.110.101]:48688
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751107AbcEXBQl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2016 21:16:41 -0400
X-Greylist: delayed 1030 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 May 2016 21:16:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=StratusTechnologies.onmicrosoft.com; s=selector1-stratus-com;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=11KIx8sXNpYdpmQlqnyuteiGpiss1P+2zLQ7GczC8OY=;
 b=ot2jkcT5PvvxHtvSO93Q45RxG64x6foIujvDc9Yi+jqK20hNp7OmaYtRtsgqGzYS3zZ344juGLKqhWmhNSfV9IaiLBTSDaXFG6oojVvFeU5rc/FcwUQp3DjJ37oWkC28hvKj00Lh6xBIyoioh3goc3+qarcOqD0PHWDEa806hqk=
Received: from CO2PR0801MB599.namprd08.prod.outlook.com (10.141.246.143) by
 CO2PR0801MB597.namprd08.prod.outlook.com (10.141.246.141) with Microsoft SMTP
 Server (TLS) id 15.1.506.2; Tue, 24 May 2016 00:44:25 +0000
Received: from CO2PR0801MB599.namprd08.prod.outlook.com ([10.141.246.143]) by
 CO2PR0801MB599.namprd08.prod.outlook.com ([10.141.246.143]) with mapi id
 15.01.0506.007; Tue, 24 May 2016 00:44:25 +0000
Thread-Topic: Typo spotted in archive-tar.c
Thread-Index: AdG1VWogaFBMo/QzQEWpoK+2VY1cdw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=stratus.com;
x-originating-ip: [198.97.42.5]
x-ms-office365-filtering-correlation-id: 4f8cc021-715e-4e54-5024-08d3836c8e42
x-microsoft-exchange-diagnostics: 1;CO2PR0801MB597;5:AMjjn7krTPd86fHHf1W9hVqG7wl9omyDSCzK7LXui10ljzOoKigB1pord8eeaG1VCSGKLKA0hdWh51atMC1+3jtimotwW92oEP4W4CLI50F3Z4qXE85xd41cnkfyzG9QdtKJm0x2j9fQsPxgnxxyhg==;24:VTACR6UgQ7o6dYPSiL7zBmQOaijXgxtVSiis2zkrn3dvqkD4x7fRKd5aBa7DIayRRxLqAgnGbP3ZJ/bMZkxCl92kTCVEjjzY+caBcQueefs=;7:SfQEjKhgCzLuD+HpBFbXh8EZi5V6uv/MUsKAlbYvcfeuLRXvNc0K0BboXOntvaMaoOTk39gUOCr3SW/w4WQ+JcsBaYPyx05TY16wlyvmBNThC2a77S33ZbLWY6VP7qs8Wo+JVuSU7hrOmnnsKwcQGMO1OJSMFHunJyeBk2QUR/a2Ow+XBxaEr2FFHyWE5Vgq;20:MEkJmJeBdBrZ1cbeXVYZE00OtL9kUcGoUvIEYsw1pgty4e6a8XM2ygCUMbhbr1ACYsTPx3BKTIxh1eh9Q6aa6wH0KpYba1HscyI7wFgzQEUa58FeNI05T7+Fe8jZPHAVoNspuRpmGf5oQMR3jyFGvh2yJWgB3gc+XOtXszaKlCA=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0801MB597;
x-microsoft-antispam-prvs: <CO2PR0801MB597D1DA7AEEFA53D44D63BE8E4F0@CO2PR0801MB597.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:CO2PR0801MB597;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0801MB597;
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(19580395003)(11100500001)(1220700001)(10400500002)(5004730100002)(5008740100001)(5002640100001)(102836003)(6116002)(1730700003)(2900100001)(8676002)(586003)(81166006)(15975445007)(5003600100002)(33656002)(8936002)(77096005)(122556002)(9686002)(74316001)(76576001)(99286002)(86362001)(66066001)(87936001)(107886002)(450100001)(2501003)(2351001)(229853001)(54356999)(50986999)(2906002)(92566002)(3660700001)(189998001)(3280700002)(110136002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR0801MB597;H:CO2PR0801MB599.namprd08.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
X-OriginatorOrg: stratus.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2016 00:44:24.7351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: de36b473-b8ad-46ff-837f-9da16b8d1b77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0801MB597
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295409>

While examining (relatively) recent changes to git, my eye happened to notice the following inconsistency on line 184 of the current version of archive-tar.c. 

-    sprintf(header->chksum, "%07o", ustar_header_chksum(header));
+    snprintf(header->chksum, sizeof(header->chksum), "%07o", ustar_header_chksum(header));

I believe the author meant to invoke the xsnprintf function, not the snprintf function. I say this because all of the other references to sprintf were indeed changed to xsnprintf, with the necessary additional 2nd argument.

This change was applied September 24, 2015 (commit f2f026752993054c1b712b6f4ae3ff167db38cbe). 

See https://github.com/git/git/commit/f2f026752993054c1b712b6f4ae3ff167db38cbe#diff-d18f7cb5411066ed8eda566b26d2570c  for the full set of related changes to archive-tar.c.

Thanks
PG
--
Sr. Technical Consultant, Stratus Technologies, Inc.
5 Mill and Main, Suite 500, Maynard, MA 01754
Office: +1 (978) 461-7557, FAX: +1 (978) 461-3610
