Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794469763;
	b=tMRTktN7pxG7YEURFmK4tHvdroLFLRWxc5uzaGQ6jYhx6n3DbraD5IcYKIGVmh8aR/9y
	 x5T0qgczNfNyOcfaNWXlr69gP0oDWGzC3wn4tcZhSP/a9m4FhlCWszNWNttQLZo4yQ7D2
	 2jrELOX45AmkIP9e9ca0ZmqoPKUtLCgwBavpKUOkbLf7FvQHwmYWYOc9oHqh6SJmh/s48
	 hrlUh30bOG/pqJ6V5Ty76Hcl4Xkc+arslxvDv7Ah+V4pjeGlpagDf5InVpZki6qMNMhoU
	 QCBxhzBjiOA+U36O0Be5pYbIqCio3JD6yO80PwWVjdd0KyWSZP2Ig5G0hq+f4YozoUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469763;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:X-QQ-mid;
	bh=PL3m/siHu9bO34ndPMKj9jhzDp83j1nIyfMy/rQ53uU=;
	b=hmPezoaSOQfYYTOogBa4SMsmvW5HJFrJDbvz2nEZ8G5iIf28Nkl/JbbMorwGw4IJXBnV
	 8wWWAtTF0z+rAppvK9mxSQvHfPrGX481/OGwhWrKCQwwOJpLsT3y0T2So6uPCP7uB+6g8
	 XUfUgrV8opi4xiFhhryrYOWCtPeIWBtYPW9XkzsOYKsX80SooSIfF5nK8Uq1L7vyr5+n1
	 xJ65glgeCx73zSqG/0u+L1gcnA38MiXQ7PoHTv2KxKiZijfL4pOv+BsfoiMTeuvcShEx7
	 KfWw7EZXNTBFFu7cgr7izvrfcdaAJBBDc2aUqvNafjq9A5G+4kJ1E8NzUUg5GJrrqhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=mfbgQQo5;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999FD60A5BE9
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 07:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 999FD60A5BE9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=mfbgQQo5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794469751;
	bh=PL3m/siHu9bO34ndPMKj9jhzDp83j1nIyfMy/rQ53uU=;
	h=From:To:Cc:Subject:Date;
	b=mfbgQQo5cAQuhdBCdqf4GBqHMA+LpIssEHc1GUf8Ah7oKOfDK5Ulv8D+9jWPqJZG5
	 jf9olT6IGnvFIjluktvJ0RLDYAeG6XXCkF/fPmyROY5UPyU5csq/1OyAPceXtK0/QH
	 igzLKTpqwNDQb9Y0KmD4VvJIqqeS4D8IPnd/ZcbU=
X-QQ-XMRINFO: NI4Ajvh11aEjYm/R9hkdfFFQ7ssSdEshmA==
X-QQ-XMAILINFO: NRrO+V1v8gUcZgeVy8ODQdi08UvAJRC8qTQ9cD6NXLPyWRTYRDlyQAKpcM3NPy
	 DKLAD96Xw2aG8SIvSZdtodjovfbug5TCpKcXvzjOEsqZifYo9F/9ViZ+q+FgF+ULyLlvErKpuwz55
	 DCozJFN1ppKHWSfABg4mu5IXLRfMACAnvZminfiAu1DAa19wTpepfg1DCubaAHbq+edXOLa2uOUAP
	 orveBdSpdxAuMgwtHdcCsEEaAPUaBdBFQWTG38w8073tP+HEvMOitEDXRjKameHJ5Ko/aIOBZuF9I
	 HhlVlw/R5xZM7gUvQX/k0YECfIUG1bWj0YPmRqnxAVJwrQ+TxWvmHIuxv0I6N/QBNvimOiL/B9w18
	 lU73vzRBuS9W9UgMMPBwa1w5WtsniolfLrglZX9nu/vPaEXAiY6Mwz/IvJpFxLHuYD8LqhtsoGtEP
	 KfAOvBmq4f4cSMT/mQIvTMLMobGiwSra7IHkf4pPEb+0q8YMbqwYbn8hdwBYNTiIG8ts2uqXZswZ2
	 8R02KVjljgSNfGu+vCEqz9M4KW7WHZsnf+McaWXDxYnrBffooiJdUkzpXFKNJoekaolxFFv8hhk+d
	 6qqvgYGi6vuplDs7a6Nod9ddCVLnLWgVI+i1mIxEx3kgl3mjYnkds4HhnV318gICNmtCzphJxVC3z
	 /BfnMEiuRZYHsJHnlNyZrTqjh8HxZbqUv977ZxHkmfiSC4yHscBh3sUc17hFCd6uQJpvnHpvqm8LN
	 n2MzjfaDyONDf3VKG+V3lsd31wSCP7Qgm1Wp6gsxE8YqEWC6mk85TQeeG5xBe5fbfmU1ueC6PRpOV
	 QNNHVcGA+HbRyLZCsscqtMHg5C6H5DxaFrnw0YVAskx1sUQlr92NUWDtvfuHwrQjVriIYuzNGWmQw
	 cr3kOqxTu/pNsnAnqcLeCqHXc9rVNz9ytuV7qnAvtTuGxI+oMD5nLoYH9x+CaFqtpuZczXowZvj/6
	 rkD7F+TXNSb36Qg2YeirmZFKODumFfl9vCwQ9baTklBljS5DFEalkTvPn1hQr107gmZkmQf4LfePV
	 lou457Z/uzzzMTHYQc9upzT9x7/rpG75g26VtY1at3Oc2B+WAOAIfRH1ETEQQiPIp+MN0gK7hEbzm
	 +EeLraEK+jwVHfDdmOdGIZScAEY+ZNXy4pxBqKXKX81IdeVUpZF/fhlMxeF8XT68MiLPOfd6CwHAw
	 6t+56E09Etz
From: "=?utf-8?B?a29uZ2ZhbmthaWthaQ==?=" <kongfankaikai@foxmail.com>
To: "=?utf-8?B?U2lkZGhhcnRoIFNocmltYWxp?=" <r.siddharth.shrimali@gmail.com>
Cc: "=?utf-8?B?Z2l0?=" <git@vger.kernel.org>, "=?utf-8?B?U2FtdWVsIEJyb25zb24=?=" <naesten@gmail.com>, "=?utf-8?B?U2lkZGhhcnRoIFNocmltYWxp?=" <r.siddharth.shrimali@gmail.com>
Subject: Re: [BUG] repack --drop-filtered aborts when a filtered blob is referenced by the index
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 12 Nov 2026 15:49:09 +0800
X-Priority: 3
Message-ID: <tencent_EB6E67B22EC8C9D00D0A7D062B62BB95ED05@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmsezb58-0t1794469749t8973obfs

SGkgU2lkZGhhcnRoLAoKVGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24gYW5kIHRoZSB1cGRh
dGUhCgpJdCdzIGdyZWF0IHRvIGtub3cgdGhhdCBhIGZpeCBpcyBhbHJlYWR5IGJlaW5nIHdv
cmtlZCBvbi4gSSdsbCBrZWVwIGFuIGV5ZSBvbiB0aGUgZGlzY3Vzc2lvbi4KClRoYW5rcwoK
Cgrljp/lp4vpgq7ku7YK5Y+R5Lu25Lq677yaU2lkZGhhcnRoIFNocmltYWxpIDxyLnNpZGRo
YXJ0aC5zaHJpbWFsaUBnbWFpbC5jb20+CuWPkeS7tuaXtumXtO+8mjIwMjblubQxMeaciDEy
5pelIDE1OjI5CuaUtuS7tuS6uu+8mmtvbmdmYW5rYWlrYWkgPGtvbmdmYW5rYWlrYWlAZm94
bWFpbC5jb20+CuaKhOmAge+8mmdpdCA8Z2l0QHZnZXIua2VybmVsLm9yZz4sIFNhbXVlbCBC
cm9uc29uIDxuYWVzdGVuQGdtYWlsLmNvbT4sIFNpZGRoYXJ0aCBTaHJpbWFsaSA8ci5zaWRk
aGFydGguc2hyaW1hbGlAZ21haWwuY29tPgrkuLvpopjvvJpSZTogW0JVR10gcmVwYWNrIC0t
ZHJvcC1maWx0ZXJlZCBhYm9ydHMgd2hlbiBhIGZpbHRlcmVkIGJsb2IgaXMgcmVmZXJlbmNl
ZCBieSB0aGUgaW5kZXgKCgpIaSwKCk9uwqBUaHUswqBOb3bCoDEyLMKgMjAyNsKgYXTCoDEy
OjUxOjA3QU3CoCswODAwLMKga29uZ2ZhbmthaWthacKgd3JvdGU6Cj7CoFdoZW7CoGHCoGJs
b2LCoHNlbGVjdGVkwqBiecKgdGhlwqBmaWx0ZXLCoGZvcsKgZHJvcHBpbmfCoGlzwqByZWZl
cmVuY2VkwqBiecKgdGhlCj7CoGN1cnJlbnTCoGluZGV4LMKgR2l0wqBhYm9ydHPCoHRoZcKg
ZW50aXJlwqByZXBhY2vCoHdpdGg6Cj4KPsKgYGZhdGFsOsKgY2Fubm90wqBkcm9wwqAncGF0
aC90by9sYXJnZS1maWxlLmJpbifCoChvYmplY3QtaWQpOsKgaXTCoGlzCj7CoHJlZmVyZW5j
ZWTCoGJ5wqB0aGXCoGN1cnJlbnTCoGluZGV4YAo+Cj7CoFRoaXPCoHN0b3BzwqBvdGhlcsKg
ZWxpZ2libGXCoGJsb2JzwqBmcm9twqBiZWluZ8KgZHJvcHBlZCzCoGV2ZW7CoHRob3VnaMKg
dGhvc2UKPsKgYmxvYnPCoGFyZcKgbm90wqByZWZlcmVuY2VkwqBiecKgdGhlwqBpbmRleC4K
ClRoYW5rc8KgZm9ywqB0aGXCoHJlcG9ydC7CoFRoaXPCoGlzwqBhwqBrbm93bsKgbGltaXRh
dGlvbsKgYW5kwqBhwqBmaXjCoGlzwqBhbHJlYWR5CnBsYW5uZWQuCgpTYW11ZWzCoEJyb25z
b27CoHJhbsKgaW50b8KgZXhhY3RsecKgdGhlwqBzYW1lwqB0aGluZ8Kgb27CoGHCoHJlYWzC
oGxsdm0tcHJvamVjdApjbG9uZcKgYW5kwqBzZW50wqBhbsKgUkZDwqBwYXRjaMKgZm9ywqBp
dMKgaW7CoFNlcHRlbWJlcjoKCsKgwqBodHRwczovL2xvcmUua2VybmVsLm9yZy9naXQvczB2
cXpqYXZ3OHAuZnNmQGdtYWlsLmNvbS8KCmFuZMKgScKgYWdyZWVkwqB3aXRowqB0aGXCoGRp
cmVjdGlvbsKgdGhlcmU6CgrCoMKgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZ2l0L0NBR1dn
eWg5Qj1yZTA2YW9maWk5VkZCMXhPd0VlVHR4WUU9N1QxNG05V0ZBeDFPUnBNZ0BtYWlsLmdt
YWlsLmNvbS8KCj7CoElzwqB0aGVyZcKgYcKgc3BlY2lmaWPCoHJlYXNvbsKgdGhpc8KgY29u
ZGl0aW9uwqBpc8KgdHJlYXRlZMKgYXPCoGZhdGFswqByYXRoZXIKPsKgdGhhbsKgc2tpcHBp
bmfCoHRoZcKgYWZmZWN0ZWTCoG9iamVjdHM/Cj4KPsKgVGhpc8KgYmVoYXZpb3LCoHdvdWxk
wqBiZcKgZXNwZWNpYWxsecKgaGVscGZ1bMKgZm9ywqBwYXJ0aWFswqBjbG9uZXPCoHdpdGgK
PsKgbGFyZ2XCoHdvcmtpbmfCoHRyZWVzLgoKTm/CoGNvcnJlY3RuZXNzwqByZWFzb24uwqBU
aGXCoGd1YXJkwqBvbmx5wqBhdm9pZHPCoGRyb3BwaW5nwqBhwqBibG9iwqB0aGF0wqB0aGUK
bmV4dMKgY29tbWFuZMKgd291bGTCoGxhenktZmV0Y2jCoHJpZ2h0wqBiYWNrLMKgc2/CoHN1
Y2jCoGHCoGJsb2LCoGlzwqBuZXZlcsKgYXQKcmlzay7CoEFib3J0aW5nwqB3YXPCoHNpbXBs
ecKgYcKgY29uc2VydmF0aXZlwqB2ZXJzaW9uwqBvZsKgdGhlwqBndWFyZCzCoGFuZMKgYXMK
eW91wqBhbmTCoFNhbXVlbMKgcG9pbnTCoG91dMKgaXTCoGlzwqBhwqBwb29ywqB0cmFkZS1v
ZmYuCgpUaGXCoGZpeMKgaXPCoHRvwqByZXBsYWNlwqB0aGXCoGRpZSgpwqB3aXRowqBhwqB3
YXJuaW5nwqBhbmTCoGRyb3DCoHRoZcKgcmVtYWluaW5nCmVsaWdpYmxlwqBibG9icy7CoEnC
oGFtwqB3b3JraW5nwqBvbsKgdGhpc8KgYW5kwqB3aWxswqBwb3N0wqBpdMKgdG/CoHRoZcKg
bGlzdC4KClRoYW5rcywKU2lkZGhhcnRowqAKCgoK

