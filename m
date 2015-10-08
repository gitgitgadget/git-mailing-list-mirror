From: "McAuley, Ben" <Ben.McAuley@sungard.com>
Subject: [BUG] GIT_INDEX environment variable ignored?
Date: Thu, 8 Oct 2015 04:48:46 +0000
Message-ID: <3316005380861448B5340D39CF27A7242F2375BE@us-voo-mb04.internal.sungard.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 08 06:49:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk39Q-0006Lj-OM
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 06:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbbJHEtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 00:49:33 -0400
Received: from mail-by2on0143.outbound.protection.outlook.com ([207.46.100.143]:36186
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750886AbbJHEtb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 00:49:31 -0400
Received: from SN1PR0701CA0053.namprd07.prod.outlook.com (10.163.126.21) by
 DM2PR0701MB1184.namprd07.prod.outlook.com (10.160.246.26) with Microsoft SMTP
 Server (TLS) id 15.1.286.20; Thu, 8 Oct 2015 04:49:30 +0000
Received: from BL2FFO11FD053.protection.gbl (2a01:111:f400:7c09::199) by
 SN1PR0701CA0053.outlook.office365.com (2a01:111:e400:52fd::21) with Microsoft
 SMTP Server (TLS) id 15.1.293.16 via Frontend Transport; Thu, 8 Oct 2015
 04:49:29 +0000
Authentication-Results: spf=none (sender IP is 192.88.60.126)
 smtp.mailfrom=sungard.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=sungard.com;
Received-SPF: None (protection.outlook.com: sungard.com does not designate
 permitted sender hosts)
Received: from us-voo-edge01.sungard.com (192.88.60.126) by
 BL2FFO11FD053.mail.protection.outlook.com (10.173.161.181) with Microsoft
 SMTP Server (TLS) id 15.1.293.9 via Frontend Transport; Thu, 8 Oct 2015
 04:49:28 +0000
Received: from US-VOO-CAS04.internal.sungard.corp (10.247.204.8) by
 us-voo-edge01.sungard.com (192.88.60.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Thu, 8 Oct 2015 00:50:08 -0400
Received: from US-VOO-MB04.internal.sungard.corp ([169.254.4.245]) by
 US-VOO-CAS04.internal.sungard.corp ([10.247.204.8]) with mapi id
 14.03.0235.001; Thu, 8 Oct 2015 00:48:46 -0400
Thread-Topic: [BUG] GIT_INDEX environment variable ignored?
Thread-Index: AdEBgg1PrHSbkIIkTkC33FoPYzRzQA==
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.247.204.252]
X-CFilter-Loop: VT_Reflected
X-EOPAttributedMessage: 0
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD053;1:3RwauYBmhBHD18X6guO+iEyXa608iDhTvzUyfcCP1svEQHDtEquoBotXUPoJ5Ii8aCMnxK3bTRT0IDDKAaNkyJ1pz4M7Cy0kIPZACRgWqLyBazomI07sid5W4WeNbeu1a3JLNEwnJSOhOvEQdjg6BxXpuFF21N9G9kdn8j6+ml56j31QWNjyx+I/tOSJlA9R5QTyuRRIpQHMFCFjC8EfF2K7HEBiS6MZv/Lnmh9A30GuDmaCJiozVc8Ijq+nAZ+OuUfS7AP5FW/P6MKrKWu1mDbri6bAQa76jc3Ckbj8tvhgozaqbrJnxYfKHRRH0L/buWo70FmrM/cUWZvH0DAvpw==
X-Forefront-Antispam-Report: CIP:192.88.60.126;CTRY:US;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(10019020)(6009001)(2980300002)(428002)(199003)(164054003)(189002)(97736004)(5003600100002)(5008740100001)(6806005)(106466001)(33656002)(5007970100001)(55846006)(2930100002)(87936001)(81156007)(102836002)(2900100001)(450100001)(46102003)(77096005)(2920100001)(23676002)(2351001)(101416001)(47776003)(189998001)(69596002)(86362001)(64706001)(5001960100002)(229853001)(2501003)(5004730100002)(16796002)(50466002)(92566002)(50986999)(105586002)(54356999)(107886002)(110136002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR0701MB1184;H:us-voo-edge01.sungard.com;FPR:;SPF:None;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1184;2:cUtljT4W0STgepH+LrloF0mXYt/pFngu+Qe/3FTHzSvWRBixkVLXt5ImFysic/ceJ/mu2Ws2QtmPMM4qU7plcNV1YLmFzAo5J/I0Ib/wr8wW0cYZP0V6fObUxoHih3X4OxD8y8PKgJSeouUOxEl3qpfe6hQqDU4HDDcuYec3PUE=;3:utHJ0o0T8FFTCh9obVSt64SfwA9hkRsO5kSmpbLIeKtOFCW3sSySnSe5t4K0ticGCz2+NZfz9OxjvGr2H4grJDprzkbMnHsnWLtp5cUbrZdTHwlQTUlh0INHhSmbPtumE9gWcvUINsv1HjW1ayVDIu0opiQAP/hLubpHRrJdxcHXidz23Q7qPx4jf6hqEeBZbsv78oV2ouPvAnAeM0+VxR13Pp/ILBaUsRVJCZ5xnpE=;25:Z18lrbSmKIc7oVYmO7/xx2gxfExB3pvZDtSHZfrFrJV59ZamKHcNiEiSkZ0xCY3hvkiKVjkZn4N6bZu9YivMWdVBqJNZ8aR+aevqjdlKLc7mxRdtoTP7lQ5wXHU/zdpIxaK3mAPq5pEyNq/TkmwVjGBRH8AtrAJNQAGK8b4KXBNBXsNiAuuW9szDb22IgQvWxn5rarnybsn65oY6MTFcJH21LI++qnVi22/zL5f1ikPKJje5GDbfeDMLU5KW1BHK0Lz03+1JuliZdwNBkI5Low==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0701MB1184;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1184;20:alTCqAqIX4obzXBSIVbs0FlemaySW3EqNw0C+0XPwxwBEmiRHI5k3KPA+jL2ebDEwIdMMMVifKStXT7Q66h60YMoy27YiVrugeA9MB8Llk6Lj8yJnpF93nVNhl4NXaUFkKZsrGrQF7jdYYmxSXYZg1mW1sEh/FAnrLht5Itn3mnX1uxVsaiat/LbaXKbSxvgeABKOWSNG9s7YM0NpNmMijovaVaAQfgNZqsTePLhIpxBbVpiGubPK9VdFoAVNQn81yyoxKWtBqXSuW1XyfqIwngV6C6mYU1TIsBCnewkR94G2Vqmc448Jbt881TA/ySTTju8KBvVjbUj18lu85JMNZ2dbfPlslFu+tfuaZkNOcuesn23SwS/cH5mmzDpzSFUWie6i3O+7sfGfqXSnfV3k4sr9VTgqMgR6tHekriQaxXdysYHQ4HV4TMx0v6QFqsPcBEeE5+ud9oDjW9SlDvmSt6isYPfr/looMI95vQyGbCh6haG976FBrgyHOwG7XJB;4:3rwbHJQJjpveSU2SZ12gH9u8FmFg1AArbgbbMA+VwIkqQqZ0Grr2p4+AjOTaZcTaNNfPpioPclJAY6bJapI2danbwhOmJeJvZbAKQzk9soaQ0P1ZOhh8li3HzpaCy8DZ++BZgQgiXnahQ9z7P6gAvL8w1IZ1BH81HdQxEJfeM9tl41evw406+2k7lRERlDQmHDGsCFf4gd1OI6eeRUApLpvk3RnQJ8OeRShoXX
 /75CM38JehttapDsYwWEbOBCAVKMKJOPiDV9XwUAxl+b8yH6lMzWDxutk1sJDK2h9aKMpQmFIXUss0Zbig51703Aj4HUleU/Eo 
X-Microsoft-Antispam-PRVS: <DM2PR0701MB1184301E7311B35B99912437E0350@DM2PR0701MB1184.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(520078)(5005006)(8121501046)(3002001);SRVR:DM2PR0701MB1184;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0701MB1184;
X-Forefront-PRVS: 0723A02764
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjA3MDFNQjExODQ7MjM6SG96MG5wL3V3SHdBbjZreVFTVi9RWjlq?=
 =?utf-8?B?QTRwWE5jT0lzVXkyZElLWEo3ZnRoOXdqOGV1eVJhZmxYR2Exa0thaEhzMWJS?=
 =?utf-8?B?b3pUdGJXL0pUdnBNVTlyMHkxbUJsVno0RHFoSHIzVG82NFdoK2ZrNW5CSHV4?=
 =?utf-8?B?dDFKTHF1ZHRrK3ZCQThDOFRHSk1GcTVXTGYxZWI1bUtoZWU3Sk9GQkVKV0sx?=
 =?utf-8?B?YU5nM0xKUUpxVmZTUnV0Uy9FSjdZMU9INnNJWHYzd3RlLytFc3ZWYXUvQ0h0?=
 =?utf-8?B?SlYzVCtiNEpLNjBQbE5CbEVoZDJsalJaWE5hc2ZZSmJ4N25jU3NOcUREVkZh?=
 =?utf-8?B?VEZIL1hiMXJtbEsrbWxlZXpLWkdRVEtQWnFweDlhdEVLUk5GbWdhL3M3VThi?=
 =?utf-8?B?Z1BuZkplQ2Y3UnlHL2R1NFVZM2JVNnlDRkVVUnpSZExHUTREUnQ1Tys0aUhK?=
 =?utf-8?B?cHY2S0tKOXlCdjNkVzVqM0xzNWsxMnVZVnlYN25NSkxxM1NCNWZXVEJmR1lX?=
 =?utf-8?B?M1FZSzhvNGZUU1EwRjdWdmhvSmpsRjh2MmdhcjgrVFRJVkE5UEJEajA1aEZ4?=
 =?utf-8?B?ZUo4WGh3UUptb2dBNCtuUW5JVUNSR2pnWC8vMTRFeWR5WUQ5TjNnMHlXdjY5?=
 =?utf-8?B?VXJITkVKbVlEbk5ZL1BZcmVMSEQwRlpoVkwyaVNEWU 
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1184;5:vWT3IesdX/j18ujK1/moCXIkgYC7TemhT8tbaKfzEoRVDnH2FLknGFwp+uNhHm/uU3nPCWc4HkA2blvXX42UI6cOTWEYrZ/ZDVSmExv6jHOMj7llUglNBx4c1g3CFomJEMUyA+CpAvZ49tJZgdj3ig==;24:MDpOg0J1P/VhqQhFxsjzcMLsRsTn7chT94xjP6BUPGDV0+MnTsy6PVw03Hy4vZ9gHQ7OMbwLKgCNuUJmxxQKM8aqWcGcUpYNhowxWpSSRoQ=;20:IeP9+23BWOFSfh33H6YX4PjFp1c8lIJNkllM/kVY0LyjPG81A+R4sp7eQ/UslNVjgQUbOFVCHbqF2zzxbsuIyQ==
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sungard.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2015 04:49:28.6547
 (UTC)
X-MS-Exchange-CrossTenant-Id: df15b212-d5ef-48ef-927b-a705d561f02c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=df15b212-d5ef-48ef-927b-a705d561f02c;Ip=[192.88.60.126];Helo=[us-voo-edge01.sungard.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0701MB1184
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279215>

SGVsbG8sDQoNCkkgd2FzIHRyeWluZyB0byB1c2UgbXVsdGlwbGUgaW5kZXhlcyBlYXJsaWVyLCBh
bmQgcmFuIGludG8gYW4gaXNzdWUgd2hpY2ggSSd2ZSBzdW1tYXJpc2VkIGludG8gYSB0ZXN0IGNh
c2U6DQoNCiQgZ2l0IGluaXQNCiQgdG91Y2ggZmlsZTEgJiYgZ2l0IGFkZCBmaWxlMSAmJiBnaXQg
Y29tbWl0IC1tICJmaWxlMSINCiQgZ2l0IGJyYW5jaCByZWxlYXNlIA0KJCB0b3VjaCBmaWxlMiAm
JiBnaXQgYWRkIGZpbGUyICYmIGdpdCBjb21taXQgLW0gImZpbGUyIg0KJCBjcCAuZ2l0L2luZGV4
IC5naXQvaW5kZXhNYXN0ZXINCiQgZ2l0IGNoZWNrb3V0IHJlbGVhc2UNCiQgdG91Y2ggZmlsZTMg
JiYgZ2l0IGFkZCBmaWxlMyAmJiBnaXQgY29tbWl0IC1tICJmaWxlMyINCg0KSSB0aGVuIHJhbiBs
cy1maWxlcyB3aXRoIHRoZSAtLXN0YWdlIG9wdGlvbiB0byBsb29rIGF0IHdoYXQgdGhlIGluZGV4
IGNvbnRhaW5zLg0KQXMgZXhwZWN0ZWQgZmlsZTEgYW5kIGZpbGUzIGFyZSBwcmVzZW50LCB3ZSdy
ZSBvbiB0aGUgJ3JlbGVhc2UnIGJyYW5jaCBzdGlsbC4NCg0KJCBnaXQgbHMtZmlsZXMgLS1zdGFn
ZQ0KMTAwNjQ0IGU2OWRlMjliYjJkMWQ2NDM0YjhiMjlhZTc3NWFkOGMyZTQ4YzUzOTEgMCAgICAg
ICBmaWxlMQ0KMTAwNjQ0IGU2OWRlMjliYjJkMWQ2NDM0YjhiMjlhZTc3NWFkOGMyZTQ4YzUzOTEg
MCAgICAgICBmaWxlMw0KDQpIb3dldmVyIHdoZW4gSSBydW4gdGhlIHNhbWUgY29tbWFuZCBhZ2Fp
biwgdGhpcyB0aW1lIHVzaW5nIHRoZSANCkdJVF9JTkRFWCBlbnYgdmFyaWFibGUgdG8gcHJvdmlk
ZSB0aGUgaW5kZXggSSBwcmV2aW91c2x5IHNhdmVkIG9uIG1hc3RlciwNCkkgZG9uJ3Qgc2VlIGZp
bGUyIGxpa2UgSSdkIGV4cGVjdC4uLg0KDQokIEdJVF9JTkRFWD0uZ2l0L2luZGV4TWFzdGVyIGdp
dCBscy1maWxlcyAtLXN0YWdlDQoxMDA2NDQgZTY5ZGUyOWJiMmQxZDY0MzRiOGIyOWFlNzc1YWQ4
YzJlNDhjNTM5MSAwICAgICAgIGZpbGUxDQoxMDA2NDQgZTY5ZGUyOWJiMmQxZDY0MzRiOGIyOWFl
Nzc1YWQ4YzJlNDhjNTM5MSAwICAgICAgIGZpbGUzDQoNCklzIHRoaXMgc29tZXRoaW5nIGdvaW5n
IHdyb25nLCBvciBhbSBJIG1pc3VuZGVyc3RhbmRpbmcgdGhlIHJvbGUgb2YgdGhlIGluZGV4L0dJ
VF9JTkRFWCB2YXJpYWJsZT8NCg0KUmVwbGljYXRlZCBvbiAyLjUuMC53aW5kb3dzLjEgYW5kIDIu
Ni4xIChMaW51eCkuDQoNClRoYW5rcywNCkJlbg0K
