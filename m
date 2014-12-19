From: "Dan Langille (dalangil)" <dalangil@cisco.com>
Subject: Re: git-http-backend auth via Kerberos
Date: Fri, 19 Dec 2014 20:57:51 +0000
Message-ID: <FBFEB910-4CB8-4049-901C-AADBFAB3AE9E@cisco.com>
References: <540A8740-B240-40FF-BB50-0D90DEA04031@cisco.com>
 <20141218225418.GA84625@vauxhall.crustytoothpaste.net>
 <D562883B-47D7-4569-B1BB-84BFBDCBA93A@cisco.com>
 <20141219201633.GA88110@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Dec 19 21:58:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y24cZ-0001G1-2T
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 21:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbaLSU5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 15:57:53 -0500
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:48275 "EHLO
	rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbaLSU5x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 15:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3712; q=dns/txt; s=iport;
  t=1419022672; x=1420232272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sIgW7YuGr8DNtOCGe9goapftg5kAetUqHWGvQCq68vU=;
  b=Q+YdUkQvYlWJD4ZhcudiTCueLiZa8qCW54Wi8QSrvq2O9RXpBoOIgG58
   hRFhZrtt5brk1VnlpBiWHGUed90jprhYWdhb1Y3mbbHo68j78Rteos696
   hVsGffz3BjqwhIo5HpyRVzthUL4y+EYL5OryjF/8I3rIXv6ylIbgGq6pn
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq8GAHiQlFStJA2N/2dsb2JhbABagwZSWASDAcMjhXUCHHsWAQEBAQF9hAwBAQEDASMRRRACAQgYAgIUDAYCAgIwFRACBA4FiCQIunOFLZB3AQEBAQEBAQEBAQEBAQEBAQEBAQEBF4EhjgxFBwQUglAugRMFjg2DPoU0gQ0wijqCGIM5IoNub4FFfgEBAQ
X-IronPort-AV: E=Sophos;i="5.07,608,1413244800"; 
   d="scan'208";a="378340808"
Received: from alln-core-8.cisco.com ([173.36.13.141])
  by rcdn-iport-1.cisco.com with ESMTP; 19 Dec 2014 20:57:52 +0000
Received: from xhc-rcd-x09.cisco.com (xhc-rcd-x09.cisco.com [173.37.183.83])
	by alln-core-8.cisco.com (8.14.5/8.14.5) with ESMTP id sBJKvpq1011548
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 19 Dec 2014 20:57:52 GMT
Received: from xmb-rcd-x03.cisco.com ([169.254.7.194]) by
 xhc-rcd-x09.cisco.com ([173.37.183.83]) with mapi id 14.03.0195.001; Fri, 19
 Dec 2014 14:57:51 -0600
Thread-Topic: git-http-backend auth via Kerberos
Thread-Index: AQHQGxCrd+//UJfMPkWu780RpZEfpJyWWaAAgAEPyoCAAFZngIAAC4gA
In-Reply-To: <20141219201633.GA88110@vauxhall.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.82.243.85]
Content-ID: <252F6469A393854F9160FDD23BAF87EB@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261595>

T24gRGVjIDE5LCAyMDE0LCBhdCAzOjE2IFBNLCBicmlhbiBtLiBjYXJsc29uIDxzYW5kYWxzQGNy
dXN0eXRvb3RocGFzdGUubmV0PiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgRGVjIDE5LCAyMDE0IGF0
IDAzOjA3OjIwUE0gKzAwMDAsIERhbiBMYW5naWxsZSAoZGFsYW5naWwpIHdyb3RlOg0KPj4gQ29y
cmVjdCwgd2UgYXJlIHRyeWluZyB0byBhdm9pZCB0aGF0LiAgSW4gYWRkaXRpb24sIHRoZXJlIGlz
IG9ubHkgaHR0cHMsIG5vIGh0dHAuDQo+IA0KPiBJIGRvbid0IHRoaW5rIEhUVFBTIHZlcnN1cyBI
VFRQIG1hdHRlcnMuICBJIHVzZSBLZXJiZXJvcyBvdmVyIEhUVFBTIG9ubHkNCj4gYW5kIGl0IHdv
cmtzIGZpbmUuDQo+IA0KPj4gVG8gYmUgY2xlYXIsIGZvciB0aGUgZm9sbG93aW5nIHRlc3RzLCB0
aGVyZSBpcyBubyBLZXJiZXJvcyB0aWNrZXQuDQo+PiANCj4+IEkgdHJpZWQgdGhhdCBVUkwgdXNp
bmcgdGhyZWUgZGlmZmVyZW50IGJyb3dzZXJzLiAgRWFjaCB0aW1lIEkgYW0gcHJvbXB0ZWQgZm9y
DQo+PiBhIHVzZXJuYW1lICYgcGFzc3dvcmQuICBBZnRlciBlbnRlcmluZyB2YWxpZCBjcmVkZW50
aWFscywgSSBnZXQ6DQo+PiANCj4+IENocm9tZTogTm8gZGF0YSByZWNlaXZlZC4gVW5hYmxlIHRv
IGxvYWQgdGhlIHdlYnBhZ2UgYmVjYXVzZSB0aGUgc2VydmVyDQo+PiBzZW50IG5vIGRhdGEuIEVy
cm9yIGNvZGU6IEVSUl9FTVBUWV9SRVNQT05TRQ0KPj4gDQo+PiBXaXRoIEZpcmVmb3g6IFRoZSBj
b25uZWN0aW9uIHdhcyByZXNldA0KPj4gDQo+PiBTYWZhcmk6IFNhZmFyaSBDYW7igJl0IE9wZW4g
VGhlIFBhZ2UNCj4+IA0KPj4gSG93ZXZlciwgSSBkaWQgc3R1bWJsZSBhY3Jvc3Mgc29tZXRoaW5n
IHdoaWNoIHNlZW1zIHByb21pc2luZy4NCj4+IA0KPj4gQWZ0ZXIgdGhlIGFib3ZlIGZhaWx1cmVz
LCBpZiBJIHRoZW4gYnJvd3NlIHRvIC9naXR3ZWIvDQo+PiAod2hlcmUgSSBzZWUgZXhwZWN0ZWQg
cmVzdWx0cykgYW5kIHRoZW4gZ28gdG8gdGhlIGluZm8vcmVmcyBVUkwgeW91IHN1cHBsaWVkLA0K
Pj4gSSBzZWUgZGF0YSBzdWNoIGFzIHRoaXM6DQo+PiANCj4+ICAgZmUwNjhhOGFlNTVjZWE0YmI5
MGUyY2M3MTQxMDdmNGM1Mzg5ZDUxNglyZWZzL2hlYWRzLzAuOTYueA0KPj4gICBkMzg0YTk2Mzk4
MGU5YjQwZTM0ZGVhODBlYWMyODBjZjJkNGI3YzczCXJlZnMvaGVhZHMvMC45Ny54DQo+PiANCj4+
IENvbmNsdXNpb246IHRoZXJlIGlzIHNvbWV0aGluZyBpbiB0aGUgL2dpdHdlYiBhdXRoIHdoaWNo
IGlzIHN1Y2NlZWRpbmcgYW5kIHRoZW4NCj4+IGFsbG93aW5nIC9naXQgdG8gd29yaw0KPiANCj4g
VGhhdCBjb3VsZCBwb3NzaWJseSBiZSBkdWUgdG8gS3JiU2F2ZUNyZWRlbnRpYWxzLg0KPiANCj4+
IEZvciB0aGUgcmVjb3JkLCB0aGlzIGlzIHRoZSBnaXR3ZWIgYXV0aDoNCj4+IA0KPj4gPExvY2F0
aW9uIC9naXR3ZWI+DQo+PiAgU1NMT3B0aW9ucyArU3RkZW52VmFycw0KPj4gIE9wdGlvbnMgK0V4
ZWNDR0kgK0ZvbGxvd1N5bUxpbmtzICtTeW1MaW5rc0lmT3duZXJNYXRjaA0KPj4gDQo+PiAgQXV0
aFR5cGUgICAgICAgICAgIEtlcmJlcm9zDQo+PiAgQXV0aE5hbWUgICAgICAgICAgIOKAnHVzLmV4
YW1wbGUuY29tIg0KPj4gIEtyYkF1dGhSZWFsbXMgICAgICB1cy5leGFtcGxlLmNvbQ0KPj4gIEty
YlNlcnZpY2VOYW1lICAgICBIVFRQL3VzLmV4YW1wbGUuY29tDQo+PiAgS3JiNUtleXRhYiAgICAg
ICAgIC91c3IvbG9jYWwvZXRjL2FwYWNoZTIyL3JlcG8tdGVzdC5rZXl0YWINCj4+ICBLcmJNZXRo
b2ROZWdvdGlhdGUgb24NCj4+ICBLcmJNZXRob2RrNVBhc3N3ZCAgb24NCj4gDQo+IERvZXMgaXQg
d29yayBpZiB5b3Ugc2V0IHRoaXMgdmFsdWUgKEtyYk1ldGhvZEs1UGFzc3dkIG9uKSBleHBsaWNp
dGx5IGluDQo+IHRoZSBvdGhlciBjb25maWd1cmF0aW9uPyAgVGhhdCBtaWdodCBiZSBzdWZmaWNp
ZW50Lg0KDQpObywgaXQgZG9lcyBub3QuDQoNCj4+IFRoYXQgYXR0ZW1wdCBpcyBzaG93biBoZXJl
OiBodHRwOi8vZHBhc3RlLmNvbS8wNFJHMzdFLnR4dA0KPj4gDQo+Pj4gWW91J2xsIG9idmlvdXNs
eQ0KPj4+IHdhbnQgdG8gc2VlIGlmIHRoZSBzZXJ2ZXIgb2ZmZXJzIEJhc2ljIGF1dGggYXMgd2Vs
bCBhcyBOZWdvdGlhdGUuDQo+PiANCj4+IEnigJltIG5vdCB1cCBvbiBteSBrbm93bGVkZ2UgaGVy
ZS4gIFlvdSBtZWFuIHRoZSBLZXJiZXJvcyBzZXJ2ZXI/DQo+IA0KPiBObywgSSBtZWFudCB0aGUg
SFRUUCBzZXJ2ZXIsIHdoaWNoIGl0IGxvb2tzIGxpa2UgZnJvbSB5b3VyIGF0dGVtcHQgaXQNCj4g
ZG9lcy4gIEknbSBub3QgcmVhbGx5IHN1cmUgd2hhdCB0aGUgaXNzdWUgaXMgYWZ0ZXIgbG9va2lu
ZyBhdCB0aGF0LA0KPiBhbHRob3VnaCBpdCBsb29rcyBsaWtlIEdpdCBpc24ndCBzZW5kaW5nIHRo
ZSB1c2VybmFtZSBhbmQgcGFzc3dvcmQuDQo+IEknbGwgdHJ5IHRvIGxvb2sgYXQgdGhpcyBhIGxp
dHRsZSBtb3JlIHRoaXMgd2Vla2VuZC4NCg0KSWYgeW91IGNhbiwgdGhhbmtzLiAgSeKAmWxsIGJl
IGhhcHB5IHRvIHJ1biBhbnkgdGVzdHMgZXRjLiAgSeKAmW0gdGhlIHNlY29uZA0KcGVyc29uIGhl
cmUgdG8gdGFja2xlIHRoaXMgYW5kIHdlIGtlZXAgaGl0dGluZyB0aGUgc2FtZSBibG9jay4NCg0K
Y2hlZXJzDQoNCuKAlCANCkRhbiBMYW5naWxsZQ0KSW5mcmFzdHJ1Y3R1cmUgJiBPcGVyYXRpb25z
DQpUYWxvcyBHcm91cA0KU291cmNlZmlyZSwgSW5jLg0K
