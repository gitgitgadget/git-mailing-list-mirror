From: "Benkstein, Frank" <frank.benkstein@sap.com>
Subject: git blame breaking on repository with CRLF files
Date: Fri, 7 Aug 2015 16:32:58 +0000
Message-ID: <B0BFE3BB9B3E8C4A890D53FA460552D3737328B0@DEWDFEMB16B.global.corp.sap>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 07 18:39:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNkfy-00007E-7n
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 18:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbbHGQi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 12:38:58 -0400
Received: from smtpgw02.sap-ag.de ([155.56.66.97]:41191 "EHLO smtpgw.sap-ag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932143AbbHGQi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 12:38:57 -0400
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Aug 2015 12:38:57 EDT
Thread-Topic: git blame breaking on repository with CRLF files
Thread-Index: AdDRLGkXrTzA3eIPSxmDDSZPpRRZSw==
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.21.40.92]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275470>

SGVsbG8sDQoNCkkgYW0gd29ya2luZyB3b3JraW5nIG9uIExpbnV4IGFuZCBhbSBleGFtaW5pbmcg
Y29kZSBpbiBhIGdpdCByZXBvc2l0b3J5IEkgZG8NCm5vdCBrbm93IG11Y2ggYWJvdXQuICBJIGFt
IG9ubHkgbG9va2luZyBhdCBmaWxlcywgbm90IGNoYW5naW5nIGFueXRoaW5nLiAgT24NCnNvbWUg
ZmlsZXMgaW4gdGhlIHJlcG9zaXRvcnkgSSBnZXQgIjAwMDAwMDAwIChOb3QgQ29tbWl0dGVkIFll
dCIgZm9yIGFsbCBsaW5lcw0Kd2hlbiBydW5uaW5nICJnaXQgYmxhbWUiLiAgSSBjaGVja2VkIHdp
dGggImdpdCBzdGF0dXMiLCAiZ2l0IHJlc2V0IiwgImdpdA0KY2xlYW4iIHRoYXQgdGhlIGZpbGVz
IGFyZSBpbmRlZWQgaW4gdGhlIHJlcG9zaXRvcnkgYW5kIHVubW9kaWZpZWQuICBJIG5vdGljZWQN
CnRoYXQgdGhpcyBvbmx5IGhhcHBlbnMgd2l0aCBnaXQgdjIuNS4wLiAgV2l0aCBnaXQgdjIuNC4w
IGl0IGxvb2tzIGNvcnJlY3QsIGkuZS4NCnRoZSBvdXRwdXQgaGFzIHByb3BlciBjb21taXQgaWRz
LCBBdXRob3IgbmFtZXMgYW5kIGRhdGVzLi4gIFdpdGggImdpdCBiaXNlY3QiIEkNCnRyYWNrZWQg
dGhpcyBkb3duIHRvIHRoZSBmb2xsb3dpbmcgY29tbWl0Og0KDQogY29tbWl0IDRiZjI1NmQ2N2E4
NWJlZDFlMTc1ZWNjMjcwNjMyMmVhZmU0NDg5Y2EgKEhFQUQsIHJlZnMvYmlzZWN0L2JhZCkNCiBB
dXRob3I6IFRvcnN0ZW4gQsO2Z2Vyc2hhdXNlbiA8dGJvZWdpQHdlYi5kZT4NCiBEYXRlOiAgIFN1
biBNYXkgMyAxODozODowMSAyMDE1ICswMjAwDQoNCiAgICAgYmxhbWU6IENSTEYgaW4gdGhlIHdv
cmtpbmcgdHJlZSBhbmQgTEYgaW4gdGhlIHJlcG8NCg0KRGlnZ2luZyBmdXJ0aGVyLCBpdCBzZWVt
cyB0aGF0IG1vc3QgZmlsZXMgaW4gdGhlIHJlcG9zaXRvcnkgYXJlIGNoZWNrZWQgaW4gd2l0aA0K
Q1JMRiBsaW5lIGVuZGluZ3MuICBJbiBteSB3b3JraW5nIHRyZWUgdGhlc2UgYXJlIGNoZWNrZWQg
b3V0IGFzIExGIC0gd2hpY2gNCnNlZW1zIHRvIGJlIHRoZSBleGFjdCBvcHBvc2l0ZSBzaXR1YXRp
b24gb2Ygd2hhdCB0aGUgY29tbWl0IGlzIHRyeWluZyB0bw0KYWRkcmVzcy4gIFdoZW4gSSBzZXQg
ImNvcmUuYXV0b2NybGYiIHRvICJmYWxzZSIgSSBhbHNvIGdldCB0aGUgY29ycmVjdCBiZWhhdmlv
cg0Kb2YgImdpdCBibGFtZSIgLSB0aGlzIGlzIGEgd29ya2Fyb3VuZCBhcyBsb25nIGFzIEkgZG8g
bm90IGhhdmUgdG8gYWN0dWFsbHkNCm1vZGlmeSBhbnl0aGluZy4NCg0KQmVzdCByZWdhcmRzLA0K
RnJhbmsuDQo=
