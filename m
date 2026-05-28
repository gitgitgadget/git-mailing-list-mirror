Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E381343888
	for <git@vger.kernel.org>; Thu, 28 May 2026 05:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779944896; cv=none; b=ICDE99b1ZrSFaxIrbW6gmanUq1Lil2LL9zdMUe7P7yW43uQSXQTllO0Yw2hU5Ppzke1LAuVl0hjXmOz7mJvEzepsB7DqtPm2Wx911uZ49R0UvjQTOHcoIl3brOAvkTqazxnxlU+9dkqmz8LR92t9mbYFrtYNMstUPlSfqF1Ig/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779944896; c=relaxed/simple;
	bh=VmyzLisQL1OtX4dXxJR4Vyw2otA2vrS6zs4rHdxC/no=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=C+WAjwLY1AE3tRhRwUm8GVnTyLAQIKapXj4Rn07d6oxr35LJjYDXiS8MT5TEns6rrdxRt9TRDc7RHVIxTYoyqGzcuoSPVzIRIYCWKmvjCzm8NNZ61/Pn77LCNhHTDiqh6jX4g1ixcHocw6vnjXJ5CVHfPGYiWbxJrWVeL8ei0es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunline.cn; spf=pass smtp.mailfrom=sunline.cn; dkim=pass (1024-bit key) header.d=sunline.cn header.i=@sunline.cn header.b=BCds67GH; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunline.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sunline.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sunline.cn header.i=@sunline.cn header.b="BCds67GH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sunline.cn;
	s=rfib2312; t=1779944888;
	bh=VmyzLisQL1OtX4dXxJR4Vyw2otA2vrS6zs4rHdxC/no=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=BCds67GHprAQVPVdxwVCkIPCdx3BUn+uq1whigb2ZJWK1hSNo9o7BueqVMpLfTutB
	 7jH8YW+TQfr6NW4UV0RbFq/Te+K1TvYGtgyFXuOlo6DvK4ESNeFSLtADp6+9tNvZAZ
	 LFe7yfPPBLImVCWaJmhydEtZsdbimacuKPLLpJqQ=
EX-QQ-RecipientCnt: 1
X-QQ-GoodBg: 2
X-BAN-DOWNLOAD: 1
X-BAN-SHARE: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqSwkqKLQj+J8S+T4iI3B9fh5njmt0jmxRE=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: NOoZJ3Gd6s6NVtNL8B4evJdjALIGCqKuhrLLek7NmKo=
X-QQ-STYLE: 
X-QQ-mid: lv3gz6b-0t1779944885t934e43a5
From: "=?utf-8?B?6IOh6ZSm?=" <hujin2@sunline.cn>
To: "=?utf-8?B?Z2l0?=" <git@vger.kernel.org>
Subject: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 28 May 2026 12:08:05 +0700
X-Priority: 3
Message-ID: <tencent_124443E95FD3502A16815464@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 10404604405836623916
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 28 May 2026 13:08:06 +0800 (CST)
Feedback-ID: lv:sunline.cn:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M1WXC/ARMOUbNGQz5s4Sf/VfvTWrXt+aBwCnqUto858dzQQ2eZC4Awnb
	lxNz8wNbD78IlY27iHZw+Zgz9804y3GZR3k8D82pxBMcKTbUboLwrIMiyoxdygbxsj1x04/
	0/nk12NleUF+2WTDGpuCZMmKW1f53+YNZ4p19k/2CFcUsJVu3BtcxxfYY1qKG+nUTBBaN49
	9cfQW5i8BwZyfQJr+euguv5HTCNfw/hu7jJiiSPuhf4TCKHzFCw0uWC11gs0w8brhAItJVl
	4GNDDjtlEGxioWRZXHb64W2fwiHLU7AFfQ1AbTMFMZoYzKwuOeZ3V2oGOrHvohToKdXQS10
	+MA+vLoGSChyXmquRWEVZdGXaWiBIwvClLkTXCrVL7fiyQVdYT5yTiIjgRgZs+PvpL2JiMl
	Oe3Ca7eLXbtVArrMGtVPlSydTQBvOOu0nsU/Ybxle9MFIND1+/KVbUvtv9wxwFEKuBWxujb
	r3ereRnRwiWe115JtMoANEhhGRsriPmSE48Bhhd2H1Fomvby1Lm2qz7bSM6CY0Elu8ysq1Y
	86zkGAAhkUU2KFZp4o258g1EophLQhJRCrXr0qUjKPH9/EkJw3EQxntaXNYDJp1QjitoBvU
	qLqF3knwjSHTo8x3VZR0NcAZH//u2kqwTqUIpWc2W5PEanyJocnpQ1dRdb8MCTcStPZs07C
	3KaNm909QlU2AhmUMscSh69abYwP6gKwJmdqqLw/SYiNkJnEXk9tzY9NhIhlUEuZmrBhf/K
	HArn+k9QzVIzcdRaOniY9tbD7BdbErXJ5SJSZAb0JetwcZa767hGWN22ZpBEeNn+BUNfPKa
	SSRHNnE+pBLEtVYTm8+EuRfvHjyau3z60RSbaAmZPq6X7s3fS2tCveqH0fTzPF9rpEBGpkB
	l5tSz0tVaxtqmYftcdVaTzLIt5ObMfbsaNUpDi7ONNIVW/yNr1NTczvzYK4qWCsexYLZ2S9
	CWgtuC+Bd+EfaBASK6IID8EqxditG6RrKonQ9beP59SGQ2/oJMj6XeyzflabAbX/67e/qAx
	pmAKYNxw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

