From: =?euc-kr?B?x+PBvri4?= <jongman.heo@samsung.com>
Subject: Re: Re: Segmentation fault with latest git (070c57df)
Date: Fri, 01 Feb 2013 01:31:27 +0000 (GMT)
Message-ID: <15540714.372461359682286477.JavaMail.weblogic@epml08>
Reply-To: jongman.heo@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Cc: git <git@vger.kernel.org>, Antoine Pelisse <apelisse@gmail.com>
To: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Feb 01 02:32:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U15Tz-0000Ga-BI
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 02:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977Ab3BABbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 20:31:35 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:14003 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab3BABbd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 20:31:33 -0500
Received: from epcpsbge6.samsung.com (epcpsbge6 [203.254.230.16])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHI00CDHPJR8CJ0@mailout1.samsung.com> for
 git@vger.kernel.org; Fri, 01 Feb 2013 10:31:32 +0900 (KST)
Received: from epcpsbge6.samsung.com ( [203.254.230.46])
	by epcpsbge6.samsung.com (EPCPMTA) with SMTP id 49.F8.20213.1FA1B015; Fri,
 01 Feb 2013 10:31:29 +0900 (KST)
X-AuditID: cbfee610-b7f856d000004ef5-ca-510b1af151d9
Received: from epextmailer01 ( [203.254.219.151])
	by epcpsbge6.samsung.com (EPCPMTA) with SMTP id 02.F8.20213.FEA1B015; Fri,
 01 Feb 2013 10:31:27 +0900 (KST)
X-MTR: 20130201012425356@jongman.heo
Msgkey: 20130201012425356@jongman.heo
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130201012425356@jongman.heo
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
MIME-version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsVy+t8zPd0vUtyBBk/Xc1h0XelmcmD0+LxJ
	LoAxissmJTUnsyy1SN8ugSvj1K6TzAXPeCvmnTrF1sC4hbeLkZNDSEBN4ubnQ4wgtoSAicSE
	OftZIWwxiQv31rN1MXIB1SxjlOjq3gNXtHdDGyNEYj6jRNP5mWAJFgEViY/v9oJ1swmYSRw7
	/xssLixgJ3G4pR0ozsEhIuAhseGILUiYWcBTYuL7GYwQRyhKXFu6mA3E5hUQlDg58wkLxC4V
	iaULHrBAxFUlJrxvZYeIS0jMmn4B6lBeiRntT6Hq5SSmfV3DDGFLS5yftYER5pnF3x9Dxfkl
	jt3ewQRyDkjvk/vBMGN2b/7CBmELSEw9cxCqVVPi6KpLUDafxJqFb1lgxuw6tZwZpvf+lrlM
	EG8pSkzpfsgOYWtJfPmxD8NbvAJOEguWXWCcwKg8C0lqFpL2WUjakdUsYGRZxSiaWpBcUJyU
	nmqmV5yYW1yal66XnJ+7iRGSFgR2MC5psDjEKMDBqMTDe+InV6AQa2JZcWXuIUYJDmYlEd6b
	L4BCvCmJlVWpRfnxRaU5qcWHGJOB8TeRWUo0OR+YsvJK4g2NDYwNDS0NzUwtTQ1IE1YS52Wv
	mB4gJJCeWJKanZpakFoEs4WJg1OqgXHT/Iuq5yQ/7Tyv9eHWIZsNzX+vcJda+1Wfecqtu4XJ
	x/KS+sGSluU2npt4yxa4ByR9nKm+esXq49Yfn64rDfXqlPKdt7L62GrPyboz89/fvHPjfnfg
	99VWs9yjr3bX6UeylhueTJp2/OO6/L9XzzFsP7nUqvb34W2zrX9eL3+9RE9QhE/y 
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42I5/e/2dN2PUtyBBl9OqVp0XelmcmD0+LxJ
	LoAxKsMmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2io
	kkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKdrIwFjPyNREz8jYQM/EINbK0MDAyBSoKiEj
	49Suk8wFz3gr5p06xdbAuIW3i5GTQ0hATeLm50OMILaEgInE3g1tULaYxIV769m6GLmAauYz
	SjSdnwmWYBFQkfj4bi8riM0mYCZx7PxvsLiwgJ3E4ZZ2oDgHh4iAh8SGI7YgYWYBT4mJ72cw
	QuxSlLi2dDEbiM0rIChxcuYTFohdKhJLFzxggYirSkx438oOEZeQmDX9AiuEzSsxo/0pVL2c
	xLSva5ghbGmJ87M2wN28+PtjqDi/xLHbO5hAzgHpfXI/GGbM7s1f2CBsAYmpZw5CtWpKHF11
	Ccrmk1iz8C0LzJhdp5Yzw/Te3zKXCeItRYkp3Q/ZIWwtiS8/9mF4i1fASWLBsguMExjlZiFJ
	zULSPgtJO7KaBYwsqxhFUwuSC4qT0lPN9IoTc4tL89L1kvNzNzGCE9QzgR2MSxosDjEKcDAq
	8fCe+MkVKMSaWFZcmXuIUYKDWUmE9+YLoBBvSmJlVWpRfnxRaU5q8SHGZGD8TWSWEk3OBybP
	vJJ4Q2MDY0NDS3MDU0MjC9KElcR52SumBwgJpCeWpGanphakFsFsYeLglGpg9J/xsnXGvc/h
	Cv3F+b8NbCYf08tZ8er2ge4u9YmFwV3MetlG/Y3nA7UtuVL8n5iof7gjJNJytmeZ 
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215196>

DQo+IA0KW3NuaXBdDQo+IEdvb2QgcG9pbnQuIFVuZm9ydHVuYXRlbHksIEkgY2FuJ3QgZ2V0IGVp
dGhlciB5b3VycyBvciBtaW5lIHRvIGZhaWwsDQo+IG5laXRoZXIgd2l0aCBhIHJlY2VudCB2ZXJz
aW9uIG9mIGdjYyBub3Igd2l0aCBnY2MtNC4xLiAgQnV0IEkgY2FuJ3QNCj4gY29udmluY2UgZ2l0
IHRvIGZhaWwsIGVpdGhlci4gVGhlIG9ubHkgZ2NjLTQuMSBJIGhhdmUgaXMgRGViaWFuJ3MNCj4g
NC4xLjMgcmVsZWFzZSwgd2hpY2ggaXMgbm90IHF1aXRlIHdoYXQgdGhlIE9QIGhhcy4NCj4gDQo+
ID4gT3IgcGVyaGFwcyBzb21ldGhpbmcgaW4gdGhlIGJ1aWxkIHByb2Nlc3Mgd2VudCB3cm9uZywg
YW5kIGZldGNoLmMgZGlkbid0DQo+ID4gZ2V0IHRoZSBtZW1vIGFib3V0IHRoZSBuZXcgZmllbGQg
aW4gdGhlIHN0cnVjdC4gIERlcGVuZGluZyBvbiBzdGFjaw0KPiA+IGxheW91dCwgdGhlIG5leHQg
dmFyaWFibGUgbWlnaHQgYmUgdGhlICdpbnQgaScgcmlnaHQgYmVmb3JlIHRoZQ0KPiA+ICdzdHJp
bmdfbGlzdCBsaXN0JyBpbiB0aGUgY29kZSwgd2hpY2ggY291bGQgZXhwbGFpbiB0aGUgdmFsdWUg
b2YgMS4NCj4gDQo+IFllYWgsIHRoYXQgd291bGQgbWFrZSBzZW5zZSB0byBtZSB3aXRoIHJlc3Bl
Y3QgdG8gdGhlIGJlaGF2aW9yIHdlIGFyZQ0KPiBzZWVpbmcsIGJ1dCB0aGF0IHBhcnQgb2YgdGhl
IE1ha2VmaWxlIHNob3VsZCBiZSBwcmV0dHkgc2ltcGxlIGFuZA0KPiBidWctZnJlZSwgSSdkIHRo
aW5rIChhbmQgZnJvbSB0aGUgb3JpZ2luYWwgcmVwb3J0LCBpdCBzZWVtcyBsaWtlIGhlIHdhcw0K
PiBhYmxlIHRvIHJlcHJvZHVjZSBpdCB3ZWxsIGVub3VnaCB0byBiaXNlY3QpLiBTdGlsbCwgdHJ5
aW5nIGEgIm1ha2UgY2xlYW4NCj4gJiYgbWFrZSIgbWlnaHQgYmUgd29ydGggaXQganVzdCB0byBy
dWxlIHRoYXQgb3V0Lg0KPiANCj4gUHV6emxlZC4uLg0KPiANCj4gLVBlZmYNCg0KSGksIGFsbCwN
Cg0KVGhvbWFzJ3MgdGVzdCBjb2RlIGFsc28gcmV0dXJucyAiY21wIGlzIDAiLiANCkJ1dCAibWFr
ZSBjbGVhbiAmJiBtYWtlIiBmaXhlcyBteSBpc3N1ZS4NCg0KU29ycnkgZm9yIHRoZSBub2lzZSBJ
IG1hZGUuDQpCdXQgdXN1YWxseSB3aGVuIEkgYnVpbGQgdXBzdHJlYW0gTGludXgga2VybmVsLCBJ
IGRvbid0IGRvICJtYWtlIGNsZWFuIiBhZnRlciBnaXQgcHVsbC4uIA0KSSBkaWRuJ3QgZXhwZWN0
IHRoYXQgSSBuZWVkZWQgIm1ha2UgY2xlYW4iIGZvciBnaXQgYnVpbGQuIFRoYW5rcyB5b3UgZ3V5
cy4NCg0KQmVzdCByZWdhcmRzLA0KSm9uZ21hbiBIZW8u
