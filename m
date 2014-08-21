From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: cherry picking and merge
Date: Thu, 21 Aug 2014 17:36:02 +0000
Message-ID: <1408642561.20771.7.camel@jekeller-desk1.amr.corp.intel.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
	 <20140801024329.GA28914@vauxhall.crustytoothpaste.net>
	 <AC750A73-4FE9-4BCB-9A51-4DE28F2110A7@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>
To: "mikestump@comcast.net" <mikestump@comcast.net>
X-From: git-owner@vger.kernel.org Thu Aug 21 19:36:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKWHm-0007oZ-Mb
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 19:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbaHURg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 13:36:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:42936 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239AbaHURg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 13:36:26 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 21 Aug 2014 10:30:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,909,1406617200"; 
   d="scan'208";a="591461372"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga002.jf.intel.com with ESMTP; 21 Aug 2014 10:36:03 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Thu, 21 Aug 2014 10:36:03 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.235]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.134]) with mapi id 14.03.0195.001;
 Thu, 21 Aug 2014 10:36:03 -0700
Thread-Topic: cherry picking and merge
Thread-Index: AQHPrSPD+/6v1TJ/S0WPKdhqxfKaW5u7f9GAgADuboCAH3mRgA==
In-Reply-To: <AC750A73-4FE9-4BCB-9A51-4DE28F2110A7@comcast.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <F097DB65270BD44D986CDB965E753612@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255625>

T24gRnJpLCAyMDE0LTA4LTAxIGF0IDA5OjU2IC0wNzAwLCBNaWtlIFN0dW1wIHdyb3RlOg0KPiBT
aW5jZSBldmVyeXRoaW5nIEkgZG8gZ29lcyB1cCBhbmQgZG93biBpbnRvIHJlcG9zaXRvcmllcyBh
bmQgSSBkb27igJl0IHdhbnQgbXkgZnJpZW5kcyBhbmQgZmFtaWx5IHRvIHNjb3JuIG1lLCByZWJh
c2UgaXNu4oCZdCB0aGUgY29tbWFuZCBJIHdhbnQgdG8gdXNlLg0KDQpZb3UgY29tcGxldGVseSBt
aXMtdW5kZXJzdGFuZCB3aGF0ICJwdWJsaXNoZWQiIG1lYW5zLiBQdWJsaXNoZWQgaGlzdG9yeQ0K
aXMgaGlzdG9yeSBmcm9tIHdoaWNoIG90aGVyIHBlb3BsZSBjYW4gcHVsbCByaWdodCBub3cuDQoN
ClRoYXQgbWVhbnMgaXQgaGFzIHRvIGJlIGluIGEgcHVibGljbHkgYWRkcmVzc2FibGUgcmVwb3Np
dG9yeSAoaWU6IGp1c3QNCmxpa2UgdGhlIHJlbW90ZSB0aGF0IHlvdSBhcmUgcHVsbGluZyBmcm9t
IGFzIHVwc3RyZWFtKS4NCg0KcmViYXNpbmcgY29tbWl0cyB3aGljaCBhcmUgYWxyZWFkeSBpbiB0
aGUgdXBzdHJlYW0gaXMgYmFkLiBSZWJhc2luZw0KY29tbWl0cyB3aGljaCB5b3UgaGF2ZSBjcmVh
dGVkIGxvY2FsbHkgaXMgTk9UIGJhZC4gVGhlc2UgY29tbWl0cyB3b3VsZA0Kbm90IGJlIHB1Ymxp
c2hlZCB1bnRpbCB5b3UgZG8gYSBwdXNoLg0KDQpUaGlzIGlzIHRoZSBmdW5kYW1lbnRhbCBpc3N1
ZSB3aXRoIHJlYmFzZSwgYW5kIGl0IGlzIGluZmFjdCBlYXN5IHRvDQphdm9pZCBtaXMtdXNpbmcs
IGVzcGVjaWFsbHkgaWYgeW91IGRvbid0IHB1Ymxpc2ggY2hhbmdlcy4gVGhlIGtleSBpcw0KdGhh
dCBhIGNvbW1pdCBpc24ndCBwdWJsaXNoZWQgdW50aWwgaXQncyBzb21ldGhpbmcgc29tZW9uZSBl
bHNlIGNhbg0KZGVwZW5kIG9uLg0KDQpEb2luZyAiZ2l0IHB1bGwgLS1yZWJhc2UiIGVzc2VudGlh
bGx5IGRvZXNuJ3QgZXZlciBnZXQgeW91IGludG8gdHJvdWJsZS4NCg0KUmVnYXJkcywNCkpha2UN
Cg==
