From: "Richard Furness -X (rfurness - ENSOFT LIMITED at Cisco)" 
	<rfurness@cisco.com>
Subject: RE: 2.8.0 gitignore enhancement not working as expected
Date: Fri, 18 Mar 2016 15:33:26 +0000
Message-ID: <20118f38fdbb48af99292e69648fd7e9@XCH-RCD-003.cisco.com>
References: <4a4980485c234280bce91be87d213216@XCH-RCD-003.cisco.com>
 <CACsJy8Bjv=fF0CSNF_QNTCYCqQjy=j0ZEyjYOBFscz0HEYATig@mail.gmail.com>
 <551499517627471db2c8434077eb16db@XCH-RCD-003.cisco.com>
 <CACsJy8BfySC0extNWmKHgF1QOoEzGtg5RxgpfsNxjp8HJ_rdXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 16:33:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agwP8-0003Oi-3t
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 16:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbcCRPda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 11:33:30 -0400
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:18497 "EHLO
	rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbcCRPd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 11:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1224; q=dns/txt; s=iport;
  t=1458315208; x=1459524808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YQz2ELC3HXYnIX5GWlvZIGJ+zq+XS1edN2TooeDWDcE=;
  b=Q+FWrkiKw7OE+0tRRSGKijRpX3OLhj1xX38rNUkiynoLzkriGc1nutd0
   0S9AFGh4JZEoyYF1Pc0saeuDTCG+ApXWtqLgraMLVhEj2xIVFjS+PbqkK
   op+recfcSlrSu2Nl7SZhI3ISuyW2+UfNKa8M7iRpfgYrT00x/8en62pWl
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AFAgDQHuxW/4MNJK1eg0VTcgauSYtNA?=
 =?us-ascii?q?Q2BbyGFbAIcgRI4FAEBAQEBAQFkJ4RBAQEBBCMRRQwEAgEIDgMEAQEBAgIjAwI?=
 =?us-ascii?q?CAh0CERQBCAgBAQQOBQiICgMSDrEainkNhFYBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEVfIlmgj6BWIMmglYFkwSEIjEBFoVahh6BboI3jFeHMYdUAR4BAUKDZWoBAQG?=
 =?us-ascii?q?JJT1+AQEB?=
X-IronPort-AV: E=Sophos;i="5.24,355,1454976000"; 
   d="scan'208";a="82136313"
Received: from alln-core-1.cisco.com ([173.36.13.131])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Mar 2016 15:33:27 +0000
Received: from XCH-ALN-004.cisco.com (xch-aln-004.cisco.com [173.36.7.14])
	by alln-core-1.cisco.com (8.14.5/8.14.5) with ESMTP id u2IFXR6I026752
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
	Fri, 18 Mar 2016 15:33:27 GMT
Received: from xch-rcd-003.cisco.com (173.37.102.13) by XCH-ALN-004.cisco.com
 (173.36.7.14) with Microsoft SMTP Server (TLS) id 15.0.1104.5; Fri, 18 Mar
 2016 10:33:26 -0500
Received: from xch-rcd-003.cisco.com ([173.37.102.13]) by
 XCH-RCD-003.cisco.com ([173.37.102.13]) with mapi id 15.00.1104.009; Fri, 18
 Mar 2016 10:33:26 -0500
Thread-Topic: 2.8.0 gitignore enhancement not working as expected
Thread-Index: AdGA+Oope1o05p+SRVOEuS4waIVawgAOQXSAAAQGuNAAA2twgAAJGyVw
In-Reply-To: <CACsJy8BfySC0extNWmKHgF1QOoEzGtg5RxgpfsNxjp8HJ_rdXQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.63.23.173]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289224>

SGkgRHV5LA0KDQpUaGF0IHNlZW1zIHRvIGhhdmUgZml4ZWQgaXQgOi0pDQoNClRoYW5rcyBmb3Ig
eW91ciBoZWxwIQ0KDQpSaWNoYXJkDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogRHV5IE5ndXllbiBbbWFpbHRvOnBjbG91ZHNAZ21haWwuY29tXQ0KPiBTZW50OiAxOCBN
YXJjaCAyMDE2IDE0OjUzDQo+IFRvOiBSaWNoYXJkIEZ1cm5lc3MgLVggKHJmdXJuZXNzIC0gRU5T
T0ZUIExJTUlURUQgYXQgQ2lzY28pDQo+IDxyZnVybmVzc0BjaXNjby5jb20+DQo+IENjOiBnaXRA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiAyLjguMCBnaXRpZ25vcmUgZW5oYW5jZW1l
bnQgbm90IHdvcmtpbmcgYXMgZXhwZWN0ZWQNCj4gDQo+IE9uIEZyaSwgTWFyIDE4LCAyMDE2IGF0
IDk6MzIgUE0sIFJpY2hhcmQgRnVybmVzcyAtWCAocmZ1cm5lc3MgLSBFTlNPRlQNCj4gTElNSVRF
RCBhdCBDaXNjbykgPHJmdXJuZXNzQGNpc2NvLmNvbT4gd3JvdGU6DQo+ID4gSGkgRHV5LA0KPiA+
DQo+ID4gSSB0cmllZCB5b3VyIGV4YWN0IGV4YW1wbGUgYW5kIGl0IHdvcmtlZCBjb3JyZWN0bHku
IEJ1dCB0aGVuIEkgdHJpZWQgYWRkaW5nDQo+IHNvbWUgbW9yZSBmaWxlcy9kaXJzIGF0IHRoZSB0
b3AgbGV2ZWwgYW5kIEkgc3RpbGwgc2VlIGFuIGlzc3VlOg0KPiANCj4gVGhhbmsgeW91LiBQaGV3
Li4gSSBiZXQgeW91IGhpdCB0aGUgc2FtZSBidWcgd2UgZm91bmQgeWVzdGVyZGF5ICh5b3VyDQo+
IHRyYWNlIHN1Z2dlc3RzIHNvKS4gQ2FuIHlvdSB0cnkgdGhpcyBwYXRjaCBbMV0ganVzdCB0byBj
b25maXJtPw0KPiANCj4gWzFdIGh0dHA6Ly9hcnRpY2xlLmdtYW5lLm9yZy9nbWFuZS5jb21wLnZl
cnNpb24tY29udHJvbC5naXQvMjg5MTAxDQo+IC0tDQo+IER1eQ0K
