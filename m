Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE8033998
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 06:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247352; cv=none; b=Nti78Q6QR/PD1UTmeErUz7shsZbBgLOdXV6rsq0g6PfJZ+/IDb8eHcVxNfUi3oEgxeGZOv/0tLiHOVQYf57PQW1tsgr+mkQAmEsmNHThWRWQV3X7ybJQQXsdJGKEn9+53rTH4Pegy6L4kSDihga337SLY5b1r0LZhQKGWTjFm0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247352; c=relaxed/simple;
	bh=SH6ZTRrKz15gZG2n7B85izzgL/zdWJfP3ibGbbdupC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=m3+3ASBTCFoxWKfdGr8iMjVxG46Ds/idJQ8mmpSmtGgRt1Kbay/OzNq2ZoJgXbczfGQI8D5q+B9AjkDia2YDwYL6ea4DYPocOUEOKsAnB2LAO43qLufox+jpk1YT8j0vCjqVSDD6Xqe9cqriVornnK+oLW5hfojXr3meEVt+7lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=b1NHP1P/ reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="b1NHP1P/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=HgLtuA+m3j7GGOoxPhymRzg3Yd14KiRB9fXM9aUM7wY=; b=b
	1NHP1P/jY0ZKYcY2ESBG7cYB7xM9BwTq4A/03yFROwbdNKSv0mySlzl3vS3tuhFB
	EpyMIVePccDBujV2yxBlGPuJZ6ShbaZLeKABB/8VeMdu9i76MVl5jBZyRg5Ik3jm
	Zl94r2pdzkHzF4fQo77Cbnb6eCCfqWTK8LD0RJlfhc=
Received: from ttdlyu$163.com ( [223.221.240.38] ) by
 ajax-webmail-wmsvr-40-117 (Coremail) ; Tue, 16 Apr 2024 14:02:25 +0800
 (CST)
Date: Tue, 16 Apr 2024 14:02:25 +0800 (CST)
From: ttdlyu  <ttdlyu@163.com>
To: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc: 
	=?UTF-8?Q?=E7=A7=83=E5=A4=B4=E7=81=AF=E7=AC=BC=E9=B1=BC_via_GitGitGadget?= <gitgitgadget@gmail.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re:Re: [PATCH v2 1/2] doc: git.txt-Fix inconsistency param
 description
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAN0heSpvKFKVnyve0wvcVJ3gvm5H8OggVTKpz2Se4je3iRHwCw@mail.gmail.com>
References: <pull.1669.git.git.1707479467028.gitgitgadget@gmail.com>
 <pull.1669.v2.git.git.1712822221.gitgitgadget@gmail.com>
 <28a5625f32cca6ef134a385fe9ba66962c40100f.1712822221.git.gitgitgadget@gmail.com>
 <CAN0heSpvKFKVnyve0wvcVJ3gvm5H8OggVTKpz2Se4je3iRHwCw@mail.gmail.com>
X-NTES-SC: AL_Qu2aAf6fuEsv4yGeZukXnEwRge49XsCzvP4u34JWOps0pyTiwCosUF9hJmPb4c2KEyyokDiGYj5M9PpcU7hZeIJ9QVo52b6/5DxgiC1dJE5n
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2ee4f6e3.78c1.18ee57fda14.Coremail.ttdlyu@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3f3lxFB5mhxweAA--.47803W
X-CM-SenderInfo: xwwgz5rx6rljoofrz/1tbiox3CimVOC68YtgABsW
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

ClRoYXQgbWFrZXMgc2Vuc2UuIEkgdGhpbmsgd2hhdCB5b3Ugc2FpZCBpcyB2ZXJ5IHJlYXNvbmFi
bGUsIGFuZCBJIGhhZG7igJl0IGNvbnNpZGVyZWQgaXQgdGhvcm91Z2hseS4KCgpJJ3ZlIHJlY2Vu
dGx5IGJlZW4gd29ya2luZyBvbiB0aGUgQ2hpbmVzZSB0cmFuc2xhdGlvbiBvZiB0aGUgZ2l0bWFu
cGFnZXMsIGFuZCB3aGVuIEkgY2FtZSBhY3Jvc3MgdGhpcyBpbmNvbnNpc3RlbmN5LCBJIGRpc2N1
c3NlZCBpdCB3aXRoIHRoZSBtYWludGFpbmVycyBvZiB0aGUgZ2l0LW1hbnBhZ2VzLWwxMG4gcmVw
b3NpdG9yeS4gQ2xlYXJseSwgbmVpdGhlciBvZiB1cyBoYWQgY29uc2lkZXJlZCB0aGUgZGVzY3Jp
cHRpb24gaW4gZ2l0bmFtZXNwYWNlcyg3KS4KCgpBbmQgdGhhbmsgeW91IGZvciB5b3VyIHJlcGx5
LiBJZiBwb3NzaWJsZSwgY291bGQgeW91IHBsZWFzZSBjb3JyZWN0IHRoZSBkZXNjcmlwdGlvbiBp
biBnaXQudHh0PyBJIGFtIG5vdCB2ZXJ5IGZhbWlsaWFyIHdpdGggdGhlIHByb2Nlc3Mgb2Ygc3Vi
bWl0dGluZyBwYXRjaGVzLgoKCll1IEppYW4KCihJJ20gbm90IHN1cmUgaWYgeW91J3ZlIHNlZW4g
dGhlIG1lc3NhZ2Ugb24gR2l0SHViLCBzbyBJJ20gc2VuZGluZyB5b3UgYW4gZW1haWwgc3BlY2lm
aWNhbGx5LiBJIGFwb2xvZ2l6ZSBpZiBJJ20gYm90aGVyaW5nIHlvdS4pCgpBdCAyMDI0LTA0LTEx
IDE4OjM5OjU5LCAiTWFydGluIMOFZ3JlbiIgPG1hcnRpbi5hZ3JlbkBnbWFpbC5jb20+IHdyb3Rl
Ogo+T24gVGh1LCAxMSBBcHIgMjAyNCBhdCAxMDoyMCwg56eD5aS054Gv56y86bG8IHZpYSBHaXRH
aXRHYWRnZXQKPjxnaXRnaXRnYWRnZXRAZ21haWwuY29tPiB3cm90ZToKPj4KPj4gRnJvbTogPT9V
VEYtOD9xPz1FNz1BNz04Mz1FNT1BND1CND1FNz04MT1BRj1FNz1BQz1CQz1FOT1CMT1CQz89Cj4+
ICA8dHRkbHl1QDE2My5jb20+Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IOeng+WktOeBr+esvOmxvCA8
dHRkbHl1QDE2My5jb20+Cj4KPj4gLSAgICBbLS1naXQtZGlyPTxwYXRoPl0gWy0td29yay10cmVl
PTxwYXRoPl0gWy0tbmFtZXNwYWNlPTxuYW1lPl0KPj4gKyAgICBbLS1naXQtZGlyPTxwYXRoPl0g
Wy0td29yay10cmVlPTxwYXRoPl0gWy0tbmFtZXNwYWNlPTxwYXRoPl0KPgo+VGhpcyBtYWtlcyBp
dCBjb25zaXN0ZW50IHdpdGggdGhlIGluc3RhbmNlIGxhdGVyIGluIHRoZSBkb2N1bWVudCwgd2hl
cmUKPml0IGFscmVhZHkgc2F5cyAiLS1uYW1lc3BhY2U9PHBhdGg+Ii4gT2suCj4KPkhvd2V2ZXIs
IHRoaXMgaXMgZG9jdW1lbnRlZCBhcyAiZXF1aXZhbGVudCB0byBzZXR0aW5nIHRoZSBHSVRfTkFN
RVNQQUNFCj5lbnZpcm9ubWVudCB2YXJpYWJsZSIuIEFuZCBnaXRuYW1lc3BhY2VzKDcpIHNheXMK
PiJHSVRfTkFNRVNQQUNFPTxuYW1lc3BhY2U+Iiwgc28gdGhhdCBpcyBzdGlsbCBpbmNvbnNpc3Rl
bnQuIEkgYWxzbyBzZWUKPnRoaXM6Cj4KPiAgTm90ZSB0aGF0IG5hbWVzcGFjZXMgd2hpY2ggaW5j
bHVkZSBhIC8gd2lsbCBleHBhbmQgdG8gYSBoaWVyYXJjaHkgb2YKPiAgbmFtZXNwYWNlczsgZm9y
IGV4YW1wbGUsIEdJVF9OQU1FU1BBQ0U9Zm9vL2JhciB3aWxsIHN0b3JlIHJlZnMgdW5kZXIKPiAg
cmVmcy9uYW1lc3BhY2VzL2Zvby9yZWZzL25hbWVzcGFjZXMvYmFyLwo+Cj5TbyBmb28vYmFyIGlz
bid0IGEgZmlsZSBwYXRoLiBnaXRuYW1lc3BhY2VzKDcpIHVzZXMgInBhdGgiLCAibmFtZXNwYWNl
Igo+YW5kICJuYW1lc3BhY2UgcGF0aCIgc29ydCBvZiBpbnRlcmNoYW5nZWFibHkuIEV2ZW4gc28s
IEkgdGhpbmsgaXQgY291bGQKPmJlIGEgZ29vZCBpZGVhIHRvIGF2b2lkICJwYXRoIiBzaW5jZSBp
dCBjb3VsZCBnaXZlIHRoZSB3cm9uZyBraW5kIG9mCj5pZGVhcy4KPgo+SSB3b25kZXIgaWYgdGhp
cyBwYXRjaCBzaG91bGQgaW5zdGVhZCBjaGFuZ2UgYm90aCAtLW5hbWVzcGFjZT08bmFtZT4gYW5k
Cj4tLW5hbWVzcGFjZT08cGF0aD4gdG8gLS1uYW1lc3BhY2U9PG5hbWVzcGFjZT4gYW5kIGdpdmUg
c29tZSBtb3RpdmF0aW9uCj5zdWNoIGFzICJNYWtlIHRoZSBwbGFjZWhvbGRlciBjb25zaXN0ZW50
IHdpdGggdGhlIGdpdG5hbWVzcGFjZXMKPmRvY3VtZW50LiIgV2hhdCBkbyB5b3UgdGhpbms/Cj4K
Pk1hcnRpbgo=
