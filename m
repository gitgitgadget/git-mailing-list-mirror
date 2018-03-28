Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A7F51F404
	for <e@80x24.org>; Wed, 28 Mar 2018 18:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeC1Sfl (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 14:35:41 -0400
Received: from alln-iport-5.cisco.com ([173.37.142.92]:1384 "EHLO
        alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbeC1Sfk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 14:35:40 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Mar 2018 14:35:40 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=6126; q=dns/txt; s=iport;
  t=1522262140; x=1523471740;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=96Y0Ba4TrSEU5GCMiiFPbvogwUT0NoZDZlpjFv5G4c8=;
  b=lBQuItS61Hwk+a2dhWekkR4Ep16pJro65X8QHoXKh7Lrd0dRh7Xx/v6z
   J7mbUab4ZEK1g3CyxIwrDIqFwnL71u6/9AGTClGZbzeJO0s+XXafU3DTp
   wcw/FcmifsvkwjEW5QlsWI8tBLhBY8xL4ayrGk1dUv/5yTwePTnczeb3o
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CVAgBK3bta/49dJa1dGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYMWK2FvKAqDUpUBgVOBMJRECyWEe4NzITgUAQIBAQEBAQE?=
 =?us-ascii?q?Cax0LhU8RNyABIgImAgQdExUSBBOFDg+ra4IchFWDb4IkBYEIhDyCGoITgQw?=
 =?us-ascii?q?iDIIogz8BA4FGgxQwgiQChwuQKAgCGIEahB2GQ4IUgS+GL4RTiRGGPwIREwG?=
 =?us-ascii?q?BJAEzIYFScBVkAYIYgiAXegEJjRJvAY0qgS6BFwEB?=
X-IronPort-AV: E=Sophos;i="5.48,372,1517875200"; 
   d="scan'208";a="90234776"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2018 18:26:10 +0000
Received: from XCH-RTP-018.cisco.com (xch-rtp-018.cisco.com [64.101.220.158])
        by rcdn-core-7.cisco.com (8.14.5/8.14.5) with ESMTP id w2SIQ9vm016466
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 18:26:09 GMT
Received: from xch-rtp-020.cisco.com (64.101.220.160) by XCH-RTP-018.cisco.com
 (64.101.220.158) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 28 Mar
 2018 14:26:08 -0400
Received: from xch-rtp-020.cisco.com ([64.101.220.160]) by
 XCH-RTP-020.cisco.com ([64.101.220.160]) with mapi id 15.00.1320.000; Wed, 28
 Mar 2018 14:26:08 -0400
From:   "Erik Brady -X (brady - ROBERT HALF INTERNATIONAL INC at Cisco)" 
        <brady@cisco.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Apparent bug in credential tool running...
Thread-Topic: Apparent bug in credential tool running...
Thread-Index: AQHTxsI9w7UvG8AaqkW66sXaczqa9w==
Date:   Wed, 28 Mar 2018 18:26:08 +0000
Message-ID: <7898B9A4-D52E-41AD-9162-5B6B401A1AEA@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.24.45.247]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A728085F5D4DA442A84EB83C60353ED1@emea.cisco.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQpIaSBnaXQgRXhwZXJ0cywNCg0KSSBiZWxpZXZlIHdlJ3ZlIGVuY291bnRlcmVkIGEgYnVnIGlu
IGdpdC4gIEkgYnVpbHQgdGhlIGxhdGVzdCwgZ2l0IDIuMTYuMywgYW5kIGl0IHN0aWxsIGFwcGVh
cnMgdG8gYmUgYSBwcm9ibGVtLiAgSSdtIG5vdCBhIGdpdCBleHBlcnQgYW5kIG15IEMgaXMgcmlk
aWN1bG91c2x5IHJ1c3R5IGJ1dCBJIHRoaW5rIGEgY28td29ya2VyIGFuZCBJIGZpZ3VyZWQgaXQg
b3V0Li4uIGFwb2xvZ2llcyBpZiB3ZSBhcmUgaW5jb3JyZWN0IGluIGFueSBhc3N1bXB0aW9ucyAo
YXMgSSBkbyBub3Qgd2lzaCB0byB3YXN0ZSBhbnlvbmUncyB0aW1lKS4NCg0KVGhlIGxvY2F0aW9u
IG9mIHRoZSBwcm9ibGVtIGlzIGluIGNyZWRlbnRpYWwuYywgcnVuX2NyZWRlbnRpYWxfaGVscGVy
KCkuLi4gdGhpcyBjb2RlOg0KDQogICAuLi4NCiAgICBmcCA9IHhmZG9wZW4oaGVscGVyLmluLCAi
dyIpOw0KICAgIGNyZWRlbnRpYWxfd3JpdGUoYywgZnApOw0KICAgIGZjbG9zZShmcCk7DQogICAu
Lg0KDQpXaGljaCBJIHRoaW5rIG5lZWRzIHRvIGJlY29tZSBzb21ldGhpbmcgbGlrZSB0aGlzOg0K
DQogICAgZnAgPSB4ZmRvcGVuKGhlbHBlci5pbiwgInciKTsNCiAgICBzaWdjaGFpbl9wdXNoKFNJ
R1BJUEUsIFNJR19JR04pOw0KICAgIGNyZWRlbnRpYWxfd3JpdGUoYywgZnApOw0KICAgIGZjbG9z
ZShmcCk7DQogICAgc2lnY2hhaW5fcG9wKFNJR1BJUEUpOw0KDQpUaGUgYmFzaWNzIGFyZSB0aGF0
IHdlIHdyb3RlIGEgY3JlZGVudGlhbCBoZWxwZXIgaW4gR28gYW5kLCBmb3IgdGhlIHN0b3JlIGFj
dGlvbiwgaXQgc2ltcGx5IGV4aXRzIDAuICBJdCBpcyBmYXN0LiAgVGhpcyBpcyBzaW1pbGFyIHRv
IHRoZSBleGFtcGxlIGhlcmU6DQoNCmh0dHBzOi8vZ2l0LXNjbS5jb20vYm9vay9lbi92Mi9HaXQt
VG9vbHMtQ3JlZGVudGlhbC1TdG9yYWdlI19hX2N1c3RvbV9jcmVkZW50aWFsX2NhY2hlDQoNCldo
aWNoIGlzLCBvZiBjb3Vyc2UsIGluIFJ1YnksIG5vdCBHbyAoc28sIG5vdCBzbyBmYXN0KS4gIEl0
IGV4aXRzIGlmIGl0IGlzIG5vdCBhIGdldCBjcmVkIGhlbHBlciBhY3Rpb24gd2l0aG91dCByZWFk
aW5nIHN0ZGluLiAgQW55aG93LCBmb3Igb3VyIGNyZWRlbnRpYWwgaGVscGVyIHRoZSBzdG9yZSBv
cGVyYXRpb24gY29tcGxldGVzIHZlcnkgcXVpY2tseS4gIFdoYXQgd2UndmUgZm91bmQgaXMgdGhh
dCBvY2Nhc2lvbmFsbHkgdGhlIGdpdCBjb21tYW5kIHdpbGwgYmUga2lsbGVkIG9mZiBqdXN0IGFm
dGVyIHJ1bm5pbmcgdGhlIGNyZWRlbnRpYWwgc3RvcmUgb3BlcmF0aW9uLiAgV2UgY2FuIHNlZSB0
aGF0IG91ciBjcmVkZW50aWFsIGhlbHBlciBpcyBiZWluZyBmaXJlZCB1cCAoaXQgaGFzIGEgZGVi
dWcgbW9kZSkgYW5kIGl0IHF1aWNrbHkgZXhpdHMuICBXZSBjYW4gc2VlIHRoYXQgZ2l0IGRpZXMg
b24gdGhlIGZjbG9zZShmcCkgYnkgcHV0dGluZyB0cmFjZV9wcmludGYoKSBjYWxscyBiZWZvcmUg
YW5kIGFmdGVyIHRoYXQgZmNsb3NlIGluIHRoZSBnaXQgc291cmNlIGNvZGUgKGllOiB0aGUgdHJh
Y2UgbWVzc2FnZSBiZWZvcmUgdGhlIGZjbG9zZSgpIHByaW50cywgdGhlIHRyYWNlIG1lc3NhZ2Ug
YWZ0ZXIgdGhlIGZjbG9zZSBkb2VzIG5vdCkuDQoNCk91ciBiZWxpZWYgaXMgdGhhdCB0aGUgd3Jp
dGUgaXMgYnVmZmVyZWQgYW5kIHdyaXR0ZW4gYXQgdGhlIHRpbWUgb2YgZmNsb3NlKCkuLi4gYW5k
IHRoYXQgdGhlIGNyZWRlbnRpYWwgaGVscGVyIHRvb2wgaGFzIGFscmVhZHkgZXhpdGVkICJzb21l
dGltZXMiIChhcyBpdCBpcyB2ZXJ5IGZhc3QsIGJ1dCBldmVuIHNvIHRoaXMgZG9lc24ndCBmYWls
IHZlcnkgb2Z0ZW4pLiAgRm9yIHRob3NlIHRpbWVzIHdoZW4gb3VyIGNyZWQgaGVscGVyIGhhcyBl
eGl0ZWQgInF1aWNrbHkgZW5vdWdoIiwgYSBTSUdQSVBFIGNhbiBiZSBnZW5lcmF0ZWQuLi4gYW5k
LCBhcyBTSUdQSVBFIGlzIG5vdCBpZ25vcmVkLCBnaXQgZ29lcyAia2Fib29tISIgYW5kIGRpZXMu
DQoNClRvIGNhdGNoIHRoaXMgc2NlbmFyaW8gd2Ugd3JvdGUgYSBzaW1wbGUgaGFjayBQZXJsIHRv
b2wgdG8gcnVuIGEgYnVuY2ggb2Ygc2VyaWFsIGdpdCBscy1yZW1vdGUgY29tbWFuZHMgbGlrZSBz
bzoNCg0KIyEvdXNyL2Npc2NvL2Jpbi9wZXJsIC13DQoNCiRFTlZ7J0dJVF9UUkFDRSd9ID0gMjsN
CiRFTlZ7J0dJVF9UUkFDRV9DVVJMJ30gPSAyOw0KJEVOVnsnR0lUX1RSQUNFX1BFUkZPUk1BTkNF
J30gPSAxOw0KJEVOVnsnR0lUX1RSQUNFX1BBQ0tFVCd9ID0gMTsNCg0KZm9yICggbXkgJGkgPSAx
OyAkaTw9MTAwMDAwOyAkaSsrKSB7DQogICAgcHJpbnQoIlJ1bjogJGlcbiIpOw0KICAgIG15ICRv
dXRwdXQgPSBgL3dzL2JyYWR5LXNqYy9naXQvZ2l0LTIuMTYuMy9iaW4vZ2l0IGxzLXJlbW90ZSBo
dHRwczovL2hvc3RuYW1lLmNvbXBhbnkuY29tL2dpdC9wYXRoL3JlcG8uZ2l0IEhFQUQgMj4mMWA7
DQogICAgaWYgKCAkPyAhPSAwICkgew0KICAgICAgICBwcmludCgiRkFJTDogb3V0cHV0OlxuJG91
dHB1dFxuIik7DQogICAgICAgIGV4aXQoMSk7DQogICAgfQ0KfQ0KZXhpdCgwKTsNCg0KVGhlIHBy
b2JsZW0gc2VlbWVkIHRvIGNvbWUgdXAgbW9zdCBjb21tb25seSBvbiBvbGRlciBsaW51eCBWTSdz
Li4uIGluIHRoaXMgY2FzZSBydW5uaW5nIDIuNi4xOC00MTYuZWw1ICMxIFNNUC4gIFRoZSB0b29s
IHdpbGwgaXRlcmF0ZSBmb3IgYSB3aGlsZSBhbmQgdGhlbiwgYm9vbSwgaXQgYmxvd3MgdXAgKHVz
dWFsbHkgd2l0aGluIDEwMDAgaXRlcmF0aW9ucywgc29tZXRpbWVzIGEgY291cGxlL2ZldyB0aG91
c2FuZCBidXQgdXN1YWxseSB3ZWxsIGJlZm9yZSB0aGF0KS4NCg0KQW55aG93Li4uIHdlIGRpZCBh
IGZldyB0aGluZ3MgdG8gdGVzdCBvdXIgdGhlb3J5IHRoYXQgaXQgaXMsIGluZGVlZCwgU0lHUElQ
RSBjYXVzaW5nIGdpdCB0byBleGl0Og0KDQoxKSBNeSBjby13b3JrZXIgbW9kaWZpZWQgb3VyIGNy
ZWRlbnRpYWwgbWFuYWdlciB0byByZWFkIGluIHRoZSBkYXRhIHNlbnQgYnkgZ2l0IGJlZm9yZSBl
eGl0aW5nLi4uIHRoYXQgc29sdmVkIHRoZSBwcm9ibGVtIGFzIHdlIGFjY2VwdCB0aGUgZGF0YSB3
cml0dGVuIHNvIHRoZSBjaGlsZCBpcyBzdGlsbCB0aGVyZSBhbmQgbm8gU0lHUElQRSBpcyBnZW5l
cmF0ZWQuLi4gdGhpcyBpcyBvdXIgY3VycmVudCB3b3JrYXJvdW5kIChzbyB3ZSBhcmUgT0ssIGJ1
dCB3b3VsZCBiZSBnb29kIHRvIGZpeCB0aGlzIGluIHRoZSBnaXQgY29kZSB3ZSB0aGluaykNCg0K
MikgSSBtb2RpZmllZCB0aGUgYWJvdmUgY29kZSB0byB1c2UgYSBzaWduYWwgaGFuZGxlciBpbiBj
cmVkZW50aWFsLmMgKGluc3RlYWQgb2YgU0lHX0lHTikgYW5kIHB1dCBhIHRyYWNlX3ByaW50Zigp
IGFuZCBhbiBleGl0KDEpIGluc2lkZSB0aGUgc2lnbmFsIGhhbmRsZXIuLi4gc2ltaWxhciB0byB0
aGUgcHJvYmxlbSB3ZSdyZSBzZWVpbmcgaXQnbGwgcnVuIGEgYnVuY2ggc3VjY2Vzc2Z1bGx5IHVu
dGlsLCBib29tLCB0aW1pbmcgaXMgaGl0IHN1Y2ggdGhhdCB0aGUgY2hpbGQgZXhpdHMgcXVpY2ts
eSBlbm91Z2ggYW5kIGNhdXNlcyB0aGUgU0lHUElQRSB0byBvY2N1ciBhdCB3aGljaCBwb2ludCBn
aXQgaXMga2lsbGVkLi4uLiBzbyB1c2luZyB0aGUgY2hlZXN5IFBlcmwgdGVzdCBzY3JpcHQgaXQg
cmFuIHRocm91Z2ggYSBjb3VwbGUgaHVuZHJlZCBpdGVyYXRpb25zIGZpbmUgYW5kIHRoZW4gYSBT
SUdQSVBFIHdhcyBzZWVuIGFuZCBpdCBkaWVkIGluIHRoZSBzaWduYWwgaGFuZGxlciBJIHdyb3Rl
Li4uIHNvIGNsZWFybHkgU0lHUElQRSBpcyBiZWluZyBnZW5lcmF0ZWQgYnV0IG9ubHkgb2NjYXNp
b25hbGx5IChpdCBpcyB0aW1pbmcgYmFzZWQsIHNvIG9jY3VycyBvbmx5IG5vdyBhbmQgdGhlbi4u
LiBhbmQgd2UgYWxtb3N0IG5ldmVyIHNlZSBpdCBvbiBzb21lIG9mIG91ciBib3hlcykNCg0KMykg
SSBtb2RpZmllZCB0aGUgZ2l0IGNvZGUgKHVzaW5nIG91ciBvbGQgY3JlZCBoZWxwZXIgd2hpY2gg
ZXhpdHMgcXVpY2tseSkgcGVyIHRoZSBhYm92ZSByZWNvbW1lbmRlZCBjcmVkZW50aWFsLmMgY2hh
bmdlcyAoeW91IGZvbGtzIGNhbiBsaWtlbHkgZG8gYSBiZXR0ZXIgZml4KS4uLiBhbmQgcmUtcnVu
IHRoZSBQZXJsIHRlc3Qgc2NyaXB0Li4uIG5vIGxvbmdlciBmYWlscyBub3cgdGhhdCB3ZSBhcmUg
aWdub3JpbmcgU0lHUElQRSAocmFuIGFib3V0IDIwLDAwMCsgaXRlcmF0aW9ucykuDQoNCk5vdGUg
dGhhdCB0aGUgYnVpbGQtaW4gY3JlZGVudGlhbCBtYW5hZ2VyIHdhcyBub3QgZmFpbGluZy4uLiBp
dCByZWFkcyB0aGUgY3JlZCBoZWxwZXIgc3RvcmUgZGF0YSBzbyBpdCB3b3VsZCBub3QgaGF2ZSB0
aGUgcHJvYmxlbS4NCg0KTGV0IG1lIGtub3cgaWYgeW91IG5lZWQgYW55IGFkZGl0aW9uYWwgaW5m
b3JtYXRpb24uLi4gYW5kIHRoYW5rcyBmb3IgeW91ciB0aW1lIGFuZCBjb25zaWRlcmF0aW9uLg0K
DQpFcmlrDQpicmFkeUBjaXNjby5jb20NCg0KDQo=
