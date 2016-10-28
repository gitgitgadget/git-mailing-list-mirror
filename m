Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 734322035F
	for <e@80x24.org>; Fri, 28 Oct 2016 21:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762010AbcJ1VJJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 17:09:09 -0400
Received: from ns3.impromed.com ([74.62.95.114]:34711 "EHLO ns3.impromed.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756709AbcJ1VJI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 17:09:08 -0400
X-HSAH-MailScanner-Watermark: 1478120937.07394@2GYKFKEQpU+6MHRvWiUDPA
X-HSAH-MailScanner-To: git@vger.kernel.org, gitster@pobox.com
X-HSAH-MailScanner-From: srchamberlain@impromed.com
X-HSAH-MailScanner-SpamCheck: not spam (whitelisted),
        SpamAssassin (not cached, score=-11, required 5, autolearn=not spam,
        ALL_TRUSTED -1.00, BAYES_00 -10.00)
X-HSAH-MailScanner: Found to be clean
X-HSAH-MailScanner-ID: u9SL8a29128407
X-HSAH-MailScanner-Information: This email has been scanned by ImproMed-LLC 
 a Henry Schein Animal Health company
Received: from ex.impromed.com (es4.impromed.com [10.13.88.62])
        by ns3.impromed.com (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id u9SL8a29128407;
        Fri, 28 Oct 2016 16:08:36 -0500
Received: from ES4.impromed.com (10.13.88.64) by ES4.impromed.com
 (10.13.88.64) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Fri, 28 Oct
 2016 16:08:34 -0500
Received: from ES4.impromed.com ([fe80::1d86:6fd8:634a:86d4]) by
 ES4.impromed.com ([fe80::1d86:6fd8:634a:86d4%12]) with mapi id
 15.00.1210.000; Fri, 28 Oct 2016 16:08:34 -0500
From:   "Scott R. Chamberlain" <srchamberlain@impromed.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Can't get git to stop outputting to StdErr
Thread-Topic: Can't get git to stop outputting to StdErr
Thread-Index: AdIxWdLXUBgGGNakQFmM5BW2VpA8DgABXP/8AAAHDKA=
Date:   Fri, 28 Oct 2016 21:08:34 +0000
Message-ID: <824a1f973733418aa7486a3a30e41d93@ES4.impromed.com>
References: <c09d32d8ab97418d98ddf356e20a6ff5@ES4.impromed.com>
 <xmqq7f8syyhg.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq7f8syyhg.fsf@gitster.mtv.corp.google.com>
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

VGhpcyBpcyB0YWxraW5nIHRvIGEgdmlzdWFsc3R1ZGlvLmNvbSBnaXQgcmVw
by4gSSB3aWxsIGZpbGUgYSBidWcgd2l0aCB0aGVtLg0KDQpTY290dCBDaGFt
YmVybGFpbg0KU29mdHdhcmUgRW5naW5lZXIgDQpJbXByb01lZCwgTExDDQoo
ODAwKSA5MjUtNzE3MQ0Kd3d3LmltcHJvbWVkLmNvbQ0KDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKdW5pbyBDIEhhbWFubyBbbWFp
bHRvOmdpdHN0ZXJAcG9ib3guY29tXSANClNlbnQ6IEZyaWRheSwgT2N0b2Jl
ciAyOCwgMjAxNiA0OjA3IFBNDQpUbzogU2NvdHQgUi4gQ2hhbWJlcmxhaW4g
PHNyY2hhbWJlcmxhaW5AaW1wcm9tZWQuY29tPg0KQ2M6IGdpdEB2Z2VyLmtl
cm5lbC5vcmcNClN1YmplY3Q6IFJlOiBDYW4ndCBnZXQgZ2l0IHRvIHN0b3Ag
b3V0cHV0dGluZyB0byBTdGRFcnINCg0KIlNjb3R0IFIuIENoYW1iZXJsYWlu
IiA8c3JjaGFtYmVybGFpbkBpbXByb21lZC5jb20+IHdyaXRlczoNCg0KPiBU
aGUgbGluZSBJIGRvIGlzOg0KPg0KPiAgICAgZ2l0IHB1c2ggLXEgYmluYXJ5
UmVwbyBIRUFEOiIkRW52OkJVSUxEX1NPVVJDRUJSQU5DSCINCg0KVGhpcyB3
b3VsZCANCg0KICgxKSBzcXVlbGNoIHRoZSBvdXRwdXQgZnJvbSB0aGUgc2Vu
ZGluZyBzaWRlIChpLmUuIGxvY2FsKSwgYW5kDQoNCiAoMikgYXNrICJxdWll
dCIgdG8gdGhlIHJlY2VpdmluZyBzaWRlIChpLmUuIHJlbW90ZSksIGlmIHRo
ZXkga25vdw0KICAgICBob3cgdG8gYmUgcXVpZXQuDQoNCj4gQnV0IEkgZ2V0
IHRoZSBmb2xsb3dpbmcgaW4gbXkgbG9nIGFmdGVyIHRoZSBidWlsZA0KPg0K
PiAgICAgMjAxNi0xMC0yOFQyMDowNTozMi4zMTc5NDQyWiAjI1tlcnJvcl1y
ZW1vdGU6IA0KPiAgICAgcmVtb3RlOiBBbmFseXppbmcgb2JqZWN0cy4uLiAo
My8zKSAoNjU3IG1zKSAgICAgICAgDQo+ICAgICByZW1vdGU6IFN0b3Jpbmcg
cGFja2ZpbGUuLi4gZG9uZSAoNDAgbXMpICAgICAgICANCj4gICAgIHJlbW90
ZTogU3RvcmluZyBpbmRleC4uLiBkb25lICg0MiBtcykgICAgICAgIA0KDQpU
aGVzZSB0aHJlZSBsaW5lcyBwcmVmaXhlZCB3aXRoICJyZW1vdGU6IiBhcmUg
Y29taW5nIGZyb20gdGhlIHNvZnR3YXJlIHRoYXQgcnVucyBvbiB0aGUgcmVt
b3RlIG1hY2hpbmUgdGhhdCBhY2NlcHRzIHlvdXIgcHVzaCwgYnV0IHRoZSB3
YXkgaXQgc2F5cyB0aGVzZSB0aHJlZSB0aGluZ3MgZG8gbm90IGxvb2sgZmFt
aWxpYXIgdG8gbWUuICBJcyBpdCBwb3NzaWJsZSB0aGF0IHRoZSByZW1vdGUg
bWFjaGluZSBpcyBydW5uaW5nIGEgR2l0IHNlcnZlciB0aGF0IGlzIG5vdCBv
dXJzLCB3aGljaCBsYWNrcyB0aGUgc3VwcG9ydCBmb3IgInF1aWV0IiBjYXBh
YmlsaXR5PyAgSWYgdGhhdCBpcyB0aGUgY2FzZSwgdGhlIHN5bXB0b20gaXMg
dW5kZXJzdGFuZGFibGUuDQoNCkEgcXVpY2sgYXJjaGl2ZSBzZWFyY2ggdGVs
bHMgbWUgdGhhdCB5b3UgYXJlIHNlZWluZyB0aGUgc2FtZSBpc3N1ZSBhcyB0
aGlzIG9uZToNCg0KaHR0cHM6Ly9wdWJsaWMtaW5ib3gub3JnL2dpdC8yMDE2
MDUxNjEzMzczMS5HQTY5MDNAc2lnaWxsLmludHJhLnBlZmYubmV0Lw0KDQp3
aGVyZSB0aGUgY29uY2x1ZGluZyByZW1hcmssIHRvIHdoaWNoIEkgYWdyZWUs
IGlzOg0KDQogICAgVGhlIHNlcnZlciBzaWRlIGhlcmUgaXMgY2xlYXJseSBu
b3Qgc3RvY2sgZ2l0LCBmcm9tIHRoZSBjb250ZW50DQogICAgb2YgdGhvc2Ug
cHJvZ3Jlc3MgbWVzc2FnZXMgKHNvbWUgZ29vZ2xpbmcgc2hvd3MgaXQgbG9v
a3MgbGlrZQ0KICAgIHdoYXRldmVyIHZpc3VhbHN0dWRpby5jb20gaXMgcnVu
bmluZywgYnV0IEkgZG9uJ3Qga25vdyB3aGF0IHRoYXQNCiAgICBpcykuIFNv
IGVpdGhlciB0aGUgc2VydmVyIGltcGxlbWVudGF0aW9uIGRvZXNuJ3Qgc3Vw
cG9ydCB0aGUNCiAgICAicXVpZXQiIHByb3RvY29sIGV4dGVuc2lvbiwgb3Ig
aXQgaXMgaWdub3JpbmcgaXQuIEl0IG1pZ2h0IGJlDQogICAgd29ydGggZmls
aW5nIGEgYnVnIHdpdGggdGhlbS4NCg0KDQoKLS0gClJlbHkgT24gVXMuCklt
cHJvTWVkIExMQwpIZW5yeSBTY2hlaW4gQW5pbWFsIEhlYWx0aAotLQoK
