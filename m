From: chenxitwo <chenxitwo@126.com>
Subject: Re: Git: How to keep multiple bare repos in sync?
Date: Wed, 3 Jun 2015 09:55:21 +0800
Message-ID: <201506030955200885513@126.com>
References: <2015051312090840845945@126.com>, 
	<xmqq4mnhccti.fsf@gitster.dls.corp.google.com>, 
	<2015051315014048836362@126.com>
Reply-To: chenxitwo <chenxitwo@126.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Cc: git <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 03:55:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzxu0-0005pp-HB
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 03:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbbFCBz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 21:55:28 -0400
Received: from m15-114.126.com ([220.181.15.114]:32980 "EHLO m15-114.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564AbbFCBz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 21:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:Mime-Version:Message-ID; bh=06ssI
	u8omlqocuVCyXe7j8sQKs7jNMP7n6IrM7OYaBY=; b=WSuqt84noG3RkfmC1pKVE
	DChCkN9mzgjrBujEbPX2HHPtv5qALHqYXv6JRnSdac5LB4rSEZ/CWsWMdvbgnUcu
	9f+JnuejTWWKNXSVZjrB1/agFWFNEf38mJ9ltUVt4Tw4zB857p0p526q6SrpcCSR
	m30c3G+xSSOayHh7kBrJFs=
Received: from eg080 (unknown [121.15.85.201])
	by smtp7 (Coremail) with SMTP id DsmowABHJgeIXm5VtXd8BA--.25227S2;
	Wed, 03 Jun 2015 09:55:21 +0800 (CST)
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.0.1.92[cn]
X-CM-TRANSID: DsmowABHJgeIXm5VtXd8BA--.25227S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1UZryktry5Cw47KF1kGrg_yoW8Cw4UpF
	ZxK3Z7ur1kKrZ8CrWkXrWkta4jywsYy3y3C34ktrykXws0gryxGFyakFWFg3yxGrWvqr1Y
	qr4DAFn8uan0vw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjjgxUUUUU=
X-Originating-IP: [121.15.85.201]
X-CM-SenderInfo: hfkh05plwz0qqrswhudrp/1tbiXAoO51R0Wdg5FQAAsy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270623>

SGkgS29ucmFkIFNjaGVyZXIsDQoJVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KIA0KCUJ1dCBnaXQg
bWlycm9yIGlzIGhlbHBsZXNzIGZvciBtZS4NCglJIGhhdmUgYW4gaWRlYSBhYm91dCB0d28gcmVw
b3MnIHN5bmMuIEhvd2V2ZXIgdGhlcmUgaXMgYSBwcm9ibGVtIHdpdGggdGhpcyBpcyBob3cgdG8g
cHJldmVudCBvdGhlciB1c3JzJyBwdXNoIG9wZXJhdGlvbi4NCiANCglEZXRhaWxzIGFzIGZvbGxv
d3M6DQoJVGVhbSBBLCBCIGhhdmUgdGhlaXIgb3duIGdpdCBzZXJ2ZXIgcmVwb3MsIHJlc3BlY3Rp
dmVseSByZXBvc19BLCByZXBvc19CLg0KCXN0ZXAxOiBUaGUgcmVwb3NfQSBsb2NraW5nIHJlcG9z
X0IgV2hlbiByZXBvc19BIHJlY2VpdmVkIFRlYW1fQSByZXF1ZXN0cyB0byBwdXNoLCBhbmQgcmVw
b3NfQiBjYW4ndCBhY2NlcHQgb3RoZXIgdXNlcnMnIHB1c2ggcmVxdWVzdC4gKHVzZSBwcmUtcmVj
ZWl2ZSBob29rKQ0KCXN0ZXAyOiBBZnRlciB0aGUgcmVwb3NfQSBpcyB1cGRhdGVkLCB0aGUgcmVw
b3NfQSB3aWxsIHNlbmQgcHVzaCByZXF1ZXN0IHRvIHRoZSByZXBvc19CLg0KCXN0ZXAzOiBBZnRl
ciB0aGUgcmVwb3NfQiBpcyB1cGRhdGVkLCB0aGUgcmVwb3NfQSB3aWxsIHVubG9jayB0aGUgcmVw
b3NfQi4NCiANCglQcm9ibGVtOiBIb3cgdG8gbG9jayBnaXQgcmVtb3RlIHJlcG9zIHRvIHByZXZl
bnQgb3RoZXIgdXNycycgcHVzaCBvcGVyYXRpb24uDQogDQoNCg0KLS0tLS0tLS0tLS0tLS0NCmNo
ZW54aXR3bw0KPm5vdCByZW1vdGUgc3luYy4gIA0KPg0KPldlIGhhdmUgdGhyZWUgdGVhbXMgdG8g
cGFydGljaXBhdGUgaW4gdGhlIHNhbWUgcHJvamVjdCwgYW5kIGlzIGxvY2F0ZWQgaW4gZGlmZmVy
ZW50IHBsYWNlcy4gQmFuZHdpZHRoIHRoYXQgYmV0d2VlbiB0aGUgdHdvIG9mIG91ciB0ZWFtcyBp
cyBub3QgZW5vdWdoLiBUaHJlZSB0ZWFtcyBoYXZlIHRoZWlyIG93biBnaXQgc2VydmVyLiBMaWtl
IHRoaXMga2luZCBvZiBzaXR1YXRpb24sIGhvdyBzaG91bGQgaGFuZGxlPw0KPg0KPg0KPg0KPmNo
ZW54aXR3bw0KPg0KPkZyb206IEp1bmlvIEMgSGFtYW5vDQo+RGF0ZTogMjAxNS0wNS0xMyAxMjoz
Nw0KPlRvOiBjaGVueGl0d28NCj5DQzogZ2l0DQo+U3ViamVjdDogUmU6IEdpdDogSG93IHRvIGtl
ZXAgbXVsdGlwbGUgYmFyZSByZXBvcyBpbiBzeW5jPw0KPmNoZW54aXR3byA8Y2hlbnhpdHdvQDEy
Ni5jb20+IHdyaXRlczoNCj4NCj4+IFRoZXJlIGFyZSB0aHJlZSBnaXQgc2VydmVyKGJhcmUgcmVw
b3MpLCBidXQgaSBkb24ndCBrbm93IHRvIHNvbHZlIHRoZQ0KPj4gcHJvYmxlbSB0aGF0IGhvdyB0
byBrZWVwIHRoZXNlIGdpdCBzZXJ2ZXJzIGluIHN5bmMuDQo+DQo+cnN5bmM/DQo+DQo+VGhlIHBy
b2JsZW0gaXMgdW5kZXItc3BlY2lmaWVkLiAgSXMgdGhlcmUgb25lIG9mIHRoZW0gdGhhdCBpcw0K
PmF1dGhvcml0YXRpdmUgYW5kIHRoYXQgdGhlIG90aGVyIG9uZXMgc2hvdWxkIG1hdGNoIGl0cyBw
cm9ncmVzcz8NCj5JZiBzbywgcGVyaGFwcyBwdXNoIGZyb20gdGhlIGF1dGhvcml0YXRpdmUgb25l
IHRvIHRoZSBvdGhlciB0d28NCj53aXRoICJwdXNoIC0tbWlycm9yIiAob3IgaGF2ZSB0aGUgb3Ro
ZXIgb25lcyAiZmV0Y2ggLS1taXJyb3IiKT8NCj4NCj5JZiB5b3UgYXJlIGFsbG93aW5nIHBlb3Bs
ZSB0byBwdXNoIGludG8gYW55IG9mIHRoZW0gcmFuZG9tbHksDQo+dGhlbiB0aGVyZSBpcyBubyBn
ZW5lcmFsIHNvbHV0aW9uLiAgSWYgSSBwdXNoIGFuIHVwZGF0ZSB0byAnbWFzdGVyJw0KPm9mIGlu
c3RhbmNlIEEgd2hpbGUgeW91IHVwZGF0ZSB0aGUgc2FtZSAnbWFzdGVyJyBicmFuY2ggb2YgaW5z
dGFuY2UNCj5CLCBzb21lYm9keSBoYXMgdG8gcmVjb25jaWxlIHRoZSBkaXZlcmdlbmNlIGJldHdl
ZW4gdGhlIHR3byBieQ0KPmNyZWF0aW5nIGEgbWVyZ2UsIGFuZCB0aGF0IGNhbiBwb3NzaWJseSBj
b25mbGljdCwgbmVlZGluZyBodW1hbg0KPmludGVydmVudGlvbiB0byByZXNvbHZlLg==
