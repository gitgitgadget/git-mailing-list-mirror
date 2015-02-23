From: "Sokolov, Konstantin (ext)" <konstantin.sokolov.ext@siemens.com>
Subject: AW: git blame swallows up lines in case of mixed line endings
Date: Mon, 23 Feb 2015 19:09:21 +0000
Message-ID: <71BF70CE41AEE741896AF3A5450D86F11F2D21EB@DEFTHW99EH3MSX.ww902.siemens.net>
References: <71BF70CE41AEE741896AF3A5450D86F11F2D1F46@DEFTHW99EH3MSX.ww902.siemens.net>
	<54E88BFA.9050900@web.de> <xmqqwq38tql9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "'git@vger.kernel.org'" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 20:09:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPyO5-0003qH-JT
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 20:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbbBWTJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 14:09:45 -0500
Received: from david.siemens.de ([192.35.17.14]:40197 "EHLO david.siemens.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752695AbbBWTJp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 14:09:45 -0500
Received: from mail2.sbs.de (localhost [127.0.0.1])
	by david.siemens.de (8.14.3/8.14.3) with ESMTP id t1NJ9U6n005966;
	Mon, 23 Feb 2015 20:09:31 +0100
Received: from DEFTHW99ERHMSX.ww902.siemens.net (defthw99erhmsx.ww902.siemens.net [139.22.70.133])
	by mail2.sbs.de (8.14.3/8.14.3) with ESMTP id t1NJ9SMY028209
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 23 Feb 2015 20:09:30 +0100
Received: from DEFTHW99ER0MSX.ww902.siemens.net (139.22.70.175) by
 DEFTHW99ERHMSX.ww902.siemens.net (139.22.70.133) with Microsoft SMTP Server
 (TLS) id 14.3.224.2; Mon, 23 Feb 2015 20:09:23 +0100
Received: from DEFTHW99EH3MSX.ww902.siemens.net ([169.254.1.249]) by
 DEFTHW99ER0MSX.ww902.siemens.net ([139.22.70.175]) with mapi id
 14.03.0224.002; Mon, 23 Feb 2015 20:09:22 +0100
Thread-Topic: git blame swallows up lines in case of mixed line endings
Thread-Index: AQHQT5jNIhmDfLX5RVankGP+MpKSCZz+lyjQ
In-Reply-To: <xmqqwq38tql9.fsf@gitster.dls.corp.google.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.22.70.37]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264287>

VGhhbmsgeW91IGZvciBnb2luZyBpbnRvIHRoZSBtYXR0ZXIuIEkgd2FzIG5vdCBhd2FyZSBvZiB0
aGUgdGV4dGNvbnYgZmlsdGVyLiBUaGlzIGlzIGRlZmluaXRlbHkgYSBkZWNlbnQgc29sdXRpb24u
IEJ1dCB3aGF0IGV4YWN0bHkgZG8geW91IG1lYW4gYnkgIkV2ZW4gdGhvdWdoIHdlIGhhdmUgYW4g
b3B0aW9uIHRvIG1hcmsgPENSPiBhbG9uZSBhcyB0aGUgZW5kIG9mIGxpbmUgbWFya2VyIj8gSXMg
dGhlcmUgcmVhbGx5IHN1Y2ggYW4gb3B0aW9uIGluIEdpdCBvciBkaWQgeW91IG1lYW4gdGhhdCBp
dCdzIHBvc3NpYmxlIGluIGdlbmVyYWwgKGJ5IGNoYW5naW5nIHRoZSBpbXBsZW1lbnRhdGlvbik/
DQoNCktpbmQgUmVnYXJkcw0KS29uc3RhbnRpbg0KDQotLS0tLVVyc3Byw7xuZ2xpY2hlIE5hY2hy
aWNodC0tLS0tDQpWb246IEp1bmlvIEMgSGFtYW5vIFttYWlsdG86Z2l0c3RlckBwb2JveC5jb21d
IA0KR2VzZW5kZXQ6IE1vbnRhZywgMjMuIEZlYnJ1YXIgMjAxNSAxOTo0NQ0KQW46IFRvcnN0ZW4g
QsO2Z2Vyc2hhdXNlbg0KQ2M6IFNva29sb3YsIEtvbnN0YW50aW4gKGV4dCk7ICdnaXRAdmdlci5r
ZXJuZWwub3JnJw0KQmV0cmVmZjogUmU6IGdpdCBibGFtZSBzd2FsbG93cyB1cCBsaW5lcyBpbiBj
YXNlIG9mIG1peGVkIGxpbmUgZW5kaW5ncw0KDQpUb3JzdGVuIELDtmdlcnNoYXVzZW4gPHRib2Vn
aUB3ZWIuZGU+IHdyaXRlczoNCg0KPiBPbiAyMDE1LTAyLTE5IDE0LjQ4LCBTb2tvbG92LCBLb25z
dGFudGluIChleHQpIHdyb3RlOg0KPj4gDQo+PiBJIGVuY291bnRlciB1bmV4cGVjdGVkIGJlaGF2
aW9yIGluIHRoZSBmb2xsb3dpbmcgY2FzZToNCj4+IA0KPj4gZmlsZSBjb250ZW50Og0KPj4gDQo+
PiBsaW5lMTxDUj48TEY+DQo+PiBsaW5lMjxDUj4NCj4+IGxpbmUzPENSPjxMRj4NCj4+IGxpbmU0
DQoNCllvdSBjYW4gbWFyayBhIGZpbGUgYXMgPENSTEY+IHRlcm1pbmF0ZWQgdmlhIGF0dHJpYnV0
ZXMgc3lzdGVtIGFuZCBoYXZlIEdpdCBjb252ZXJ0IHRoZW0gdG8gdXNlIDxMRj4gYXMgZW5kLW9m
LWxpbmUgd2hlbiBmaWxlIGNvbnRlbnRzIGFyZSBzdG9yZWQgaW4gR2l0ICgiPExGPiBhcyBlbmQt
b2YtbGluZSIgaXMgdGhlIHJlcHJlc2VudGF0aW9uICJnaXQgYmxhbWUiIHVzZXMgaW50ZXJuYWxs
eSkuICBLb25zdGFudGluIHNhaWQgIm9uIFdpbmRvd3MiLCBhbmQgSSBndWVzc2VkIGluaXRpYWxs
eSB0aGF0IHRoZSBsaW5lcyBhcmUgbWFya2VkIGFzIHN1Y2gsIGJ1dCBhZnRlciBsb29raW5nIGF0
IHRoZSBibGFtZS50eHQgb3V0cHV0IEkgYW0gbm90IHN1cmUuDQoNClRoYXQgbWVhbnMgdGhlIGNv
bnRlbnRzIG9mIHRoZSBsaW5lcyBhcmU6DQoNCiAgICBGaXJzdCBMaW5lOiAgImxpbmUxIg0KICAg
IFNlY29uZCBMaW5lOiAibGluZTIiICsgQ1IgKyAibGluZTMiDQogICAgVGhpcmQgTGluZTogICJs
aW5lNCINCg0Kb3IgaWYgQ1JMRiBjb252ZXJzaW9uIGlzIG5vdCBzcGVjaWZpZWQgaW4gS29uc3Rh
bnRpbidzIHJlcG9zaXRvcnk6DQoNCiAgICBGaXJzdCBMaW5lOiAgImxpbmUxIiArIENSDQogICAg
U2Vjb25kIExpbmU6ICJsaW5lMiIgKyBDUiArIENSICsgImxpbmUzIiArIENSDQogICAgVGhpcmQg
TGluZTogICJsaW5lNCIgKyBDUg0KDQpFaXRoZXIgd2F5LCB0aGF0IG1ha2VzIHRoZSBvYnNlcnZl
ZCBiZWhhdmlvciB0b3RhbGx5IGV4cGVjdGVkIGFuZCB1bmRlcnN0YW5kYWJsZS4NCg0KPj4gVGhp
cyBpcyB3aGF0IEkgZ2V0IGFzIGNvbnNvbGUgb3V0cHV0IChvbiBXaW5kb3dzKToNCj4+IA0KPj4+
IGdpdCBibGFtZSAtcyBmaWxlLnR4dA0KPj4gN2RiMzY0MzYgMSkgbGluZTENCj4+IGxpbmUzNDM2
IDIpIGxpbmUyDQo+PiA3ZGIzNjQzNiAzKSBsaW5lNA0KDQpBcyBwcmludGluZyBDUiBtb3ZlcyB0
aGUgY3Vyc29yIHRvIHRoZSBiZWdpbm5pbmcgb2YgbGluZSBvbiBtYW55IHRlcm1pbmFscywgaXQg
aXMgdW5kZXJzdGFuZGFibGUgdG8gc2VlIHRoZSBhYm92ZSBvdXRwdXQuICBBZnRlciBwcmludGlu
ZyB0aGUgZmlyc3QgbGluZSwgaXQgd2lsbCBzaG93IA0KDQogICAgN2RiMzY0MzYgMikgbGluZTIN
Cg0KYW5kIHRoZW4gZ28gYmFjayB0byB0aGUgbGVmdG1vc3QgY29sdW1uIGFuZCB0aGVuIG92ZXJ3
cml0ZSA3ZGIzLi4uDQp3aXRoICJsaW5lMyIuDQoNCkV2ZW4gdGhvdWdoIHdlIGhhdmUgYW4gb3B0
aW9uIHRvIG1hcmsgPENSPiBhbG9uZSBhcyB0aGUgZW5kIG9mIGxpbmUgbWFya2VyLCBiZWNhdXNl
IHRoZSBibGFtZWQgY29udGVudCBjYW4gZ28gdGhyb3VnaCB0aGUgdGV4dGNvbnYgZmlsdGVyLCBp
dCBtYXkgYmUgcG9zc2libGUgdG8gZGVmaW5lIGEgdGV4dGNvbnYgZmlsdGVyIGZvciB0aGUgcGF0
aCB2aWEgdGhlIGF0dHJpYnV0ZSBzeXN0ZW0gYW5kIGNvbnZlcnQgc3VjaCAibWl4ZWQgbGluZSBl
bmRpbmdzIg0KY29udGVudHMgdG8gYSBzZXJpZXMgb2YgPExGPi10ZXJtaW5hdGVkIGxpbmVzLiAg
VGhhdCB3b3VsZCBzcGxpdCB0aGUgc2Vjb25kIGxpbmUgaW4gdGhlIG9yaWdpbmFsIGlucHV0IGlu
dG8gdHdvIGxpbmVzIGFuZCBtYXkgcHJvZHVjZSBkZXNpcmVkIHJlc3VsdC4NCg0K
