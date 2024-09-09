Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0276A1AC89D
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725850263; cv=none; b=Xyl5zOB+IDSkLAlM/Vu9XqWcEQMy+wzVF7nkUcMfqRTaIh/nWWz/1qUUJjVjSEetN27oGvFwyN2lm8mozC+G17tZuaBoZ8b5GCi0VF8KVBa7y3+n565iShG3rlv5AFmUFt111a3GX3zLFRhERS418k2kwhVlJVMgfn1OFditqc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725850263; c=relaxed/simple;
	bh=SRyTcvCVYspT7CRZBfXnG6oD2Mq06iqbP7oZXyrb5NY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Q1nMaRNpZCClMhY6gcL3wxmWUcPTKnFPYtj8gplH9/mLq2bY5P6auVzHsHriaiq8TaXExLx7H9RHamN2oASTNJVnxqDGYqV8YUDGm6iXyhffzDxBO1Z2XqvaOZ/CVrlXg3ZSnpsBEk2fVu9vqaeUHDxBjzF0C1dCBfuFvX3dwDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=OYAFOtZq reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="OYAFOtZq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Nfxm0wMssO4J3kixFvZA6ftqB73oXbnHlvu5QkpqqIM=; b=O
	YAFOtZqVdVK4l5pbnnyfS0uADu/0kH8oLRHMajrJL4GI6XY5b5Tz6QpEszu6Q7WU
	xwTEUOS87dD9ecir+FHGHmcIygI6I1gjT7FMu+PL9VYAAhiLjPpGbUdE4M8zsU/Z
	yePAHUiX7RYsMXaQem3K67SOD65WRRApuRtdGtF8Wc=
Received: from bupt_xingxin$163.com ( [122.224.123.146] ) by
 ajax-webmail-wmsvr-40-114 (Coremail) ; Mon, 9 Sep 2024 10:50:21 +0800 (CST)
Date: Mon, 9 Sep 2024 10:50:21 +0800 (CST)
From: "Xing Xin" <bupt_xingxin@163.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Brandon Williams" <bmwill@google.com>, 
	"Jonathan Tan" <jonathantanmy@google.com>, 
	"Xing Xin" <xingxin.xx@bytedance.com>
Subject: Re:Re: Re: Re: [PATCH 3/4] builtin/clone.c: recognize
 fetch.serverOption configuration
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <Ztm1w_61vjEkiC4C@pks.im>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
 <7c3ebda513d872a2ab2aa0cff5887757de4cde0a.1725279236.git.gitgitgadget@gmail.com>
 <ZtbgafDQwbU9tBoq@pks.im>
 <366dd64e.7b53.191bc028796.Coremail.bupt_xingxin@163.com>
 <ZtmQZQHnwYLNvT0F@pks.im>
 <3ce04aef.b004.191c21a2159.Coremail.bupt_xingxin@163.com>
 <Ztm1w_61vjEkiC4C@pks.im>
X-NTES-SC: AL_Qu2ZB/Sev0op5yCfbekXn0oVhe85UMW2ufsg3YReP500oyTt3wQOZW9gN3DOwseIGxGjoAiySzpP+MV/UZJjQpgCI5SE8C7o817mtE21CaWd
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3a7b1ced.364e.191d4b07a1a.Coremail.bupt_xingxin@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3vwZtYt5mrCUgAA--.609W
X-CM-SenderInfo: xexs3sp0lqw5llq6il2tof0z/1tbiLwxVbWVOGM2brwADsS
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNC0wOS0wNSAyMTo0NDo0MSwgIlBhdHJpY2sgU3RlaW5oYXJkdCIgPHBzQHBrcy5pbT4g
d3JvdGUKCltzbmlwXQoKPj4gPj4gSSBuYW1lZCB0aGUgbmV3IGNvbmZpZ3VyYXRpb24gYGZldGNo
LnNlcnZlck9wdGlvbmAgbWFpbmx5IHRvIGZvbGxvdyB0aGUKPj4gPj4gYHB1c2gucHVzaE9wdGlv
bmAgcGF0dGVybi4gIFNpbmNlIHdoaWNoIHNlcnZlciBvcHRpb25zIHRvIHN1cHBvcnQgaXMKPj4g
Pj4gYWN0dWFsbHkgc2VydmVyLXNwZWNpZmljLCB1c2luZyBgcmVtb3RlLjxuYW1lPi5zZXJ2ZXJP
cHRpb25gIGlzIGEgZ29vZAo+PiA+PiBpZGVhIGZvciBnaXQtZmV0Y2guIEhvd2V2ZXIsIGhvdyBz
aG91bGQgd2UgZGVzaWduIHRoZSBjb25maWd1cmF0aW9uIGZvcgo+PiA+PiBnaXQtbHMtcmVtb3Rl
IG9yIGdpdC1jbG9uZSwgaWYgd2Ugd2FubmEgcHJvdmlkZSBhbGwgb2YgdGhlbSB3aXRoIGEKPj4g
Pj4gZGVmYXVsdCBsaXN0IG9mIHNlcnZlciBvcHRpb25zIHRvIHNlbmQ/Cj4+ID4KPj4gPkFzIG1l
bnRpb25lZCBpbiBhbm90aGVyIHJlcGx5LCBJIHRoaW5rIHRoYXQgcHV0dGluZyB0aGlzIGludG8g
dGhlIHJlbW90ZQo+PiA+Y29uZmlndXJhdGlvbiAicmVtb3RlLiouc2VydmVyT3B0aW9uIiBtaWdo
dCBiZSBhIGJldHRlciBzb2x1dGlvbiwgYXMgaXQKPj4gPmFsc28gYnJpbmdzIHlvdSB0aGUgYWJp
bGl0eSB0byBzZXQgdGhpcyBwZXIgcmVtb3RlIGJ5IGRlZmF1bHQuCj4+IAo+PiBJIGFncmVlIHRo
YXQgdXNpbmcgInJlbW90ZS4qLnNlcnZlck9wdGlvbiIgaXMgYmV0dGVyLiBJbiBmYWN0LCBJIGFs
c28KPj4gdGhpbmsgInB1c2gucHVzaE9wdGlvbiIgd291bGQgYmUgYmV0dGVyIGFzICJyZW1vdGUu
Ki5wdXNoT3B0aW9uIi4gV2hhdCBJJ20KPj4gY29udGVtcGxhdGluZyBpcyB3aGV0aGVyIHdlIG5l
ZWQgdG8gYWRkIGEgY29uZmlndXJhdGlvbiBmb3IgYSBkZWZhdWx0Cj4+IGxpc3Qgb2Ygc2VydmVy
IG9wdGlvbnMsIHNvIHRoYXQgd2hlbiAicmVtb3RlLm9yaWdpbi5zZXJ2ZXJPcHRpb24iIGlzIG5v
dAo+PiBwcmVzZW50LCB3ZSBjYW4gZmFsbCBiYWNrIHRvIHVzZSB0aGF0IGFzIGRlZmF1bHQuCj4K
Pkp1bmlvIHByb3Bvc2VkIGluIFsxXSB0byBpbnRyb2R1Y2UgYFtyZW1vdGUgIioiXWAgc3ludGF4
IHRvIHN1cHBseQo+ZGVmYXVsdCB2YWx1ZXMgdG8gYWxsIHJlbW90ZXMuIFlvdSBjb3VsZCBwaWNr
IHVwIHRoYXQgcHJvcG9zYWwgYW5kCj5pbXBsZW1lbnQgaXQgYXMgcGFydCBvZiB5b3VyIHBhdGNo
IHNlcmllcy4KCkdpdmVuIHRoZSBhZGRpdGlvbiBvZiBhIHJlbW90ZS4qLjxzdWJrZXk+IGNvbmZp
Z3VyYXRpb24gaW4gR2l0J3MgZ2xvYmFsCnNldHRpbmdzLCBzdWNoIGFzOgoKICAgIGdpdCBjb25m
aWcgLS1nbG9iYWwgcmVtb3RlLiIqIi5kZW1vQ29uZmlnS2V5IGRlbW9Db25maWdWYWx1ZQoKVGhl
IGN1cnJlbnQgdmVyc2lvbnMgb2YgR2l0IG1heSBwcm9kdWNlIGVycm9ycyB3aXRoIGNlcnRhaW4g
Y29tbWFuZHMuCkZvciBleGFtcGxlLCBydW5uaW5nIGBnaXQgZmV0Y2ggLS1hbGxgIHdpbGwgcmVz
dWx0IGluOgoKICAgICQgZ2l0IGZldGNoIC0tYWxsCiAgICBGZXRjaGluZyAqCiAgICBmYXRhbDog
JyonIGRvZXMgbm90IGFwcGVhciB0byBiZSBhIGdpdCByZXBvc2l0b3J5CiAgICBmYXRhbDogQ291
bGQgbm90IHJlYWQgZnJvbSByZW1vdGUgcmVwb3NpdG9yeS4KCiAgICBQbGVhc2UgbWFrZSBzdXJl
IHlvdSBoYXZlIHRoZSBjb3JyZWN0IGFjY2VzcyByaWdodHMKICAgIGFuZCB0aGUgcmVwb3NpdG9y
eSBleGlzdHMuCiAgICBlcnJvcjogY291bGQgbm90IGZldGNoICoKICAgIEZldGNoaW5nIG9yaWdp
bgoKVGhpcyByYWlzZXMgdGhlIHF1ZXN0aW9uIG9mIHdoZXRoZXIgdGhpcyBjYW4gYmUgZGVmaW5l
ZCBhcyBhbgppbmNvbXBhdGliaWxpdHkgb3Igd2hldGhlciB0aGlzIGlzIGFjY2VwdGFibGUuIElm
IGl0IGlzbid0LCBJIHByZWZlcgp1c2luZyBhIGByZW1vdGUuZGVmYXVsdFNlcnZlck9wdGlvbmAg
aW5zdGVhZCwgYXMgaXQgYWxpZ25zIHdpdGggb3VyCmV4aXN0aW5nIHVzZSBvZiBgcmVtb3RlLnB1
c2hEZWZhdWx0YCBhbnl3YXkuCgpbc25pcF0KClhpbmcgWGluCg==
