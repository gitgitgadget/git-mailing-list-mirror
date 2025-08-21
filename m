Received: from out30-70.freemail.mail.aliyun.com (out30-70.freemail.mail.aliyun.com [115.124.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D402D9EDA
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 04:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750602; cv=none; b=cgRwBHrO9WmhYPuux3Vnpk05wmGRc9c6DhEf5HS/Ij5L+bziCmcO3sXBTASzpUXCruOpThJgHcYwj8P6VtdsxVC9ZcHshabu4Xy/iFe0yy6/CFw+4r0LqVWqNLzc0WejYTDjiQatVHvh+sjy62qNfq20jcT7QW0yNTi2x3tnCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750602; c=relaxed/simple;
	bh=gxCr/Npy/A92ModIWPOSZ4sCdgR6rmk+YX0jXANR/CY=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=s+sdVVuYfHPiglCGWZNTsiHsC0NnkAnA4b13BFx/I35DuwH2nYDoJGiyDtat6KPcRJFRxNgHetiw+/H+SBIvxdc8R0wSNIyBobOsce6qzl6gr7AzBPXZSLyzb94YyZ3nbs8ysNJGOiiv7v/Z5HBfHSyHg66JGKwq6RIc3Th72sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=GEKEhse2; arc=none smtp.client-ip=115.124.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="GEKEhse2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1755750598; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=gxCr/Npy/A92ModIWPOSZ4sCdgR6rmk+YX0jXANR/CY=;
	b=GEKEhse2PXAHcu4pdfd8ze+IFF8g7gVQ0ZdSrLHhUeFIMPIj2FP7HzOBUdl2bJ+DR6sVXlUyqRpfzWSGBtDW0BCJBFkW+l9sg0HJ+ztV7DdsChPSUXQh2xMoUSlEEl8kAzgIdZoZyBA+4pzf8EnjkXJze3G4C+9MOGf5NcYcYPM=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09398892|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0908519-0.00448094-0.904667;FP=15960465879084943845|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083043147;MF=engdoc@aliyun.com;NM=1;PH=DW;RN=1;RT=1;SR=0;TI=W4_0.2.3_v5ForWebDing_212DE4D4_1755750597866_o7001c221r;
Received: from WS-web (engdoc@aliyun.com[W4_0.2.3_v5ForWebDing_212DE4D4_1755750597866_o7001c221r] cluster:ay36) at Thu, 21 Aug 2025 12:29:57 +0800
Date: Thu, 21 Aug 2025 12:29:57 +0800
From: "engdoc" <engdoc@aliyun.com>
To: "git" <git@vger.kernel.org>
Reply-To: "engdoc" <engdoc@aliyun.com>
Message-ID: <a903afc8-9bf6-4ba8-bdab-87a76adf631e.engdoc@aliyun.com>
Subject: =?UTF-8?B?W1JGQ10gQWxsb3cgaW5jbHVkZUlmLmhhc2NvbmZpZyB0byB0YWtlIHByZWNlZGVuY2Ugb3Zl?=
  =?UTF-8?B?ciBpbmNsdWRlSWYuZ2l0ZGly?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][v5ForWebDing][Chrome]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_KEtTW96aWxsYS81LjAgKFgxMTsgTGludXggeDg2XzY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTI3LjAuMC4wIFNhZmFyaS81MzcuMzY=zY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

CgpIZWxsbyBHaXQgZGV2ZWxvcGVycywKSSB3b3VsZCBsaWtlIHRvIHJlcXVlc3QgYSBmZWF0dXJl
IHJlZ2FyZGluZyB0aGUgcHJpb3JpdHkgb2YgY29uZGl0aW9uYWwgaW5jbHVkZXMgaW4gR2l0IGNv
bmZpZ3VyYXRpb24uCgoKQmFja2dyb3VuZDoKQ3VycmVudGx5LCB3aGVuIGJvdGjCoGluY2x1ZGVJ
Zi5naXRkaXLCoGFuZMKgaW5jbHVkZUlmLmhhc2NvbmZpZ8KgY29uZGl0aW9ucyBtYXRjaCBmb3Ig
YSByZXBvc2l0b3J5LCBHaXQgYWx3YXlzIHByb2Nlc3NlcyBnaXRkaXIgZmlyc3QsIHJlZ2FyZGxl
c3Mgb2YgdGhlIG9yZGVyIGluIHRoZSBjb25maWcgZmlsZS7CoFRoaXMgYmVoYXZpb3IgaXMgaGFy
ZGNvZGVkIGFuZCBjYW5ub3QgYmUgY2hhbmdlZCBieSB1c2Vycy4KCgpNeSB1c2UgY2FzZToKSW4g
bXkgd29ya2Zsb3csIGR1ZSB0byB0aGUgY3VycmVudCBwcmlvcml0eSBvcmRlciwgdGhlIGdpdGRp
ciBpbmNsdWRlIGFsd2F5cyB0YWtlcyBwcmVjZWRlbmNlLCBtYWtpbmcgaXQgaW1wb3NzaWJsZSB0
byBvdmVycmlkZSBpdCB3aXRoIGhhc2NvbmZpZyB3aGVuIGJvdGggbWF0Y2guCgoKUmVxdWVzdDoK
SSB3b3VsZCBsaWtlIHRvIGhhdmUgYSB3YXkgdG8gbWFrZcKgaW5jbHVkZUlmLmhhc2NvbmZpZ8Kg
dGFrZSBwcmVjZWRlbmNlIG92ZXLCoGluY2x1ZGVJZi5naXRkaXIsIGVpdGhlciBieToKQWxsb3dp
bmcgdXNlcnMgdG8gc3BlY2lmeSB0aGUgcHJpb3JpdHkvb3JkZXIgb2YgY29uZGl0aW9uYWwgaW5j
bHVkZXMsIG9yCgpBbHdheXMgcHJvY2Vzc2luZyBoYXNjb25maWcgYmVmb3JlIGdpdGRpciwgb3IK
ClByb3ZpZGluZyBhIGNvbmZpZ3VyYXRpb24gb3B0aW9uIHRvIGNvbnRyb2wgdGhpcyBiZWhhdmlv
ci4KCgoKTW90aXZhdGlvbjoKVGhpcyB3b3VsZCBhbGxvdyBtb3JlIGZsZXhpYmxlIGFuZCBjb250
ZXh0LWF3YXJlIGNvbmZpZ3VyYXRpb24gc2V0dXBzLCBlc3BlY2lhbGx5IGZvciB0ZWFtcyBvciB1
c2VycyB3aG8gd2FudCB0byBoYXZlIHBlci1yZXBvc2l0b3J5IG92ZXJyaWRlcyBiYXNlZCBvbiB0
aGUgcHJlc2VuY2Ugb2YgY2VydGFpbiBjb25maWcgZmlsZXMsIHdpdGhvdXQgYmVpbmcgY29uc3Ry
YWluZWQgYnkgdGhlIHJlcG9zaXRvcnkgcGF0aC4KCgpUaGFuayB5b3UgZm9yIGNvbnNpZGVyaW5n
IHRoaXMgZmVhdHVyZSByZXF1ZXN0IQoKCkJlc3QgcmVnYXJkcwoKCgoK
