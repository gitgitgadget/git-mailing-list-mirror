Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963111761BF
	for <git@vger.kernel.org>; Thu, 30 May 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059258; cv=none; b=PNYZKnEDj4q6C+LvXCO1iGHUBbxWfaBYyz0qo+vqdRdUOGSC79kSBNQvm7M1LKPAp57K5wulSm31eQ/RToo/5ab/R/TYj1vTdjfb1IjlTlnYKS+2YGbb7N2gxkxZGjMsMBPFPdbTFi5RXP+0Mw+qVpnIsSmLolh+mFsOk7YyDiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059258; c=relaxed/simple;
	bh=tltfq0fki79II/ck8gkGBmuIEnWDWyyJRXiblQjbKsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=CIwRQ0mjSrAZD7SKH2xF5xOL2PrRVz9DOK8LuarLytq8ZnufTMvb8DJbokt2EDKOZ3cF0GAiKPt6JzOS75PcRlmxb/MkzO//u2vhbocwYHx3MTuBHYJSxJZtW6zsKIQu4ayyhf9DNuGDgfl9OTsrBkwG3rV5vhzL7V91pZQY+jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=lRp3mtp4 reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="lRp3mtp4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=laQfUSelslEJ/r2lyj+XE/+t7OBQnBWOYhqGs9EekHY=; b=l
	Rp3mtp4iqAmlC1o/DX3oZrJpMjFRmO0YLqYFahjMCIr08wJAUc+WKFKptXDftppl
	USwQDiYe7Y6hVUKtP4SCMQntKO/SqxLqsG8II5WmfWLcpMW5oR4EWFDenvuNHCB8
	gjz0aW71XxbmC65qa7rtQhSXZfXiNe282+FpkqIjAY=
Received: from bupt_xingxin$163.com ( [122.224.123.146] ) by
 ajax-webmail-wmsvr-40-129 (Coremail) ; Thu, 30 May 2024 16:54:00 +0800
 (CST)
Date: Thu, 30 May 2024 16:54:00 +0800 (CST)
From: "Xing Xin" <bupt_xingxin@163.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Karthik Nayak" <karthik.188@gmail.com>, 
	"Xing Xin" <xingxin.xx@bytedance.com>
Subject: Re:Re: [PATCH v3 4/4] unbundle: introduce new option
 UNBUNDLE_FSCK_FOLLOW_FETCH
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <ZlXInJZn7oDfyvWv@tanuki>
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
 <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
 <c19b8f633cb9f851948b3a17b5425f3310d900d5.1716824518.git.gitgitgadget@gmail.com>
 <ZlXInJZn7oDfyvWv@tanuki>
X-NTES-SC: AL_Qu2aBfyetkov5imbZukXn0oVhe85UMW2ufsg3YReP500mCTM4QcEQltABUHxzMyBNyqhlDytThRXwdhIdIxYfI47BrbL+rSIBCV3EB1zp67r
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <501f41c2.904b.18fc8b4c3e9.Coremail.bupt_xingxin@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3_9CoPlhmRdlSAA--.40476W
X-CM-SenderInfo: xexs3sp0lqw5llq6il2tof0z/1tbiLwPubWVOD9QNlAAEsC
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNC0wNS0yOCAyMDowNTo0OCwgIlBhdHJpY2sgU3RlaW5oYXJkdCIgPHBzQHBrcy5pbT4g
d3JvdGU6CltzbmlwXQo+PiAgCj4+ICt0ZXN0X2V4cGVjdF9zdWNjZXNzICdjbG9uZSBidW5kbGUg
d2l0aCBmZXRjaC5mc2NrT2JqZWN0cycgJwo+PiArCXRlc3RfY3JlYXRlX3JlcG8gYnVuZGxlLWZz
Y2sgJiYKPj4gKwkoCj4+ICsJCWNkIGJ1bmRsZS1mc2NrICYmCj4+ICsJCXRlc3RfY29tbWl0IGZp
cnN0ICYmCj4+ICsJCWNhdCA+ZGF0YSA8PC1FT0YgJiYKPj4gKwkJdHJlZSAkKGdpdCByZXYtcGFy
c2UgSEVBRF57dHJlZX0pCj4+ICsJCXBhcmVudCAkKGdpdCByZXYtcGFyc2UgSEVBRCkKPj4gKwkJ
YXV0aG9yIEEgVSBUaG9yCj4+ICsJCWNvbW1pdHRlciBBIFUgVGhvcgo+PiArCj4+ICsJCWNvbW1p
dDogdGhpcyBpcyBhIGNvbW1pdCB3aXRoIGJhZCBlbWFpbHMKPj4gKwo+PiArCQlFT0YKPj4gKwkJ
Z2l0IGhhc2gtb2JqZWN0IC0tbGl0ZXJhbGx5IC10IGNvbW1pdCAtdyAtLXN0ZGluIDxkYXRhID5j
b21taXQgJiYKPj4gKwkJZ2l0IGJyYW5jaCBiYWQgJChjYXQgY29tbWl0KSAmJgo+PiArCQlnaXQg
YnVuZGxlIGNyZWF0ZSBiYWQuYnVuZGxlIGJhZAo+PiArCSkgJiYKPj4gKwl0ZXN0X211c3RfZmFp
bCBnaXQgLWMgZmV0Y2guZnNja09iamVjdHM9dHJ1ZSBcCj4+ICsJCWNsb25lIGJ1bmRsZS1mc2Nr
L2JhZC5idW5kbGUgYnVuZGxlLWZzY2stY2xvbmUgMj5lcnIgJiYKPj4gKwl0ZXN0X2dyZXAgIm1p
c3NpbmdFbWFpbCIgZXJyCj4+ICsnCj4KPkRvIHdlIGFsc28gd2FudCB0byBoYXZlIGEgdGVzdCBm
b3IgYHRyYW5zZmVyLmZzY2tPYmplY3RzYD8KClN1cmUsIHNvbWUgbW9yZSBjb21iaW5hdGlvbnMg
b2YgImZldGNoLmZzY2tPYmplY3RzIiBhbmQgInRyYW5zZmVyLmZzY2tPYmplY3RzIgphcmUgYWRk
ZWQgaW4gdGVzdHMuCgpYaW5nIFhpbgo=
