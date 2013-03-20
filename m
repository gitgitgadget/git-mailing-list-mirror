From: Josh Rowe <Joshua.Rowe@microsoft.com>
Subject: RE: FW: Windows. Git, and Dedupe
Date: Wed, 20 Mar 2013 20:43:03 +0000
Message-ID: <2156b5b7b012490490c1b52637a6164a@BLUPR03MB019.namprd03.prod.outlook.com>
References: <02803146dc74414191fab53b0de33fa1@BLUPR03MB019.namprd03.prod.outlook.com>
 <5148D3BD.4040608@lsrfire.ath.cx>
 <614e174a0b4548a1bcdc6c24c2682829@BLUPR03MB019.namprd03.prod.outlook.com>
 <514A140C.1040901@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"msysgit@googlegroups.com" <msysgit@googlegroups.com>
To: =?utf-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Mar 20 21:45:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIPtF-0000RJ-EJ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 21:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080Ab3CTUpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 16:45:12 -0400
Received: from mail-by2lp0237.outbound.protection.outlook.com ([207.46.163.237]:23899
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752702Ab3CTUpK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 16:45:10 -0400
Received: from BY2FFO11FD006.protection.gbl (10.1.15.203) by
 BY2FFO11HUB040.protection.gbl (10.1.14.161) with Microsoft SMTP Server (TLS)
 id 15.0.641.9; Wed, 20 Mar 2013 20:45:08 +0000
Received: from TK5EX14HUBC104.redmond.corp.microsoft.com (131.107.125.37) by
 BY2FFO11FD006.mail.protection.outlook.com (10.1.14.127) with Microsoft SMTP
 Server (TLS) id 15.0.641.9 via Frontend Transport; Wed, 20 Mar 2013 20:45:08
 +0000
Received: from ch1outboundpool.messaging.microsoft.com (157.54.51.112) by
 mail.microsoft.com (157.54.80.25) with Microsoft SMTP Server (TLS) id
 14.2.318.3; Wed, 20 Mar 2013 20:44:48 +0000
Received: from mail94-ch1-R.bigfish.com (10.43.68.246) by
 CH1EHSOBE008.bigfish.com (10.43.70.58) with Microsoft SMTP Server id
 14.1.225.23; Wed, 20 Mar 2013 20:43:08 +0000
Received: from mail94-ch1 (localhost [127.0.0.1])	by mail94-ch1-R.bigfish.com
 (Postfix) with ESMTP id 2B0D420782	for
 <git@vger.kernel.org.FOPE.CONNECTOR.OVERRIDE>; Wed, 20 Mar 2013 20:43:08
 +0000 (UTC)
X-Forefront-Antispam-Report-Untrusted: CIP:157.56.240.21;KIP:(null);UIP:(null);(null);H:BL2PRD0310HT001.namprd03.prod.outlook.com;R:internal;EFV:INT
X-SpamScore: -3
X-BigFish: PS-3(zz9371Ic89bh542I1432I1453I4015Izz1f42h1ee6h1de0h1202h1e76h1d1ah1d2ahzz8275dh8275bhz31h2a8h668h839h93fhd24hf0ah1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh162dh1631h1758h18e1h1946h19b5h1ad9h1b0ah9a9j1155h)
Received-SPF: softfail (mail94-ch1: transitioning domain of microsoft.com does not designate 157.56.240.21 as permitted sender) client-ip=157.56.240.21; envelope-from=Joshua.Rowe@microsoft.com; helo=BL2PRD0310HT001.namprd03.prod.outlook.com ;.outlook.com ;
X-Forefront-Antispam-Report-Untrusted: SFV:SKI;SFS:;DIR:OUT;SFP:;SCL:-1;SRVR:BLUPR03MB018;H:BLUPR03MB019.namprd03.prod.outlook.com;LANG:en;
Received: from mail94-ch1 (localhost.localdomain [127.0.0.1]) by mail94-ch1
 (MessageSwitch) id 1363812186301063_4116; Wed, 20 Mar 2013 20:43:06 +0000
 (UTC)
Received: from CH1EHSMHS040.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.236])	by mail94-ch1.bigfish.com (Postfix) with ESMTP id 3D07E40085;
	Wed, 20 Mar 2013 20:43:06 +0000 (UTC)
Received: from BL2PRD0310HT001.namprd03.prod.outlook.com (157.56.240.21) by
 CH1EHSMHS040.bigfish.com (10.43.69.249) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Wed, 20 Mar 2013 20:43:06 +0000
Received: from BLUPR03MB018.namprd03.prod.outlook.com (10.255.208.40) by
 BL2PRD0310HT001.namprd03.prod.outlook.com (10.255.97.36) with Microsoft SMTP
 Server (TLS) id 14.16.287.3; Wed, 20 Mar 2013 20:43:05 +0000
Received: from BLUPR03MB019.namprd03.prod.outlook.com (10.255.208.41) by
 BLUPR03MB018.namprd03.prod.outlook.com (10.255.208.40) with Microsoft SMTP
 Server (TLS) id 15.0.620.20; Wed, 20 Mar 2013 20:43:04 +0000
Received: from BLUPR03MB019.namprd03.prod.outlook.com ([169.254.1.13]) by
 BLUPR03MB019.namprd03.prod.outlook.com ([169.254.1.13]) with mapi id
 15.00.0620.020; Wed, 20 Mar 2013 20:43:04 +0000
Thread-Topic: FW: Windows. Git, and Dedupe
Thread-Index: Ac4kHWwJ1TuRv71UTiaX6E7A5Ky1SQAAHxSwADH9ZoAAAGeYUAAvUzUAAADM6jA=
In-Reply-To: <514A140C.1040901@lsrfire.ath.cx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.93.4]
X-OrganizationHeadersPreserved: BLUPR03MB018.namprd03.prod.outlook.com
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
X-FOPE-CONNECTOR: Id%59$Dn%GOOGLEGROUPS.COM$RO%2$TLS%6$FQDN%corpf5vips-237160.customer.frontbridge.com$TlsDn%
X-FOPE-CONNECTOR: Id%59$Dn%VGER.KERNEL.ORG$RO%2$TLS%6$FQDN%corpf5vips-237160.customer.frontbridge.com$TlsDn%
X-FOPE-CONNECTOR: Id%59$Dn%LSRFIRE.ATH.CX$RO%2$TLS%6$FQDN%corpf5vips-237160.customer.frontbridge.com$TlsDn%
X-CrossPremisesHeadersPromoted: TK5EX14HUBC104.redmond.corp.microsoft.com
X-CrossPremisesHeadersFiltered: TK5EX14HUBC104.redmond.corp.microsoft.com
X-Forefront-Antispam-Report: CIP:131.107.125.37;CTRY:US;IPV:CAL;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(199002)(189002)(20776003)(79102001)(33646001)(23676001)(65816001)(47446002)(74662001)(69226001)(80022001)(56816002)(54356001)(51856001)(54316002)(44976002)(74502001)(4396001)(47736001)(50986001)(63696002)(16676001)(49866001)(47776003)(73894001)(53806001)(6806001)(31966008)(77982001)(56776001)(59766001)(47976001)(76482001)(46102001)(621065001)(50466001)(24736002);DIR:OUT;SFP:;SCL:1;SRVR:BY2FFO11HUB040;H:TK5EX14HUBC104.redmond.corp.microsoft.com;RD:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-OriginatorOrg: microsoft.onmicrosoft.com
X-Forefront-PRVS: 07915F544A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218679>

SWYgeW91IGhhdmUgV2luOCBvciBIeXBlclYgMjAxMiwgSSBjYW4gc2hpcCB5b3UgYSBzbWFsbCBO
VEZTIC52aGQgd2l0aCBzb21lIGRlZHVwZWQgZmlsZXMuICBJJ20gbm90IHN1cmUgaWYgdGhhdCB3
aWxsIGJlIHJlYWRhYmxlLCBidXQgSSB3b3VsZCBoYXphcmQgYSBndWVzcyB0aGF0IGl0IHdvdWxk
IGJlLiAgSXQgZGVmaW5pdGVseSB3aWxsIG5vdCBiZSByZWFkYWJsZSBvbiBXaW43LiAgDQoNCkkn
bSB1c2luZzoNCg0KUFMgQzpcPiBnaXQgdmVyc2lvbg0KZ2l0IHZlcnNpb24gMS44LjAubXN5c2dp
dC4wDQoNCkkgZG9uJ3Qgc2VlIGFueSBjaGFuZ2VzIHJlbGF0ZWQgdG8gdGhpcyBpbiB0aGUgZmls
ZSBsb2cgc2luY2UgdGhlIG9yaWdpbmFsIGNvZGUgd2FzIGFkZGVkIGluIDIwMTAuICBJIGRvIG5v
dGljZSB0aGF0IG1pbmd3X2ZzdGF0IGRvZXNuJ3QgZG8gYW55dGhpbmcgc3BlY2lhbCB3aXRoIHN5
bWxpbmtzOyBJIGRvbid0IGtub3cgd2hlcmUgdGhhdCBpcyB1c2VkLiAgDQoNClRoZSBmaWxlIHNp
emVzIHNob3cgdXAgYXMgdGhlaXIgb3JpZ2luYWwgc2l6ZSB3aXRoIFdpbmRvd3MgdG9vbHMgKHBv
d2Vyc2hlbGwsIFdpbjMyLCBjbWQsIC5OZXQsIGV0YykuICBnaXQgbHMtdHJlZSAtciBIRUFEIGRv
ZXMgbm90IHNob3cgdGhhdCBoYXNoIGNvZGUgZm9yIGZpbGVzIHRoYXQgYXJlIG5vdCBpbnRlbnRp
b25hbGx5IGVtcHR5LiAgDQoNCkptcg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBSZW7DqSBTY2hhcmZlIFttYWlsdG86cmVuZS5zY2hhcmZlQGxzcmZpcmUuYXRoLmN4XSAN
ClNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjAsIDIwMTMgMTI6NTUgUE0NClRvOiBKb3NoIFJvd2UN
CkNjOiBnaXRAdmdlci5rZXJuZWwub3JnOyBtc3lzZ2l0QGdvb2dsZWdyb3Vwcy5jb20NClN1Ympl
Y3Q6IFJlOiBGVzogV2luZG93cy4gR2l0LCBhbmQgRGVkdXBlDQoNCkFtIDE5LjAzLjIwMTMgMjI6
MzYsIHNjaHJpZWIgSm9zaCBSb3dlOg0KPiBZZXMsIERlZHVwIGlzIGluIGZhY3QgYSBTZXJ2ZXIt
b25seSBmZWF0dXJlLg0KDQpJcyB0aGVyZSBhbiBlYXNpZXIgd2F5IHRvIHJlcHJvZHVjZSB0aGUg
aXNzdWUgdGhhbiByZWdpc3RlcmluZyBhbmQgZG93bmxvYWRpbmcgdGhlIFdpbmRvd3MgU2VydmVy
IDIwMTIgZXZhbHVhdGlvbiB2ZXJzaW9uPyAgSXQncyBub3QgdGhhdCBoYXJkLCBhZG1pdHRlZGx5
LCBidXQgc3RpbGwuDQoNCj4gVGhlIHJlcGFyc2UgcG9pbnQgY291bGQgYmUgZGVjb2RlZCBhcyBi
ZWluZyBhIG5vbi1zeW1saW5rIHJlcGFyc2UgDQo+IGl0ZW11c2luZzsgaW4gdGhvc2UgY2FzZXMs
IHRyZWF0aW5nIHRoZSBmaWxlIGFzIGFuICJvcmRpbmFyeSINCj4gZmlsZSB3b3VsZCBiZSBhcHBy
b3ByaWF0ZS4NCj4NCj4gRm9yIGV4YW1wbGUsIHNlZSB0aGUgZm9sbG93aW5nLiBUaGUgcmVwYXJz
ZSB0YWcgdmFsdWUgZm9yIHN5bWxpbmtzIA0KPiBpc0lPX1JFUEFSU0VfVEFHX1NZTUxJTksgKDB4
YTAwMDAwMGMpIGFuZCBmb3IgZGVkdXBlZCBmaWxlcyBpcw0KID4gKElPX1JFUEFSU0VfVEFHX0RF
RFVQKSAweDgwMDAwMDEzLg0KDQpUaGF0J3MgaW50ZXJlc3RpbmcgYW5kIGludmFsaWRhdGVzIG15
IGluaXRpYWwgY2hlY2tzIHdpdGggbWtsaW5rLCBiZWNhdXNlIGlmIEkgcmVhZCBjb21wYXQvbWlu
Z3cuYyBbMV0gY29ycmVjdGx5IHRoZW4gZ2l0IGhhbmRsZXMgc3ltbGlua3Mgb24gV2luZG93cyBp
biBhIHNwZWNpYWwgd2F5LCBidXQgc2hvdWxkIHRyZWF0IGRlZHVwIHJlcGFyc2UgcG9pbnRzIGFz
IG5vcm1hbCBmaWxlcyBhbHJlYWR5Lg0KDQpIcm0sIGJ1dCBwcm9iYWJseSBzdF9zaXplIGlzIHNl
dCB0byB6ZXJvIGZvciB0aGVtLiAgRG8gdGhlIGRlZHVwZWQgZmlsZXMgYXBwZWFyIGFzIGVtcHR5
PyAgImdpdCBscy10cmVlIC1yIEhFQUQiIHdvdWxkIHNob3cgdGhlbSB3aXRoIGEgaGFzaCBvZiBl
NjlkZTI5YmIyZDFkNjQzNGI4YjI5YWU3NzVhZDhjMmU0OGM1MzkxLiAgSWYgdHJ1ZSB0aGVuIGhv
dyBkbyB3ZSBnZXQgdGhlaXIgcmVhbCBjb250ZW50IHNpemVzIHVzaW5nIFdpbjMyIEFQSSBjYWxs
cz8NCg0KQnkgdGhlIHdheSwgd2hhdCBkb2VzIHRoZSBjb21tYW5kICJnaXQgdmVyc2lvbiIgcmV0
dXJuIGZvciB5b3U/DQoNClRoYW5rcywNClJlbsOpDQoNCg0KWzFdIGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvY2dpdC9naXQvZ2l0LmdpdC90cmVlL2NvbXBhdC9taW5ndy5jI240MjcNCg0KDQoNCg==
