From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 2/2 v4] tag: support configuring --sort via .gitconfig
Date: Fri, 11 Jul 2014 20:37:02 +0000
Message-ID: <1405111022.22963.44.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405036334-8093-1-git-send-email-jacob.e.keller@intel.com>
	 <1405036334-8093-2-git-send-email-jacob.e.keller@intel.com>
	 <xmqqion4543l.fsf@gitster.dls.corp.google.com>
	 <1405096840.22963.8.camel@jekeller-desk1.amr.corp.intel.com>
	 <xmqqzjgf3g1j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"peff@peff.net" <peff@peff.net>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 22:37:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5hZr-0004LY-6W
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 22:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488AbaGKUhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 16:37:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:26831 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918AbaGKUhv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 16:37:51 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 11 Jul 2014 13:37:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,645,1400050800"; 
   d="scan'208";a="568656725"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2014 13:37:03 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Fri, 11 Jul 2014 13:37:03 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.189]) with mapi id 14.03.0123.003;
 Fri, 11 Jul 2014 13:37:03 -0700
Thread-Topic: [PATCH 2/2 v4] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPnTYMSWWDJi5WWEKYCjRA7Q2n5ZubyqkA
In-Reply-To: <xmqqzjgf3g1j.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <A8B2B351EC484041B7AEC1314E6BE163@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253321>

T24gRnJpLCAyMDE0LTA3LTExIGF0IDExOjI5IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gIktlbGxlciwgSmFjb2IgRSIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4gd3JpdGVzOg0K
PiANCj4gPiBUaGlzIGlzIG5vdCBob3cgdGhlIHJlc3Qgb2YgdGhlIGN1cnJlbnQgdGVzdHMgd29y
ay4gSSB3aWxsIHN1Ym1pdCBhDQo+ID4gcGF0Y2ggd2hpY2ggZml4ZXMgdXAgdGhlIGN1cnJlbnQg
LS1zb3J0IHRlc3RzIChidXQgbm90IGV2ZXJ5IHRlc3QsIGZvcg0KPiA+IG5vdykgYXMgd2VsbC4N
Cj4gDQo+IEkgZG8gbm90IHdhbnQgdG8gcGlsZSBtb3JlIHdvcmsgdGhhdCBpcyB1bnJlbGF0ZWQg
dG8gdGhlIHRhc2sgYXQNCj4gaGFuZCBvbiB5b3VyIHBsYXRlLCBpLmUuIGNsZWFuLXVwIHdvcmss
IHNvIEkgd291bGQgYXNzaWduIGEgdmVyeSBsb3cNCj4gcHJpb3JpdHkgdG8gImZpeCB1cCB0aGUg
Y3VycmVudCB0ZXN0cyIuICBBdCB0aGUgc2FtZSB0aW1lLCBleGlzdGluZw0KPiBtaXN0YWtlcyBh
cmUgbm90IGV4Y3VzZXMgdG8gaW50cm9kdWNlIG5ldyBzaW1pbGFyIG9uZXMsIGhlbmNlIG15DQo+
IHN1Z2dlc3Rpb25zIHRvIHRoZSBhZGRlZCBjb2RlIGluIHRoZSBwYXRjaCBJIHNhdy4NCj4gDQoN
Ckl0IHdhcyB0cml2aWFsIHRvIGZpeCBhdCBsZWFzdCB0aGUgLS1zb3J0IHRlc3RzLCBzbyBJIHN1
Ym1pdHRlZCBhIHBhdGNoDQp0aGF0IGdvZXMgYmVmb3JlIHRoaXMgb25lIHRvIGZpeCB0aG9zZSBh
cyB3ZWxsLg0KDQpUaGFua3MsDQpKYWtlDQo=
