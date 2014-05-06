From: "Klishevich, Yauheni" <yklishevich@scnsoft.com>
Subject: read-tree bug
Date: Tue, 6 May 2014 13:32:00 +0000
Message-ID: <CF8EBE3A.9AF%yklishevich@scnsoft.com>
References: <CF8EB1C1.996%yklishevich@scnsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 06 19:49:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiS0-0008Bg-4S
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207AbaEFNcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 09:32:21 -0400
Received: from mail4.scnsoft.com ([93.171.207.9]:22483 "EHLO mail2.scnsoft.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753312AbaEFNcU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 09:32:20 -0400
Received: from SRV-SCN-MBX2.scnsoft.com (10.20.1.84) by
 srv-scn-mbx1.scnsoft.com (10.20.1.83) with Microsoft SMTP Server (TLS) id
 15.0.775.38; Tue, 6 May 2014 16:32:01 +0300
Received: from SRV-SCN-MBX2.scnsoft.com ([fe80::e1f5:7334:ca34:3ec1]) by
 srv-scn-mbx2.scnsoft.com ([fe80::e1f5:7334:ca34:3ec1%14]) with mapi id
 15.00.0775.031; Tue, 6 May 2014 16:32:00 +0300
Thread-Topic: read-tree bug
Thread-Index: AQHPaSeoIWkS6oy84UubKFhYuyGk05szjNEA
In-Reply-To: <CF8EB1C1.996%yklishevich@scnsoft.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.2.58]
Content-ID: <D2AE60D9B0866D40B16BD9A750D4FCDF@scnsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248193>

U29tZSBtb3JlIGluZm86DQoNCglJZiBJIHVzZSBpbiA1LXRoIGNvbW1hbmQg4oCc4oCUcHJlZml4
PS0tcHJlZml4PW1iL3RydW5rL3NyYy9saWJz4oCcIC0gaXNzdWUgaXMNCnJlcHJvZHVjZWQNCg0K
CUlmIOKAnOKAlHByZWZpeD0tLXByZWZpeD1tYi9saWJz4oCcIC0gYWxsIHdvcmsgZmluZQ0KDQoJ
V2l0aCDigJzigJRwcmVmaXg9LS1wcmVmaXg9bWIvdHJ1bmsvbGlic+KAnCBJIGhhdmVu4oCZdCB0
cmllZCwgaWYgaXQgaXMgZGVzaXJlZA0KdG8gY2hlY2sgdGhpcyBjYXNlLCBqdXN0IGxldCBtZSBr
bm93Lg0KDQoNCg0KDQoNCg0KT24gNS82LzE0LCAxNTozNSwgIktsaXNoZXZpY2gsIFlhdWhlbmki
IDx5a2xpc2hldmljaEBzY25zb2Z0LmNvbT4gd3JvdGU6DQoNCj5IZWxsbyENCj4NCj5JIGhhdmUg
c29tZSB0cm91YmxlcyB3aXRoIGdpdCBjb21tYW5kIMKzcmVhZC10cmVlwrIuDQo+DQo+SSBoYXZl
IGJpZyBwcm9qZWN0IGFuZCBJIHRyeSB0byBhZGQgc2hhcmVkIGxpYnJhcnkgdG8gc3ViZGlyZWN0
b3J5LiBTbyBJDQo+bWFkZSB0aGUgZm9sbG93aW5nIGluIG15IHByb2plY3QgKG9uIG1hc3RlcikN
Cj4NCj5naXQgcmVtb3RlIGFkZCBnaXRAYml0YnVja2V0Lm9yZzppamluMTk4NC9ncm91bmR3b3Jr
LmdpdA0KPmdpdCBmZXRjaCBncm91bmR3b3JrDQo+Z2l0IGNoZWNrb3V0IMKtYiBnd2JyYW5jaCBn
cm91bmR3b3JrL21hc3Rlcg0KPmdpdCBjaGVja291dCBtYXN0ZXINCj5naXQgcmVhZC10cmVlIC0t
cHJlZml4PW1iL3RydW5rL3NyYy9ydS51cmFsc2liLmRiby5jbGllbnQuaXBob25lL2xpYnMvIC11
DQo+Z3dicmFuY2gNCj5naXQgY29tbWl0IMKtbSDCs2FkZCBncm91bmR3b3JrIHRvIGxpYnPCsg0K
PkFmdGVyIHRoYXQgSSBtYWtlIHNtYWxsIGNoYW5nZSBpbiBvbmUgZmlsZSBpbnNpZGUgbGlicyAo
Zm9yIGV4YW1wbGUgaW4NCj4ibWIvdHJ1bmsvc3JjL3J1LnVyYWxzaWIuZGJvLmNsaWVudC5pcGhv
bmUvbGlicy9ncm91bmR3b3JrL25vdGVzLnR4dMKyIGFuZA0KPmNvbW1pdCB3aXRoIA0KPmdpdCBj
b21taXQgwq1hIMKtbSDCs3Rlc3QgY29tbWl0wrINCj4NCj5UaGVuIEkgbWFkZTogDQo+Z2l0IGNo
ZWNrb3V0IGd3YnJhbmNoDQo+Z2l0IG1lcmdlIC0tc3F1YXNoIC1zIHN1YnRyZWUgLS1uby1jb21t
aXQgbWFzdGVyDQo+DQo+QW5kIGFmdGVyIHRoaXMgaW5zdGVhZCBvZiBtZXJnaW5nIEkgZmluZCB0
aGUgd2hvbGUgbWFpbiBwcm9qZWN0IGluIHN1YmRpcg0KPsKzZ3JvdW5kd29yay9Hcm91bmR3b3Jr
L0Jhc2UubHByb2rCsi4NCj4NCj5JZiBJIGRvIHRoZSA1LXRoIGNvbW1hbmQgd2l0aCDigLlwcmVm
aXggb3B0aW9uIHZhbHVlIGVxdWFsIHRvIGZvciBleGFtcGxlDQo+wrNsaWJzwrIgdGV0aGVyIHRo
YW4gc29tZXRoaW5nIGxpa2UgwrNzdWJkaXIvc3Vic3ViZGlyL8WgL2xpYnPCsiAtIGFsbCB3b3Jr
cw0KPmZpbmUuDQo+DQo+SSB0aGluayB0aGF0IGl0IGlzIGJhZywgYmVjYXVzZSBJIGV4cGVyaW1l
bnRlZCBxdWl0ZSBhIGxvdCB3aXRoIGRlZmVycmVudA0KPnZhbHVlcy4gSSB0aGluayB0aGF0IHBy
b2JsZW0gaW4gZGlyZWN0b3J5IG5hbWUgd2l0aCBkb3RzLCBpLmUuDQo+InJ1LnVyYWxzaWIuZGJv
LmNsaWVudC5pcGhvbmXCsi4NCj4NCj5Db3VsZCB5b3UgcGxlYXNlIGhlbHAgbWUgd2l0aCB0aGlz
IGlzc3VlLiBJZiB5b3UgbmVlZCB0byBhZGQgc29tZSBtb3JlDQo+aW5mbyBhYm91dCB0aGlzIGNh
c2UgSSB3aWxsIHByb3ZpZGUuDQo+DQo+VGhhbmtzIGluIGFkdmFuY2UuDQo+DQo+DQo+QmVzdCBy
ZWdhcmRzLCANCj5FdWdlbmUgS2xpc2hldmljaA0KPmlPUy1kZXZlbG9wZXINCj5za3lwZTogZXVn
ZW5lLmtsaXNoZXZpY2gNCj4NCj4NCj4NCj4NCg0K
