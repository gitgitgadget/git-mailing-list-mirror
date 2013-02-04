From: Jongman Heo <jongman.heo@samsung.com>
Subject: Re: Re: Re: Re: Re: Segmentation fault with latest git (070c57df)
Date: Mon, 04 Feb 2013 02:18:06 +0000 (GMT)
Message-ID: <19086873.858651359944284535.JavaMail.weblogic@epml01>
Reply-To: jongman.heo@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 03:18:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Bdi-0000a4-2O
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 03:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903Ab3BDCSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 21:18:12 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:53834 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730Ab3BDCSI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 21:18:08 -0500
Received: from epcpsbge6.samsung.com (epcpsbge6 [203.254.230.16])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHO005BDBNTANA0@mailout1.samsung.com> for
 git@vger.kernel.org; Mon, 04 Feb 2013 11:18:06 +0900 (KST)
Received: from epcpdlpp3 ( [203.254.230.43])	by epcpsbge6.samsung.com (EPCPMTA)
 with SMTP id 8C.B9.20213.E5A1F015; Mon, 04 Feb 2013 11:18:06 +0900 (KST)
X-AuditID: cbfee610-b7f856d000004ef5-a4-510f1a5e1557
Received: from epextmailer03 ( [203.254.219.153])
	by epcpsbge6.samsung.com (EPCPMTA) with SMTP id 6C.B9.20213.E5A1F015; Mon,
 04 Feb 2013 11:18:06 +0900 (KST)
X-MTR: 20130204021442994@jongman.heo
Msgkey: 20130204021442994@jongman.heo
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130204021442994@jongman.heo
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
MIME-version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsVy+t8zbd04Kf5Ag579hhZdV7qZHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4Mo4dr2y4Al3xa8TL1gaGHdwdzFycggJqEnc/HyIEcSWEDCRuHnj
	LRuELSZx4d56IJsLqGYWo8THNctZYYpOv1jIBNE8n1HiwuJIEJtFQEVi55U/LCA2m4CORMf/
	/WD1wgJeEr9bl4DViwhoSbz7fZsRZCizwE5GiStzbjJCDFKUuLZ0MdhmXgFBiZMzn7BALFOR
	+Hz8MCNEXFXi8PojzBBxCYlZ0y9AHcQrMaP9KVS9nMS0r2ugaqQlzs/awAjzzeLvj6Hi/BLH
	bu8AOogDrPfJ/WCYMbs3f4F6XkBi6pmDUK2aEp+PbYIazyexZuFbFpgxu04tZ4bpvb9lLtiP
	zECvTOl+yA5ha0l8+bEPw1u8Ak4SUx9vZ5vAqDwLSWoWkvZZSNqR1SxgZFnFKJpakFxQnJSe
	aqZXnJhbXJqXrpecn7uJEZIWBHYwLmmwOMQowMGoxMPL+IsvUIg1say4MvcQowQHs5II71Uj
	oBBvSmJlVWpRfnxRaU5q8SHGZGAMTmSWEk3OB6asvJJ4Q2MDY0NDS0MzU0tTA9KElcR52Sum
	BwgJpCeWpGanphakFsFsYeLglGpgrCq5W9CXcENTX+anjLzHhQXzfCaKFKVovmsOMzNfmM8Q
	fuXXZl/eKxZmG8wOVsz0Tp4tw+NbM9Hxly6vc29pi2bUwi3tKWyfb1zrV539z9L3l+f06ZYv
	5ugYTuebdFm9O7NrXdf0GOXvreYvrmjf/t7mF+LwhPORYqH6hzOaOYWyfhqdTwqV 
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42I5/e/2TN04Kf5Ag1t9OhZdV7qZHBg9Pm+S
	C2CMyrDJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMARqq
	pFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVijYyMNYzMjXRMzI20DMxiLUyNDAwMgWqSsjI
	OHa9suAJd8WvEy9YGhh3cHcxcnIICahJ3Px8iBHElhAwkTj9YiEThC0mceHeejaImvmMEhcW
	R4LYLAIqEjuv/GEBsdkEdCQ6/u9nBbGFBbwkfrcuAesVEdCSePf7NtBMLg5mgZ2MElfm3GSE
	GKQocW3pYrChvAKCEidnPmGBWKYi8fn4YUaIuKrE4fVHmCHiEhKzpl9ghbB5JWa0P4Wql5OY
	9nUNVI20xPlZGxhhjl78/TFUnF/i2O0dQAdxgPU+uR8MM2b35i9sELaAxNQzB6FaNSU+H9sE
	NZ5PYs3CtywwY3adWs4M03t/y1ywH5mBXpnS/ZAdwtaS+PJjH4a3eAWcJKY+3s42gVFuFpLU
	LCTts5C0I6tZwMiyilE0tSC5oDgpPdVMrzgxt7g0L10vOT93EyM4QT0T2MG4pMHiEKMAB6MS
	Dy/jL75AIdbEsuLK3EOMEhzMSiK8V42AQrwpiZVVqUX58UWlOanFhxiTgTE4kVlKNDkfmDzz
	SuINjQ2MDQ0tzQ1MDY0sSBNWEudlr5geICSQnliSmp2aWpBaBLOFiYNTqoGxN22Z76Rjqbv2
	HpyhbXXjPPebPcyPxbLbpyh2rMjZnCDBbMvR3bjB0czinPmTFUyzYuu1X7bPWbRE 
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215347>

DQpKb25hdGhhbiBOaWVkZXIgd3JvdGU6DQoNCj4gSm9uZ21hbiBIZW8gd3JvdGU6DQo+DQo+Pj4g
QnV0IGl0IGRvZXNuJ3Qgc3RpbXVsYXRlIGFueSBwcmVyZXF1aXNpdGVzIGluIG1ha2UsIHdoaWNo
IGlzIHdlaXJkLg0KPj4+IFdoYXQncyBpbiBidWlsdGluLy5kZXBlbmQvZmV0Y2guby5kPw0KPlsu
Li5dDQo+PiBwbGVhc2Ugc2VlIGJlbG93fi4NCj4+DQo+PiAkIGNhdCBidWlsdGluLy5kZXBlbmQv
ZmV0Y2guby5kICAgICAgICAgICAgDQo+PiBmZXRjaC5vOiBidWlsdGluL2ZldGNoLmMgY2FjaGUu
aCBnaXQtY29tcGF0LXV0aWwuaCBjb21wYXQvYnN3YXAuaCBcDQo+DQo+VGhhdCdzIHRoZSBwcm9i
bGVtLiAgU2VlIHRoZSBmb2xsb3dpbmcgdGhyZWFkOg0KPg0KPiAgaHR0cDovL3RocmVhZC5nbWFu
ZS5vcmcvZ21hbmUuY29tcC52ZXJzaW9uLWNvbnRyb2wuZ2l0LzE4NTYyNS9mb2N1cz0xODU2ODAN
Cj4NCj5DdXJyZW50bHkgd2hlbiBDT01QVVRFX0hFQURFUl9ERVBFTkRFTkNJRVM9YXV0byBnaXQg
dGVzdHMgZm9yDQo+ZGVwZW5kZW5jeSBnZW5lcmF0aW9uIHN1cHBvcnQgYnkgY2hlY2tpbmcgdGhl
IG91dHB1dCBhbmQgZXhpdCBzdGF0dXMNCj5mcm9tIHRoZSBmb2xsb3dpbmcgY29tbWFuZDoNCj4N
Cj4kKENDKSAkKEFMTF9DRkxBR1MpIC1jIC1NRiAvZGV2L251bGwgLU1NRCAtTVAgXA0KPi14IGMg
L2Rldi9udWxsIC1vIC9kZXYvbnVsbCAyPiYxDQo+DQo+UGVyaGFwcyB0aGlzIGNhbiBiZSBpbXBy
b3ZlZD8gIEV2ZW4gc29tZXRoaW5nIGFzIHNpbXBsZSBhcyBhIGNjYWNoZQ0KPnZlcnNpb24gdGVz
dCBjb3VsZCBwcmVzdW1hYmx5IGhlbHAgYSBsb3QuDQo+DQo+SG9wZSB0aGF0IGhlbHBzLA0KPkpv
bmF0aGFuDQoNCkhpLA0KDQpVbmZvcnR1bmF0ZWx5LCB0aGUgcGF0Y2ggZGlkbid0IGhlbHAgdG8g
bWUuDQpBbnl3YXksIGNjYWNoZSBpcyB0aGUgY3VscHJpdCAoSSdtIHVzaW5nIGNjYWNoZSAyLjQg
dmVyc2lvbikuDQoNCklmIEkgZGlzYWJsZSBjY2FjaGUgdXNpbmcgQ0NBQ0hFX0RJU0FCTEU9MSwg
dGhlbiB0aGUgaXNzdWUgZG9lc24ndCBoYXBwZW4uIFRoYW5rcy4NCg0KQmVzdCByZWdhcmRzLA0K
Sm9uZ21hbiBIZW8uDQo=
