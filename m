Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2001D63C0
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507593; cv=none; b=jt5y7TLMtroPDcfKJOVBbP45Qts4TjXdCHVCPheaUXOlH7U/KSmE9ckd/lvlUCuxDEdaMCopCyEJtEwyjkzbww2IgbvBAclFqGLjnI78E9EFh5c2oF4GtAbJJe2l0Yp74jiop/8VbhdJKRDakT0F2L8MNlcJKn74Ikthz1nq2Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507593; c=relaxed/simple;
	bh=DnfZIXzy2w6/TmLQ8nz5s9IywmsnasipW+GTDXSqSjs=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=cmG+rMnD7d8yFuD71+H2g1faFTtCDTPw+8D6g72zpmRwAsMyC2jQHU/zB8kSU77FMUMOnfIoZyRvVYcvlGnakx6mol0hlTIqkNH/47O1x87JrK8Sg763ZL8b0nCGllm+EkUBMIhg2DO3TdQD6SrFbtAb570AF6VHt8ZG9ir2uHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz3t1751507582t9826288a
X-QQ-Originating-IP: sZYiZnLWhZ5OmbHXD2HbAFFW4U/AFJq5ZFJb3/zmQuw=
Received: from smtpclient.apple ( [202.119.46.106])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <git@vger.kernel.org>; Thu, 03 Jul 2025 09:53:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 399295598078922140
From: Lidong Yan <502024330056@smail.nju.edu.cn>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 2/2] bloom: enable multiple pathspec bloom keys
Date: Thu, 3 Jul 2025 09:52:51 +0800
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
 <20250625125541.3048632-3-502024330056@smail.nju.edu.cn>
 <xmqqy0td8fa9.fsf@gitster.g> <C8E0D62E-11B1-4921-AD4C-2905F10E07B6@gmail.com>
 <xmqqo6u4kkg0.fsf@gitster.g> <D5CB9B7A-C7B2-4F5A-B358-8F46A4E18CDB@gmail.com>
 <xmqq1pqyfvb2.fsf@gitster.g>
To: git@vger.kernel.org
In-Reply-To: <xmqq1pqyfvb2.fsf@gitster.g>
Message-Id: <2E8CA6E5-0A2C-4470-A1C0-BE7D72B36DD8@smail.nju.edu.cn>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MB5+LsFw85NotIvO0XWzmeEl4z3Vvz9goHthRx+z3X4cIZoomIAyiNW+
	AMdm6YokNscW2g8yoXmI1c5LrCOuoWfqtzlZ4eKschnKHn0QsAa+ML9bpunesJjl0dbUR53
	i0iSH61uQF3oXkO7lLR+vI+w/wpXK6CiL8298ejd1n7Rz7Ipd+FG+0CgEKTXAwN6dpS9WqX
	aMxUKYzdcoY4gpW544fAWVG7z7DMswnnCO0QzUOqkNcESvNjQuekozOdP3oYWpLTlAiVk0V
	29aoo9D9MsNuwx9yI0t6pFyE6wlurxgMdXjT7lxOg6m56Vqn9qLz1n7+x1YoXe72D/illVj
	wh3v4g7D5hHLdh9S9X6yPnYDptt9JeUPEiDCee6084VoWUeSioqFo1DfQKqtdSWovUwDyRP
	HciJIujb0RcmwzknvpPKBWp1tW9w57Pwm26UmsgjkGT0x+jtVf5i73o4MJWBj4ZHUTHZKBp
	ooE3ZA3sB5JTks/8Y/il+AaWfcNs5uxQR51bA/OTk8sdTjqqWFczCbA6kNjM/iGpLKu+AOn
	321Ebiouzv4tCLfZPe2viSsOXvpsSnRYxbudfJiHRR5XbIpo/CZ876KSKPecbxV0IzhIX+L
	sgjqHHvBoR/fhzbY4jnyfb5OTcBbnpX44k5Sz+8cPY0kNEQdjPhx7ylnaiMjS9fO7NBdHCJ
	iF1xZ7IWUvVIg+MiUH1wInj6INVs8OMm28DYyQRJnHMKfcwJFBo0fyrUqpeyZIHaVCrWWtX
	ddmwXMzZN6LhHUtheV3F3zBoVAYO+XwaFOyANKYwKg6RAiqJXbz6uYF7Uzj6qUvLYXdbbuT
	VWytowQu9GUdrd6B532JtYccV6YfcqPIbr35J1QYbKmIpRNMxgQqo7El2fKSlb4S4dO6ze9
	P9sPUli1N8AJUwFqze/rSEQYXPWZl5/6O3MFG5NNJsMnA/9VChlyRY4+M5w4fGm4UbQt0W6
	w2nTgGbKW1nYAKhUR2N91xh5Wqs3k6OR7Hof1Rp2BdsB4mY2jHOCpg2U3cv9n8VrJIjZe69
	AxA2NB3A==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Junio C Hamano <gitster@pobox.com> writes:
>=20
> Before concluding so, we may want to double check how Bloom filters
> are built on case insensitive systems, though.  If we normalize the
> string by downcasing before murmuring the string, the resulting
> Bloom filter may have more false positives for those who want to
> (ab)use it to optimize case sensitive queries (without affecting
> correctness), but case insensitive queries would be helped.  I do
> not think we support (or want to support) a repository that spans
> across two filesystems with different case sensitivity, so those who
> worked on our changed-path Bloom filter subsystem may have already
> placed such an optimization, based on the case sensitivity recorded
> in the repository (core.ignorecase).

I understand. I should check whether commit graph file's change path
bloom filter is case sensitive. If the change path bloom filter is case =
insensitive,
we could optimize PATHSPEC_ICASE as well.

>=20
> Updating a patch with a fix to obvious known problems is good.
>=20
> Extending the scope of the series should be left out for a new
> separate commit.  It may even be a better idea to hold it while
> the current set of patches are still being polished, and then sent
> out as a new series after the dust settles (even if you internally
> developed that part as a direct extension to the current effort).

Got it. So for now I should just polish this current patch.=20

Thanks,
Lidong

