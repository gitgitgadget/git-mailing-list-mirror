Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE8E3D6480
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772265791; cv=none; b=Vhh0B/ymzlWLUn691wNvsyLY6WIEMm2drmnTyXuKqVabiWkjwzw3eaKOJtOq9KkkVcVLz236ead+kQaoWXvDM9VNyKKwK8tIep91dUeYN6qAXJWAluwETVOiSIGAwshq1NOF8xHiYRztqtcYS/y0oBjFh0qhbbXTV2TNAk+FAWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772265791; c=relaxed/simple;
	bh=fALFAb7qYdoXsYUSimvxKwjAXF1uwRbtJurmX1esqxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBn8e9oi0Z83QmFkwCmJ7q1XifAXYmKVZLUeEj3t97wEy8I9CvHMvvx13guhbdLQe4lQmp4i+MGJdSUF8Y93X5QamZZreAZ9ITu+S0VSYa5aMJ/UDorCgFABRRVIRA2RsrmcxR+RpJrnTnbFVSoy03w9/quQCnMXU8i11wTfMuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=none smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=n7LfMFrE; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deepin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="n7LfMFrE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1772265742;
	bh=fALFAb7qYdoXsYUSimvxKwjAXF1uwRbtJurmX1esqxg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=n7LfMFrEQPUf9mjMguXETGlx2N1wy3AGTv+tt97jXdW7qT3YvBdI97Cc++EYTmRTi
	 1bqc3X9WvXWePe2tmGN6C1CQ4yLSAb9tvYbpdWCW5Jf51n0mHkUR5uu+xPrnqB6YjQ
	 7p9J7I01hN3kVvVydN0zkRPRunRgw6+MGIIBH+JE=
X-QQ-mid: zesmtpsz2t1772265740t524d578a
X-QQ-Originating-IP: 7/vcBoOzh46Q66t9cJp6OtJkxT72ItCdX+jSGp6CQgw=
Received: from hwlaptop ( [171.11.3.224])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 28 Feb 2026 16:02:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2459214094411233959
EX-QQ-RecipientCnt: 6
From: Wang Zichong <wangzichong@deepin.org>
To: j6t@kdbg.org
Cc: git@blumia.net,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	wangzichong@deepin.org
Subject: Re: [PATCH] gitk: support config the color of linkfgcolor via Gitk Preferences
Date: Sat, 28 Feb 2026 16:02:12 +0800
Message-ID: <03C4B4FC7F6D3C97+20260228080212.3338436-1-wangzichong@deepin.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <8526ae9b-804b-4f39-b5bd-1a8971cc7d6c@kdbg.org>
References: <8526ae9b-804b-4f39-b5bd-1a8971cc7d6c@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:deepin.org:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: Mp6z4bZjgTSTgAW43l8vef9SpcxCzi0EWooC6TwbBdOMZ3O/NvuZEr45
	8qtt77s3GHLyEnQKjHK/TNuEEt/PupTigjgeQ1Y6NVcTyFtb+fI1gg/eH6GrYuUIkXp1h71
	A5H8cKtH7SB/po2QdHClW1LFP3f6SKhiRzWY4BuyDJ+2I0Bxkd62Fa77jtcd6/BM5Q/qnkU
	wj4XkXdWVWWo9nw0NTZMaxWH3QyIHIfSWdJ3yrl53XeudBBLz5aqvfPhGVcpNHRQc3ZDvxU
	pUkw7saIA3uniFR2Ltw3FT104Lp2yPB89DRu8rc+dV4UBaHcOtdnWYz5+hvU6jjcYoOjuoV
	RtnpoQ+V0MFeGk3P4bHR0ciUM5MxurO+t2re/kW8qstmbLfGERazddd1498ATG8L1AOs5Gm
	V2YXKYRtn7YqjO0/PB4QAVpN/Btpa6e3QWh/1A0267gxGS40sgc+e0N2scpXXfKakPojNW4
	we+LYvNJp2x63UfnSeh5s5I3qXIHvjQzCqA58F4izwoo4kcOm7GOzbdJXF8Gv6BOXgasRc+
	Ht8LaZGmms7icewChcC+QqVi1X107NprpcnTxHE78tYuc6TcSbZvS3Zkt16jX47AJIUMU7B
	cOStnGXuTinN+P4qLodp4/GV+bZhK70jFLnZpU9syndy1ICDlX1usNxCAvc3cP+Jpx4kYAo
	7edj+dPVIqvSwwVEEXkFrQ0gllZEM8ilu61tahv36xptoODt+ip9tt1TNfKrBLg5/ETfZ92
	6TjCHz6bJp9Ox9gS/BHBEEWRiDcX0mp90cUZTnDAUfC/dIymmYgz1xygGF+aY38V7DyURKj
	AYxqQOwKu0oRvlN2FK3vuUEzCgnzm2RJnLq5cLMyj24zWePmBCxYWpKTuip0OEiFQaYdxe7
	R2n2bfXncZRRIK83b8WPFEexipPqmU5yYCr5hZGzjVvUrUt7+8uX2iWThgwjaKvmgi1u9/O
	PCZmJBzagHHrJ3r+rS8CW3va34T5Ha6SmNoECmV6Vk/vbk/UD/SOt2C+2nlU/KXX0mciQmn
	7LHRgr5A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

> This page says:
>
> "You can CC potential reviewers by adding a footer to the PR description..."
>
> The commit message is not the PR description. Please don't add Cc lines
> to the commit message. Edit the PR description on Github before you
> /submit the patches with GitGitGadget.
>
> -- Hannes

Sorry! Patch now updated with CC removed from commit message and moved to PR
description.

-- Gary
