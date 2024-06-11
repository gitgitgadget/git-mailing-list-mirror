Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A0314287
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088414; cv=none; b=XsO/0AGq4semvhrI+4cm2Awzm6Uw17TmYO36pGvButBYPKMuLudMIMUWdlBLPdSMm2l4hMI2NQ/0DOZxSD1MqpyJAYR7idDNFybS2ta+VWmJTEPf53a24/0kYyQtI9oXG4UpZkazebRaqu76RBRWFTfHW1GjNMe+T/Kf/SerY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088414; c=relaxed/simple;
	bh=HSEgRzEQhvf/mS7hN8rlCwdKlCamgArp3o55dZJfKjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=BgHmuEydoVOfdyRyiQnF87kWdgVm6m1qIqNt0mIIomB3GQN/CIxQ62L4bsji/gswwLS2UJzQWJQFH2E7JaHtcE+iU56g5AicjvVYr/Ez3a8AtsW3ExrloAjwjvf2tn+lBxB1uFmgAD66sQb6eCmLf4M0OgpWmLVb8XTnxEZnV7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=IQxcGv1E reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="IQxcGv1E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Lijnbzz7mvhlIeTB86be3C1fHkzkMADPf3893KbFpLU=; b=I
	QxcGv1ED4OhDdMUbgfel7sFjdpRfPZUo96hghhGYZ1sII5qG/2Re1T0W0kpIZ0Vn
	xSSDD9fs5toel6llp+ESFoqMGuBQMp4GbSE9oBy8d61DVKeU9HzZHNEYor+J4WcA
	GXNW6IqyE1b/8yIYehTHS6Do5C8Ou3BFtBKu6dKGxA=
Received: from bupt_xingxin$163.com ( [124.160.72.194] ) by
 ajax-webmail-wmsvr-40-126 (Coremail) ; Tue, 11 Jun 2024 14:46:31 +0800
 (CST)
Date: Tue, 11 Jun 2024 14:46:31 +0800 (CST)
From: "Xing Xin" <bupt_xingxin@163.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Karthik Nayak" <karthik.188@gmail.com>, 
	"Xing Xin" <xingxin.xx@bytedance.com>
Subject: Re:Re: [PATCH v4 4/4] unbundle: introduce option
 VERIFY_BUNDLE_FSCK_FOLLOW_FETCH
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <ZmGmV8-QNMN643ou@tanuki>
References: <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
 <pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
 <68b9bca9f8b19897997c2adc9a278ac5052e75cd.1717057290.git.gitgitgadget@gmail.com>
 <ZmGmV8-QNMN643ou@tanuki>
X-NTES-SC: AL_Qu2aCvyTt0si5yWYbOkXn0oVhe85UMW2ufsg3YReP500lSTjxiIlZFJ9N1fa2/u0FR+unTWLfjh2xfRKcalEdLwFu2IJlfGSrvMPw8Bvd9FV
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1238d76b.6e25.190060c5b5d.Coremail.bupt_xingxin@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3n1nH8mdm4_pXAA--.2573W
X-CM-SenderInfo: xexs3sp0lqw5llq6il2tof0z/1tbiRRn6bWXAmx22egABsl
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNC0wNi0wNiAyMDowNjo0NywgIlBhdHJpY2sgU3RlaW5oYXJkdCIgPHBzQHBrcy5pbT4g
d3JvdGU6Cj5PbiBUaHUsIE1heSAzMCwgMjAyNCBhdCAwODoyMTozMEFNICswMDAwLCBYaW5nIFhp
biB2aWEgR2l0R2l0R2FkZ2V0IHdyb3RlOgo+PiBGcm9tOiBYaW5nIFhpbiA8eGluZ3hpbi54eEBi
eXRlZGFuY2UuY29tPgo+Cj5TYW1lIGhlcmUsIHRoZSBpbXBvcnRhbnQgcGFydCBpcyBub3QgdGhh
dCB3ZSBpbnRyb2R1Y2UgdGhlIGZsYWcsIGJ1dAo+dGhhdCB3ZSBzdGFydCB1c2luZyBpdCBpbiBg
dW5idW5kbGVfZnJvbV9maWxlKClgLgo+Cj4+IGRpZmYgLS1naXQgYS9idW5kbGUtdXJpLmMgYi9i
dW5kbGUtdXJpLmMKPj4gaW5kZXggMDY2ZmY3ODgxMDQuLmU3ZWJhYzZjZTU3IDEwMDY0NAo+PiAt
LS0gYS9idW5kbGUtdXJpLmMKPj4gKysrIGIvYnVuZGxlLXVyaS5jCj4+IEBAIC0zNzMsNyArMzcz
LDcgQEAgc3RhdGljIGludCB1bmJ1bmRsZV9mcm9tX2ZpbGUoc3RydWN0IHJlcG9zaXRvcnkgKnIs
IGNvbnN0IGNoYXIgKmZpbGUpCj4+ICAJICogdGhlIHByZXJlcXVpc2l0ZSBjb21taXRzLgo+PiAg
CSAqLwo+PiAgCWlmICgocmVzdWx0ID0gdW5idW5kbGUociwgJmhlYWRlciwgYnVuZGxlX2ZkLCBO
VUxMLAo+PiAtCQkJICAgICAgIFZFUklGWV9CVU5ETEVfUVVJRVQgfCBWRVJJRllfQlVORExFX0ZT
Q0tfQUxXQVlTKSkpCj4+ICsJCQkgICAgICAgVkVSSUZZX0JVTkRMRV9RVUlFVCB8IFZFUklGWV9C
VU5ETEVfRlNDS19GT0xMT1dfRkVUQ0gpKSkKPj4gIAkJcmV0dXJuIDE7Cj4+ICAKPj4gIAkvKgo+
Cj5PbmUgdGhpbmcgdGhhdCBpcyBhIGJpdCB3ZWlyZCBpcyB0aGF0IHdlIGZpcnN0IGNoYW5nZSBg
dW5idW5kbGUoKWAgdG8KPnVzZSBgRlNDS19BTFdBWVNgIGluIGEgcHJlY2VkaW5nIHBhdGNoLCBh
bmQgdGhlbiBjb252ZXJ0IGl0IHRvIHVzZQo+YEZTQ0tfRk9MTE9XX0ZFVENIYCBpbiB0aGUgc2Ft
ZSBzZXJpZXMuIEl0IGNvdWxkIGJlIHJlc3RydWN0dXJlZCBhIGJpdAo+dG8gZmlyc3QgaW50cm9k
dWNlIHRoZSBmbGFncywgb25seSwgd2hpbGUgbm90IG1vZGlmeWluZyBhbnkgb2YgdGhlCj5jYWxs
c2l0ZXMgeWV0LiBQYXNzaW5nIHRoZSByZXNwZWN0aXZlIGZsYWdzIHdvdWxkIHRoZW4gYmUgZG9u
ZSBpbiBhCj5zZXBhcmF0ZSBjb21taXQuCgpUaGlzIG1ha2VzIHNlbnNlIHRvIG1lLCB0aGFua3Mh
CgpYaW5nIFhpbgo=
