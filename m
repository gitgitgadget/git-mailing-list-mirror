From: Josh Rowe <Joshua.Rowe@microsoft.com>
Subject: FW: Windows. Git, and Dedupe
Date: Mon, 18 Mar 2013 21:20:48 +0000
Message-ID: <02803146dc74414191fab53b0de33fa1@BLUPR03MB019.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 18 22:23:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHhX6-0006yq-JL
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 22:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933038Ab3CRVXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 17:23:09 -0400
Received: from mail-by2lp0238.outbound.protection.outlook.com ([207.46.163.238]:2607
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933036Ab3CRVXD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 17:23:03 -0400
Received: from BL2FFO11FD010.protection.gbl (10.173.161.202) by
 BL2FFO11HUB021.protection.gbl (10.173.161.45) with Microsoft SMTP Server
 (TLS) id 15.0.641.9; Mon, 18 Mar 2013 21:23:01 +0000
Received: from TK5EX14HUBC106.redmond.corp.microsoft.com (131.107.125.37) by
 BL2FFO11FD010.mail.protection.outlook.com (10.173.161.16) with Microsoft SMTP
 Server (TLS) id 15.0.641.9 via Frontend Transport; Mon, 18 Mar 2013 21:23:00
 +0000
Received: from va3outboundpool.messaging.microsoft.com (157.54.51.114) by
 mail.microsoft.com (157.54.80.61) with Microsoft SMTP Server (TLS) id
 14.2.318.3; Mon, 18 Mar 2013 21:22:47 +0000
Received: from mail198-va3-R.bigfish.com (10.7.14.231) by
 VA3EHSOBE009.bigfish.com (10.7.40.29) with Microsoft SMTP Server id
 14.1.225.23; Mon, 18 Mar 2013 21:20:54 +0000
Received: from mail198-va3 (localhost [127.0.0.1])	by
 mail198-va3-R.bigfish.com (Postfix) with ESMTP id 8829920093	for
 <git@vger.kernel.org.FOPE.CONNECTOR.OVERRIDE>; Mon, 18 Mar 2013 21:20:54
 +0000 (UTC)
X-Forefront-Antispam-Report-Untrusted: CIP:157.56.240.21;KIP:(null);UIP:(null);(null);H:BL2PRD0310HT002.namprd03.prod.outlook.com;R:internal;EFV:INT
X-SpamScore: 2
X-BigFish: PS2(zzc89bhzz1f42h1ee6h1de0h1202h1e76h1d1ah1d2ahzzz31h2a8h668h839h93fhd24hf0ah1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh162dh1631h1758h18e1h1946h19b5h19ceh1ad9h1b0ah9a9j1155h)
Received-SPF: softfail (mail198-va3: transitioning domain of microsoft.com does not designate 157.56.240.21 as permitted sender) client-ip=157.56.240.21; envelope-from=Joshua.Rowe@microsoft.com; helo=BL2PRD0310HT002.namprd03.prod.outlook.com ;.outlook.com ;
X-Forefront-Antispam-Report-Untrusted: SFV:SKI;SFS:;DIR:OUT;SFP:;SCL:-1;SRVR:BLUPR03MB018;H:BLUPR03MB019.namprd03.prod.outlook.com;LANG:en;
Received: from mail198-va3 (localhost.localdomain [127.0.0.1]) by mail198-va3
 (MessageSwitch) id 1363641651902088_13646; Mon, 18 Mar 2013 21:20:51 +0000
 (UTC)
Received: from VA3EHSMHS038.bigfish.com (unknown [10.7.14.250])	by
 mail198-va3.bigfish.com (Postfix) with ESMTP id D72E942026F	for
 <git@vger.kernel.org>; Mon, 18 Mar 2013 21:20:51 +0000 (UTC)
Received: from BL2PRD0310HT002.namprd03.prod.outlook.com (157.56.240.21) by
 VA3EHSMHS038.bigfish.com (10.7.99.48) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Mon, 18 Mar 2013 21:20:51 +0000
Received: from BLUPR03MB018.namprd03.prod.outlook.com (10.255.208.40) by
 BL2PRD0310HT002.namprd03.prod.outlook.com (10.255.97.37) with Microsoft SMTP
 Server (TLS) id 14.16.287.2; Mon, 18 Mar 2013 21:20:51 +0000
Received: from BLUPR03MB019.namprd03.prod.outlook.com (10.255.208.41) by
 BLUPR03MB018.namprd03.prod.outlook.com (10.255.208.40) with Microsoft SMTP
 Server (TLS) id 15.0.620.20; Mon, 18 Mar 2013 21:20:47 +0000
Received: from BLUPR03MB019.namprd03.prod.outlook.com ([169.254.1.13]) by
 BLUPR03MB019.namprd03.prod.outlook.com ([169.254.1.13]) with mapi id
 15.00.0620.020; Mon, 18 Mar 2013 21:20:48 +0000
Thread-Topic: Windows. Git, and Dedupe
Thread-Index: Ac4kHWwJ1TuRv71UTiaX6E7A5Ky1SQAAHxSw
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.107.192.82]
X-OrganizationHeadersPreserved: BLUPR03MB018.namprd03.prod.outlook.com
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
X-FOPE-CONNECTOR: Id%59$Dn%VGER.KERNEL.ORG$RO%2$TLS%6$FQDN%corpf5vips-237160.customer.frontbridge.com$TlsDn%
X-CrossPremisesHeadersPromoted: TK5EX14HUBC106.redmond.corp.microsoft.com
X-CrossPremisesHeadersFiltered: TK5EX14HUBC106.redmond.corp.microsoft.com
X-Forefront-Antispam-Report: CIP:131.107.125.37;CTRY:US;IPV:CAL;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(199002)(189002)(80022001)(74662001)(66066001)(77982001)(56776001)(50466001)(76482001)(54316002)(46102001)(74502001)(53806001)(16676001)(54356001)(4396001)(47736001)(50986001)(621065001)(47446002)(69226001)(63696002)(79102001)(59766001)(65816001)(47776003)(49866001)(47976001)(20776003)(51856001)(6806001)(33646001)(31966008)(56816002)(44976002)(73894001)(23676001)(24736002);DIR:OUT;SFP:;SCL:1;SRVR:BL2FFO11HUB021;H:TK5EX14HUBC106.redmond.corp.microsoft.com;RD:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-OriginatorOrg: microsoft.onmicrosoft.com
X-Forefront-PRVS: 07891BF289
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218454>

V2luZG93cyBwcm9iYWJseSBpc27igJl0IHRoZSBtb3N0IHBvcHVsYXIgcGxhdGZvcm0gZm9yIEdp
dCBkZXZlbG9wZXJzIOKYuiwgYnV0IGhlcmUgZ29lc+KApg0KDQpPbiBXaW5kb3dzIHdpdGggYW4g
TlRGUyB2b2x1bWUgd2l0aCBEZWR1cGxpY2F0aW9uIGVuYWJsZWQsIEdpdCBiZWxpZXZlcyB0aGF0
IGRlZHVwbGljYXRlZCBmaWxlcyBhcmUgc3ltbGlua3MuwqAgSXQgdGhlbiBmYWlscyB0byBiZSBh
YmxlIHRvIGRvIGFueXRoaW5nIHdpdGggdGhlIGZpbGUuwqAgVGhpcyBjYW4gYmUgcmVwcm8tZWQg
YnkgY3JlYXRpbmcgYW4gTlRGUyB2b2x1bWUgd2l0aCBkZWR1cCwgY3JlYXRpbmcgc29tZSBkdXBs
aWNhdGUgZmlsZXMsIHZlcmlmeWluZyB0aGF0IGEgZmV3IGZpbGVzIGFyZSBkZWR1cGVkLCBhbmQg
dHJ5aW5nIHRvIGFkZCBhbmQgY29tbWl0IHRoZSBmaWxlcyB2aWEgZ2l0Lg0KDQpKbXINCg0K
