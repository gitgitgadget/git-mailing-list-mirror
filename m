From: Gary England <GEngland@myvrx.com>
Subject: Bug report: Unhandled Exception
Date: Thu, 11 Jun 2015 19:21:59 +0000
Message-ID: <DM2PR06MB4936C92C10128BD37E4ABC1D1BC0@DM2PR06MB493.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 11 21:22:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z383K-0002Gl-Ls
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 21:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbbFKTWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 15:22:10 -0400
Received: from zixgateway01.myvrx.com ([192.41.40.104]:35670 "EHLO
	zixgateway01.myvrx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbbFKTWG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jun 2015 15:22:06 -0400
Received: from 127.0.0.1 (ZixVPM [127.0.0.1])
	by Outbound.myvrx.com (Proprietary) with SMTP id C6AAD51C85
	for <git@vger.kernel.org>; Thu, 11 Jun 2015 13:21:12 -0600 (MDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by zixgateway01.myvrx.com (Proprietary) with ESMTPS id BB92D51C63
	for <git@vger.kernel.org>; Thu, 11 Jun 2015 13:21:10 -0600 (MDT)
Received: from DM2PR06MB493.namprd06.prod.outlook.com (10.141.159.143) by
 DM2PR06MB493.namprd06.prod.outlook.com (10.141.159.143) with Microsoft SMTP
 Server (TLS) id 15.1.190.14; Thu, 11 Jun 2015 19:21:59 +0000
Received: from DM2PR06MB493.namprd06.prod.outlook.com ([10.141.159.143]) by
 DM2PR06MB493.namprd06.prod.outlook.com ([10.141.159.143]) with mapi id
 15.01.0190.013; Thu, 11 Jun 2015 19:21:59 +0000
Thread-Topic: Bug report: Unhandled Exception
Thread-Index: AQHQpHvjXwz0ypi5fUG3gxOiHquz0Q==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;
x-originating-ip: [50.79.71.233]
x-microsoft-exchange-diagnostics: 1;DM2PR06MB493;3:A3ja2c7dL4AHb+tAMMUS5vlSeaF/V0RtRY8ql0/xF3NSAIebvgY9fdry39VHCJM05jaPpi7GvHLnKP5uAsAzszcHDT1hw2mnwwmALz0Zg79qJDp6GK/esiXg34T2XTXMD37V9QJ30vzuJOXjq6alrg==;10:Z/lcl8aqXUh3o43yeoeqr1GEykMBE4xVafXzpgQH9XEOAixUZrxJRw5CVlJ5FeiJK26JCGczIE1egXr0+3R+rRAlTLCF/xNmIFjFLooXzJk=;6:xKv9ZOS0SOzQyc78y+DhEjv/cy8Y1MfLXzhkqZz+jkBvIFY3hy8XUYkLq79ADZNH
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DM2PR06MB493;
x-microsoft-antispam-prvs: <DM2PR06MB49380532B7FB742F8E5AB3ED1BC0@DM2PR06MB493.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(5005006)(520003)(3002001);SRVR:DM2PR06MB493;BCL:0;PCL:0;RULEID:;SRVR:DM2PR06MB493;
x-forefront-prvs: 0604AFA86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(377424004)(252514010)(164054003)(86362001)(102836002)(189998001)(33656002)(50986999)(15974865002)(62966003)(77156002)(450100001)(19580395003)(19580405001)(2900100001)(2656002)(76576001)(87936001)(5001960100002)(54356999)(107886002)(77096005)(110136002)(92566002)(106116001)(80792005)(2501003)(46102003)(74316001)(2351001)(5003600100002)(229853001)(66066001)(40100003)(5002640100001)(122556002)(460985005)(18886075002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR06MB493;H:DM2PR06MB493.namprd06.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-OriginatorOrg: myvrx.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2015 19:21:59.2137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6161f9fd-e776-4f16-b146-64e3f1184f0b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR06MB493
X-VPM-MSG-ID: 2b340165-1e45-431f-b47c-f48ce3b8930e
X-VPM-HOST: zixgateway01.myvrx.com
X-VPM-GROUP-ID: 3cf70084-e109-4823-affd-dd84f58c3eb6
X-VPM-ENC-REGIME: Plaintext
X-VPM-CERT-FLAG: 0
X-VPM-IS-HYBRID: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271455>

Hello,

Using git version 1.9.2-preview20140411, in Git Bash for Windows, performing a "git pull --rebase", received an unhandled exception. Here is the stack trace:


MSYS-1.0.12 Build:2012-07-05 14:56
Exception: STATUS_ACCESS_VIOLATION at eip=00418DAA
eax=680A38E4 ebx=685704CC ecx=00542E38 edx=00000154 esi=00000000 edi=685700D4
ebp=0028FE90 esp=0028FE6C program=C:\Program Files (x86)\Git\bin\cat.exe
cs=0023 ds=002B es=002B fs=0053 gs=002B ss=002B
Stack trace:
Frame     Function  Args
0028FE90  00418DAA  (685700D4, 00000154, 00000003, 004144EA)
0028FEE0  0041466B  (00000000, 01805AB1, 0028FF20, 00405894)
0028FF00  00414C5F  (00401BB0, 00401000, FFFFD000, 00000000)
0028FF20  00414C98  (00000000, 00000000, FFFFF801, 00000000)
0028FF50  004057A4  (00401BB0, 9B30881F, FFFF9E16, 00000000)
0028FF80  0040103D  (7FFDE000, 76F87BE0, 005E63FC, 0028FFDC)
0028FF94  76F87C04  (7FFDE000, 00045F96, 00000000, 00000000)
0028FFDC  7752AD1F  (FFFFFFFF, 77510236, 00000000, 00000000)
0028FFEC  7752ACEA  (00401000, 7FFDE000, 00000000, 78746341)
End of stack trace


The rebase succeeded, so maybe this isn't of much concern, or maybe it's something specific to my machine. It's the first time I have ever received an unhandled exception while using git. Either way, wanted to let you guys know what happened. Let me know if you need any further information, or if this is the appropriate channel to report this bug.

Thanks,

Gary England
Software Engineer
 
VRx |P.O. Box 9780, Salt Lake City, UT 84109
Office: 801.990.9981|Fax: 801.449.3090
E-mail: gengland@myvrx.com|Website: www.myvrx.com
