Received: from mail-m49248.qiye.163.com (mail-m49248.qiye.163.com [45.254.49.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6652D0C80
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069203; cv=none; b=USUvAhetWuwCKmhml+lmZNFxJTbAj3V2RjsZS7D+t95Sn45titaVBTE2v3k0NhUk2te+7Fgjo3wyCgvFUBkB+f3SowPCHCcH1+KcFJkYe7QK2mlBRJu/HA7hSGj2q3QFA/F2bwgAk/IY99icSkMOfTBlVaTCOMUH656JKjfUU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069203; c=relaxed/simple;
	bh=NIwZosGqXs/2Wcmd6zMXq8MCvzFvR096T1fwkVZksYE=;
	h=Content-Type:Message-ID:To:Subject:MIME-Version:From:Date; b=TQwW1qcnUhpXdeaP5i6p2syV2mHRLQO4m7ucTHudfNmDn8JukwsarkVJtAnRa2DYrTVGfG66wgoDYtEJSXeKEA/xymQut7PkH30Wcl0G0Q0Bkr0Ft7VhC7KYfpWR6MysZFvm49P4qdgGjzA1V4fGFCrp0k6AxL0/BfOhyecb2/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=BKQC/EkP; arc=none smtp.client-ip=45.254.49.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="BKQC/EkP"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AAkArwD3JXZP4EIjvKF0Waow.1.1755044612233.Hmail.2201111603@stu.pku.edu.cn>
To: git@vger.kernel.org
Subject: =?UTF-8?B?UG90ZW50aWFsIE51bGwgUG9pbnRlciBEZXJlZmVyZW5jZSBkZXRlY3RlZCBieSBzdGF0aWMgYW5hbHlzaXMgdG9vbA==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 2201111603@stu.pku.edu.cn( [240e:390:aa6:ea90:c055:732a:9666:d608] ) by ajax-webmail ( [127.0.0.1] ) ; Wed, 13 Aug 2025 08:23:32 +0800 (GMT+08:00)
From: Cheng <prophecheng@stu.pku.edu.cn>
Date: Wed, 13 Aug 2025 08:23:32 +0800 (GMT+08:00)
X-HM-Tid: 0a98a0c89e5d09bfkunm3da3d4db8aea
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMURCwdwWE/DTAMnERH6bvac1I1iAnZ4LwWs9TJ
	UxGexNRaea+LDnGFX7Kndr+BuxjrnSA5SRmxnfP5KCkgAT0RqMCo5fn7MpWATHtUturr4rImPO53
	khRp2kcaqgPlO4uZX+yQ3Ng+n9yL9lSrnsR/c=
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDT0xNVk9CQhlCSx4ZTk0ZSVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlJT0seQUhCS0EaGk1BHhpCS0EYS05OQUxISRpBQk1NTUEfTUtDWVdZFh
	oPEhUdFFlBWUtVS1VLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=BKQC/EkP41IHtV069+OXtxAevrD30xkSOBLcPQXfosGyRTNQHv8FbC51K5E7Odg7ng47QpbhbxM+92rp8JGQYGHzWC2fAbgkc62//YYyY6r1ytWbww+nwe/4bxi/mlwJ7xJzPhvMc52lrzeWYf32wnyQUDyUtk0Ja7hOCYfh6oY=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=NIwZosGqXs/2Wcmd6zMXq8MCvzFvR096T1fwkVZksYE=;
	h=date:mime-version:subject:message-id:from;

CgpsaW5lIDMyNiBpbiBidWlsdGluL2Rlc2NyaWJlLmNkZXNjcmliZS5jLCB3aGljaCBpcyBsb2Nh
dGVkIGluIHRoZSBmdW5jdGlvbiBkZXNjcmliZV9jb21taXQuIEluIHRoZSBmb2xsb3dpbmcgY29k
ZSwgY21pdMKgY291bGQgYmUgTlVMTCBwYXNzZWQgdG8gdGhlIGNhbGwsIHdoaWNoIHRoZW4gY2F1
c2VzIGEgTlVMTCBkZXJlZmVyZW5jZS4gU2VlbXMgc2hvdWxkIGJlIHJlcGxhY2VkwqBsb29rdXBf
Y29tbWl0X3JlZmVyZW5jZSB3aXRowqBsb29rdXBfY29tbWl0X29yX2RpZS4KCgpgYGBjcHAKY21p
dCA9IGxvb2t1cF9jb21taXRfcmVmZXJlbmNlKHRoZV9yZXBvc2l0b3J5LCBvaWQpOwpuID0gZmlu
ZF9jb21taXRfbmFtZSgmY21pdC0+b2JqZWN0Lm9pZCk7CmBgYAogICAgCgoKVGhlIE5VTEwgdmFs
dWUgc2VlbXMgdG8gY29tZSBmcm9tIGZ1bmN0aW9uIGxvb2t1cF9jb21taXRfcmVmZXJlbmNlX2dl
bnRsecKgd2hlcmU6CgotIDEuIGNhbGwgdG8gZGVyZWZfdGFnIG1heSByZXR1cm4gTlVMTC4KCi0g
Mi4gY2FsbCB0byBvYmplY3RfYXNfdHlwZSBtYXkgcmV0dXJuIE5VTEwuCgoKSW4gdGhpcyByZXBv
c2l0b3J5LCAgb3RoZXIgY2FsbHPCoMKgbG9va3VwX2NvbW1pdF9yZWZlcmVuY2UgYXJlIGZvbGxv
d2VkIGJ5IGEgbnVsbCBjaGVjay4gU28gdGhpcyBzZWVtcyB0byBsZWFkIHRvIE5VTEwgZGVyZWZl
cmVuY2UuIENhbiBJIGNvbmZpcm0gd2l0aCB5b3Ugd2hldGhlciB0aGlzIGlzIGEgdHJ1ZSBwb3Np
dGl2ZSBidWcgcmVwb3J0PwoKCgoKCgoNCg0K
