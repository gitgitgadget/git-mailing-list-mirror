From: Dominik Rauch <dominik.rauch@gmx.at>
Subject: git log --merges doesn't show commits as expected
Date: Fri, 13 Nov 2015 16:21:36 +0000
Message-ID: <AMSPR02MB168531F809E1625FACEB25283110@AMSPR02MB168.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 13 17:37:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxHLr-0006TV-Ki
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 17:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933162AbbKMQhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 11:37:21 -0500
Received: from mail-am1on0124.outbound.protection.outlook.com ([157.56.112.124]:1376
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932281AbbKMQhU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Nov 2015 11:37:20 -0500
X-Greylist: delayed 940 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Nov 2015 11:37:19 EST
Received: from AMSPR02MB168.eurprd02.prod.outlook.com (10.242.94.25) by
 AMSPR02MB166.eurprd02.prod.outlook.com (10.242.94.22) with Microsoft SMTP
 Server (TLS) id 15.1.325.17; Fri, 13 Nov 2015 16:21:36 +0000
Received: from AMSPR02MB168.eurprd02.prod.outlook.com ([10.242.94.25]) by
 AMSPR02MB168.eurprd02.prod.outlook.com ([10.242.94.25]) with mapi id
 15.01.0325.003; Fri, 13 Nov 2015 16:21:36 +0000
Thread-Topic: git log --merges doesn't show commits as expected
Thread-Index: AdEeLaVPhrMV+VW+SRK9Z9ItZS3uGA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dominik@dominikrauch.onmicrosoft.com; 
x-ms-exchange-messagesentrepresentingtype: 2
x-originating-ip: [212.186.82.27]
x-microsoft-exchange-diagnostics: 1;AMSPR02MB166;5:zisuRZqPdq9JWTAfb9+AMEms7rH2kJIzQdSrHTzIbvh+vKbO7ZDcDkceHrxjk7WbBUpEBKCYOYqxmzyYr+rUu9B3n+4GdsYhjNjmcjoMzv3vQFjO56BNznaWF2FpBe7g207S9nj2xWYqMs2StgQGZg==;24:PGNT25/KNluozrH4k/uOvjH12ze70Knxz1j1BJ74L4IdIU0IJNmYPtiH+CWPIvnZMAqV33+A+sqKEKE2r+2/comEgjJBh72kBoOKdhAGGas=;20:oHH5TapvxGOI9VBlVN4mUejLaFgfyYIqNZlGK4DZKRG4Erk04jOtFZ7V+36OJqbf4QvlC/d1lICj6JNUdBkYAA==
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:AMSPR02MB166;
x-microsoft-antispam-prvs: <AMSPR02MB1660A69CD036AE82EB04A6D83110@AMSPR02MB166.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(520078)(8121501046)(10201501046)(3002001);SRVR:AMSPR02MB166;BCL:0;PCL:0;RULEID:;SRVR:AMSPR02MB166;
x-forefront-prvs: 0759F7A50A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(189002)(199003)(5003600100002)(19580395003)(64872006)(11100500001)(2351001)(229853001)(10400500002)(2501003)(76576001)(15975445007)(74316001)(5002640100001)(89136004)(92566002)(5007970100001)(106356001)(15395725005)(5004730100002)(189998001)(54356999)(102836002)(450100001)(86902001)(101416001)(2900100001)(81156007)(5001960100002)(74482002)(107886002)(66066001)(50986999)(110136002)(97736004)(40100003)(87936001)(105586002)(33656002)(122556002)(77096005)(86972001)(42882005);DIR:OUT;SFP:1102;SCL:1;SRVR:AMSPR02MB166;H:AMSPR02MB168.eurprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:0;LANG:en;
received-spf: None (protection.outlook.com: dominikrauch.onmicrosoft.com does
 not designate permitted sender hosts)
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
X-OriginatorOrg: dominikrauch.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2015 16:21:36.1137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 62860c5f-96cd-494b-b6bc-19dacd3a942d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMSPR02MB166
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281256>

Hello!
 
(This is my first post to this mailing list and I couldn't find a FAQ section - please excuse me, if I haven't followed all the established posting guidelines yet.)

I have the following repository tree:

C
|\
| B
| /
A

Commit A: Parents=(). Initial commit. Contains file foo with content "ABC".
Commit B: Parents=(A). Represents a commit on some feature branch. Contains file foo with content "XYZ".
Commit C: Parents=(A, B). Represents a merge commit of a feature branch back to the main branch. Contains file foo with content "XYZ".

I expected "git log --merges foo" to show C, however, the log is empty! Specifying "--full-history" results in the correct history, therefore I assume, I misunderstand Git's default history simplification algorithm. Unfortunately, the example in the Git docs at [1] does not contain the very same situation (although it is probably one of the most common situations...).

Does anybody know why I don't see the log output I expect? I'm confused...even if the log output is correct, I don't think it follows the principle of least surprise...

Side note: specifying "--first-parent" also results in commit C being shown.

Best regards,
Dominik

PS: This is a cross post of [2], somebody noted it could be a bug, which is why I decided to post to this mailing list.

[1] https://git-scm.com/docs/git-log#_history_simplification 
[2] http://stackoverflow.com/q/33695763/
