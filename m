From: PFDuc <pierre-francois.duc@mail.mcgill.ca>
Subject: Git issue report : issue with capital letter in folder name
Date: Thu, 17 Dec 2015 10:45:25 -0500
Message-ID: <5672D895.7030209@mail.mcgill.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 17 19:19:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9d9Z-0005XX-AB
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 19:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbbLQSTp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2015 13:19:45 -0500
Received: from mail-by2on0054.outbound.protection.outlook.com ([207.46.100.54]:3913
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751491AbbLQSTo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 13:19:44 -0500
X-Greylist: delayed 7266 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Dec 2015 13:19:43 EST
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pierre-francois.duc@mail.mcgill.ca; 
Received: from [142.157.43.28] (142.157.43.28) by
 BN1PR0301MB0707.namprd03.prod.outlook.com (10.160.78.139) with Microsoft SMTP
 Server (TLS) id 15.1.355.16; Thu, 17 Dec 2015 15:45:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
X-Originating-IP: [142.157.43.28]
X-ClientProxiedBy: BN3PR16CA0014.namprd16.prod.outlook.com (25.165.112.152) To
 BN1PR0301MB0707.namprd03.prod.outlook.com (25.160.78.139)
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0301MB0707;2:P1JMBLxKn7yRYmsmcWt+Awah5X+W81rYiuLDx285rz3/5abPRjUIYIOSv5Z4EPhDxfsEO8V9JDdA6XXO1Odz+6agGqrHggWO6jHkDfa5igt2JHfRrPnycfmilE5K3HyOywGH3SV3hQ1NU1GXl7Q9yg==;3:U+5fPtyqobHf5PKicSGEHaPoNRoXOHhsr8ehAFS//f53UZ3dwQgnCIZmvqXy42GT9Sh8A9FL6118gyqLNzQdE/AGfkHAx+rCyF30zouqyTQj6xkGZSMJBdkD4rLQwHGo;25:NGcc7uWP5VlH4sgq8lQp/jDpEWkY36SJvvua3LjV6yIP9/wZk2sPspNyc6Ub24dkPrMDvify8b7F/uNQuV4XLTfJfnfyWhJLEAuboXuwe+rG83R9ou55n2j11epma+bQmtlxtF/byOsVn3gAWmWFk4Nzi/dgmGDEiEr+tJvyjYCX6X3yZjbzSAn37vo4+US14ymWjHb1cF2h4CGyWd5hBvbVqjxmmxshJWiPkX1+mU1NEQZ17o3NSr61hIxaxY1GuuDR+Mm0G2xhGvO+HEMbLg==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN1PR0301MB0707;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0301MB0707;20:lwyy3tnmmOhzRLgxLZSvyPQOkjcHTESwTAK+9wPfaKP669rr1GeuBdyXQmmxxpCSsuglPYfMCB8GZ4ZmDaTCPQPaCyZkd4317x5gFj8Jn8GKaZZ10koOrOwG98jRa/BWBzPo0xwdVtoxh0PXYMsRL3nN4k+lKhgDec2MMfu8RXsw1Vu2W33OtgDgJ0v3Zoj3fJ+mcGqCeQ98V3D3VVQyXtiR+vw1elKPirsOm4jN+S1UaaiXCcASmGDn3kDdQIM35Bs3qd29im10t1IxZS+CSVH01oLKNmg93Bm5GUyC1LhvSlXP7vYxZ25xI7Duy5zKkBE7aVgjAiDu1fcyBJHI4p32UIP4A1GkszNC2fdnXzrLFGwUTDeywk/jTBnhKB3+TGglKiEKbLE6R0KFnFKXqQMGzPMSLGNHI3wh69S9P0vSH9kTMkph+Qr1rclpsEcJe/3UsxyPqnvG20FWVT9ud6WMKn0h02Yr2d7iFHgPOwYuenVDuwDX0h1K/y7phIxf;4:MZSRyDM56Pz6y1KLrFjYy0ob+YA1dQqCN8F9LRT0eyO+OnmngGQ2FaVbGFNBj7ugUls3DplclJ64bNpnM8AVo+zlLvxL6rdMGPlyb3PpLO+vc0wW9xBmAKYV1AI+UeXU23foSkhXbE5OceWy86twJMeMQAZx3sO9mJIuyuMR8OD2OuCaFcxtbxeTfK4izERrP8pHBI58RR1k13L5+2b5nhuMTrr2+XpEuC0JZo
 GFghYKrzaSipGfLF7Q7/RkTxHyRuhBk/wL1Qd2qRhyoqGt8EetntzJWcn8JLkSZHzT++klFFPbPkfLT4rjqF6NcXInSAWvJnMY 
X-Microsoft-Antispam-PRVS: <BN1PR0301MB07072797BD32F069DD4721A394E00@BN1PR0301MB0707.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(520078)(8121501046)(10201501046)(3002001);SRVR:BN1PR0301MB0707;BCL:0;PCL:0;RULEID:;SRVR:BN1PR0301MB0707;
X-Forefront-PRVS: 07935ACF08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(6009001)(199003)(189002)(92566002)(59896002)(65956001)(66066001)(77096005)(5008740100001)(54356999)(87266999)(65806001)(450100001)(64126003)(47776003)(586003)(3846002)(1096002)(6116002)(40100003)(74482002)(122386002)(87976001)(50986999)(80316001)(33656002)(65816999)(5001960100002)(4001350100001)(110136002)(189998001)(86362001)(81156007)(50466002)(97736004)(105586002)(107886002)(19580395003)(106356001)(2351001)(229853001)(83506001)(5004730100002)(23676002)(101416001)(42186005)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR0301MB0707;H:[142.157.43.28];FPR:;SPF:None;PTR:InfoNoRecords;A:0;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: mail.mcgill.ca does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjFQUjAzMDFNQjA3MDc7MjM6UUtwN0JKUE80UlYvMjlKM3M2VUNvc1BD?=
 =?utf-8?B?VTZWSG12MmFpazhLZlNFYXBsby9LNkkrZ09keTgrd21iTklVWDdDb3hwV0Mx?=
 =?utf-8?B?U29tYTdsOUV1Y2J3MVlyNEpyTTh0RFlpT0d0dFFnSC8xdm1jWG5MZFkweTFp?=
 =?utf-8?B?VVhSNUJvdEQ0ZmFST00xQy9nTDRhbUxFSkVnVFBCemEwMWQ2NExjU1NZR0Rv?=
 =?utf-8?B?cU15ME56a1dNVnBXcWxaU0pCRHJZeFAwNzloaERqQXoybUhETGFZQXM3MWRu?=
 =?utf-8?B?V1VzazNmSGNCM2ZreXJEREZLMjVCNG1sSlh4YUhtcTBjZ21kVHhMeDBOY29w?=
 =?utf-8?B?TnQyV0hJS2lnQkVOV0U1MzhpMzdKU2JQblJadVJ2L0dETzhEU2pta2RINWg2?=
 =?utf-8?B?ZFZtS0tybjFjR3VrT0g5TVpJc3N4UEJ1SGZVVFRISnNkMWNPNHV6Y3VwMnNU?=
 =?utf-8?B?QWRNdGQ3amdubGw4SndzaDhMUmtrcWo2YkdpaEREWU52T25tWlA0V3Z1di9I?=
 =?utf-8?B?VG9Nbm1yUkpvYzNaUGRqdTQ2NzNVUXdDZm1rUXNhd3Vsa0lmemlPeWFUM2Fz?=
 =?utf-8?B?RG1QaUEyTEhpZnpEM0g1TVh6elZuVEQvakNEdlliQ2NwdE5KM2tieFdsTThE?=
 =?utf-8?B?d0QvcnEvR3Y2SHNrbGRKbkRBb3lxV2NXM3k2N25BNH 
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0301MB0707;5:gq2z37QaifQFW3Er2HsBa8Wa0Vta3poBMYMfHqlfstwnkRkuWlzgs5l+aB0Fj9w5YO2bJMflSM2eLX1WdfyULF1xuXBAtk5/SdLaNFzbndDLCjBvlLNsa36ZUCuYqYANtGLQueernoxlK4+wOmOEmg==;24:NH6eV8HeHKMDhvCLpZu3eGudSKXyYBEl5ebzJXRKwALZSmVxRd4rYoCWoN/TarSZVboeEaaQ8DZ75FO6qAnUAxaVrx7B7tO83HlxYrtIKDI=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mail.mcgill.ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2015 15:45:47.5520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR0301MB0707
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282662>

Hello,

first of all thank you for developping git !

I had an issue with a capital block in the folder name inside my git=20
repo. The folder in my local was named "Display" and the one at origin=20
was named "display" resulting in error when importing python code from=20
this folder for users who got the repo from origin.

I tried to change the folder name on bitbucket.org but I was unable to=20
(or wasn't smart enough to find how to).

I fixed the issue by deleting the file from my local, then commit, then=
=20
push, put the same folder in my local, then commit then push.

I am therefore only writing to tell you that story which is not so=20
important, but I had the thought that because it is not so important=20
maybe nobody reports that and the bug (if any) cannot be fixed.

Have a good day and happy end of year season!

Regards,

Pierre-Fran=C3=A7ois Duc
PhD candidate Physics McGill university
