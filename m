From: =?ISO-8859-1?Q?G=E1bor_Szeder?= <szeder@ira.uka.de>
Subject: Re: [SECURITY PATCH] git-prompt.sh: don't put unsanitized branch
 names in $PS1
Date: Thu, 24 Apr 2014 23:10:10 +0430
Message-ID: <E1WdOZY-0006ck-F9@iramx2.ira.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Cc: sitaramc@gmail.com, Richard Hansen <rhansen@bbn.com>,
	git@vger.kernel.org, Simon Oosthoek <s.oosthoek@xs4all.nl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 20:41:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdOaP-0004qW-GD
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 20:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758796AbaDXSl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 14:41:26 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:38409 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758735AbaDXSlY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Apr 2014 14:41:24 -0400
Received: from [5.123.33.62]
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1WdOZY-0006ck-F9; Thu, 24 Apr 2014 20:40:50 +0200
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1398364850.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246993>

SGksCgpPbiBBcHIgMjIsIDIwMTQgMjo1MyBBTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9i
b3guY29tPiB3cm90ZToKPgo+IFJpY2hhcmQgSGFuc2VuIDxyaGFuc2VuQGJibi5jb20+IHdyaXRl
czogCj4KPiA+IEJvdGggYmFzaCBhbmQgenNoIHN1YmplY3QgdGhlIHZhbHVlIG9mIFBTMSB0byBw
YXJhbWV0ZXIgZXhwYW5zaW9uLCAKPiA+IGNvbW1hbmQgc3Vic3RpdHV0aW9uLCBhbmQgYXJpdGht
ZXRpYyBleHBhbnNpb24uwqAgUmF0aGVyIHRoYW4gaW5jbHVkZSAKPiA+IHRoZSByYXcsIHVuZXNj
YXBlZCBicmFuY2ggbmFtZSBpbiBQUzEgd2hlbiBydW5uaW5nIGluIHR3by0gb3IgCj4gPiB0aHJl
ZS1hcmd1bWVudCBtb2RlLCBjb25zdHJ1Y3QgUFMxIHRvIHJlZmVyZW5jZSBhIHZhcmlhYmxlIHRo
YXQgaG9sZHMgCj4gPiB0aGUgYnJhbmNoIG5hbWUuwqAgQmVjYXVzZSB0aGUgc2hlbGxzIGRvIG5v
dCByZWN1cnNpdmVseSBleHBhbmQsIHRoaXMgCj4gPiBhdm9pZHMgYXJiaXRyYXJ5IGNvZGUgZXhl
Y3V0aW9uIGJ5IHNwZWNpYWxseS1jcmFmdGVkIGJyYW5jaCBuYW1lcyBzdWNoIAo+ID4gYXMgJyQo
SUZTPV87Y21kPXN1ZG9fcm1fLXJmXy87JGNtZCknLiAKPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTog
UmljaGFyZCBIYW5zZW4gPHJoYW5zZW5AYmJuLmNvbT4gCj4KPiBJJ2QgbGlrZSB0byBzZWUgdGhp
cyBwYXRjaCBleWViYWxsZWQgYnkgdGhvc2Ugd2hvIGhhdmUgYmVlbiBpbnZvbHZlZCAKPiBpbiB0
aGUgc2NyaXB0IChzaG9ydGxvZyBhbmQgYmxhbWUgdGVsbHMgbWUgdGhleSBhcmUgU1pFREVSIGFu
ZCAKPiBTaW1vbiwgQ0MnZWQpLCBzbyB0aGF0IHdlIGNhbiBob3BlZnVsbHkgbWVyZ2UgaXQgYnkg
dGhlIHRpbWUgLXJjMSBpcyAKPiB0YWdnZWQuCgpJIHRoaW5rIHRoaXMgaXMgYSBzZW5zaWJsZSB0
aGluZyB0byBkby7CoCBIb3dldmVyLCBmb3Igbm93IEkgY2FuIG9ubHkgY2hlY2sgdGhlIHBhdGNo
IG9uIG15IHBob25lLCBoZW5jZSBJIGNhbid0IHNheSBhbnkgbW9yZSAoZS5nLiBhY2tlZCBvciBy
ZXZpZXdlZCBieSkgdGhhbiB0aGF0LCB1bmZvcnR1bmF0ZWx5LgoKPiA+ICsgIyBub3QgbmVlZGVk
IGFueW1vcmU7IGtlZXAgdXNlcidzIAo+ID4gKyAjIGVudmlyb25tZW50IGNsZWFuIAo+ID4gKyB1
bnNldCBfX2dpdF9wczFfdXBzdHJlYW1fbmFtZSAKPiA+ICsgZmkKCldlIGFscmVhZHkgaGF2ZSBh
IGxvdCBvZiBzdHVmZiBpbiB0aGUgdXNlcidzIGVudmlyb25tZW50IGJlZ2lubmluZyB3aXRoIF9f
Z2l0LCBzbyBJIGRvbid0IHRoaW5rIHRoZSB1bnNldCBpcyBuZWNlc3NhcnkuCgpCZXN0LApHw6Fi
b3IK
