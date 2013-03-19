From: Josh Rowe <Joshua.Rowe@microsoft.com>
Subject: RE: FW: Windows. Git, and Dedupe
Date: Tue, 19 Mar 2013 21:36:12 +0000
Message-ID: <614e174a0b4548a1bcdc6c24c2682829@BLUPR03MB019.namprd03.prod.outlook.com>
References: <02803146dc74414191fab53b0de33fa1@BLUPR03MB019.namprd03.prod.outlook.com>
 <5148D3BD.4040608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"msysgit@googlegroups.com" <msysgit@googlegroups.com>
To: =?utf-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Mar 19 22:37:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI4Dx-00010v-Ch
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 22:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022Ab3CSVhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 17:37:07 -0400
Received: from mail-bn1lp0157.outbound.protection.outlook.com ([207.46.163.157]:27387
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756801Ab3CSVhF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 17:37:05 -0400
Received: from BL2FFO11FD008.protection.gbl (10.173.161.203) by
 BL2FFO11HUB034.protection.gbl (10.173.161.114) with Microsoft SMTP Server
 (TLS) id 15.0.641.9; Tue, 19 Mar 2013 21:37:01 +0000
Received: from TK5EX14HUBC107.redmond.corp.microsoft.com (131.107.125.37) by
 BL2FFO11FD008.mail.protection.outlook.com (10.173.161.4) with Microsoft SMTP
 Server (TLS) id 15.0.641.9 via Frontend Transport; Tue, 19 Mar 2013 21:37:01
 +0000
Received: from CO9EHSOBE020.bigfish.com (157.54.51.80) by mail.microsoft.com
 (157.54.80.67) with Microsoft SMTP Server (TLS) id 14.2.318.3; Tue, 19 Mar
 2013 21:36:38 +0000
Received: from mail146-co9-R.bigfish.com (10.236.132.246) by
 CO9EHSOBE020.bigfish.com (10.236.130.83) with Microsoft SMTP Server id
 14.1.225.23; Tue, 19 Mar 2013 21:36:17 +0000
Received: from mail146-co9 (localhost [127.0.0.1])	by
 mail146-co9-R.bigfish.com (Postfix) with ESMTP id 7C3895001C0	for
 <git@vger.kernel.org.FOPE.CONNECTOR.OVERRIDE>; Tue, 19 Mar 2013 21:36:17
 +0000 (UTC)
X-Forefront-Antispam-Report-Untrusted: CIP:157.56.240.21;KIP:(null);UIP:(null);(null);H:BL2PRD0310HT004.namprd03.prod.outlook.com;R:internal;EFV:INT
X-SpamScore: -7
X-BigFish: PS-7(zz9371Ic89bh15bfK146fI542Izz1f42h1ee6h1de0h1202h1e76h1d1ah1d2ahzz17326ah186M1954cbh8275bhz31h2a8h668h839h93fhd24hf0ah1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh162dh1631h1758h18e1h1946h19b5h1ad9h1b0ah17ej9a9j1155h)
Received-SPF: softfail (mail146-co9: transitioning domain of microsoft.com does not designate 157.56.240.21 as permitted sender) client-ip=157.56.240.21; envelope-from=Joshua.Rowe@microsoft.com; helo=BL2PRD0310HT004.namprd03.prod.outlook.com ;.outlook.com ;
X-Forefront-Antispam-Report-Untrusted: SFV:SKI;SFS:;DIR:OUT;SFP:;SCL:-1;SRVR:BLUPR03MB018;H:BLUPR03MB019.namprd03.prod.outlook.com;LANG:en;
Received: from mail146-co9 (localhost.localdomain [127.0.0.1]) by mail146-co9
 (MessageSwitch) id 1363728975306028_11131; Tue, 19 Mar 2013 21:36:15 +0000
 (UTC)
Received: from CO9EHSMHS015.bigfish.com (unknown [10.236.132.228])	by
 mail146-co9.bigfish.com (Postfix) with ESMTP id 3FEA45C0057;	Tue, 19 Mar 2013
 21:36:15 +0000 (UTC)
Received: from BL2PRD0310HT004.namprd03.prod.outlook.com (157.56.240.21) by
 CO9EHSMHS015.bigfish.com (10.236.130.25) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Tue, 19 Mar 2013 21:36:15 +0000
Received: from BLUPR03MB018.namprd03.prod.outlook.com (10.255.208.40) by
 BL2PRD0310HT004.namprd03.prod.outlook.com (10.255.97.39) with Microsoft SMTP
 Server (TLS) id 14.16.287.3; Tue, 19 Mar 2013 21:36:13 +0000
Received: from BLUPR03MB019.namprd03.prod.outlook.com (10.255.208.41) by
 BLUPR03MB018.namprd03.prod.outlook.com (10.255.208.40) with Microsoft SMTP
 Server (TLS) id 15.0.620.20; Tue, 19 Mar 2013 21:36:13 +0000
Received: from BLUPR03MB019.namprd03.prod.outlook.com ([169.254.1.13]) by
 BLUPR03MB019.namprd03.prod.outlook.com ([169.254.1.13]) with mapi id
 15.00.0620.020; Tue, 19 Mar 2013 21:36:12 +0000
Thread-Topic: FW: Windows. Git, and Dedupe
Thread-Index: Ac4kHWwJ1TuRv71UTiaX6E7A5Ky1SQAAHxSwADH9ZoAAAGeYUA==
In-Reply-To: <5148D3BD.4040608@lsrfire.ath.cx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:0:fff:0:5efe:10.123.144.173]
X-OrganizationHeadersPreserved: BLUPR03MB018.namprd03.prod.outlook.com
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
X-FOPE-CONNECTOR: Id%59$Dn%GOOGLEGROUPS.COM$RO%2$TLS%6$FQDN%corpf5vips-237160.customer.frontbridge.com$TlsDn%
X-FOPE-CONNECTOR: Id%59$Dn%VGER.KERNEL.ORG$RO%2$TLS%6$FQDN%corpf5vips-237160.customer.frontbridge.com$TlsDn%
X-FOPE-CONNECTOR: Id%59$Dn%LSRFIRE.ATH.CX$RO%2$TLS%6$FQDN%corpf5vips-237160.customer.frontbridge.com$TlsDn%
X-CrossPremisesHeadersPromoted: TK5EX14HUBC107.redmond.corp.microsoft.com
X-CrossPremisesHeadersFiltered: TK5EX14HUBC107.redmond.corp.microsoft.com
X-Forefront-Antispam-Report: CIP:131.107.125.37;CTRY:US;IPV:CAL;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(189002)(199002)(47446002)(44976002)(54316002)(46102001)(73894001)(51856001)(54356001)(4396001)(56816002)(621065001)(31966008)(74662001)(33646001)(47976001)(50466001)(74502001)(6806001)(76482001)(53806001)(56776001)(69226001)(23676001)(49866001)(20776003)(16676001)(65816001)(59766001)(47736001)(77982001)(47776003)(50986001)(80022001)(79102001)(63696002)(24736002)(3826001);DIR:OUT;SFP:;SCL:1;SRVR:BL2FFO11HUB034;H:TK5EX14HUBC107.redmond.corp.microsoft.com;RD:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-OriginatorOrg: microsoft.onmicrosoft.com
X-Forefront-PRVS: 0790FB1F33
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218558>

WWVzLCBEZWR1cCBpcyBpbiBmYWN0IGEgU2VydmVyLW9ubHkgZmVhdHVyZS4gIEhvd2V2ZXIsIHRo
ZXJlIGFyZSBsb3RzIG9mIHBlb3BsZSB1c2luZyB0aGUgU2VydmVyIFNLVSBhcyBkZXZlbG9wbWVu
dCB3b3Jrc3RhdGlvbnMgKGVzcGVjaWFsbHkgaGVyZSBhdCBNaWNyb3NvZnQgPGc+KS4gIFRoZXJl
IGFyZSBhbHNvIHNvbWUgc3lzYWRtaW5zIHRoYXQgSSBrbm93IG9mIHdobyB1c2UgZ2l0IGFuZCBk
b3dubG9hZCBzeXNhZG1pbiBzY3JpcHRzIHZpYSBnaXQgdG8gU2VydmVycy4gIEZpbmFsbHksIEkg
d291bGQgaGF6YXJkIGEgZ3Vlc3MgdGhhdCBpdCdzIHBvc3NpYmxlIHRvIG1vdW50IGFuIE5URlMg
ZmlsZXN5c3RlbSBjb250YWluaW5nIGRlZHVwZWQgZmlsZXMgZnJvbSBhIFNlcnZlciBtYWNoaW5l
IG9udG8gYSBjbGllbnQgU0tVIGFuZCBhY2Nlc3MgdGhvc2UgZmlsZXMuICAoSSdtIG5vdCBvbiB0
aGUgTlRGUyB0ZWFtLCBhbmQgaGF2ZW4ndCB0cmllZCBpdC4pICBTbyBJIHRoaW5rIHRoZXJlIGFy
ZSBnb29kIHJlYXNvbnMgdG8gc3VwcG9ydCByZXBhcnNlIHBvaW50cyBvbiBXaW5kb3dzLiAgDQoN
ClRoZSByZXBhcnNlIHBvaW50IGNvdWxkIGJlIGRlY29kZWQgYXMgYmVpbmcgYSBub24tc3ltbGlu
ayByZXBhcnNlIGl0ZW0gdXNpbmc7IGluIHRob3NlIGNhc2VzLCB0cmVhdGluZyB0aGUgZmlsZSBh
cyBhbiAib3JkaW5hcnkiIGZpbGUgd291bGQgYmUgYXBwcm9wcmlhdGUuDQoNCkZvciBleGFtcGxl
LCBzZWUgdGhlIGZvbGxvd2luZy4gIFRoZSByZXBhcnNlIHRhZyB2YWx1ZSBmb3Igc3ltbGlua3Mg
aXMgSU9fUkVQQVJTRV9UQUdfU1lNTElOSyAoMHhhMDAwMDAwYykgYW5kIGZvciBkZWR1cGVkIGZp
bGVzIGlzIChJT19SRVBBUlNFX1RBR19ERURVUCkgMHg4MDAwMDAxMy4gIFRoZSB2YWx1ZSBjYW4g
YmUgZGlzY292ZXJlZCBmcm9tIHRoZSBpbmZvcm1hdGlvbiBhdCBbMV0uICANCg0KSSBhZG1pbiB0
byBub3QgaGF2aW5nIGxvb2tlZCBhdCB0aGUgZ2l0IGNvZGUgbm9yIGJlaW5nIGZhbWlsaWFyIHdp
dGggbWluZ3cuICBBcmUgbmF0aXZlIFdpbjMyIGNhbGxzIHN1cHBvcnRlZCBpbiB0aGUgZ2l0IGNv
ZGViYXNlPw0KDQpKbXINCg0KDQpbMV0gaHR0cDovL21zZG4ubWljcm9zb2Z0LmNvbS9lbi11cy9s
aWJyYXJ5L3dpbmRvd3MvZGVza3RvcC9hYTM2NTc0MCh2PXZzLjg1KS5hc3B4DQoNCg0KUFMgSTpc
dGVtcD4gY21kIC9jIG1rbGluayB4IHkNCnN5bWJvbGljIGxpbmsgY3JlYXRlZCBmb3IgeCA8PD09
PT4+IHkNClBTIEk6XHRlbXA+IGZzdXRpbCByZXBhcnNlcG9pbnQgcXVlcnkgeA0KUmVwYXJzZSBU
YWcgVmFsdWUgOiAweGEwMDAwMDBjDQpUYWcgdmFsdWU6IE1pY3Jvc29mdA0KVGFnIHZhbHVlOiBO
YW1lIFN1cnJvZ2F0ZQ0KVGFnIHZhbHVlOiBTeW1ib2xpYyBMaW5rDQoNClJlcGFyc2UgRGF0YSBM
ZW5ndGg6IDB4MDAwMDAwMTANClJlcGFyc2UgRGF0YToNCjAwMDA6ICAwMiAwMCAwMiAwMCAwMCAw
MCAwMiAwMCAgMDEgMDAgMDAgMDAgNzkgMDAgNzkgMDAgIC4uLi4uLi4uLi4uLnkueS4NClBTIEk6
XHRlbXA+IGZzdXRpbCByZXBhcnNlcG9pbnQgcXVlcnkgeC50eHQNClJlcGFyc2UgVGFnIFZhbHVl
IDogMHg4MDAwMDAxMw0KVGFnIHZhbHVlOiBNaWNyb3NvZnQNCg0KUmVwYXJzZSBEYXRhIExlbmd0
aDogMHgwMDAwMDA3Yw0KUmVwYXJzZSBEYXRhOg0KMDAwMDogIDAxIDAyIDdjIDAwIDAwIDAwIDAw
IDAwICA2NiA5YyAxYSAwMSAwMCAwMCAwMCAwMCAgLi58Li4uLi5mLi4uLi4uLg0KMDAxMDogIDAw
IDAwIDAxIDAwIDAwIDAwIDAwIDAwICBjYiBlYiBjNSAwMCA2YSA5NyA2MyA0ZCAgLi4uLi4uLi4u
Li4uai5jTQ0KMDAyMDogIDk3IDljIDEzIDBjIDQxIDhlIGVkIDhiICA0MCAwMCA0MCAwMCA0MCAw
MCAwMCAwMCAgLi4uLkEuLi5ALkAuQC4uLg0KMDAzMDogIGQzIGI5IGE4IGQ0IGU0IGM2IGNkIDAx
ICA1NSBjYSAwMiAwMCAwMCAwMCAwNSAwMCAgLi4uLi4uLi5VLi4uLi4uLg0KMDA0MDogIDcwIGFj
IDIxIDA0IDAwIDAwIDA1IDAwICAwMSAwMCAwMCAwMCA4OCA4ZCAwMCAwMCAgcC4hLi4uLi4uLi4u
Li4uLg0KMDA1MDogIGM4IDMwIDAwIDAwIDAwIDAwIDAwIDAwICBjOCA0NCBkYiA5NCA2YyA4OCA5
YSBkNCAgLjAuLi4uLi4uRC4ubC4uLg0KMDA2MDogIDBhIGE5IDAxIDNhIDFmIDgwIDgwIDhkICBl
YSAwZCA1MyBkNyAzNiA0OSBiOSBhNCAgLi4uOi4uLi4uLlMuNkkuLg0KMDA3MDogIDgyIGEyIGI5
IDRlIDJhIDE2IDRiIGExICAyZSBkOSBmMyBkZCAgICAgICAgICAgICAgLi4uTiouSy4uLi4uDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBSZW7DqSBTY2hhcmZlIFttYWlsdG86
cmVuZS5zY2hhcmZlQGxzcmZpcmUuYXRoLmN4XSANClNlbnQ6IFR1ZXNkYXksIE1hcmNoIDE5LCAy
MDEzIDI6MDggUE0NClRvOiBKb3NoIFJvd2UNCkNjOiBnaXRAdmdlci5rZXJuZWwub3JnOyBtc3lz
Z2l0QGdvb2dsZWdyb3Vwcy5jb20NClN1YmplY3Q6IFJlOiBGVzogV2luZG93cy4gR2l0LCBhbmQg
RGVkdXBlDQoNCkFtIDE4LjAzLjIwMTMgMjI6MjAsIHNjaHJpZWIgSm9zaCBSb3dlOg0KPiBPbiBX
aW5kb3dzIHdpdGggYW4gTlRGUyB2b2x1bWUgd2l0aCBEZWR1cGxpY2F0aW9uIGVuYWJsZWQsIEdp
dCANCj4gYmVsaWV2ZXMgdGhhdCBkZWR1cGxpY2F0ZWQgZmlsZXMgYXJlIHN5bWxpbmtzLiAgSXQg
dGhlbiBmYWlscyB0byBiZSANCj4gYWJsZSB0byBkbyBhbnl0aGluZyB3aXRoIHRoZSBmaWxlLiAg
VGhpcyBjYW4gYmUgcmVwcm8tZWQgYnkgY3JlYXRpbmcgDQo+IGFuIE5URlMgdm9sdW1lIHdpdGgg
ZGVkdXAsIGNyZWF0aW5nIHNvbWUgZHVwbGljYXRlIGZpbGVzLCB2ZXJpZnlpbmcgDQo+IHRoYXQg
YSBmZXcgZmlsZXMgYXJlIGRlZHVwZWQsIGFuZCB0cnlpbmcgdG8gYWRkIGFuZCBjb21taXQgdGhl
IGZpbGVzIA0KPiB2aWEgZ2l0Lg0KDQpCb3RoIFNpbmdsZSBJbnN0YW5jZSBTdG9yYWdlWzFdIGFu
ZCBEYXRhIERlZHVwbGljYXRpb25bMl0gKGludHJvZHVjZWQgd2l0aCBXaW5kb3dzIFNlcnZlciAy
MDEyKSBzZWVtIHRvIGJlIHNlcnZlci1vbmx5IGZlYXR1cmVzLiAgSG93IGFib3V0IGtlZXBpbmcg
cmVndWxhciBnaXQgcmVwb3NpdG9yaWVzIHdpdGggY2hlY2tlZC1vdXQgZmlsZXMgb24gY2xpZW50
IGRpc2tzIGFuZCB1c2UgdGhlIHNlcnZlciBvbmx5IGZvciBiYXJlIHJlcG9zaXRvcmllcyAod2l0
aG91dCB3b3JraW5nIHRyZWUpPw0KDQpXaGVuIEkgdHJpZWQgdG8gYWRkIGEgc3ltYm9saWMgbGlu
ayBjcmVhdGVkIHdpdGggbWtsaW5rIG9uIFdpbmRvd3MgOCwgdGhlIG1pbmd3IHZlcnNpb24gb2Yg
Z2l0IHJlZnVzZWQgYmVjYXVzZSByZWFkbGluaygyKSBpcyBub3Qgc3VwcG9ydGVkLiAgVGhpcyBz
ZWVtcyB0byBiZSBzdWZmaWNpZW50IHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUuDQoNCkkgY291bGRu
J3QgdGVzdCB0aGUgQ3lnd2luIHZlcnNpb24sIHRob3VnaCwgYmVjYXVzZSBodHRwOi8vY3lnd2lu
LmNvbSBkb2Vzbid0IHJlc3BvbmQgYXQgdGhlIG1vbWVudC4NCg0KQnV0IGEgd29ya2luZyByZWFk
bGluaygyKSB3b3VsZG4ndCBoZWxwIGFueXdheSwgSSBndWVzcy4gIEkgaW1hZ2luZSB0aGF0IHRo
ZSByZXBhcnNlIHBvaW50cyB1c2VkIGZvciBkZWR1cGxpY2F0aW9uIHBvaW50IGludG8gYSBtYWdp
YyBibG9jayBzdG9yZSB3aGljaCBwZXJmb3JtcyBnYXJiYWdlIGNvbGxlY3Rpb24gb2YgY29udGVu
dCB0aGF0IGlzIG5vIGxvbmdlciByZWZlcmVuY2VkIC0tIHdoaWNoIHByb2JhYmx5IG1lYW5zIHRo
YXQgYSByZWNyZWF0ZWQgInN5bWxpbmsiDQptYXkgcG9pbnQgdG8gYmxvY2tzIHRoYXQgaGF2ZSBi
ZWVuIGRlbGV0ZWQgaW4gdGhlIG1lYW50aW1lLg0KDQpQZXJoYXBzIHlvdSBuZWVkIGEgd2F5IHRv
IGFzayBnaXQgdG8gYWx3YXlzIGZvbGxvdyBzeW1saW5rcyBpbnN0ZWFkIG9mIHRyeWluZyB0byBz
dG9yZSB0aGVpciB0YXJnZXQgc3BlY2lmaWNhdGlvbi4NCg0KUmVuw6kNCg0KDQpbMV0gaHR0cDov
L3RlY2huZXQubWljcm9zb2Z0LmNvbS9lbi11cy9saWJyYXJ5L2RkNTczMzA4JTI4dj13cy4xMCUy
OS5hc3B4DQpbMl0gaHR0cDovL21zZG4ubWljcm9zb2Z0LmNvbS9lbi11cy9saWJyYXJ5L3dpbmRv
d3MvZGVza3RvcC9oaDc2OTMwMyUyOHY9dnMuODUlMjkuYXNweA0KDQoNCg0K
