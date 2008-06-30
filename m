From: "Matt Seitz (matseitz)" <matseitz@cisco.com>
Subject: Re: Git branches - confusing behavior
Date: Mon, 30 Jun 2008 00:23:46 -0700
Message-ID: <70952A932255A2489522275A628B97C3072392FA@xmb-sjc-233.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Cc: <dima.kagan@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 09:24:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDDk7-0004w9-A7
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 09:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbYF3HWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 03:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbYF3HWm
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 03:22:42 -0400
Received: from sj-iport-3.cisco.com ([171.71.176.72]:55286 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbYF3HWl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 03:22:41 -0400
X-IronPort-AV: E=Sophos;i="4.27,726,1204531200"; 
   d="scan'208";a="84016355"
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-3.cisco.com with ESMTP; 30 Jun 2008 00:22:41 -0700
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id m5U7MfJE022342;
	Mon, 30 Jun 2008 00:22:41 -0700
Received: from xbh-sjc-221.amer.cisco.com (xbh-sjc-221.cisco.com [128.107.191.63])
	by sj-core-5.cisco.com (8.13.8/8.13.8) with ESMTP id m5U7Mfjj015984;
	Mon, 30 Jun 2008 07:22:41 GMT
Received: from xmb-sjc-233.amer.cisco.com ([128.107.191.88]) by xbh-sjc-221.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 30 Jun 2008 00:22:40 -0700
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: Git branches - confusing behavior
Thread-Index: AcjagjwfPfjESN3nSk2WHlygivkYxQ==
X-OriginalArrivalTime: 30 Jun 2008 07:22:40.0845 (UTC) FILETIME=[14BACFD0:01C8DA82]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; l=2510; t=1214810561; x=1215674561;
	c=relaxed/simple; s=sjdkim4002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=matseitz@cisco.com;
	z=From:=20=22Matt=20Seitz=20(matseitz)=22=20<matseitz@cisco.
	com>
	|Subject:=20Re=3A=20Git=20branches=20-=20confusing=20behavi
	or
	|Sender:=20;
	bh=U7zVAxVNoYjujcjDSFuknfespDQkXo/Y4djKFWf8ptQ=;
	b=Nzb+6+EPQpVJ2azScFzOiZBrsUVryR9aNq0SFQ9qlDb/BeVg7jnVtDZz0e
	PvVkzW7D9GBYeYkUplPxgUiTvm670krFRKPtXvTnyKgLn7vuccLK2BOpIMeC
	HrqoQcA19E;
Authentication-Results: sj-dkim-4; header.From=matseitz@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86886>

T24gTWF5IDExLCAzOjU4IGFtLCBtaXR5YSA8ZGltYS5rYS4uLkBnbWFpbC5jb20+IHdyb3RlOg0K
PiBJIHN0YXJ0ZWQgd2l0aCB0aGUgZm9sbG93aW5nIHN0ZXBzOg0KPiANCj4gPiBnaXQtc3ZuIGNs
b25laHR0cDovL3N2bi50ZXN0Lm9yZy90ZXN0L3RydW5rDQo+ID4gY2QgdHJ1bmsNCj4gPiBnaXQg
YnJhbmNoIHRlc3RfYnJhbmNoDQo+ID4gZ2l0IGNoZWNrb3V0IHRlc3RfYnJhbmNoDQo+ID4gdmkg
c29tZWZpbGUNCj4gDQo+IEhvd2V2ZXIsIHdoZW4gSSBleGVjdXRlICdnaXQgY2hlY2tvdXQgbWFz
dGVyJywgSSBnZXQ6DQo+IE0gICAgICAgc29tZWZpbGUNCj4gU3dpdGNoZWQgdG8gYnJhbmNoICJt
YXN0ZXIiDQo+IA0KPiBCYXNpY2FsbHkgSSBzZWUgdGhhdCB0aGUgc2FtZSBmaWxlIEkgZWRpdGVk
IG9uIHRoZSAndGVzdF9icmFuY2gnDQo+IGJyYW5jaCBhcHBlYXJzIHRvIGJlIG1vZGlmaWVkIG9u
IHRoZSAnbWFzdGVyJyBicmFuY2ggYXMgd2VsbC4gDQoNCkkgd2FzIGFsc28gY29uZnVzZWQgYnkg
dGhpcyBiZWhhdmlvci4gIEkgdGhpbmsgdGhpcyBpcyBhIGRvY3VtZW50YXRpb24gaXNzdWUuICBJ
biB0aGUgIm1hbiIgcGFnZSBmb3IgImdpdC1jaGVja291dCIsIHRoZSAiRGVzY3JpcHRpb24iIHNl
Y3Rpb24gc2F5czoNCg0KIi4uLnRoaXMgY29tbWFuZCBzd2l0Y2hlcyBicmFuY2hlcyBieSB1cGRh
dGluZyB0aGUgaW5kZXggYW5kIHdvcmtpbmcgdHJlZSB0byByZWZsZWN0IHRoZSBzcGVjaWZpZWQg
YnJhbmNoLi4uIi4NCg0KVGhpcyBsZWQgbWUgdG8gYmVsaWV2ZSB0aGF0IGFsbCBmaWxlcyBpbiB0
aGUgd29ya2luZyB0cmVlIHdvdWxkIGJlIHVwZGF0ZWQgdG8gbWF0Y2ggdGhlIGxhc3QgY29tbWl0
IGluIHRoZSBzcGVjaWZpZWQgYnJhbmNoLiAgVGhlICJEZXNjcmlwdGlvbiIgc2VjdGlvbiBkb2Vz
bid0IG1lbnRpb24gYW55IGV4Y2VwdGlvbnMsIHN1Y2ggYXMgZmlsZXMgdGhhdCBoYXZlIGJlZW4g
bW9kaWZpZWQgYnV0IG5vdCBjb21taXR0ZWQgaW4gdGhlIGN1cnJlbnQgYnJhbmNoLiAgDQoNClRo
ZXJlIGFyZSBzb21lIGNsdWVzIHRoYXQgdGhpcyBpcyB0aGUgaW50ZW5kZWQgYmVoYXZpb3IgaW4g
dGhlIGRlc2NyaXB0aW9ucyBvZiB0aGUgIi1mIiBhbmQgIi1tIiBvcHRpb25zLCBhbmQgaW4gdGhl
ICJBZnRlciB3b3JraW5nIGluIHRoZSB3cm9uZyBicmFuY2guLi4iIGV4YW1wbGUuICBCdXQgaXQg
d2FzIG5vdCBjbGVhciB0byBtZSBmcm9tIHJlYWRpbmcgdGhlICJtYW4iIHBhZ2UgKGFuZCB0aGUg
ImdpdHR1dG9yaWFsIiBhbmQgdGhlICJHaXQgVXNlcidzIEd1aWRlIikgdGhhdCB0aGlzIGJlaGF2
aW9yIHdhcyBjb3JyZWN0IGFuZCBpbnRlbmRlZC4gDQoNCkkgdGhpbmsgaXQgd291bGQgYmUgaGVs
cGZ1bCBpbiB0aGUgIkRlc2NyaXB0aW9uIiBzZWN0aW9uIG9mIHRoZSAibWFuIiBwYWdlIHRvIGVs
YWJvcmF0ZSBvbiBob3cgZ2l0IHVwZGF0ZXMgdGhlIHdvcmtpbmcgdHJlZSB0byByZWZsZWN0IHRo
ZSBzcGVjaWZpZWQgYnJhbmNoLiAgVGhpcyBjb3VsZCBpbmNsdWRlIGRvY3VtZW50aW5nIHRoZSBk
ZWZhdWx0IGhhbmRsaW5nIG9mIGZpbGVzIHRoYXQgaGF2ZSBiZWVuIG1vZGlmaWVkIGluIHRoZSBj
dXJyZW50IGJyYW5jaC4gIEEgcmF0aW9uYWxlIGZvciB0aGUgYmVoYXZpb3Igd291bGQgYWxzbyBi
ZSBoZWxwZnVsLiAgVGhpcyBtaWdodCBoYXZlIHByZXZlbnRlZCBteSBjb25mdXNpb24gd2hlbiBm
aXJzdCBlbmNvdW50ZXJpbmcgdGhpcyBpc3N1ZS4NCiAgDQotLQ0KTWF0dCBTZWl0eg0KTWFuYWdl
ciwgRmlsZSBTeXN0ZW0gVmlydHVhbGl6YXRpb24NCkNpc2NvIFN5c3RlbXMsIEluYy4NCi46fDou
Onw6LiANCg==
