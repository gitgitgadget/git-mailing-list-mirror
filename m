From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: git notes from incoming patch
Date: Tue, 3 Mar 2015 01:32:38 +0000
Message-ID: <1425346358.13037.13.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 03 02:32:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSbhW-0007U4-4i
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 02:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbbCCBcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 20:32:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:5219 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754851AbbCCBcl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 20:32:41 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP; 02 Mar 2015 17:32:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,679,1418112000"; 
   d="scan'208";a="461629845"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Mar 2015 17:26:31 -0800
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Mon, 2 Mar 2015 17:32:39 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.201]) by
 ORSMSX158.amr.corp.intel.com ([169.254.10.145]) with mapi id 14.03.0195.001;
 Mon, 2 Mar 2015 17:32:39 -0800
Thread-Topic: git notes from incoming patch
Thread-Index: AQHQVVHv6MaveNGQ+ki00TL1AePDFA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.3.110]
Content-ID: <CE5F0F2FB0403B458C5267E6BF06C749@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264640>

SGksDQoNCkkgYW0gd29uZGVyaW5nIHdoZXRoZXIgaXQgaXMgcG9zc2libGUgdG8gcmVhZCBmcm9t
IGEgZm9ybWF0LXBhdGNoIGlucHV0DQphbmQgYWRkIG5vdGVzIHdoZW4gd2UgZ2VuZXJhdGUgdGhl
IGFwcGxpZWQgcGF0Y2guDQoNClRoZSB1c2UgY2FzZSBpcyB0byBiZSBhYmxlIHRvIHNlbmQgcGF0
Y2hlcyB0aGF0IGhhZCBub3RlcyBhcHBlbmRlZCB2aWENCg0KJGdpdCBmb3JtYXQtcGF0Y2ggLS1u
b3RlcyAuLi4NCg0KQW5kIGhhdmUgbm90ZXMgb2JqZWN0cyBjcmVhdGVkIG9uIHRoZSByZW1vdGUg
cmVwb3NpdG9yeSB0byBzdG9yZSB0aGlzDQppbmZvcm1hdGlvbi4NCg0KSXMgdGhlcmUgYW55IHdh
eSB0byBkbyB0aGlzPyBhbmQvb3IgaXMgdGhlcmUgYSB3YXkgdG8gZ2V0IHRoZSBzYW1lDQpyZXN1
bHRzIHRoYXQgbWF5YmUgZG9lc24ndCB1c2Ugbm90ZXM/DQoNClRoZSBwcm9ibGVtIHdlIGFyZSB0
cnlpbmcgdG8gc29sdmUgaXMgYSB3YXkgdG8gdHJhY2sgc29tZSBpbmZvcm1hdGlvbg0KYWJvdXQg
YSBwYXRjaCB0aGF0IHdlIG5lZWQgaW50ZXJuYWxseSB3aXRob3V0IHN1Ym1pdHRpbmcgaXQgdXBz
dHJlYW0NCndoZW4gd2Ugc3VibWl0IHRoZSBwYXRjaGVzIGxhdGVyLiBXZSB1c2UgZW1haWwgdG8g
aGFuZGxlIGludGVybmFsIHBhdGNoDQpxdWV1ZXMsIHNvIGVzc2VudGlhbGx5IHdlIHdhbnQgdG8g
YmUgYWJsZSB0byBhZGQgbm90ZSBvYmplY3RzIHRvIHRoZQ0KZm9ybWF0LXBhdGNoIGFuZCBzZW5k
IHRoZW0gdmlhIGVtYWlsLg0KDQpSZWdhcmRzLA0KSmFrZQ0K
