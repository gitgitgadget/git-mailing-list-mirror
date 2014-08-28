From: =?big5?B?p/Wvp7TF?= <r01942008@ntu.edu.tw>
Subject: Git Bug Resolve: bisect run failed to locate the right commit, not
 git bug
Date: Thu, 28 Aug 2014 15:43:12 +0000
Message-ID: <C40A01C66E914D4EB90E1B40564B0E56CBFE311B@MBOX2-4.ntu.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 17:43:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN1rO-0004kA-RW
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 17:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbaH1PnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 11:43:18 -0400
Received: from mail.ntu.edu.tw ([140.112.9.9]:65418 "EHLO mail.ntu.edu.tw"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930AbaH1PnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 11:43:16 -0400
Received: from MBOX2-4.ntu.internal ([fe80::5d32:d7a9:9a20:f15]) by
 Exchcas05.ntu.internal ([fe80::b9f2:172d:db56:4084%15]) with mapi id
 14.03.0123.003; Thu, 28 Aug 2014 23:43:13 +0800
Thread-Topic: Git Bug Resolve: bisect run failed to locate the right commit,
 not git bug
Thread-Index: Ac/C1PRqDnQr6Kf9Tz6a6MDZBhqRtg==
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [223.133.125.143]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256099>

RGVhciBnaXQgZGV2ZWxvcGVyOg0KDQpPbiBBdWd1c3QgMjcsIEkgcmVwb3J0IGEgYnVnIG9uIGdp
dCBiaXNlY3Q6IA0KImJpc2VjdCBydW4gZmFpbGVkIHRvIGxvY2F0ZSB0aGUgcmlnaHQgY29tbWl0
Ig0KDQpUb2RheSwgbXkgZnJpZW5kIHRvbGQgbWUgdGhhdCB0aGUgcHJvYmxlbSBtYXkgYmUgY2F1
c2VkIGJ5IHRoZSBweXRob24gY29tcGlsZWQgZmlsZSAqLnB5Yy4NClNpbmNlIGlmIHB5dGhvbiBz
ZWUgdGhlIHB5YyBpcyBhICJuZXciIGNvbXBpbGVkLCBpdCB3aWxsIGRpcmVjdGx5IHJ1biAqcHlj
IGZpbGUgYnV0IHVwZGF0ZSBpdC4NCg0KV2hlbiB3ZSB1c2UgYmlzZWN0LXJ1biwgaXQgcXVpY2ts
eSBjaGVja291dCBkaWZmZXJlbnQgdmVyc2lvbiBhbmQgcnVuIHRoZSBzY3JpcHQgdG8gdGVzdCBp
dC4NCkl0J3Mgc28gZmFzdCB0aGF0IHRoZSAqcHljIGZpbGUgYXJlIHN0aWxsIG5ldyBmaWxlcywg
c28gcHl0aG9uIHJ1biAqLnB5YyBhbmQgZ2V0IHNhbWUgcmVzdWx0Lg0KVGhhdCdzIHRoZSB3cm9u
ZyByZXN1bHQgY2FtZSBmcm9tLg0KDQpUaGVyZSBhcmUgdHdvIHdheSB0byBhdm9pZCB0aGlzIHBy
b2JsZW06DQpGaXJzdCBpcyBkZWxldGUgYWxsICoucHljIGJlZm9yZSBweXRob24gcnVuLCBhZGQg
YSB0ZXN0LnNoIHdpdGggZm9sbG93aW5nIGNvbnRlbnQ6DQpmaW5kIC4gLW5hbWUgKi5weWMgLWV4
ZWMgcm0ge30gXDsNCi4vYXV0b3NjcmlwdC5weQ0KDQpTZWNvbmQgaXMgbGV0IHB5dGhvbiBydW4g
c2xvd2VyLCBhZGRpbmcgYSBkZWxheSBpbiBhdXRvc2NyaXB0LnB5Og0KaW1wb3J0IHRpbWUNCnRp
bWUuc2xlZXAoMSkNCg0KQm90aCBtZXRob2QgbGV0IGdpdC1iaXNlY3QtcnVuIGdpdmUgdGhlIHJp
Z2h0IHJlc3VsdC4NCg0KU29ycnkgYWJvdXQgdGhlIHdyb25nIGJ1ZyByZXBvcnQsIGl0IHByb3Zl
IHRoYXQgZ2l0LWJpc2VjdC1ydW4gaXMgdmVyeSB2ZXJ5IGZhc3QgLS0gdG9vIGZhc3QgdG8gY2F1
c2Ugc29tZSBtaXN0YWtlIGxvbA0KDQpTaW5jZXJlbHkgDQpZb2RhTGVlDQoyMDE0MDgyOA==
