Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8268F3BBDE
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 03:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358773; cv=none; b=XSAJbqvqEomJQsZIydym0jvW479qY3QOk0typkLI8tp8Qs2w8RVS+UgMXi87jFQHBuD01HzhMorbVFz11NOuWyIzM99UwQnUi+wFFfZhI76BSmLebX02zAMWcNRFwPbPcL632VBTjItsLkCznmQWXNNoDITKHX1GYULm46+ymuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358773; c=relaxed/simple;
	bh=SwDCvmjy7yKMdt9SKEd0u/BXdeE+3aFXGerUu7hz4uM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=lekvfaLaJtWHi0v1HwYlUWplzV2g96JYIb6NusvpWZNFIQdU+xrWtC1we/a18ZF3kdoCOaRA53R8pK2D/Ns+BO07iUqNzEsToec9V/FGoWRC+V2/r7wz/4qKN1m0MFcoO69faKmzPxJbDC6uMfyDorTC2SCYmRcXMkGliFo88oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=IdEfe3bt reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="IdEfe3bt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=K+gKYqmbmDwMb2Jcc3PqstXnL8dzKxrLae3XzMEJrhI=; b=I
	dEfe3btu0bvvFCjlR/0bGjraZxhifPbkq+BuM10dN0iOW0rionAR517/gSMfRbme
	UAdtdtLSLBg1YBwzrmcA9Z5vhfnTCbGRsN761qSrkxUTWoOA83Kxemr9hIeWA5U9
	AZgr8rLpYGowTtbn3Lyezr8pPbrq2sxTy1eMnrEVJE=
Received: from bupt_xingxin$163.com ( [240e:694:e21:b::2] ) by
 ajax-webmail-wmsvr-40-105 (Coremail) ; Tue, 8 Oct 2024 11:38:51 +0800 (CST)
Date: Tue, 8 Oct 2024 11:38:51 +0800 (CST)
From: "Xing Xin" <bupt_xingxin@163.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Brandon Williams" <bmwill@google.com>, 
	"Jonathan Tan" <jonathantanmy@google.com>, 
	"Xing Xin" <xingxin.xx@bytedance.com>
Subject: Re:Re: [PATCH v2 2/5] remote: introduce remote.<name>.serverOption
 configuration
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <ZwOaR5OqdLaS4cu6@pks.im>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
 <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
 <2474b4c69d68576e901cdd6381aac9410cf21922.1727093878.git.gitgitgadget@gmail.com>
 <ZwOaR5OqdLaS4cu6@pks.im>
X-NTES-SC: AL_Qu2ZCv+et08o5yebZukXn0oVhe85UMW2ufsg3YReP500tyTsxQ0LbW9AOFTI+s6LKRqhoAi8dRR/9dRqf6BhVodj7QL6m1pIIwpBaDousDRo
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <e927c65.4aed.1926a354fdb.Coremail.bupt_xingxin@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aSgvCgDXX0xLqQRndoYHAA--.51546W
X-CM-SenderInfo: xexs3sp0lqw5llq6il2tof0z/1tbiRQlybWcEpsJKSQABsW
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNC0xMC0wNyAxNjoyMjozMSwgIlBhdHJpY2sgU3RlaW5oYXJkdCIgPHBzQHBrcy5pbT4g
d3JvdGU6Cj5PbiBNb24sIFNlcCAyMywgMjAyNCBhdCAxMjoxNzo1NVBNICswMDAwLCBYaW5nIFhp
biB2aWEgR2l0R2l0R2FkZ2V0IHdyb3RlOgo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9j
b25maWcvcmVtb3RlLnR4dCBiL0RvY3VtZW50YXRpb24vY29uZmlnL3JlbW90ZS50eHQKPj4gaW5k
ZXggOGVmYzUzZTgzNmQuLjhiYTQ4NTczZmI2IDEwMDY0NAo+PiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2NvbmZpZy9yZW1vdGUudHh0Cj4+ICsrKyBiL0RvY3VtZW50YXRpb24vY29uZmlnL3JlbW90ZS50
eHQKPj4gQEAgLTk1LDMgKzk1LDEzIEBAIHJlbW90ZS48bmFtZT4ucGFydGlhbGNsb25lZmlsdGVy
OjoKPj4gIAlDaGFuZ2luZyBvciBjbGVhcmluZyB0aGlzIHZhbHVlIHdpbGwgb25seSBhZmZlY3Qg
ZmV0Y2hlcyBmb3IgbmV3IGNvbW1pdHMuCj4+ICAJVG8gZmV0Y2ggYXNzb2NpYXRlZCBvYmplY3Rz
IGZvciBjb21taXRzIGFscmVhZHkgcHJlc2VudCBpbiB0aGUgbG9jYWwgb2JqZWN0Cj4+ICAJZGF0
YWJhc2UsIHVzZSB0aGUgYC0tcmVmZXRjaGAgb3B0aW9uIG9mIGxpbmtnaXQ6Z2l0LWZldGNoWzFd
Lgo+PiArCj4+ICtyZW1vdGUuPG5hbWU+LnNlcnZlck9wdGlvbjo6Cj4+ICsJV2hlbiBubyBgLS1z
ZXJ2ZXItb3B0aW9uPTxvcHRpb24+YCBhcmd1bWVudCBpcyBnaXZlbiBmcm9tIHRoZSBjb21tYW5k
Cj4+ICsJbGluZSwgZ2l0IHdpbGwgdXNlIHRoZSB2YWx1ZXMgZnJvbSB0aGlzIGNvbmZpZ3VyYXRp
b24gYXMgYSBkZWZhdWx0IGxpc3Qgb2YKPgo+VGhpcyBkZXNjcmlwdGlvbiBmZWVscyBhIGJpdCBp
bmVsZWdhbnQgdG8gbWUuIEhvdyBhYm91dCB0aGUgZm9sbG93aW5nOgo+Cj4gICAgVGhlIGRlZmF1
bHQgc2V0IG9mIHNlcnZlciBvcHRpb25zIHVzZWQgd2hlbiBmZXRjaGluZyBmcm9tIHRoZQo+ICAg
IHJlbW90ZS4gVGhlc2Ugc2VydmVyIG9wdGlvbnMgYXJlIG92ZXJyaWRkZW4gYnkgdGhlCj4gICAg
YC0tc2VydmVyLW9wdGlvbj1gIGNvbW1hbmQgbGluZSBhcmd1bWVudHMuCgpUaGFua3MgZm9yIHRo
ZSBoZWxwISBBcHBsaWVkIHRvIHRoZSBuZXcgcGF0Y2ggKHdpdGggc29tZSBtaW5vciBtb2RpZmlj
YXRpb25zKS4KCj4+IEBAIC0xMjUsNiArMTI2LDcgQEAgc3RhdGljIHN0cnVjdCByZW1vdGUgKm1h
a2VfcmVtb3RlKHN0cnVjdCByZW1vdGVfc3RhdGUgKnJlbW90ZV9zdGF0ZSwKPj4gIAlzdHJ1Y3Qg
cmVtb3RlICpyZXQ7Cj4+ICAJc3RydWN0IHJlbW90ZXNfaGFzaF9rZXkgbG9va3VwOwo+PiAgCXN0
cnVjdCBoYXNobWFwX2VudHJ5IGxvb2t1cF9lbnRyeSwgKmU7Cj4+ICsJc3RydWN0IHN0cmluZ19s
aXN0IHNlcnZlcl9vcHRpb25zID0gU1RSSU5HX0xJU1RfSU5JVF9EVVA7Cj4+ICAKPj4gIAlpZiAo
IWxlbikKPj4gIAkJbGVuID0gc3RybGVuKG5hbWUpOwo+PiBAQCAtMTQzLDYgKzE0NSw3IEBAIHN0
YXRpYyBzdHJ1Y3QgcmVtb3RlICptYWtlX3JlbW90ZShzdHJ1Y3QgcmVtb3RlX3N0YXRlICpyZW1v
dGVfc3RhdGUsCj4+ICAJcmV0LT5uYW1lID0geHN0cm5kdXAobmFtZSwgbGVuKTsKPj4gIAlyZWZz
cGVjX2luaXQoJnJldC0+cHVzaCwgUkVGU1BFQ19QVVNIKTsKPj4gIAlyZWZzcGVjX2luaXQoJnJl
dC0+ZmV0Y2gsIFJFRlNQRUNfRkVUQ0gpOwo+PiArCXJldC0+c2VydmVyX29wdGlvbnMgPSBzZXJ2
ZXJfb3B0aW9uczsKPgo+SSB3YXMgd29uZGVyaW5nIGF0IGZpcnN0IHdoZXJlIHdlIGFjdHVhbGx5
IHBvcHVsYXRlIHRoZQo+YHNlcnZlcl9vcHRpb25zYCwgdW50aWwgSSByZWFsaXplZCB0aGF0IHRo
aXMgaXMgb25seSBkb25lIHRvIGluaXRpYWxpemUKPnRoZSBgcmV0LT5zZXJ2ZXJfb3B0aW9uc2Au
IEkgdGhpbmsgaXQgd291bGQgYmUgbGVzcyBjb25mdXNpbmcgaWYgdGhpcwo+dXNlZCBgc3RyaW5n
X2xpc3RfaW5pdF9kdXAoKWAgaW5zdGVhZCBvZiB0aGUgbG9jYWwgdmFyaWFibGUuCgpNYWtlIHNl
bnNlLgoKWGluZyBYaW4K
