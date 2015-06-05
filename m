From: <steve.norman@thomsonreuters.com>
Subject: RE: Troubleshoot clone issue to NFS.
Date: Fri, 5 Jun 2015 12:01:16 +0000
Message-ID: <7FAE15F0A93C0144AD8B5FBD584E1C55197764FE@C111KXTEMBX51.ERF.thomson.com>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
 <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
 <20150522071224.GA10734@peff.net>
 <CACsJy8Bb1O7QZtiPWdzYwYgOdV0dLDgD3Xu_YaWNUbsuTqJB5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <git@vger.kernel.org>
To: <pclouds@gmail.com>, <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 05 14:02:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0qJm-0002z0-Oh
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 14:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbbFEMBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 08:01:37 -0400
Received: from mailout1-trp.thomsonreuters.com ([163.231.6.6]:45516 "EHLO
	mailout1-trp.thomsonreuters.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751376AbbFEMBg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2015 08:01:36 -0400
Received: from trpusmneagrly01.int.westgroup.com (relay1 [163.231.22.97])
	by mailout1-trp.thomsonreuters.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id t55C1R0Q026048
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Fri, 5 Jun 2015 12:01:28 GMT
Received: from EAGF-ERFPHUB13.ERF.thomson.com (xch4 [163.231.23.9])
	by trpusmneagrly01.int.westgroup.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id t55C1Oi6001674
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 5 Jun 2015 12:01:27 GMT
Received: from C111VCKHUB17.ERF.thomson.com (163.231.29.148) by
 EAGF-ERFPHUB13.ERF.thomson.com (163.231.23.9) with Microsoft SMTP Server
 (TLS) id 14.3.158.1; Fri, 5 Jun 2015 07:01:18 -0500
Received: from C111KXTEMBX51.ERF.thomson.com ([fe80::4999:4010:4bd1:ba61]) by
 C111VCKHUB17.ERF.thomson.com ([fe80::2900:d994:6cb2:b2a9%14]) with mapi id
 14.03.0158.001; Fri, 5 Jun 2015 07:01:16 -0500
Thread-Topic: Troubleshoot clone issue to NFS.
Thread-Index: AdCTxW/SgCCnMnTuQvaf51AB2UW2tgAN1NmAAAA88gAACEcAsAAL7E0AAA6C3AAAaFyXAAJXRjmA
In-Reply-To: <CACsJy8Bb1O7QZtiPWdzYwYgOdV0dLDgD3Xu_YaWNUbsuTqJB5g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.30.5]
X-TM-AS-Product-Ver: SMEX-10.2.0.3308-7.500.1018-21590.006
X-TM-AS-Result: No--0.848500-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270827>

T24gU3VuZGF5LCBNYXkgMjQsIDIwMTUgQCAxMDowMSBBTSBEdXkgTmd1eWVuIFttYWlsdG86cGNs
b3Vkc0BnbWFpbC5jb21dIGRpZCBzY3JpYmJsZToNCg0KPiBJbiBjYXNlIHlvdSB3YW50IHRvIGJh
Y2sgYXdheSBmcm9tIG9wdGlvbiAyIGJlY2F1c2UgaXQgc3RhcnRzIHRvIGxlYWsNCj4gcmFjaW5l
c3MsIHdoaWNoIHlvdXIgb2xkIGNvbW1pdCB0cmllZCB0byBmaXggaW4gdGhlIGZpcnN0IHBsYWNl
LiBJDQo+IHRoaW5rIHRoZSBvbmx5IG90aGVyIHBsYWNlIHRoYXQgdGVzdHMgZm9yIGxvdHMgb2Yg
bm9uLWV4aXN0ZW50IGxvb3NlDQo+IG9iamVjdHMgaXMgd3JpdGVfc2hhMV9maWxlIChlLmcuICJ0
YXIgLXhmIGJpZ3RhcmJhbGwudGFyLmd6OyBjZA0KPiBiaWd0YXJiYWxsOyBnaXQgaW5pdDsgZ2l0
IGFkZCAuIikuIEJ1dCB0aGUgbnVtYmVyIG9mIGNhbGxzIHNob3VsZCBiZQ0KPiBtdWNoIHNtYWxs
ZXIgY29tcGFyZWQgdG8gaW5kZXgtcGFjayBhbmQgaXQgZG9lcyBub3QgdXNlIGhhc19zaGExX2Zp
bGUsDQo+IGl0IHVzZXMgY2hlY2tfYW5kX2ZyZXNoZW5fZmlsZSgpIGluc3RlYWQuDQo+IA0KPiBU
aGVyZSBhcmUgb3RoZXIgcGxhY2VzIHdoZXJlIGhhc19zaGExX2ZpbGUoKSBtYXkgcmV0dXJuIDAs
IGJ1dCBJIHRoaW5rDQo+IHRoZSBudW1iZXIgb2YgY2FsbHMgaXMgZXZlbiBzbWFsbGVyIHRvIGJv
dGhlciAoc2hhbGxvdy5jLA0KPiBmZXRjaC1wYWNrLmMsIGFwcGx5LmMsIGJ1aWstY2hlY2tpbi5j
KQ0KDQpBbnkgdXBkYXRlcyAvIGZ1cnRoZXIgdGhvdWdodHMgb24gdGhpcz8NCg0KVGhhbmtzLA0K
DQpTdGV2ZQ0K
