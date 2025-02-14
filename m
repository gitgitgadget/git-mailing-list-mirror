Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC8D1DF242
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 22:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739570880; cv=none; b=IzWP4UJgHBE5kFD0sS7G9FkzZjkhCI6F+dSpLO8FYqpaLZu7R58ByP2zIwkERHY6CYoTlK76y8kCjW7wakmTaYKEeij2vvVXtieAU1QKM63y77pSXSHwtUfZLYD64jzRQpJ43N575Zg4he7MkJ/caRK6/+YIf4KhsnebsQOBtU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739570880; c=relaxed/simple;
	bh=8ci9STjpe4ZWCtY7N9NtsdoaduTvnwDFoh+5nGA0F0o=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=RjfR+4IP4GFToL31v07k5PCKpsVyIKlfIW2kNQQYfpEDJDTu5C/5vaMniZ0inN7EbndhtZZgwb4oCDe8VDRHfUQW5E0XVt5nPOZC2iaXIQjeUmRy4hSWltflYDH80dGY/SF5BbUZns1qHFUOiwq/mQ2IzwadyjWBZTfCvMY2ZIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=ZdhFg0tJ; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="ZdhFg0tJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=8ci9STjpe4ZWCtY7N9NtsdoaduTvnwDFoh+5nGA0F0o=;
 b=ZdhFg0tJ49nEivARvBkUpv8Zc0B03xjsK9l/xMl2x0svXevfOXPwB1hkje3au6dofTo8u4oDR1FR
   MtBbi398pNPZon0MzOAM8ss6iJuhC4win7mxNIoS43EKS/cFAuTE1w6Avv8oIWB2sZhW8LssN37x
   PKm0o9UT5SnPs9K39+cwJjxubKiOGRRLaGsdzayQiYHou8j1XXXdcdbtr011SO5Dzg+u74PBGLAW
   x56ZmgGIzpuztcOz/+Uv1Q8Kjy6cj7armfO63D19jwr+O6gWfrMyraO2UGWH27RELiS70lrEJMpi
   mLqNp8EYjnvVuFkvk94CGBIGJhDAreBOupk5cw==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20250128 64bit (built Jan 28
 2025))
 with ESMTPS id <0SRP00DPP18OAV20@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 14 Feb 2025 22:02:48 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Fri, 14 Feb 2025 23:01:29 +0100
Message-id: <D7SI9UARORGX.15QZAD6410YTA@ferdinandy.com>
Subject: Re: [PATCH 1/2] config/remote.txt: reunite 'severOption' description
 paragraphs
Cc: "Philippe Blain" <levraiphilippeblain@gmail.com>
To: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>,
 <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <pull.1894.git.git.1739554578.gitgitgadget@gmail.com>
 <cc2e59ca0475ea2d4f2df7784d5a4c81a70c264c.1739554578.git.gitgitgadget@gmail.com>
In-reply-to:
 <cc2e59ca0475ea2d4f2df7784d5a4c81a70c264c.1739554578.git.gitgitgadget@gmail.com>
Reporting-Meta:
 AAFRut1m5wO8eKsO8OR1jao+Jeu1sOLieX+ft67PxFHvjl/uCKnA9X0CpIgaXVQ1
 CW+7dPorgjFQ8dl7nh9dfgx4cDL5xp3K0PDcC8Fyeclv2l9tK7V8O1MGu6ca2Ypw
 6w1KsOI7hpwyEzb++eEHXXjwwBwjO3VzCesx6PtM26l2TwkK4Ed+nUc5uHJ9nJBL
 KtHzPph+maXg1SFn6aagipVc36iEf2ecHznfMe7QK+8hVwMFbkwrVqgpMXWfmP0z
 AliYkjkj1PUnvZeocr0rFFuA71pJxz7DRhjOXIpS518vNCUsSXtCh2A6u5FRS8sJ
 qcAlvMJE8HJvEg8UFxUSTaweNGPy1DRplu55amCwPPAPCgr+qW+L7D8KCPRvwn4D
 AgKk4vVom2hiTHxxEjAfYH4rAl5ncBdh9CAKinE0jnFkhDhuDhR3HVCsRMWMxjnO
 pW7y1FngqA6mGe0eRJAIuHj2yUMrlZwanQ3CstCl6DGEzUyB3brA0cMA


On Fri Feb 14, 2025 at 18:36, Philippe Blain via GitGitGadget <gitgitgadget=
@gmail.com> wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> When 'remote.<name>.followRemoteHEAD' was added in b7f7d16562 (fetch:
> add configuration for set_head behaviour, 2024-11-29), its description
> was added to remote.txt in between the two paragraphs describing
> 'remote.<name>.serverOption'. Reunite these two paragraphs.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---

Auch, that was sloppy. Thanks for cleaning up the mistake!
