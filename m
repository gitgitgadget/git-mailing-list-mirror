From: Jim Garrison <jim.garrison@nwea.org>
Subject: RE: Problem importing from SVN repository with branches/tags at
 multiple levels using git-svn
Date: Wed, 22 Jan 2014 21:11:57 +0000
Message-ID: <0C723FEB5B4E5642B25B451BA57E273075147566@S1P5DAG3C.EXCHPROD.USA.NET>
References: <52D6EB42.2060509@sedsystems.ca> <52E01601.8090705@sedsystems.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: Robert Hancock <hancock@sedsystems.ca>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 22 22:22:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W65FN-0005nl-LS
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 22:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbaAVVWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 16:22:00 -0500
Received: from gwo3.mbox.net ([165.212.64.25]:41239 "EHLO gwo3.mbox.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480AbaAVVV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 16:21:59 -0500
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jan 2014 16:21:59 EST
Received: from gwo3.mbox.net (localhost [127.0.0.1])
	by gwo3.mbox.net (Postfix) with ESMTP id 3f8fSg0lm2zxcrDx;
	Wed, 22 Jan 2014 21:12:03 +0000 (UTC)
X-USANET-Received: from gwo3.mbox.net [127.0.0.1] by gwo3.mbox.net via mtad (C8.MAIN.3.82G) 
	with ESMTP id 472saVVL66960Mo3; Wed, 22 Jan 2014 21:11:58 -0000
X-USANET-Routed: 5 gwsout-gwsd Q:gwsd
X-USANET-Routed: 3 gwsout-vs Q:bmvirus
X-USANET-GWS2-Tenant: nwea.org
X-USANET-GWS2-Tagid: NWEA
Received: from S1P5HUB5.EXCHPROD.USA.NET [165.212.120.254] by gwo3.mbox.net via smtad (C8.MAIN.3.94H) 
	with ESMTPS id XID353saVVL72150Xo3; Wed, 22 Jan 2014 21:11:58 -0000
X-USANET-Source: 165.212.120.254 OUT  jim.garrison@nwea.org S1P5HUB5.EXCHPROD.USA.NET TLS
X-USANET-MsgId: XID353saVVL72150Xo3
Received: from S1P5DAG3C.EXCHPROD.USA.NET ([169.254.3.130]) by
 S1P5HUB5.EXCHPROD.USA.NET ([10.120.223.35]) with mapi id 14.03.0174.001; Wed,
 22 Jan 2014 09:11:57 -1200
Thread-Topic: Problem importing from SVN repository with branches/tags at
 multiple levels using git-svn
Thread-Index: AQHPF6SvPmXI1thDEkOjIPuVLoiz6JqRPOjA
In-Reply-To: <52E01601.8090705@sedsystems.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.98.171.2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240861>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBCZWhhbGYgT2YgUm9iZXJ0IEhhbmNvY2sN
Cj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDIyLCAyMDE0IDExOjAzIEFNDQo+IFN1YmplY3Q6
IFJlOiBQcm9ibGVtIGltcG9ydGluZyBmcm9tIFNWTiByZXBvc2l0b3J5IHdpdGggYnJhbmNoZXMv
dGFncyBhdA0KPiBtdWx0aXBsZSBsZXZlbHMgdXNpbmcgZ2l0LXN2bg0KPiANCj4gT24gMDEvMTUv
MjAxNCAwMjoxMCBQTSwgUm9iZXJ0IEhhbmNvY2sgd3JvdGU6DQo+ID4gV2UgaGF2ZSBhbiBTVk4g
cmVwb3NpdG9yeSB0aGF0IGhhcyBhIHN0cnVjdHVyZSBmb3IgdGFncyAobGlrZXdpc2UgZm9yDQo+
ID4gYnJhbmNoZXMpIGxpa2UgdGhpczoNCj4gPg0KPiA+IHRhZ3MvdGFnMQ0KPiA+IHRhZ3MvdGFn
Mg0KPiA+IHRhZ3MvdGFnMy8NCj4gPiB0YWdzL3N1YmRpci90YWc0DQo+ID4gdGFncy9zdWJkaXIv
dGFnNQ0KPiA+DQpbc25pcF0NCg0KV2UgZGlkIHRoaXMgcmVjZW50bHkgYW5kIGRlY2lkZWQgdGhl
cmUgaXMgb25seSBvbmUgd2F5IHRvIGRvIGl0IHJlbGlhYmx5Lg0KDQpDb3B5IGFsbCB0aGUgdGFn
cywgd2l0aGluIHN1YnZlcnNpb24gaXRzZWxmLCBpbnRvIHRoZSBzdHJ1Y3R1cmUgZXhwZWN0ZWQg
YnkgZ2l0LCB0aGVuIHVzZSBnaXQgc3ZuIGZvbGxvd2luZyB0aGUgcHJvY2VkdXJlcyBvdXRsaW5l
ZCBpbiB0aGUgbWFudWFsLg0KDQpDb3B5aW5nIHRhZ3MgaXMgY2hlYXAgaW4gc3VidmVyc2lvbiwg
YW5kIHlvdSBjYW4gYWx3YXlzIGRlbGV0ZSB0aGVtIGFmdGVyd2FyZHMgaWYgeW91IHdhbnQuDQo=
