Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2224EACE
	for <git@vger.kernel.org>; Sun, 14 Apr 2024 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713063026; cv=none; b=KEeHOHtaePM4nbwo3oQrEu5ERMch84agxv9NhBA4Z6Jm8y9b/XUwv7FjdG/r2/9HugQSD4UUpl/qDmzAZdHc80fVuDBA0PVXBHUrq2NAV+k1Mql6YrJmmoD3i+7lxNCLCX/8uDkuXtzMKcPtJLOnK+vBf50F14VEScwYlbDMGss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713063026; c=relaxed/simple;
	bh=JM413mtwDOtoj2GwPOUgexw9WqTYCjRyeuCfWmvo+5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=cMgfArJ5bgUCRCGoUm9iGSQrG/yP64btXktVze5UpQfHj2qQZCSZ3SR4ZpPzIR3XjAC/4A11XQmz3u+0mspBLBmnrN+LGnJDrpeSjrZuFhLAB2niu5BpkBqZB3c8gBsf9ZY6vBScLcnl8DrAvGXvXm3HbHF0aslXtj5+vGdmk+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=R493FbXe reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="R493FbXe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Z82ueBAMAWLv9eGig5Jw6Nbbw5/uJ1wlEZOsV39G7H0=; b=R
	493FbXetYEkZdo0J09/0gqYv742YAj534OluTTtapcM/L8ZxEHjA6uk9U1xzSTGJ
	4+oJaR2DQdmAwjVhtXJHVYaBhRIbQ2QP3NHX9/xDhQApFSEnqdX9mkfnG7KY0GkS
	7uATStDiCVT3xXphhKvl2XJ+CdM5jYhh2Gsv/gERk0=
Received: from ttdlyu$163.com ( [223.221.240.38] ) by
 ajax-webmail-wmsvr-40-109 (Coremail) ; Sun, 14 Apr 2024 10:49:54 +0800
 (CST)
Date: Sun, 14 Apr 2024 10:49:54 +0800 (CST)
From: ttdlyu  <ttdlyu@163.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: 
	=?GBK?Q?=CD=BA=CD=B7=B5=C6=C1=FD=D3=E3_via_GitGitGadget?= <gitgitgadget@gmail.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re:Re: [PATCH v2 2/2] doc: git.txt-Change "--user-formats" to
 "--user-interfaces"
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <xmqqpluvu5vk.fsf@gitster.g>
References: <pull.1669.git.git.1707479467028.gitgitgadget@gmail.com>
 <pull.1669.v2.git.git.1712822221.gitgitgadget@gmail.com>
 <af548abd00485e161c2e409b0b9fa80a3a061cc8.1712822221.git.gitgitgadget@gmail.com>
 <xmqqpluvu5vk.fsf@gitster.g>
X-NTES-SC: AL_Qu2aAfydvUEi4iGZbekXnEwRge49XsCzvP4u34JWOps0uyTp+Sc4Vn9AJVDE0OCyOiy0sBiQUThK69VAQY5qToCyJFPXROq2kXYcdTTMdxCI
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1bd1d875.c81.18eda82e0cb.Coremail.ttdlyu@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3X9tSRBtm2SoNAA--.35392W
X-CM-SenderInfo: xwwgz5rx6rljoofrz/1tbiRwXAimV4IxtRkAACsu
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

U29ycnksIHRvIGJlIGhvbmVzdCwgSSBoYXZlbqGvdCByZWFkIHRoaXMgZG9jdW1lbnQgY2FyZWZ1
bGx5IGJlZm9yZSwgSSAKd2lsbCBmaW5kIHRpbWUgdG8gcmVhZCBpdCBjYXJlZnVsbHkuCgpJIHNl
bnQgc2V2ZXJhbCBlbWFpbHMgcHJldmlvdXNseSB1c2luZyBUaHVuZGVyYmlyZCwgYW5kIEknbSBu
b3Qgc3VyZSBpZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGVtLiAKSG93ZXZlciwgSSBkaWRuJ3Qgc2Vl
IHRoZSBlbWFpbHMgSSBzZW50IGF0IApodHRwczovL2xvcmUua2VybmVsLm9yZy9naXQvYWY1NDhh
YmQwMDQ4NWUxNjFjMmU0MDliMGI5ZmE4MGEzYTA2MWNjOC4xNzEyODIyMjIxLmdpdC5naXRnaXRn
YWRnZXRAZ21haWwuY29tLy4gCk5vdyBJIGhhdmUgc3dpdGNoZWQgdG8gYSBkaWZmZXJlbnQgZW1h
aWwgY2xpZW50LCBhbmQgSSBob3BlIHlvdSB3aWxsIHJlY2VpdmUgdGhpcyBlbWFpbC4KCtTaIDIw
MjQtMDQtMTIgMDI6MTE6MTGjrCJKdW5pbyBDIEhhbWFubyIgPGdpdHN0ZXJAcG9ib3guY29tPiDQ
tLXAo7oKPiLNus23tcbB/dPjIHZpYSBHaXRHaXRHYWRnZXQiIDxnaXRnaXRnYWRnZXRAZ21haWwu
Y29tPiB3cml0ZXM6Cj4KPj4gRnJvbTogPT9VVEYtOD9xPz1FNz1BNz04Mz1FNT1BND1CND1FNz04
MT1BRj1FNz1BQz1CQz1FOT1CMT1CQz89Cj4+ICA8dHRkbHl1QDE2My5jb20+Cj4+Cj4+IFNpZ25l
ZC1vZmYtYnk6IM26zbe1xsH90+MgPHR0ZGx5dUAxNjMuY29tPgo+Cj5IYXZlIHlvdSBmb2xsb3dl
ZCBEb2N1bWVudGF0aW9uL1N1Ym1pdHRpbmdQYXRjaGVzIGRvY3VtZW50LAo+ZXNwZWNpYWxseSB0
aGUgcGFydCBtYXJrZWQgd2l0aCBbW3JlYWwtbmFtZV1dPwo+Cj5KdXN0IGRvdWJsZSBjaGVja2lu
Zy4K
