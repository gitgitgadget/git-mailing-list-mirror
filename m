From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: Git tag: pre-receive hook issue
Date: Mon, 20 Jul 2015 16:02:45 +0000
Message-ID: <1437408165.11638.3.camel@intel.com>
References: <1437159533304-7635764.post@n2.nabble.com>
	 <CA+P7+xoXgSHPVhMTm_GZbq+6Pps5yttK2rBZpMycTUFGfqOCvw@mail.gmail.com>
	 <CAGDgvc2F7UMWTVrRFt5eK2xmbfz-kyWh6Vp-eQNEj7tixzRPYQ@mail.gmail.com>
	 <CA+P7+xrbWt=n6hj4bTcdLRMPXa0K51gErNBD-omQy+g-So6TYw@mail.gmail.com>
	 <CAGDgvc3O=q-k3ViiEds4iPMtDQTOSFMSJ4bUKRFyWzqwv7=J_Q@mail.gmail.com>
	 <CA+P7+xpevvV=5QdfBdzcD=8=2ff+m-kzxX-w1wLME8oRyn8QBA@mail.gmail.com>
	 <CAGDgvc1CwmQV75mo22v5LQH4q-kNMFtVq3Y9eSt9LL44JHr5Og@mail.gmail.com>
	 <CA+P7+xqXxYtJiJ4xdYya25NgqrxncWP3rpVMLYBWTbnnA_oynQ@mail.gmail.com>
	 <CAGDgvc08ZMdKH-6FdtYWXCBbiX=UYdKTTKVtEF65J+jW5mDYCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	"varuag.chhabra@gmail.com" <varuag.chhabra@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 18:02:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHDWl-0005uU-Hz
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 18:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbbGTQCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 12:02:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:17727 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752272AbbGTQCq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 12:02:46 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP; 20 Jul 2015 09:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,508,1432623600"; 
   d="scan'208";a="527206184"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jul 2015 09:02:45 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.196]) by
 ORSMSX102.amr.corp.intel.com ([169.254.1.15]) with mapi id 14.03.0224.002;
 Mon, 20 Jul 2015 09:02:45 -0700
Thread-Topic: Git tag: pre-receive hook issue
Thread-Index: AQHQwMPdeDTp2HS8L0Oq7h/tzyEqbp3hEHcAgAEOXwCAACVkAIAAoCcAgAAME4CAABqYAIAA3/AAgACIY4CAAIt5gA==
In-Reply-To: <CAGDgvc08ZMdKH-6FdtYWXCBbiX=UYdKTTKVtEF65J+jW5mDYCA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.3.85]
Content-ID: <8BE1890266DF4949B8A0A682D1867AFD@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274326>

T24gTW9uLCAyMDE1LTA3LTIwIGF0IDEzOjEzICswNTMwLCBHYXVyYXYgQ2hoYWJyYSB3cm90ZToN
Cj4gSGkgSmFrZSwNCj4gDQo+IFRoYW5rcyBhYm91dCB0aGUgcmVmcy90YWdzIGNoZWNrLiBJ4oCZ
bSBhd2FyZSBhYm91dCB0aGlzLiBKdW5pbyBhbHNvDQo+IGV4cGxhaW5lZCBpdCBpbiBvbmUgb2Yg
aGlzIHJlcGxpZXMuIEkgd2FzIGFjdHVhbGx5IGNvbmZ1c2VkIHdoeSBteQ0KPiBjdXJyZW50IGNv
ZGUgd2FzIHdvcmtpbmcgaW4gcGFzdCBmb3IgZmV3IG9mIHRoZSBhbm5vdGF0ZWQgdGFncy4NCj4g
QW55d2F5cywgbm93IHRoYXQgSSBoYXZlIGNsYXJpdHkgYWJvdXQgdGhlIG1pc3Rha2UgaW4gdGhl
IGNvZGUsIEkNCj4gZ3Vlc3MsIEnigJlsbCBmaWd1cmUgaXQgb3V0IG15c2VsZi4NCj4gDQo+IEBK
dW5pbzogVGhhbmtzIGEgbG90IGZvciB5b3VyIGRldGFpbGVkIGV4cGxhbmF0aW9uIGFib3V0IHRo
ZSDigJhiZWhpbmQNCj4gdGhlIHNjZW5lc+KAmSBhY3Rpdml0eSBkdXJpbmcgYSBwdXNoIHByb2Nl
c3MuIFRoYXQgd2FzIGRlZmluaXRlbHkNCj4gaGVscGZ1bCBhbmQgd2lsbCBoZWxwIG1lIGluIGZ1
dHVyZSB0b28uDQo+IA0KPiBASmFrZTogVGhhbmtzIGZvciB5b3VyIGhlbHAgYW5kIHlvdXIgcGF0
aWVuY2UgaW4gZXhwbGFpbmluZyB0aGluZ3MuDQo+IA0KDQpObyBwcm9ibGVtLiBJJ20gYWxzbyBu
b3QgY2VydGFpbiB3aHkgaXQgd291bGQgaGF2ZSB3b3JrZWQgaW4gc29tZQ0KY2FzZXMsIHNvIHRo
YXQgaXMgZGVmaW5pdGVseSBjb25mdXNpbmcsIGJ1dCBhdCBsZWFzdCB5b3UgY2FuIGdldCBpdA0K
c29ydGVkIHRvIGRvIHdoYXQgeW91IGludGVuZC4gQmVzdCBvZiBsdWNrIQ0KDQpSZWdhcmRzLA0K
SmFrZQ==
