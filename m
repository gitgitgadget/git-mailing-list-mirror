Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78912951C8
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728007; cv=none; b=fDjNz1hnZFFTipKbyJoyrXdvo2TsOoKe3A2kh4E0WzS92GZQROtR7/DoeG0kRSpZ5XxR15bhJtKfR3KIBjAG/Ct2I502IXTa4x4OdZ33ho4BDIzaymhYPPsqUSdBecA8W3lzeqSI4gsLwey22qK9CkIsytM2OinkzJkftLpkRQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728007; c=relaxed/simple;
	bh=zFefcdtbsaFs5yRfRbJi54t4x1Fz8K1CacWGUEna/H4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=jIGbXYxwdJNnLJQ155lm27oVKYHjdbJR1JqOggaTIK58HBiboA9q1HYz5Oqg0i5IErvx2yjfP7xhgcoNVUJy++BjBKCcw+a15p6Xhgq8NloKmGibOGmjRWky02wkX/QyvSZMW9dBzQwAguADyE+Lg3DWHV82H/4nfUbHYznXSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=airkyi.com; spf=none smtp.mailfrom=airkyi.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=airkyi.com
X-QQ-mid: izesmtp77t1744727991t9cd1e300
X-QQ-Originating-IP: Maodj+rqapE/YZfLqU5gEb6zL82xcNa8rb44dANQUzM=
Received: from [192.168.0.101] ( [121.204.120.186])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:39:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8321341277248207942
Message-ID: <8771714B848C3A9F+9f64a309-ff70-466f-8d29-15950318b728@airkyi.com>
Date: Tue, 15 Apr 2025 22:39:49 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
From: windowsair <dev@airkyi.com>
Subject: RFC2822 Message-ID corrupted on some email servers when using git
 send-email
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: izesmtp:airkyi.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MKD6Cx7ZSeC2lLfY/ekDD9awiz/GGyBZpFQQFvj6sgGIZ4nZXmiESpTk
	ofza4VwGgJ6MksZtUSLCTMejs2Tz9bRO/o/hZQz4z5Fz7UebOubXd1QGQmKMdJNJQRsGYJ8
	E+z71uRAOM+AbHw0L/P0mL5CbmHcuwOdSax2v9z/ewSyN0negI7BYebJp8NHO8w1w4452w7
	CxrMyt3iz9RVwSgdBJEEOp1HFkzq3oNFqWfkAbZLWEtnsEc9+6y2CPGqjx7MB5urjd9vqqv
	CjYAGXq+ewN4DlviFkscC4Pe24r9UwFsVHdgh3wDVotjQM9OtSVg/AqiSPT3BAvusvc1rT0
	1dBJtTttWY8izy3HJWUbgNCV1WRa+GOls01XQJzOrEThZbcEejFh9NubBElkpIiyBtNgwGs
	3ylVp4wxnAdrvB64//u5j7JQYab+fMgDGFItxC/eOZaL223jQmI6exCwF5n6bbQEDHZLI1N
	iv1mr8lMLK5JgT5ts/FccRc2cM+xiQ8SR43XEdFSM2Wuosu49zysI58eyx/e+8fsI4i0toW
	cmTZooVoZs+s4MWNbdJWToz3Og5Nn5Z0Oho3fg7XVE1FKnpxOWkU1OxsTZTUl+nUUxKH7m7
	YsiGJWqEc706Yn5S7okkTdg3ErCe5Vep6+h8NZNt8C7A4gCPBmK7g34g3wD0u77sumzM4oT
	g0TUI3PNduAZ3ejuRB2NbLU+t/jnWdQXGqXwUViV6UERhMZPv/P0yVZY3weT3hDD0erL2N8
	I5EdHti+JlkvRYdnk0hVPM/I4m8OucacisTR6KK8D9COt5HdjJtLyTr1PI2PD8yFhgL0u6b
	G0+e4FwaZJ6Aj7ZRuHF2NYtIX79qXqpIIAanHfXxJ1L5PbJpNk07etTPwwmwWmF4YLXaVJa
	kYLbEmPPte+4n3Xp0CJbOASRo8g2wGa1H9nGsA1eanWJLcLad5TkgAdq/+R4rkP7pIcG+FM
	ef9LG8E4OLigg8IRgUc+41FOFsjngRSaKelwWAsYZmsbAIrIfSs4WdJs5/Y0/FBAzH5bt5T
	me5Dt9KhDbTCIpxKsP
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Hi there!

I am using `git send-email` to send emails and noticed a behavioral difference between different versions of Git. Since version v2.41.0, the Message-ID has been corrupted on my email provider exmail.qq.com.

The broken Message-ID may be like this:

         Message-ID: <C627A112429DDE18+20250415123427.20834-3-dev@airkyi.com>

And in the early version, the normal Message-ID looks like this:

         Message-ID: <20250415123238.17341-3-dev@airkyi.com>

It appears that the email server is overriding this field. And I finally found this commit:

         647a2bb3ffc0("Merge branch 'jc/spell-id-in-both-caps-in-message-id'")

This commit consistently spell "Message-ID" as such, not "Message-Id".

It seems that for my email server, using "Message-Id" results in the expected unmodified ID, while using the RFC2822-compliant "Message-ID" does not. So I want to document this here in case others encounter the same issue in the future :)



Best regards,
windowsair

