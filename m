From: <stefan.naewe@atlas-elektronik.com>
Subject: about rev-parse's quietness
Date: Thu, 15 Oct 2015 12:26:34 +0200
Message-ID: <561F7F5A.4060708@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 12:33:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmfqc-0006VG-MQ
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 12:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbbJOKdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 06:33:17 -0400
Received: from mail96.atlas.de ([194.156.172.86]:31097 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbbJOKdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 06:33:16 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2015 06:33:16 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 5D30010152
	for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:26:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jAwK0MJ0NbGe for <git@vger.kernel.org>;
	Thu, 15 Oct 2015 12:26:35 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP
	for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:26:35 +0200 (CEST)
Received: from MSEXSRV1.atlas.de (lbexsrv00.atlas.de [10.196.180.65])
	by mgsrv01.atlas.de (Postfix) with ESMTP id BF2F327169
	for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:26:35 +0200 (CEST)
Received: from MSSRVS1.atlas.de (10.200.101.71) by MSEXSRV1.atlas.de
 (10.200.102.56) with Microsoft SMTP Server (TLS) id 14.3.248.2; Thu, 15 Oct
 2015 12:26:35 +0200
Received: from MSSRVS4.atlas.de ([10.200.97.74]) by MSSRVS1.atlas.de
 ([10.200.101.71]) with mapi; Thu, 15 Oct 2015 12:26:35 +0200
Thread-Topic: about rev-parse's quietness
Thread-Index: AdEHM/eKNaZveqUvQNO4M2Vb0QQUIg==
Accept-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
x-enigmail-draft-status: N1010
acceptlanguage: de-DE
X-C2ProcessedOrg: 8e578ea2-b414-4638-aa54-659db1be7428
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279658>

SGVsbG8gdGhlcmUuDQoNCkknbSB1c2luZyBhIGJhc2ggZnVuY3Rpb24gdGhhdCBkb2VzIGEgY29t
YmluYXRpb24gb2YgJ2xzIC1sJywgJ2dpdCBzdGF0dXMnLCBhbmQgJ2dpdCBicmFuY2gnDQp0byBn
aXZlIG1lIGEgcXVpY2sgb3ZlcnZpZXcgb2Ygd2hlcmUgSSBzdGFuZCBpbiB0aGUgY3VycmVudCBn
aXQgcmVwby4NCg0KSSBwbGFubmVkIHRvIGV4dGVuZCB0aGF0IGZ1bmN0aW9uIHRvIGFsc28gbGlz
dCB0aGUgdG8tYmUtcHVzaGVkIGNvbW1pdHMgaW4gdGhlDQpjdXJyZW50IGJyYW5jaCwgc29tZXRo
aW5nIGxpa2UgDQoNCiQgZ2l0IGxvZyAtLW9uZWxpbmUgLS1hYmJyZXYtY29tbWl0IC0tZGVjb3Jh
dGUgQHt1fS4uDQoNCkJ1dCBJIGRvbid0IHdhbnQgdG8gcnVuIHRoYXQgJ2dpdCBsb2cuLi4nIGlm
IHRoZXJlJ3Mgbm8gdXBzdHJlYW0gY29uZmlndXJlZA0KZm9yIEhFQUQgKGFuZCBJIGRvbid0IHdh
bnQgdG8gc2VlIGFueSBlcnJvciEpDQoNCk9LLiBUaGF0J3MgYSB0YXNrIGZvciAnZ2l0IHJldi1w
YXJzZScgSSB0aG91Z2h0Og0KDQokIHVwPSQoZ2l0IHJldi1wYXJzZSAtLXZlcmlmeSAtLXF1aWV0
IEB7dX0pICYmDQogIGdpdCBsb2cgLS1sZWZ0LXJpZ2h0IC0tb25lbGluZSAtLWFiYnJldi1jb21t
aXQgLS1kZWNvcmF0ZSAkdXANCmZhdGFsOiBubyB1cHN0cmVhbSBjb25maWd1cmVkIGZvciBicmFu
Y2ggJ21hc3RlcicNCg0KV2FpdC4gV2hhdD8NCg0KSSB0aG91Z2h0IHJldi1wYXJzZSB3aXRoICct
LXZlcmlmeScgYW5kICctLXF1aWV0JyBpcyBqdXN0IHRoYXQgLSBxdWlldCAtDQppbiBjYXNlICIu
Li50aGUgZmlyc3QgYXJndW1lbnQgaXMgbm90IGEgdmFsaWQgb2JqZWN0IG5hbWUiID8NCg0KTGV0
J3Mgc2VlOg0KJCBnaXQgcmV2LXBhcnNlIC0tdmVyaWZ5IC0tcXVpZXQgbWFzdGVyQHt4eXp9IHx8
IGVjaG8gTm8NCk5vDQoNCiQgZ2l0IHJldi1wYXJzZSAtLXZlcmlmeSAtLXF1aWV0IG1hc3RlckB7
dX0gfHwgZWNobyBObw0KZmF0YWw6IG5vIHVwc3RyZWFtIGNvbmZpZ3VyZWQgZm9yIGJyYW5jaCAn
bWFzdGVyJw0KTm8NCg0KSSBkb24ndCB3YW50IHRvIHNlZSB0aGF0IGVycm9yIChhbmQgSSBrbm93
IEkgY291bGQganVzdCByZWRpcmVjdCBzdGRvdXQvc3RkZXJyIHRvIC9kZXYvbnVsbCAuLi4pDQoN
ClNvOiBBcmUgbXkgZXhwZWN0YXRpb25zIGFib3V0ICdyZXYtcGFyc2UgLS12ZXJpZnkgLS1xdWll
dCcgd3Jvbmcgb3IgYW0gSSBkb2luZw0Kc29tZXRoaW5nIHN0dXBpZCA/DQoNClRoYW5rcywNCiAg
U3RlZmFuDQotLSANCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCi9kZXYvcmFuZG9tIHNheXM6IERpc2NsYWltZXI6IFdyaXR0
ZW4gYnkgYSBoaWdobHkgY2FmZmVpbmF0ZWQgbWFtbWFsLg0KcHl0aG9uIC1jICJwcmludCAnNzM3
NDY1NjY2MTZlMmU2ZTYxNjU3NzY1NDA2MTc0NmM2MTczMmQ2NTZjNjU2Yjc0NzI2ZjZlNjk2YjJl
NjM2ZjZkJy5kZWNvZGUoJ2hleCcpIiANCkdQRyBLZXkgZmluZ2VycHJpbnQgPSAyREY1IEUwMUIg
MDlDMyA3NTAxIEJDQTkgIDk2NjYgODI5QiA0OUM1IDkyMjEgMjdBRg0K
