Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9151EB44
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710919050; cv=none; b=NVdUHdzP6ifT5N7t3zhWP/7tLm6fmylMOl3IYP5aimUVHhtoZ92nagMSmwDMp3bh6Vdjw82sGYDLalDuXm8Ox6o54HTVm2cHcvI/q6+60CrBdAJBba0HxgPQH/NUPcowVUa3Y/yquNJMO2TW645kcxIh77wi+C5xujAntggq2tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710919050; c=relaxed/simple;
	bh=s41mwz59g1lb2yGJlv+8LdWp5/PlwABJKXx2Fx1u4A0=;
	h=Date:From:To:Subject:MIME-Version:Message-ID:Content-Type; b=iWRUFPVRjMH3tXuPHnpyZYoXA93knBUibI+gIWC9DEmMLE/Dtws5BsxfrJq4c7R1Atj9n4+uaPAZRM6DNjHYbNaSAIwhJMxxHGPCVq8BgoKaUTatV1Mmr5O8aLu0phEugT9uPwSDJE9MTIectJPTU848rgNkDmSIvX0idbnWcc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: webmail.sinamail.sina.com.cn
Received: from webmail-23-147.pop3.fmail.yf.sinanode.com (HELO webmail.sinamail.sina.com.cn)([10.2.23.147])
	by sina.com (172.16.235.24) with SMTP
	id 65FA8D7A00001EB8; Wed, 20 Mar 2024 15:17:14 +0800 (CST)
X-Sender: jjb8256@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=jjb8256@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=jjb8256@sina.com
X-SMAIL-MID: 36571745089175
Received: by webmail.sinamail.sina.com.cn (Postfix, from userid 993)
	id 4CB55A146C; Wed, 20 Mar 2024 15:17:14 +0800 (CST)
Date: Wed, 20 Mar 2024 15:17:14 +0800
Received: from jjb8256@sina.com([218.4.204.164]) by m1.mail.sina.com.cn via HTTP;
 Wed, 20 Mar 2024 15:17:14 +0800 (CST)
Reply-To: jjb8256@sina.com
From: <jjb8256@sina.com>
To: "" <git@vger.kernel.org>
Subject: git push error
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Priority: 3
Message-ID: <65fa8d7a469967.62182104.7cc8fd91@m1.mail.sina.com.cn>
X-MessageID: 4bd912676f6f218f365a03e053aa4fb9_202403
X-SMAIL-UIID: E3ED219202FEE77C8664108ACD032089-20240320-151714-2
X-Mailer: Sina WebMail 4.0
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGmjug0KICAgIGdpdCBwdXNoIMqxt6LP1sjnz8KxqLTto6yzosrUzt63qNDeuMSjrMfrsO/DpqOs
0LvQu6OhDQoNCiQgZ2l0IHB1c2gNCkVudW1lcmF0aW5nIG9iamVjdHM6IDksIGRvbmUuDQpDb3Vu
dGluZyBvYmplY3RzOiAxMDAlICg4LzgpLCBkb25lLg0KRGVsdGEgY29tcHJlc3Npb24gdXNpbmcg
dXAgdG8gOCB0aHJlYWRzDQpDb21wcmVzc2luZyBvYmplY3RzOiAxMDAlICg1LzUpLCBkb25lLg0K
V3JpdGluZyBvYmplY3RzOiAxMDAlICg1LzUpLCA3MDEgYnl0ZXMgfCAyMzMuMDAgS2lCL3MsIGRv
bmUuDQpUb3RhbCA1IChkZWx0YSAwKSwgcmV1c2VkIDAgKGRlbHRhIDApLCBwYWNrLXJldXNlZCAw
IChmcm9tIDApDQpyZW1vdGU6IFRoZSBnaXRsYWItc2hlbGwgaG9va3MgaGF2ZSBiZWVuIG1pZ3Jh
dGVkIHRvIEdpdGFseSwgc2VlIGh0dHBzOi8vZ2l0bGFiLmNvbS9naXRsYWItb3JnL2dpdGFseS9p
c3N1ZXMvMTIyNg0KVG8gaHR0cDovLzEwLjExLjE1LjEwL2tzLXJkLWZ3L2dpdC10cmFpbi0yMDIy
LmdpdA0KICEgW3JlbW90ZSByZWplY3RlZF0gZGV2ZWxvcCAtPiBkZXZlbG9wIChwcmUtcmVjZWl2
ZSBob29rIGRlY2xpbmVkKQ0KZXJyb3I6IGZhaWxlZCB0byBwdXNoIHNvbWUgcmVmcyB0byAnaHR0
cDovLzEwLjExLjE1LjEwL2tzLXJkLWZ3L2dpdC10cmFpbi0yMDIyLmdpdCc=
