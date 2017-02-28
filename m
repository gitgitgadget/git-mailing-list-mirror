Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 901FA201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 16:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbdB1QMI (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 11:12:08 -0500
Received: from smtp-out10.electric.net ([185.38.180.45]:51415 "EHLO
        smtp-out10.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbdB1QLd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 11:11:33 -0500
X-Greylist: delayed 713 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Feb 2017 11:11:32 EST
Received: from 1cikBJ-00057o-Vf by out10a.electric.net with emc1-ok (Exim 4.87)
        (envelope-from <Adrian.Dudau@enea.com>)
        id 1cikBK-00058c-U3
        for git@vger.kernel.org; Tue, 28 Feb 2017 07:59:18 -0800
Received: by emcmailer; Tue, 28 Feb 2017 07:59:18 -0800
Received: from [192.36.1.72] (helo=mx-3.enea.com)
        by out10a.electric.net with esmtps (TLSv1:ECDHE-RSA-AES256-SHA:256)
        (Exim 4.87)
        (envelope-from <Adrian.Dudau@enea.com>)
        id 1cikBJ-00057o-Vf
        for git@vger.kernel.org; Tue, 28 Feb 2017 07:59:17 -0800
Received: from SESTOEX04.enea.se ([fe80::bc2d:9299:d6b2:d0b7]) by
 SESTOEX08.enea.se ([fe80::1c3:4003:dc47:23c0%11]) with mapi id
 14.03.0319.002; Tue, 28 Feb 2017 16:59:17 +0100
From:   Adrian Dudau <Adrian.Dudau@enea.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: format-patch subject-prefix gets truncated when using the
 --numbered flag
Thread-Topic: format-patch subject-prefix gets truncated when using the
 --numbered flag
Thread-Index: AQHSkdudPOedU6w8Skyvjk69WjT7EA==
Date:   Tue, 28 Feb 2017 15:59:16 +0000
Message-ID: <1488297556.2955.11.camel@enea.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.140.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3925A0F57243C4C98E8384F6D8C749E@enea.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-IP: 192.36.1.72
X-Env-From: Adrian.Dudau@enea.com
X-Proto: esmtps
X-Revdns: mx-3.enea.com
X-HELO: mx-3.enea.com
X-TLS:  TLSv1:ECDHE-RSA-AES256-SHA:256
X-Authenticated_ID: 
X-PolicySMART: 6551647
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8sDQoNCkkgbm90aWNlZCB0aGF0IHRoZSAtLXN1YmplY3QtcHJlZml4IHN0cmluZyBnZXRz
IHRydW5jYXRlZCBzb21ldGltZXMsDQpidXQgb25seSB3aGVuIHVzaW5nIHRoZSAtLW51bWJlcmVk
IGZsYXQuIEhlcmUncyBhbiBleGFtcGxlOg0KDQphZGR1QHNlc3RvZmIxMTovZGF0YS9mYi9hZGR1
L2dpdCQgZXhwb3J0IGxvbmdtPSJ2ZXJ5IHZlcnkgdmVyeSB2ZXJ5DQp2ZXJ5IHZlcnkgdmVyeSB2
ZXJ5IHZlcnkgdmVyeSB2ZXJ5IHZlcnkgdmVyeSB2ZXJ5IGxvbmcgcHJlZml4Ig0KDQoNCmFkZHVA
c2VzdG9mYjExOi9kYXRhL2ZiL2FkZHUvZ2l0JCBnaXQgZm9ybWF0LXBhdGNoIC0xIC0tc3ViamVj
dC0NCnByZWZpeD0iJGxvbmdtXVtQQVRDSCINCg0KQXMgZXhwZWN0ZWQsIGluIHRoZSBnZW5lcmF0
ZWQgcGF0Y2ggZmlsZSB3ZSBoYXZlOg0KU3ViamVjdDogW3ZlcnkgdmVyeSB2ZXJ5IHZlcnkgdmVy
eSB2ZXJ5IHZlcnkgdmVyeSB2ZXJ5IHZlcnkgdmVyeSB2ZXJ5DQp2ZXJ5IHZlcnkgbG9uZyBwcmVm
aXhdW1BBVENIXcKgDQrCoEZpcnN0IGJhdGNoIGFmdGVyIDIuMTINCg0KQnV0IG5vdywgaWYgSSBw
YXNzIHRoZSAtLW51bWJlcmVkIGZsYWcgdG9vOg0KYWRkdUBzZXN0b2ZiMTE6L2RhdGEvZmIvYWRk
dS9naXQkIGdpdCBmb3JtYXQtcGF0Y2ggLTEgLS1udW1iZXJlZCAtLQ0Kc3ViamVjdC1wcmVmaXg9
IiRsb25nbV1bUEFUQ0giDQoNCkluIHRoZSBnZW5lcmF0ZWQgcGF0Y2ggZmlsZSB3ZSBnZXQgdGhp
czrCoA0KU3ViamVjdDogW3ZlcnkgdmVyeSB2ZXJ5IHZlcnkgdmVyeSB2ZXJ5IHZlcnkgdmVyeSB2
ZXJ5IHZlcnkgdmVyRmlyc3QNCmJhdGNowqANCsKgYWZ0ZXIgMi4xMg0KDQpUaGlzIGlzIGhhcHBl
bmluZyBvbiB0aGUgbGF0ZXN0IG1hc3RlciBicmFuY2gsIHNvIEkgZHVnIHRocm91Z2ggdGhlDQpj
b2RlIGFuZCB0cmFja2VkIHRoZSBpc3N1ZSB0byB0aGlzIHBpZWNlIG9mIGNvZGUgaW4gbG9nLXRy
ZWUuYzoNCg0KwqDCoMKgwqDCoMKgwqDCoGlmIChvcHQtPnRvdGFsID4gMCkgew0KwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGF0aWMgY2hhciBidWZmZXJbNjRdOw0KwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzbnByaW50ZihidWZmZXIsIHNpemVvZihidWZmZXIpLA0K
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiU3ViamVj
dDogWyVzJXMlMCpkLyVkXSAiLA0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBvcHQtPnN1YmplY3RfcHJlZml4LA0KwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAqb3B0LT5zdWJqZWN0X3ByZWZpeCA/ICIgIiA6
ICIiLA0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBk
aWdpdHNfaW5fbnVtYmVyKG9wdC0+dG90YWwpLA0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBvcHQtPm5yLCBvcHQtPnRvdGFsKTsNCsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgc3ViamVjdCA9IGJ1ZmZlcjsNCsKgwqDCoMKgwqDCoMKgwqB9
IGVsc2UgaWYgKG9wdC0+dG90YWwgPT0gMCAmJiBvcHQtPnN1YmplY3RfcHJlZml4ICYmICpvcHQt
DQo+c3ViamVjdF9wcmVmaXgpIHsNCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Rh
dGljIGNoYXIgYnVmZmVyWzI1Nl07DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNu
cHJpbnRmKGJ1ZmZlciwgc2l6ZW9mKGJ1ZmZlciksDQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCJTdWJqZWN0OiBbJXNdICIsDQrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG9wdC0+c3ViamVjdF9wcmVmaXgp
Ow0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdWJqZWN0ID0gYnVmZmVyOw0KwqDC
oMKgwqDCoMKgwqDCoH0gZWxzZSB7DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN1
YmplY3QgPSAiU3ViamVjdDogIjsNCsKgwqDCoMKgwqDCoMKgwqB9DQoNCkFwcGFyZW50bHkgdGhl
IHNpemUgb2YgdGhlICJidWZmZXIiIHZhciBpcyBkaWZmZXJlbnQgaW4gdGhlIHR3bw0Kc2l0dWF0
aW9ucy4gQW55Ym9keSBrbm93cyBpZiB0aGlzIGlzIGJ5IGRlc2lnbiBvciBqdXN0IGFuIG9sZA0K
b3ZlcnNpZ2h0Pw0KSSBjYW4gc2VuZCBhIHBhdGNoIHRvIGZpeCBpdCBidXQgSSdtIG5vdCB2ZXJ5
IGZhbWlsaWFyIHdpdGggdGhlIGdpdA0KY29kZSBhbmQgSSdtIGFmcmFpZCBzb21lIGhpZGRlbiBj
b25zZXF1ZW5jZSBJIGRvbid0IHNlZSByaWdodCBub3cuDQoNCkNoZWVycywNCi0tQWRyaWFu
