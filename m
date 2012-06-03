From: Caleb Marchent <cmarchent@aminocom.com>
Subject: RE: [PATCH] Teach ignore machinery about pattern "/"
Date: Sun, 3 Jun 2012 22:50:46 +0000
Message-ID: <9C3609BEC91A814BB52DBF9C41F04D1E58DEDB2D@uk-swa-ex01>
References: <1337950056-26491-1-git-send-email-pclouds@gmail.com>
 <7vlikgtbcx.fsf@alter.siamese.dyndns.org>
 <CACsJy8BjUQsCVVdzZtJxA9Qu2G0izZa8dvP1EKsQQAHWXZbHdg@mail.gmail.com>
 <CACsJy8BSHFzGfsm6qY1LEX9wubKjKXXbJ_WMAiOAUhVGa631Ag@mail.gmail.com>,<7vbol0xdzj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 00:56:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbJiN-0005tl-Cf
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 00:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070Ab2FCWz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 18:55:59 -0400
Received: from mail.aminocom.com ([62.255.172.253]:12613 "EHLO
	uk-swa-cas01.aminocom.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751959Ab2FCWz6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jun 2012 18:55:58 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Jun 2012 18:55:57 EDT
Received: from uk-swa-ex01.aminocom.com ([10.171.3.9]) by
 uk-swa-cas01.aminocom.com ([::1]) with mapi id 14.02.0247.003; Sun, 3 Jun
 2012 23:50:47 +0100
Thread-Topic: [PATCH] Teach ignore machinery about pattern "/"
Thread-Index: AQHNOnUonTVjXYGLx0KhR5iQ3okDX5baw/RRgACm9QCADRphgIAAq2BxgAAO5wU=
In-Reply-To: <7vbol0xdzj.fsf@alter.siamese.dyndns.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.171.0.1]
x-exclaimer-md-config: 97205c7e-1da7-49e0-88c8-ce11b093e3e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199111>

SGkgR3V5J3MsCgpTZWVpbmcgdGhlIGRpc2N1c3Npb24gYWJvdXQgdGhlIGludGVycHJldGF0aW9u
IG9mICcvJyAtIEkgd291bGQgbGlrZSB0byBhZGQgc29tZSBhZGRpdGlvbmFsIHN1cHBvcnQgZm9y
IG15IGNhc2UgdGhhdCBpdCBzaG91bGQgcmVwcmVzZW50IHRoZSBjb250ZW50cyBvZiB0aGUgdG9w
IGxldmVsIGRpcjoKCklmIEkgZG8gImxzIC8iIG9uIGEgdW5peCBzeXN0ZW0gLSBJIGdldCBhIGxp
c3Qgb2YgdGhlIGNvbnRlbnRzIG9mIHRoZSByb290IG9mIHRoZSBmaWxlcyBzeXN0ZW0sIEkgdGhp
bmsgd2Ugc2hvdWxkIG1haW50YWluIHRoaXMgaW4gZ2l0LCBzdWNoIHRoYXQgJy8nIHJlcHJlc2Vu
dHMgdGhlIHRvcCBvZiB0aGUgdHJlZSByYXRoZXIgdGhhbiBzdXBwcmVzc2luZyBpdC4gCgpCZXN0
IFJlZ2FyZHMsCgpDYWxlYgoKQ2FsZWIgTWFyY2hlbnQsIFNvZnR3YXJlIERldmVsb3BlciwgQW1p
bm8gQ29tbXVuaWNhdGlvbnMgTHRkLCBCdWNraW5nd2F5IEJ1c2luZXNzIFBhcmssIEFuZGVyc29u
IFJvYWQsIFN3YXZlc2V5LCBDYW1icmlkZ2UsIENCMjQgNFVRLCBVSyBjbWFyY2hlbnRAYW1pbm9j
b20uY29tIHd3dy5hbWlub2NvbS5jb20KClRlbDogKzQ0IDE5NTQgMjM0IDEwMAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpGcm9tOiBnaXQtb3duZXJAdmdlci5rZXJu
ZWwub3JnIFtnaXQtb3duZXJAdmdlci5rZXJuZWwub3JnXSBvbiBiZWhhbGYgb2YgSnVuaW8gQyBI
YW1hbm8gW2dpdHN0ZXJAcG9ib3guY29tXQpTZW50OiAwMyBKdW5lIDIwMTIgMjI6NDkKVG86IE5n
dXllbiBUaGFpIE5nb2MgRHV5CkNjOiBnaXRAdmdlci5rZXJuZWwub3JnClN1YmplY3Q6IFJlOiBb
UEFUQ0hdIFRlYWNoIGlnbm9yZSBtYWNoaW5lcnkgYWJvdXQgcGF0dGVybiAiLyIKCk5ndXllbiBU
aGFpIE5nb2MgRHV5IDxwY2xvdWRzQGdtYWlsLmNvbT4gd3JpdGVzOgoKPiBPbiBTYXQsIE1heSAy
NiwgMjAxMiBhdCAxMTozMCBBTSwgTmd1eWVuIFRoYWkgTmdvYyBEdXkKPiA8cGNsb3Vkc0BnbWFp
bC5jb20+IHdyb3RlOgo+PiBPbiBTYXQsIE1heSAyNiwgMjAxMiBhdCAxMjozMiBBTSwgSnVuaW8g
QyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPiB3cm90ZToKPj4+IE5ndXnhu4VuIFRow6FpIE5n
4buNYyBEdXkgIDxwY2xvdWRzQGdtYWlsLmNvbT4gd3JpdGVzOgo+Pj4KPj4+PiBQYXR0ZXJuICIv
IiBpcyBhbWJpZ3VvdXMgYmVjYXVzZSB0aGUgc2xhc2ggY2FuIG1lYW4gImFuY2hvciB0aGUKPj4+
PiBwYXR0ZXJuIHRvIHRoaXMgbG9jYXRpb24iIChlLmcuIC9wYXRoKSwgYnV0IGl0IGNhbiBhbHNv
IG1lYW4KPj4+PiAibWF0Y2ggZGlyZWN0b3JpZXMgb25seSIgKGUuZy4gcGF0aC8pLiBDdXJyZW50
bHkgZ2l0IGludGVycHJldHMgaXQgYXMKPj4+PiB0aGUgbGF0dGVyIGV4Y2VwdCB0aGF0ICdwYXRo
JyBpcyBhbiBlbXB0eSBzdHJpbmcsIHdoaWNoIG1ha2VzIHRoaXMKPj4+PiBwYXR0ZXJuIHRvdGFs
bHkgdXNlbGVzcy4KPj4+Cj4+PiBEaWQgdGhlIG9sZCB2ZXJzaW9uIGludGVycHJldGUgaXQgYXMg
dGhlIGZvcm1lcj8KPj4KPj4gVGhhdCBjYWxscyBmb3IgYml0IG9mIHRlc3RpbmcsIHdoaWNoIEkn
bGwgZG8gc29vbi4KPgo+ICIvIiBpcyBuby1vcCBzaW5jZSAxLjQuMCAodGVzdGVkIHdpdGggcmVm
cy90YWdzL3YqKSwuLi4KClNvIGhpc3RvcmljYWxseSB3ZSBoYWQgdGhyZWUgcG9zc2libGUgaW50
ZXJwcmV0YXRpb25zIG9mICIvIiwKaS5lLiAiL3BhdGgiIHRoYXQgaGFwcGVucyB0byBoYXZlIGFu
IGVtcHR5IHBhdGgsICJwYXRoLyIgdGhhdApoYXBwZW5zIHRvIGhhdmUgYW4gZW1wdHkgcGF0aCwg
YW5kIGEgbm8tb3AuCgpUaGF0IHN0cm9uZ2x5IHN1Z2dlc3RzIHRoYXQgd2Ugc2hvdWxkIGF0IGxl
YXN0IHdhcm4gd2hlbiB3ZSBzZWUgIi8iCnRoYXQgdGhlIHVzZXIgaXMgcGxheWluZyB3aXRoIGZp
cmUgYnkgZmVlZGluZyB0aGUgZXhjbHVkZSBtYWNoaW5lcnkKc29tZXRoaW5nIHdpdGhvdXQgY2xl
YXIgc2VtYW50aWNzLgoKRG9pbmcgYSBuby1vcCBtaWdodCBiZSBhIHNhZmVyIG9wdGlvbiB0aGFu
IGFkZGluZyBpdCBuZXcgc3BlY2lhbApjYXNlIHNlbWFudGljcyB0byBpdCwgYnV0IGV2ZW4gdGhl
biBJIGRvIG5vdCB0aGluayB3ZSBzaG91bGQKc2lsZW50bHkgaWdub3JlIGl0LiAgU2lsZW50bHkg
Z2l2aW5nIG5ldyBzZW1hbnRpY3MgZm9yIHRoaXMKcGFydGljdWxhciBzcGVjaWFsIGNhc2UgaXMg
b3V0IG9mIHRoZSBxdWVzdGlvbiwgSSB3b3VsZCBoYXZlIHRvIHNheS4KClRoYW5rcyBmb3IgZGln
Z2luZy4KLS0KVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVu
c3Vic2NyaWJlIGdpdCIgaW4KdGhlIGJvZHkgb2YgYSBtZXNzYWdlIHRvIG1ham9yZG9tb0B2Z2Vy
Lmtlcm5lbC5vcmcKTW9yZSBtYWpvcmRvbW8gaW5mbyBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9y
Zy9tYWpvcmRvbW8taW5mby5odG1sCg==
