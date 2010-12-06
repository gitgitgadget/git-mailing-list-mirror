From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: Git Gui does not want to work on chunk level
Date: Mon, 6 Dec 2010 22:30:08 +0100
Message-ID: <AANLkTi=VK6ghfzVbGmG0Ow7XGkWVa=QqorCBbMHo8e0O@mail.gmail.com>
References: <c6c947f60808270216k2feb8f9ar765cdee1fc3910ee@mail.gmail.com>
	<c6c947f60809031223i575ca3fdya357588610bb72e8@mail.gmail.com>
	<20080903230814.GJ28315@spearce.org>
	<c6c947f60809040220t589e65bfkbd693fd335792069@mail.gmail.com>
	<20080904143723.GB23708@spearce.org>
	<c6c947f60809040754g34e60633lcd5f872ac5e80158@mail.gmail.com>
	<20080905045327.GA31166@spearce.org>
	<48CE09EF.7090609@viscovery.net>
	<AANLkTimz17vodjS7K_ts2pcoZHTo2eb9=FaWwEyhihsa@mail.gmail.com>
	<AANLkTikd84--37+vcoHifqFeUGznEQ9YXDaY3a3zOekn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 06 22:30:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPidj-0002eT-Ih
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 22:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007Ab0LFVaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 16:30:11 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:38681 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968Ab0LFVaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 16:30:09 -0500
Received: by gxk19 with SMTP id 19so7015348gxk.11
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 13:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Pi2kHtBjI4gIRjhwErkT3SZ925dgEx5PYaM4yteOh4k=;
        b=hmyAlnnAI2E2WM07aCKEpA8NC8IWN0EMy33yNHBK+QuFVQc4oUtftLMi89uSXSKZri
         F6A3KgWvDH/f23SC16T7YEQUh6P+rpBqJ+80WlDdAGoG15l1FU5MIpebjwU62DnENRGG
         NwIlCprhBz/XKkQd77beHDJ1UuIMH1Fu2OcQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cbOzQo/kFR81iOkfoPA6XspbgUAo8eIFJr0p5BXDsdxxK2R4ChYSEHC3RxeZE4RMOM
         83m4mOe/9jhaFJNiltkFc7cbLWy8L6e/ZiLJQMDDvs0aMTUSpaav98mVCeiWAX03669H
         7axywSHEhxOZjNt8OZ7NqJTi64vOkWnLhpQwc=
Received: by 10.42.222.200 with SMTP id ih8mr1627341icb.23.1291671008729; Mon,
 06 Dec 2010 13:30:08 -0800 (PST)
Received: by 10.42.172.193 with HTTP; Mon, 6 Dec 2010 13:30:08 -0800 (PST)
In-Reply-To: <AANLkTikd84--37+vcoHifqFeUGznEQ9YXDaY3a3zOekn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163028>

T24gVHVlLCBOb3YgMzAsIDIwMTAgYXQgMjM6MjAsIEJlcnQgV2VzYXJnIDxiZXJ0Lndlc2FyZ0Bn
b29nbGVtYWlsLmNvbT4gd3JvdGU6Cj4gT24gVHVlLCBOb3YgMzAsIDIwMTAgYXQgMjI6MTksIEJl
cnQgV2VzYXJnIDxiZXJ0Lndlc2FyZ0Bnb29nbGVtYWlsLmNvbT4gd3JvdGU6Cj4+IE9uIE1vbiwg
U2VwIDE1LCAyMDA4IGF0IDA5OjA4LCBKb2hhbm5lcyBTaXh0IDxqLnNpeHRAdmlzY292ZXJ5Lm5l
dD4gd3JvdGU6Cj4+PiDCoG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+PiDCoC0tLSAvZGV2L251bGwK
Pj4+IMKgKysrIGIvZm9vCj4+PiDCoEBAIC0wLDAgKzEgQEAKPj4+IMKgK2Zvbwo+Pgo+PiBJIGp1
c3Qgbm90aWNlZCB0aGUgc2FtZSwgYW5kIGFzayBtZSB3aHkgdGhpcyByZXBvcnQgd2Fzbid0IGhv
bm9yZWQuCj4+Cj4+IEFsc28gZ2l0IG1heSBzcGlsbCBvdXQgMiBkaWZmcyBmb3IgdHlwZSBjaGFu
Z2VzIChmaWxlIHRvIHN5bWxpbmssIGZvcgo+PiBleGFtcGxlKS4gSW4gdGhpcyBjYXNlIHRoZSB3
ZSBzaG91bGQgcHJvYmFibHkgZGlzYWJsZSBhbnkgaHVuay0gb3IKPj4gbGluZS1sZXZlbCAodW4p
c3RhZ2luZy4KPgo+IEhlcmUgaXMgYSBwcm9wb3NhbCB3aGljaCBmaXhlcyB0aGlzIGNhc2UuIE5v
dCB0ZXN0ZWQgb24gdGhlIE9QcyByZXBvcnQuCj4KPiAtLTg8LS0KPiBkaWZmIC0tZ2l0IGEvbGli
L2RpZmYudGNsIGIvbGliL2RpZmYudGNsCj4gaW5kZXggOGZlYTk0Ny4uYjM5MDFjMyAxMDA2NDQK
PiAtLS0gYS9saWIvZGlmZi50Y2wKPiArKysgYi9saWIvZGlmZi50Y2wKPiBAQCAtMzk4LDcgKzM5
OCw2IEBAIHByb2MgcmVhZF9kaWZmIHtmZCBjb25mbGljdF9zaXplIGNvbnRfaW5mb30gewo+IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgeyRsaW5lIGVxIHtkZWxldGVkIGZpbGUgbW9kZSAxMjAw
MDB9fSB7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZXQgbGluZSAiZGVs
ZXRlZCBzeW1saW5rIgo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfQo+IC0gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgc2V0IDo6Y3VycmVudF9kaWZmX2luaGVhZGVyIDAKPgo+IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIyAtLSBBdXRvbWF0aWNhbGx5IGRldGVjdCBpZiB0aGlzIGlzIGEgMyB3YXkgZGlm
Zi4KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCMKPiBAQCAtNDE0LDYgKzQxMyw3IEBAIHByb2Mg
cmVhZF9kaWZmIHtmZCBjb25mbGljdF9zaXplIGNvbnRfaW5mb30gewo+IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfHwgW3JlZ2V4cCB7XlwqIFVubWVyZ2VkIHBhdGggfSAkbGlu
ZV19IHsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNldCB0YWdzIHt9Cj4g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9IGVsc2VpZiB7JGlzXzN3YXlfZGlmZn0gewo+ICsgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2V0IDo6Y3VycmVudF9kaWZmX2luaGVhZGVy
IDAKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNldCBvcCBbc3RyaW5nIHJh
bmdlICRsaW5lIDAgMV0KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN3aXRj
aCAtLSAkb3Agewo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgeyDCoH0ge3Nl
dCB0YWdzIHt9fQo+IEBAIC00NDAsNiArNDQwLDcgQEAgcHJvYyByZWFkX2RpZmYge2ZkIGNvbmZs
aWN0X3NpemUgY29udF9pbmZvfSB7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB9Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9Cj4gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB9IGVsc2VpZiB7JGlzX3N1Ym1vZHVsZV9kaWZmfSB7Cj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzZXQgOjpjdXJyZW50X2RpZmZfaW5oZWFkZXIgMAo+IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgeyRsaW5lID09ICIifSBjb250aW51
ZQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYge1tyZWdleHAge15TdWJt
b2R1bGUgfSAkbGluZV19IHsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHNldCB0YWdzIGRfQAo+IEBAIC00NTksNiArNDYwLDcgQEAgcHJvYyByZWFkX2Rp
ZmYge2ZkIGNvbmZsaWN0X3NpemUgY29udF9pbmZvfSB7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB9Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9IGVsc2Ugewo+ICsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2V0IDo6Y3VycmVudF9kaWZmX2luaGVhZGVyIDAKPiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNldCBvcCBbc3RyaW5nIGluZGV4ICRs
aW5lIDBdCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzd2l0Y2ggLS0gJG9w
IHsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHsgfSB7c2V0IHRhZ3Mge319
Cj4KClBsZWFzZSBpZ25vcmUgdGhpcyBwcm9wb3NhbC4gSSBoYXZlIGEgYmV0dGVyIHNvbHV0aW9u
IGluIHRoZSBwaXBlCih3aGljaCBzb2x2ZXMgYm90aCBwcm9ibGVtcyByZXBvcnRlZCBoZXJlKS4K
CkJlcnQK
