From: Sebastien Toulmonde <Sebastien.Toulmonde@bisnode.com>
Subject: Re: Git 1.9.0 - build on Solaris 8 -> no git-remote-http ?
Date: Fri, 26 Sep 2014 08:43:18 +0000
Message-ID: <938AB08865DF82448B10C2CD60FD0AA1012349DC4C@EEL.pcs.sopres.be>
References: <938AB08865DF82448B10C2CD60FD0AA1012349C5EC@EEL.pcs.sopres.be>
 <vpqzjdnq4fm.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 10:53:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXRHZ-0005pr-Qn
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 10:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbaIZIxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 04:53:36 -0400
Received: from esa4.bisnode.c3s2.iphmx.com ([68.232.139.121]:54239 "EHLO
	esa4.bisnode.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753361AbaIZIxe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 04:53:34 -0400
X-Greylist: delayed 610 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Sep 2014 04:53:34 EDT
X-IronPort-AV: E=Sophos;i="5.04,603,1406584800"; 
   d="scan'208";a="1959393"
Received: from postman.wegenerdm.be (HELO postman.sopres.be) ([194.78.134.90])
  by esa4.bisnode.c3s2.iphmx.com with ESMTP; 26 Sep 2014 10:43:21 +0200
Received: from bmix.wdmbelgium.be by postman.sopres.be; Fri, 26 Sep 2014 10:43:20 +0200 (MEST)
Received: from EAGLE.pcs.sopres.be (EAGLE [172.16.70.241])
	by bmix.wdmbelgium.be (8.13.1/8.13.1) with ESMTP id s8Q8hKKY020145;
	Fri, 26 Sep 2014 10:43:20 +0200 (MEST)
Received: from EEL.pcs.sopres.be ([::1]) by EAGLE.pcs.sopres.be
 ([fe80::389b:5a27:371c:96f9%19]) with mapi id 14.02.0328.009; Fri, 26 Sep
 2014 10:43:19 +0200
Thread-Topic: Git 1.9.0 - build on Solaris 8 -> no git-remote-http ?
Thread-Index: AQHP2J8bRKVle0YUO0iiCBAN4VEU/JwRxIuTgAE0SYA=
In-Reply-To: <vpqzjdnq4fm.fsf@anie.imag.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101
 Thunderbird/24.6.0
x-originating-ip: [172.16.69.96]
Content-ID: <CB121514441C9943B29B8BE0923747B0@bisnode.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257503>

SGVsbG8gTWF0dGhpZXUsDQoNCkkgdGhvdWdodCBjdXJsIHdhcyBpbnN0YWxsZWQgY29ycmVjdGx5
IG9uIHRoZSBzZXJ2ZXIsIGJ1dCBhcHBhcmVudGx5IGl0IA0Kd2FzIG9ubHkgdGhlIGN1cmwgYmlu
YXJpZXMgKG5vIGhlYWRlcnMvbGlicykuDQoNClNvIHdoYXQgSSBkaWQgKGZvciB0aGUgcmVjb3Jk
cyk6DQoNCjEpIGNvbXBpbGUgY3VybC03LjM4LjAsIHByZWZpeCAvdXNyL2xvY2FsL2N1cmwtNy4z
OC4wIChzbyB0aGF0IG15IHN5c3RlbSANCmN1cmwgaXMgbm90IGltcGFjdGVkKQ0KMikgY29uZmln
dXJlIGdpdCB3aXRoOiBDQz0vb3B0L1NVTldzcHJvL2Jpbi9jYyAuL2NvbmZpZ3VyZSANCi0td2l0
aC1jdXJsPS91c3IvbG9jYWwvY3VybC03LjM4LjAgLS13aXRob3V0LXRjbHRrIA0KLS1wcmVmaXg9
L3Vzci9sb2NhbC9naXQtMS45LjANCg0KQW5kIG5vdywgZ2l0IGlzIG9wZXJhdGlvbmFsIChJIGRv
bid0IG5lZWQgdGhlIGd1aSkuDQoNClRoYW5rcyBmb3IgeW91ciBoZWxwIQ0KDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KU0VCQVNUSUVOIFRP
VUxNT05ERQ0KVU5JWCBTeXN0ZW0gQWRtaW5pc3RyYXRvcg0KSW5mb3JtYXRpb24gU2VydmljZXMg
RGVwYXJ0bWVudA0KICANCkJJU05PREUNCg0KRGlyZWN0OiArMzIgMiA1NTUgOTYgODYNCk1vYmls
ZTogKzMyIDQ3NSA0OSA4MSA0NQ0KT2ZmaWNlIGZheDogKzMyIDIgNTIxIDIxIDk4DQpFLW1haWw6
IHNlYmFzdGllbi50b3VsbW9uZGVAYmlzbm9kZS5jb20NCkFkZHJlc3M6IFJlc2VhcmNoZHJlZWYg
NjUgQWxsw6llIGRlIGxhIFJlY2hlcmNoZSwgMTA3MCBCcnVzc2VscywgQmVsZ2l1bQ0Kd3d3LmJp
c25vZGUuYmUNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQoNCk9uIDA5LzI1LzIwMTQgMDI6MTggUE0sIE1hdHRoaWV1IE1veSB3cm90ZToNCj4gU2Vi
YXN0aWVuIFRvdWxtb25kZSA8U2ViYXN0aWVuLlRvdWxtb25kZUBiaXNub2RlLmNvbT4gd3JpdGVz
Og0KPg0KPj4gSGVsbG8gYWxsLA0KPj4NCj4+IEknbSB0cnlpbmcgdG8gYnVpbGQgR2l0IGZyb20g
c291cmNlIGZvciBvdXIgZW5kLXVzZXJzLiBPdXIgcGxhdGZvcm0NCj4+IHJhbmdlIGZyb20gU29s
YXJpcyA4IHRvIDEwICh3ZSdyZSBtaWdyYXRpbmcgdG8gMTEgdGhpcyB5ZWFyKS4NCj4+IE1lYW53
aGlsZSwgSSdtIHRyeWluZyB0byBidWlsZCBHaXQgZnJvbSBzb3VyY2UsIGFzIHRoZXJlIGlzIG5v
IHBhY2thZ2UNCj4+IGZvciBTb2xhcmlzIDgvMTAgKG9wZW5jc3cgY2FuJ3QgYmUgdXNlZCBpbiBv
dXIgZW52aXJvbm1lbnQpLiBJJ3ZlIGJlZW4NCj4+IGFibGUgdG8gYnVpbGQgaXQgc3VjY2Vzc2Z1
bGx5LCB1c2luZyBTdW4gU3R1ZGlvIGFuZCBnbWFrZSAzLjg0LiBCdXQNCj4+IHVuZm9ydHVuYXRl
bHksIHRoZSBidWlsZCBwcm9jZXNzIGRvZXMgbm90IGNvbXBpbGUvbGluayBhbnkNCj4+IGdpdC1y
ZW1vdGUtKg0KPj4gcHJvZ3JhbXMuLi4gV2hpY2ggbGVhZHMgbWUgdG8gYW4gdW51c2FibGUgZ2l0
IGZvciB1c2UgaW4gcmVtb3RlDQo+PiBhcmNoaXRlY3R1cmUgKHdoaWNoIGlzIHdoYXQgd2UgdXNl
KS4NCj4gVGhlc2UgZ2l0LXJlbW90ZS0qIGhhdmUgbW9yZSBkZXBlbmRlbmNpZXMgdGhhbiB0aGUg
Y29yZSBnaXQgZXhlY3V0YWJsZS4NCj4gUHJvYmFibHkgeW91IGxhY2sgbGliY3VybCAobGliIG9y
IGhlYWRlciBmaWxlcykgb3Igc29tZXRoaW5nIGxpa2UgdGhpcz8NCj4NCgoqKioqIERJU0NMQUlN
RVIgKioqKgoiVGhpcyBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyB0aGVyZXRvIG1heSBjb250
YWluIGluZm9ybWF0aW9uIHdoaWNoIGlzIGNvbmZpZGVudGlhbCBhbmQvb3IgcHJvdGVjdGVkIGJ5
IGludGVsbGVjdHVhbCBwcm9wZXJ0eSByaWdodHMgYW5kIGFyZSBpbnRlbmRlZCBmb3IgdGhlIHNv
bGUgdXNlIG9mIHRoZSByZWNpcGllbnQocyluYW1lZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5m
b3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8s
IHRvdGFsIG9yIHBhcnRpYWwgcmVwcm9kdWN0aW9uLCBjb21tdW5pY2F0aW9uIG9yIGRpc3RyaWJ1
dGlvbiBpbiBhbnkgZm9ybSlieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGRlc2lnbmF0ZWQgcmVj
aXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWls
IGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgZWl0aGVyIGJ5IHRlbGVwaG9uZSBv
ciBieSBlLW1haWwgYW5kIGRlbGV0ZSB0aGUgbWF0ZXJpYWwgZnJvbSBhbnkgY29tcHV0ZXIuIFRo
YW5rIHlvdSBmb3IgeW91ciBjb29wZXJhdGlvbi4iCg==
