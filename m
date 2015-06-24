From: BGaudreault Brian <BGaudreault@edrnet.com>
Subject: Repository Code Scope (Plan Text)
Date: Wed, 24 Jun 2015 18:19:42 +0000
Message-ID: <BLUPR0701MB1969F347A7CA0ABBEE901242D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 24 20:19:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7pH4-0003vJ-RA
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 20:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbbFXSTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 14:19:46 -0400
Received: from mail-bn1on0092.outbound.protection.outlook.com ([157.56.110.92]:36797
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752620AbbFXSTp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jun 2015 14:19:45 -0400
X-Greylist: delayed 72890 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jun 2015 14:19:45 EDT
Received: from BLUPR0701MB1970.namprd07.prod.outlook.com (10.163.121.21) by
 BLUPR0701MB1025.namprd07.prod.outlook.com (10.160.35.17) with Microsoft SMTP
 Server (TLS) id 15.1.195.15; Wed, 24 Jun 2015 18:19:42 +0000
Received: from BLUPR0701MB1969.namprd07.prod.outlook.com (10.163.121.20) by
 BLUPR0701MB1970.namprd07.prod.outlook.com (10.163.121.21) with Microsoft SMTP
 Server (TLS) id 15.1.195.15; Wed, 24 Jun 2015 18:19:42 +0000
Received: from BLUPR0701MB1969.namprd07.prod.outlook.com ([10.163.121.20]) by
 BLUPR0701MB1969.namprd07.prod.outlook.com ([10.163.121.20]) with mapi id
 15.01.0195.005; Wed, 24 Jun 2015 18:19:42 +0000
Thread-Topic: Repository Code Scope (Plan Text)
Thread-Index: AdCuqiWXW3q4b8KeRjqM4Al8UTgx2A==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;
x-originating-ip: [12.188.185.200]
x-microsoft-exchange-diagnostics: 1;BLUPR0701MB1970;5:lm09dGTCb99hI4ey1tpyg8e+g+dmufVFW5XlmT87VeDEnA2lfIFlYLCaj+Z7IKtYoAu71visRnn5IhJU5eqLITFaNZMlg2mIbNud0r65yMWrcNvbc7UOUkRH0pBE/ITyiQ9MNSz20EPCL4sI5QPRMg==;24:yt8YKulNbFQpJN9mYaxd35xbjGdi6A4xjIRZkMY81sDzlL5IxWci9TfFMrVNR/KU/TQ7ZKEZRV2H6rkwU/UsatmIH6Cc5jS8D4szjsx2+tU=;20:0IGoVpphjvtXiPEgL5PI96RMs6WKRgDhxORgsNVbdo8bWlvxnqCg+fEj3ZeS6QfyruKXsDE8iB3MXCkkG5qk5g==
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1970;UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1025;
x-microsoft-antispam-prvs: <BLUPR0701MB1970EA871AF2A33E521C38A7D7AF0@BLUPR0701MB1970.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BLUPR0701MB1970;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1970;
x-forefront-prvs: 061725F016
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(164054003)(74316001)(229853001)(2351001)(40100003)(558084003)(54356999)(66066001)(102836002)(87936001)(86362001)(33656002)(92566002)(2656002)(99286002)(189998001)(5002640100001)(450100001)(110136002)(62966003)(5001960100002)(77156002)(107886002)(76576001)(46102003)(80792005)(122556002)(5001920100001)(2900100001)(50986999)(2501003)(77096005)(5003600100002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1970;H:BLUPR0701MB1969.namprd07.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2015 18:19:42.0600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5294837-2991-446b-82ba-9a6e606fbfae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1970
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1025;2:8jgDTXCM9p5k82jjZHfQCEJagEMq6cxEjDzkpfj56y/g+6J2x+HX0j1yGtCppfnb;3:+P/g0SdPZ/XT1Cydrj+d15OlRX+eDPnAb8f46RKp4VkYhLcshpshW2hoPLLVIEqVI/+gC5YZCYdcH5kBaMHSbmoKt9+647fXWxzTsAxyoOU/JHMbkcDx4tU3Lk8PJ+u8yG6V1/lkUMjCL3GsQ+w21w==;23:ol8LKES36u0ZS8k/pzD74Yvs/mFAyxKdrBXWmPCtR/y1AleVhKL2zsPKn+3GNicxEVbaH8S3cr9ai0XpWZCRfmd6wXY5ASE04HmZ6LG2/NroSd3RRWnlGEuHlkAUwOp8TzWs5bDEtjp2zV3XF55Fkvm4zIB+hfkoW7+fKlUNDf3+gK9L50Fyq2fre65AQI6Yat2LfiZY3Oq/MP0fme9L30W/WZoTTm8z1Qg9GjKI6UO1PXfotAwO+MDaz95Ccgnq
X-OriginatorOrg: edrnet.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272574>

Hello,

What type of code scope should a repository contain?  Can it be one large program with many elements or should it just be part of a program or can it be a project with multiple programs?  What are the recommendations?

Thanks,
Brian
