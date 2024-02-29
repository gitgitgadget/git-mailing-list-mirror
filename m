Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892D47E0F0
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212253; cv=none; b=XhrouxpmgYWXYg0x8wT7PqVH/V9+ttRlpGtCNc+9RvDYTbv0PCJfnj4K4AmrCJE2quTEfM/9SBqMp27e1j9ptManmdho8yzgT9e7HazZ0yASaBOWej6y18WNi/ZlFQdoaaPMm+s2iL8TIJ7IRIYSgwnje2KohzjT2iD9Jn2+DV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212253; c=relaxed/simple;
	bh=/JFJZEUp3qUI3dUIT32WiFyLl7p4DLYpGBemyTiO2kg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qd5EGkhNkGLpFLlh0fho+DL1gqHrabfXNeb6JxSX2riiX/JtQIq4f0Oflg1/4TRL7HcDIpqNkKlMyP7cpk7mxYJypYLCzjtDxMTdjPz96aj4gWZJZ7WJCSCKkTi4I4galzpNssXbOM27zHPLmooD0gXPd62iOYcJb3jpF8kGtEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from desktop (unknown [IPV6:2001:da8:d800:b162:4be9:7e8e:fbc5:4539])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 08E69920114
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 20:52:37 +0800 (CST)
Date: Thu, 29 Feb 2024 20:52:37 +0800
From: Wu Zhenyu <wuzhenyu@ustc.edu>
To: git@vger.kernel.org
Subject: [question] How to customize git revert template
Message-ID: <k4zvycdixqmntkyevdtsrswbfiklyj24mp6jhltnwwdswxromc@q3wtrivkbfbl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTxlDVk1PSU4dTUtLTx5DS1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUlLS0pBHxpDQR9DS0tBGUpNSUFPGR5CQUweQx5BHRkYTkFPTkhCWVdZFhoPEhUdFF
	lBWU9LSFVKTUNMTE9VSktLVUpCS0tZBg++
X-HM-Tid: 0a8df4ec864b03a1kunm08e69920114
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBA6OCo4LDMXIQwKMys2ARgS
	EilPCQ9VSlVKTEtCSUpKSk5DTkNPVTMWGhIXVQwOARMeFQIOOw4IDxhVHh8ORVlXWRILWUFZSUtL
	SkEfGkNBH0NLS0EZSk1JQU8ZHkJBTB5DHkEdGRhOQU9OSEJZV1kIAVlBQ0pONwY+

In https://git-scm.com/docs/git-revert

> While git creates a basic commit message automatically

How can I customize git revert template? e.g.,

```sh
git config revert.template ~/.config/git/template
```

TIA!

-- 
Best Regards
Wu Zhenyu
