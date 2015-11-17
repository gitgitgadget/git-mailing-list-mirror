From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 1/2] sendemail: teach git-send-email to list aliases
Date: Tue, 17 Nov 2015 00:09:18 +0000
Message-ID: <1447718958.23262.15.camel@intel.com>
References: <1447618940-27446-1-git-send-email-jacob.e.keller@intel.com>
	 <CAPig+cQ929oAZqQM+X68x3PVQ-opwdi3VzjcQTUsaCfVK3411g@mail.gmail.com>
	 <1447717227.23262.10.camel@intel.com>
	 <CAPig+cSMW2UmTzuyvBFpcpr4tF1FRdxHUPH4+wS3vrZSP9AzJA@mail.gmail.com>
	 <CAPig+cR2t9w6x4YX6Fuc6sk6VMpMU=gfF4GaTz_3a47Px6mwPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"spearce@spearce.org" <spearce@spearce.org>,
	"lee.marlow@gmail.com" <lee.marlow@gmail.com>,
	"felipe.contreras@gmail.com" <felipe.contreras@gmail.com>,
	"szeder@ira.uka.de" <szeder@ira.uka.de>,
	"jacob.keller@gmail.com" <jacob.keller@gmail.com>
To: "sunshine@sunshineco.com" <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 01:09:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyTpx-0002Bk-Bq
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 01:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbbKQAJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 19:09:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:27119 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829AbbKQAJY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 19:09:24 -0500
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP; 16 Nov 2015 16:09:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,305,1444719600"; 
   d="scan'208";a="687054934"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga003.jf.intel.com with ESMTP; 16 Nov 2015 16:09:20 -0800
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Mon, 16 Nov 2015 16:09:19 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.96]) by
 ORSMSX162.amr.corp.intel.com ([169.254.3.39]) with mapi id 14.03.0248.002;
 Mon, 16 Nov 2015 16:09:18 -0800
Thread-Topic: [PATCH v2 1/2] sendemail: teach git-send-email to list aliases
Thread-Index: AQHRH+NeL2JBu1hRzUqsWBsvOxZ9JJ6f09QAgAAC2YCAAALsgIAAAXmAgAADqgA=
In-Reply-To: <CAPig+cR2t9w6x4YX6Fuc6sk6VMpMU=gfF4GaTz_3a47Px6mwPg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.3.123]
Content-ID: <B92A417525926846AC8BBDF5A847EC47@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281370>

T24gTW9uLCAyMDE1LTExLTE2IGF0IDE4OjU2IC0wNTAwLCBFcmljIFN1bnNoaW5lIHdyb3RlOg0K
PiBPbiBNb24sIE5vdiAxNiwgMjAxNSBhdCA2OjUwIFBNLCBFcmljIFN1bnNoaW5lIDxzdW5zaGlu
ZUBzdW5zaGluZWNvLmMNCj4gb20+IHdyb3RlOg0KPiA+IEFsc28sIHNob3VsZG4ndCAtLWxpc3Qt
YWxpYXNlcyAob3IgLS1kdW1wLWFsaWFzZXMpIGJlIG11dHVhbGx5DQo+ID4gZXhjbHVzaXZlIHdp
dGggbWFueSBvZiB0aGUgb3RoZXIgb3B0aW9ucz8gTmV3IHRlc3RzIHdvdWxkIGNoZWNrDQo+ID4g
c3VjaA0KPiA+IGV4Y2x1c2l2aXR5IGFzIHdlbGwuDQo+IA0KPiBJbiBmYWN0LCB3aGlsZSBJIGFn
cmVlIHdpdGggU3plZGVyIHRoYXQgaXQgbWFrZXMgc2Vuc2UgdG8gcmUtdXNlDQo+IHNlbmQtZW1h
aWwncyBhbGlhc2VzIHBhcnNpbmcgZnVuY3Rpb25hbGl0eSAoYW5kIHdhcyBnb2luZyB0byBzdWdn
ZXN0DQo+IHRoZSBzYW1lLCBidXQgaGUgYmVhdCBtZSB0byBpdCksIHRoaXMgbmV3IG9wdGlvbiBp
cyBhd2Z1bGx5DQo+IG9ydGhvZ29uYWwNCj4gdG8gdGhlIG92ZXJhbGwgcHVycG9zZSBvZiBzZW5k
LWVtYWlsLCB0aHVzLCBkb2Vzbid0IHJlYWxseSBmaXQgaW4NCj4gd2VsbA0KPiBhbmQgYWxtb3N0
IGNyaWVzIG91dCBmb3IgYSBjb21tYW5kIG9mIGl0cyBvd24gd2hpY2ggd291bGQgYmUgdXNlZCBi
eQ0KPiBzZW5kLWVtYWlsIGFuZCBiYXNoIGNvbXBsZXRpb24gKHRob3VnaCBJJ20gbm90IGNvbnZp
bmNlZCB0aGF0IGl0J3MNCj4gd29ydGggZ29pbmcgdGhhdCByb3V0ZSBmb3IgdGhpcyBvbmUgbWlu
b3IgdXNlLWNhc2UpLg0KDQpJIGRvbid0IHRoaW5rIGl0J3Mgd29ydGggaXQgYXQgdGhpcyBwb2lu
dCwgYmVjYXVzZSB3ZSdkIGhhdmUgdG8gZXh0cmFjdA0Kb3V0IHRoZSBhbGlhcyBwYXJzaW5nIGxv
Z2ljIGZyb20gc2VuZC1lbWFpbCwgd2hpY2ggaXMgbm90IGVhc3kuDQoNClRoZSBvcHRpb24gaXMg
cHJldHR5IG9ydGhvZ29uYWwgdG8gZ2l0LXNlbmQtZW1haWwsIGJ1dCB1bnRpbC91bmxlc3MNCmdp
dC1zZW5kLWVtYWlsIGlzIHJlLWltcGxlbWVudGVkIGluIEMsIGkgZG9uJ3QgcmVhbGx5IHNlZSB2
YWx1ZSBpbg0KdHJ5aW5nIHRvIHNlcGFyYXRlIHRoZSBsb2dpYyBvdXQuLi4gVGhhdCBpcyBhIGxv
dCBtb3JlIGVmZm9ydCBmb3IgdmVyeQ0KbGl0dGxlIGdhaW4uDQoNClJlZ2FyZHMsDQpKYWtl
