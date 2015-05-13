From: chenxitwo <chenxitwo@126.com>
Subject: Re: Git: How to keep multiple bare repos in sync?
Date: Wed, 13 May 2015 15:01:42 +0800
Message-ID: <2015051315014048836362@126.com>
References: <2015051312090840845945@126.com>, 
	<xmqq4mnhccti.fsf@gitster.dls.corp.google.com>
Reply-To: chenxitwo <chenxitwo@126.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64
Cc: git <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 09:01:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsQg0-0005h0-7L
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 09:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbbEMHBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 03:01:51 -0400
Received: from m15-114.126.com ([220.181.15.114]:43937 "EHLO m15-114.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699AbbEMHBv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 03:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:Mime-Version:Message-ID; bh=ABJhq
	ky0b+1F97Dwseue4vPOwztcOB4k4yNXxut6DqY=; b=V+iitpP5gu0d4z6r/IWPC
	dke/tG54gBDN1QCXQaYAjMiMKoykI4ATEn8pwcCH5x5pdu6e3wq/GswTNlRjXCLI
	8QEtWhg5BmWNyHx+55gp5JEuj7TKeinVqLXNmXYPDimroCBWq7InOG0Shb88bB0o
	tY5DYifNdwKwzvzRxN2eFw=
Received: from eg080 (unknown [121.15.86.68])
	by smtp7 (Coremail) with SMTP id DsmowAB3SQTU9lJVxD6FAA--.39705S2;
	Wed, 13 May 2015 15:01:42 +0800 (CST)
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.0.1.92[cn]
X-CM-TRANSID: DsmowAB3SQTU9lJVxD6FAA--.39705S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4DWryxWryxAFy3uF47CFg_yoWkZrX_uF
	yDAr18Aa1vk34xWa15GrW0vFsxKw4vgFWvvwsrXr4rK3sYyFyrXFn7WrZa9F48Ga15Jrn8
	Ww1kZw4SkasI9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1k9NDUUUUU==
X-Originating-IP: [121.15.86.68]
X-CM-SenderInfo: hfkh05plwz0qqrswhudrp/1tbiWx3451PM8aLJvAACsi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268940>

bm90IHJlbW90ZSBzeW5jLiAgDQoNCldlIGhhdmUgdGhyZWUgdGVhbXMgdG8gcGFydGljaXBhdGUg
aW4gdGhlIHNhbWUgcHJvamVjdCwgYW5kIGlzIGxvY2F0ZWQgaW4gZGlmZmVyZW50IHBsYWNlcy4g
QmFuZHdpZHRoIHRoYXQgYmV0d2VlbiB0aGUgdHdvIG9mIG91ciB0ZWFtcyBpcyBub3QgZW5vdWdo
LiBUaHJlZSB0ZWFtcyBoYXZlIHRoZWlyIG93biBnaXQgc2VydmVyLiBMaWtlIHRoaXMga2luZCBv
ZiBzaXR1YXRpb24sIGhvdyBzaG91bGQgaGFuZGxlPw0KDQoNCg0KY2hlbnhpdHdvDQoNCkZyb206
IEp1bmlvIEMgSGFtYW5vDQpEYXRlOiAyMDE1LTA1LTEzIDEyOjM3DQpUbzogY2hlbnhpdHdvDQpD
QzogZ2l0DQpTdWJqZWN0OiBSZTogR2l0OiBIb3cgdG8ga2VlcCBtdWx0aXBsZSBiYXJlIHJlcG9z
IGluIHN5bmM/DQpjaGVueGl0d28gPGNoZW54aXR3b0AxMjYuY29tPiB3cml0ZXM6DQoNCj4gVGhl
cmUgYXJlIHRocmVlIGdpdCBzZXJ2ZXIoYmFyZSByZXBvcyksIGJ1dCBpIGRvbid0IGtub3cgdG8g
c29sdmUgdGhlDQo+IHByb2JsZW0gdGhhdCBob3cgdG8ga2VlcCB0aGVzZSBnaXQgc2VydmVycyBp
biBzeW5jLg0KDQpyc3luYz8NCg0KVGhlIHByb2JsZW0gaXMgdW5kZXItc3BlY2lmaWVkLiAgSXMg
dGhlcmUgb25lIG9mIHRoZW0gdGhhdCBpcw0KYXV0aG9yaXRhdGl2ZSBhbmQgdGhhdCB0aGUgb3Ro
ZXIgb25lcyBzaG91bGQgbWF0Y2ggaXRzIHByb2dyZXNzPw0KSWYgc28sIHBlcmhhcHMgcHVzaCBm
cm9tIHRoZSBhdXRob3JpdGF0aXZlIG9uZSB0byB0aGUgb3RoZXIgdHdvDQp3aXRoICJwdXNoIC0t
bWlycm9yIiAob3IgaGF2ZSB0aGUgb3RoZXIgb25lcyAiZmV0Y2ggLS1taXJyb3IiKT8NCg0KSWYg
eW91IGFyZSBhbGxvd2luZyBwZW9wbGUgdG8gcHVzaCBpbnRvIGFueSBvZiB0aGVtIHJhbmRvbWx5
LA0KdGhlbiB0aGVyZSBpcyBubyBnZW5lcmFsIHNvbHV0aW9uLiAgSWYgSSBwdXNoIGFuIHVwZGF0
ZSB0byAnbWFzdGVyJw0Kb2YgaW5zdGFuY2UgQSB3aGlsZSB5b3UgdXBkYXRlIHRoZSBzYW1lICdt
YXN0ZXInIGJyYW5jaCBvZiBpbnN0YW5jZQ0KQiwgc29tZWJvZHkgaGFzIHRvIHJlY29uY2lsZSB0
aGUgZGl2ZXJnZW5jZSBiZXR3ZWVuIHRoZSB0d28gYnkNCmNyZWF0aW5nIGEgbWVyZ2UsIGFuZCB0
aGF0IGNhbiBwb3NzaWJseSBjb25mbGljdCwgbmVlZGluZyBodW1hbg0KaW50ZXJ2ZW50aW9uIHRv
IHJlc29sdmUu
