Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 420A41FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 15:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759330AbcLSPDw (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 10:03:52 -0500
Received: from ns3.impromed.com ([74.62.95.114]:51391 "EHLO ns3.impromed.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758732AbcLSPDe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 10:03:34 -0500
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Dec 2016 10:03:34 EST
X-HSAH-MailScanner-Watermark: 1482591422.51533@1U0QjI6uSqa9JtckRF6Ycw
X-HSAH-MailScanner-To: git@vger.kernel.org, gitster@pobox.com
X-HSAH-MailScanner-From: srchamberlain@impromed.com
X-HSAH-MailScanner-SpamCheck: not spam (whitelisted),
        SpamAssassin (not cached, score=-11, required 5, autolearn=not spam,
        ALL_TRUSTED -1.00, BAYES_00 -10.00)
X-HSAH-MailScanner: Found to be clean
X-HSAH-MailScanner-ID: uBJEuaPh058266
X-HSAH-MailScanner-Information: This email has been scanned by ImproMed-LLC 
 a Henry Schein Animal Health company
Received: from ex.impromed.com (es5.impromed.com [10.13.88.65])
        by ns3.impromed.com (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id uBJEuaPh058266;
        Mon, 19 Dec 2016 08:56:37 -0600
Received: from ES5.impromed.com (10.13.88.65) by ES4.impromed.com
 (10.13.88.62) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Mon, 19 Dec
 2016 08:56:36 -0600
Received: from ES5.impromed.com ([fe80::9d7d:38a2:8a38:327e]) by
 ES5.impromed.com ([fe80::9d7d:38a2:8a38:327e%12]) with mapi id
 15.00.1210.000; Mon, 19 Dec 2016 08:56:36 -0600
From:   "Scott R. Chamberlain" <srchamberlain@impromed.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Can't get git to stop outputting to StdErr
Thread-Topic: Can't get git to stop outputting to StdErr
Thread-Index: AdIxWdLXUBgGGNakQFmM5BW2VpA8DgABXP/8AAAHDKAKKib6oA==
Date:   Mon, 19 Dec 2016 14:56:35 +0000
Message-ID: <77ad6aeef9a245f3adeab3751e7e94eb@ES5.impromed.com>
References: <c09d32d8ab97418d98ddf356e20a6ff5@ES4.impromed.com>
 <xmqq7f8syyhg.fsf@gitster.mtv.corp.google.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.13.90.99]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

TWljcm9zb2Z0IGZpeGVkIHRoZWlyIGdpdCByZXBvIGltcGxlbWVudGF0aW9u
IHRvIG5vIGxvbmdlciBjYXVzZSB0aGlzIHByb2JsZW0uDQoNCmh0dHBzOi8v
Y29ubmVjdC5taWNyb3NvZnQuY29tL1Zpc3VhbFN0dWRpby9mZWVkYmFjay9k
ZXRhaWxzLzMxMDk2NTQvZ2l0LWhvc3Qtb24tdmlzdWFsc3R1ZGlvLWNvbS1k
b2VzLW5vdC1yZXNwZWN0LXRoZS1xLWZsYWctZm9yLXB1c2hlcw0KDQpTY290
dCBDaGFtYmVybGFpbg0KU29mdHdhcmUgRW5naW5lZXIgDQpJbXByb01lZCwg
TExDDQooODAwKSA5MjUtNzE3MQ0Kd3d3LmltcHJvbWVkLmNvbQ0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU2NvdHQgUi4gQ2hhbWJl
cmxhaW4gDQpTZW50OiBGcmlkYXksIE9jdG9iZXIgMjgsIDIwMTYgNDowOSBQ
TQ0KVG86ICdKdW5pbyBDIEhhbWFubycgPGdpdHN0ZXJAcG9ib3guY29tPg0K
Q2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJFOiBDYW4ndCBn
ZXQgZ2l0IHRvIHN0b3Agb3V0cHV0dGluZyB0byBTdGRFcnINCg0KVGhpcyBp
cyB0YWxraW5nIHRvIGEgdmlzdWFsc3R1ZGlvLmNvbSBnaXQgcmVwby4gSSB3
aWxsIGZpbGUgYSBidWcgd2l0aCB0aGVtLg0KDQpTY290dCBDaGFtYmVybGFp
bg0KU29mdHdhcmUgRW5naW5lZXIgDQpJbXByb01lZCwgTExDDQooODAwKSA5
MjUtNzE3MQ0Kd3d3LmltcHJvbWVkLmNvbQ0KDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBKdW5pbyBDIEhhbWFubyBbbWFpbHRvOmdp
dHN0ZXJAcG9ib3guY29tXSANClNlbnQ6IEZyaWRheSwgT2N0b2JlciAyOCwg
MjAxNiA0OjA3IFBNDQpUbzogU2NvdHQgUi4gQ2hhbWJlcmxhaW4gPHNyY2hh
bWJlcmxhaW5AaW1wcm9tZWQuY29tPg0KQ2M6IGdpdEB2Z2VyLmtlcm5lbC5v
cmcNClN1YmplY3Q6IFJlOiBDYW4ndCBnZXQgZ2l0IHRvIHN0b3Agb3V0cHV0
dGluZyB0byBTdGRFcnINCg0KIlNjb3R0IFIuIENoYW1iZXJsYWluIiA8c3Jj
aGFtYmVybGFpbkBpbXByb21lZC5jb20+IHdyaXRlczoNCg0KPiBUaGUgbGlu
ZSBJIGRvIGlzOg0KPg0KPiAgICAgZ2l0IHB1c2ggLXEgYmluYXJ5UmVwbyBI
RUFEOiIkRW52OkJVSUxEX1NPVVJDRUJSQU5DSCINCg0KVGhpcyB3b3VsZCAN
Cg0KICgxKSBzcXVlbGNoIHRoZSBvdXRwdXQgZnJvbSB0aGUgc2VuZGluZyBz
aWRlIChpLmUuIGxvY2FsKSwgYW5kDQoNCiAoMikgYXNrICJxdWlldCIgdG8g
dGhlIHJlY2VpdmluZyBzaWRlIChpLmUuIHJlbW90ZSksIGlmIHRoZXkga25v
dw0KICAgICBob3cgdG8gYmUgcXVpZXQuDQoNCj4gQnV0IEkgZ2V0IHRoZSBm
b2xsb3dpbmcgaW4gbXkgbG9nIGFmdGVyIHRoZSBidWlsZA0KPg0KPiAgICAg
MjAxNi0xMC0yOFQyMDowNTozMi4zMTc5NDQyWiAjI1tlcnJvcl1yZW1vdGU6
IA0KPiAgICAgcmVtb3RlOiBBbmFseXppbmcgb2JqZWN0cy4uLiAoMy8zKSAo
NjU3IG1zKSAgICAgICAgDQo+ICAgICByZW1vdGU6IFN0b3JpbmcgcGFja2Zp
bGUuLi4gZG9uZSAoNDAgbXMpICAgICAgICANCj4gICAgIHJlbW90ZTogU3Rv
cmluZyBpbmRleC4uLiBkb25lICg0MiBtcykgICAgICAgIA0KDQpUaGVzZSB0
aHJlZSBsaW5lcyBwcmVmaXhlZCB3aXRoICJyZW1vdGU6IiBhcmUgY29taW5n
IGZyb20gdGhlIHNvZnR3YXJlIHRoYXQgcnVucyBvbiB0aGUgcmVtb3RlIG1h
Y2hpbmUgdGhhdCBhY2NlcHRzIHlvdXIgcHVzaCwgYnV0IHRoZSB3YXkgaXQg
c2F5cyB0aGVzZSB0aHJlZSB0aGluZ3MgZG8gbm90IGxvb2sgZmFtaWxpYXIg
dG8gbWUuICBJcyBpdCBwb3NzaWJsZSB0aGF0IHRoZSByZW1vdGUgbWFjaGlu
ZSBpcyBydW5uaW5nIGEgR2l0IHNlcnZlciB0aGF0IGlzIG5vdCBvdXJzLCB3
aGljaCBsYWNrcyB0aGUgc3VwcG9ydCBmb3IgInF1aWV0IiBjYXBhYmlsaXR5
PyAgSWYgdGhhdCBpcyB0aGUgY2FzZSwgdGhlIHN5bXB0b20gaXMgdW5kZXJz
dGFuZGFibGUuDQoNCkEgcXVpY2sgYXJjaGl2ZSBzZWFyY2ggdGVsbHMgbWUg
dGhhdCB5b3UgYXJlIHNlZWluZyB0aGUgc2FtZSBpc3N1ZSBhcyB0aGlzIG9u
ZToNCg0KaHR0cHM6Ly9wdWJsaWMtaW5ib3gub3JnL2dpdC8yMDE2MDUxNjEz
MzczMS5HQTY5MDNAc2lnaWxsLmludHJhLnBlZmYubmV0Lw0KDQp3aGVyZSB0
aGUgY29uY2x1ZGluZyByZW1hcmssIHRvIHdoaWNoIEkgYWdyZWUsIGlzOg0K
DQogICAgVGhlIHNlcnZlciBzaWRlIGhlcmUgaXMgY2xlYXJseSBub3Qgc3Rv
Y2sgZ2l0LCBmcm9tIHRoZSBjb250ZW50DQogICAgb2YgdGhvc2UgcHJvZ3Jl
c3MgbWVzc2FnZXMgKHNvbWUgZ29vZ2xpbmcgc2hvd3MgaXQgbG9va3MgbGlr
ZQ0KICAgIHdoYXRldmVyIHZpc3VhbHN0dWRpby5jb20gaXMgcnVubmluZywg
YnV0IEkgZG9uJ3Qga25vdyB3aGF0IHRoYXQNCiAgICBpcykuIFNvIGVpdGhl
ciB0aGUgc2VydmVyIGltcGxlbWVudGF0aW9uIGRvZXNuJ3Qgc3VwcG9ydCB0
aGUNCiAgICAicXVpZXQiIHByb3RvY29sIGV4dGVuc2lvbiwgb3IgaXQgaXMg
aWdub3JpbmcgaXQuIEl0IG1pZ2h0IGJlDQogICAgd29ydGggZmlsaW5nIGEg
YnVnIHdpdGggdGhlbS4NCg0KDQoKLS0gClJlbHkgT24gVXMuCkltcHJvTWVk
IExMQwpIZW5yeSBTY2hlaW4gQW5pbWFsIEhlYWx0aAotLQoK
