Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FE5343895
	for <git@vger.kernel.org>; Thu, 28 May 2026 05:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945364; cv=none; b=WeRIDqkaQOji9aWrJFzHts8OzB2qVfWYZ0WSSezguTpnWuyhSVW7pHK/ZVzDg+D6EmerYwzvk4Sifnlr5uw7N2PWTJ9/cYYRr6hN59RTdwnwLnIkMBefKvRwLtuR5wdAWATsS7u8fbb5f6tTyUIXEUz0x/+V3GTwV4quPV9xIYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945364; c=relaxed/simple;
	bh=VmyzLisQL1OtX4dXxJR4Vyw2otA2vrS6zs4rHdxC/no=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=IAW3+qfxRmGWEWI/NeP0VyUhBxyDu2pWcKvYCfAkacF3KbL543M1Y8Hl/cntlBdMzTe+BfbpPCREGdoFZ4l7Zfm4Jlt635XYLIfZCHYc9TCVJZe0gAohrzdQus1671gVmx1cXjCgUxaDCIaogBz6bfkNvpcmpjF1hd0rtSwZbCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunline.cn; spf=pass smtp.mailfrom=sunline.cn; dkim=pass (1024-bit key) header.d=sunline.cn header.i=@sunline.cn header.b=s6QWGli/; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunline.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sunline.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sunline.cn header.i=@sunline.cn header.b="s6QWGli/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sunline.cn;
	s=rfib2312; t=1779945354;
	bh=VmyzLisQL1OtX4dXxJR4Vyw2otA2vrS6zs4rHdxC/no=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=s6QWGli/MKDu515lV0L6PmShxPAyhH+4jryT+fpFLqfwhYx+3pKIm0vYpyeHXvrQL
	 MusL4A/66e8B9XGL4DDyEA/DI5CRLnaJ1HBcNoim6eJYd3mB2U7xWvL+AfnUGY7vBo
	 i5ar7nHfxuFE2OGWlfI64393s350NPvplKyyVj3c=
EX-QQ-RecipientCnt: 1
X-QQ-GoodBg: 2
X-BAN-DOWNLOAD: 1
X-BAN-SHARE: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqSwkqKLQj+J8S+T4iI3B9fh5njmt0jmxRE=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: 6roohaUYpBRkUBTyC6tKPq6Pbzc0A7YDVHQNUvY6cm8=
X-QQ-STYLE: 
X-QQ-mid: lv3gz6b-0t1779945351tff4c6e17
From: "=?utf-8?B?6IOh6ZSm?=" <hujin2@sunline.cn>
To: "=?utf-8?B?Z2l0?=" <git@vger.kernel.org>
Subject: Suggestion: Real-time or Conflict-Reducing Collaboration Support for Specific Directories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 28 May 2026 12:15:51 +0700
X-Priority: 3
Message-ID: <tencent_530FD5EC0E2FA9A005AB4725@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 7016819642478190862
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 28 May 2026 13:15:52 +0800 (CST)
Feedback-ID: lv:sunline.cn:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mtb4Ej7QpsMmf1LsLUujaJIAOSEafHzUZ0KJ1MORITEwABh10SCu1YiI
	FFHjSEeTD7iRTXZrkFZXn/7s+/eC+VLBQcQNj9FXsNkhV9Z31X9dvQ7ew7H8daJR7IUwRMU
	93yjPTItyZaXjpsFk8QdJM81dfUmg4rsm2qaylnQcKl0xb9aSSsC9PiRX+SLG2nnKhkodJU
	McyQC58SxnJY970Tmn71D1BMuranQyWHZerubVOlhqmIsi6xFpxo8fv8mHh/vKwVttqMmzd
	yCdL8rpSwkhDGdhO4yzppUWKHhaiimfGfPgt5JbMNB+RvFZkuwDpmRI+5TngTXhikjdxdjl
	DYax8JxYHwFcLn8+2ygVXhmNP2A7wiP2cRdMG+R69CZ76gEZC836D5XVw+/HOZRmrAo1Shc
	ykgwqSP1TQZX7LbEeINSR7bq0UQ+o62CzGb//aUUewqSZROmcxr/mVm2y7T/jAvH0HJQKn1
	nJdnrt27XSrVgAlFb1jwVtIvJ9QNiSeoFEEgMR2ZgYb1sbZIG5yrMLNSLfY/8RTPu0PZUeh
	+sffWaw029krns2ELisB0MIFUgJiJcYS53yKeqBosixXRQ2lSd2VF/s6rBm2U9DrG9P/Ldt
	6HFAzKcK5p8LWw1eTCzWC0fhfiEML6lOpw0wCtTJk+Ka40/GR4htfnNwbU30kibd1vmWQRG
	WsptU3VkxlegMwiEX7Hi0lB4J2U9WILtfoezNO/DQoV26DE5NbZsaqpOwCdm0K4w2Jzubhw
	XSK9KXHLLkZIVJvMXQG/rENx1BWTtwigahaSmYSYP4Cp+WVqfVWwNRQ3kpamvUSV8V5pOeI
	166Hf6p4s88os9AteaChj5sm2UpjGcLWU5G7RNuM4PceVziBTdp8D3v1mmp5IxQd8+XDXbO
	R/oFLQ4uTDwLEXOz+uu/dM7jNHfgAmd4KFm0auoG54ocsJo2FhrHV0rCfKC2w1mqfaapF1k
	/IEI/4NpO9xN8qHUx9mEwNu9+0Wlt6hIooeizZ51RD5Xc/6nBFzWozWtffOHezVDa/tatsw
	NIInFT8azbST9lha7d28F+OCl5Qrw3iVSWGNpGhQ==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

RGVhciBHaXQgVGVhbSwNCg0KTXkgbmFtZSBpcyBIdWppbiwgYW5kIEkgYW0gYW4gSVQgZW5n
aW5lZXIgZnJvbSBDaGluYS4gSSBoYXZlIGJlZW4gdXNpbmcgR2l0IGZvciBtb3JlIHRoYW4g
MTAgeWVhcnMuDQoNCkZpcnN0IG9mIGFsbCwgSSB3b3VsZCBsaWtlIHRvIGV4cHJlc3MgbXkg
YXBwcmVjaWF0aW9uIGZvciBHaXQuIEluIG15IGV4cGVyaWVuY2UsIEdpdCByZW1haW5zIG9u
ZSBvZiB0aGUgYmVzdCBhbmQgbW9zdCByZWxpYWJsZSB2ZXJzaW9uIGNvbnRyb2wgc3lzdGVt
cyBpbiBtb2Rlcm4gc29mdHdhcmUgZGV2ZWxvcG1lbnQuIEl0IGhhcyBwbGF5ZWQgYW4gaW1w
b3J0YW50IHJvbGUgaW4gbWFueSBwcm9qZWN0cyBJIGhhdmUgd29ya2VkIG9uLg0KDQpIb3dl
dmVyLCBJIGhhdmUgYWxzbyBlbmNvdW50ZXJlZCBhIHJlY3VycmluZyBkaWZmaWN1bHR5IGlu
IGRhaWx5IHVzZS4gRm9yIGNlcnRhaW4gdHlwZXMgb2YgZmlsZXMsIGVzcGVjaWFsbHkgZmls
ZXMgdW5kZXIgc2NyaXB0IGRpcmVjdG9yaWVzIG9yIG90aGVyIGZyZXF1ZW50bHkgbW9kaWZp
ZWQgZGlyZWN0b3JpZXMsIGNvbmZsaWN0cyBoYXBwZW4gcXVpdGUgb2Z0ZW4gYmVjYXVzZSB1
cGRhdGVzIGFyZSBub3Qgc3luY2hyb25pemVkIGluIHJlYWwgdGltZS4gSW4gc29tZSBwcm9q
ZWN0IHNjZW5hcmlvcywgbXVsdGlwbGUgZW5naW5lZXJzIG1heSBlZGl0IHJlbGF0ZWQgc2Ny
aXB0cyBhdCB0aGUgc2FtZSB0aW1lLCBhbmQgdGhpcyBjYW4gbGVhZCB0byByZXBlYXRlZCBt
ZXJnZSBjb25mbGljdHMgYW5kIGV4dHJhIGNvb3JkaW5hdGlvbiBjb3N0cy4NCg0KSSB3b25k
ZXIgd2hldGhlciBHaXQgY291bGQgcHJvdmlkZSwgaW4gZnV0dXJlIHZlcnNpb25zLCBzb21l
IG9wdGlvbmFsIGZlYXR1cmVzIHNpbWlsYXIgdG8gb25saW5lIGNvbGxhYm9yYXRpdmUgZG9j
dW1lbnRzLCBvciBkaXJlY3RvcnktbGV2ZWwgY29sbGFib3JhdGlvbiBtZWNoYW5pc21zIGZv
ciBzcGVjaWZpYyBmaWxlcyBvciBmb2xkZXJzLiBGb3IgZXhhbXBsZSwgdXNlcnMgY291bGQg
ZW5hYmxlIHNwZWNpYWwgcmVhbC10aW1lIHVwZGF0ZSwgbG9jaywgbm90aWZpY2F0aW9uLCBv
ciBjb25mbGljdC1yZWR1Y3Rpb24gYmVoYXZpb3IgZm9yIHNlbGVjdGVkIGRpcmVjdG9yaWVz
IHN1Y2ggYXMgc2NyaXB0cy4gVGhpcyBjb3VsZCBoZWxwIHJlZHVjZSBjb25mbGljdHMgYW5k
IG1ha2UgR2l0IGV2ZW4gbW9yZSBjb252ZW5pZW50IGZvciB0ZWFtcyB3b3JraW5nIG9uIGhp
Z2hseSBzaGFyZWQgZmlsZXMuDQoNCkkgdW5kZXJzdGFuZCB0aGF0IEdpdCBpcyBkZXNpZ25l
ZCBhcyBhIGRpc3RyaWJ1dGVkIHZlcnNpb24gY29udHJvbCBzeXN0ZW0sIGFuZCBzdWNoIGZ1
bmN0aW9uYWxpdHkgbWF5IG5vdCBiZSBzaW1wbGUgdG8gaW1wbGVtZW50LiBTdGlsbCwgSSBi
ZWxpZXZlIGFuIG9wdGlvbmFsIGZlYXR1cmUgaW4gdGhpcyBkaXJlY3Rpb24gY291bGQgYmUg
dmVyeSBoZWxwZnVsIGZvciBtYW55IGVuZ2luZWVyaW5nIHRlYW1zLg0KDQpUaGFuayB5b3Ug
Zm9yIHlvdXIgZ3JlYXQgd29yayBvbiBHaXQuIEkgbG9vayBmb3J3YXJkIHRvIGhlYXJpbmcg
eW91ciB0aG91Z2h0cy4NCg0KQmVzdCByZWdhcmRzLEh1amlu

