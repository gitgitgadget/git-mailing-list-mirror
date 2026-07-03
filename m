Received: from outbound.st.icloud.com (p-east2-cluster5-host12-snip4-1.eps.apple.com [57.103.79.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF55939DBE5
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070088; cv=none; b=RG6jPrjnNu1PJLrBOekmU6otMwvCH+rf660v/QKrqejmivzyuk+rp6Ni5+aK0PlkuHHef6ZrpWEhI9o6KTGZF1AnDbWp97mHqq30HkmFZf6DwYIQrf4AjNHYoZG7TS3t2yaDVOeR7Dy03AtH2uw8LU0DlUXIR0Takn0oKU+PdBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070088; c=relaxed/simple;
	bh=dc8Q9qQlmqC8vywfYewZfFUoelXBYqLRJ4vSkAfwIyc=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=GZuS7wQdktxq2kw4iLr9viZQLGDXSFfE9gsOVx9Bv8b1M+JxIei/i+oizuzeBus1Wp+FrUUbDhuA/6Ol2mU9rc7+Yu9RoCGLo/V7bz6aLFUCCN+N1CUGbIFGFXPAAFZDHZyK7BNL60IdcFKfoumQEXbj2zL9F62ChH6uyMesLT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=hYkMYsP6; arc=none smtp.client-ip=57.103.79.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="hYkMYsP6"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-1 (Postfix) with ESMTPS id F09D018003C2
	for <git@vger.kernel.org>; Fri, 03 Jul 2026 09:14:44 +0000 (UTC)
X-ICL-RepId: 019f2742-4f35-7067-9552-c3f203d6b44f
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQBIHV0ZWQJJF08HTVIPDxNRCloeQwJcFRceWgFVDkAEDzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA1BRHV8CCgRHBFsXRgNTRUEEFxFQAVgeVl5aF15NRx9ATWJJAVoZWxxAF0puTVMPDxlaFFwYU0VRH1RYXgRTVg5EfEgBKAJSdl19OwNYGl8DQA5VcVl1Uh9DfEh2XAdcCkYMPAotXgheH0wcHQ5YBgxQTQFDCAoCURxWDVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1783070085; x=1785662085; bh=dc8Q9qQlmqC8vywfYewZfFUoelXBYqLRJ4vSkAfwIyc=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=hYkMYsP6+257aT8WyPZq93el0Pll9WVKHr26fypoyll8hF4UMiPu0lzPwj8Fd4lX+AfON0h8pH5nKWt+BxULIaG/NLWIy+fwQMiCL630K9EukzYWyFdGNWKihnaAwOEeWIbeAWg87JAF+Q1k1K2Z4slBAx30KDXCmq2U/2PSJyXHd4T/5cBuID+m39jLUQVFNKfH/NxVbVZy1auASLoDV9rBtWWQZ6esO8ejpfYDCBBvn+jVVnBDcvBRjBwF88TBgquWR3uC8RP0dCnobNltGpNP9UFYVDtthgxV5AtUkeACETVcM4D5Ili1r6MzGPRcITRBhSeoF2HvEzQZGZGm5g==
Received: from smtpclient.apple (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-1 (Postfix) with ESMTPSA id E64811800113
	for <git@vger.kernel.org>; Fri, 03 Jul 2026 09:14:43 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: christine.filbert6@icloud.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Fri, 3 Jul 2026 11:14:48 +0200
Subject: merci d'effacer nos donnees
Message-Id: <4E02E59D-DC05-4107-B4B9-3E0E107865D9@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (23C55)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfX4tmrItDoWkDy
 ZQ9OwS4UlmNZSWgt5YlMGJHQCHYMNLr/4YYWWTv2mwBgKS01l9OfVw+Pbh4XPJX9J2jY39CWlMr
 ro8O1RBb+abb3fYqYWePsno1G6rbMYA0W+txW900211xwKaLofJvFV4Ck0tIapSdGCu6CZ8yDSB
 1uCFE6PVEIJjhImFSFeTvt9qBBIhW8/aXo0Dil5i+etEKA9/TlReTHG2UZjoldmaSPB+re5jQYB
 ZS8JlhEwKJlF74BYokZ4iwMeUEtJCb0FSx0F3RGftp1t3Qy+pT6NTDXzHZ01nR+YX7QuofvHMMp
 t4B5M5iINv81d6Y4b3C
X-Proofpoint-GUID: FKE3yP1S6XE17W75ooufVDslA8yNDlhN
X-Proofpoint-ORIG-GUID: FKE3yP1S6XE17W75ooufVDslA8yNDlhN


jEnvoy=C3=A9 de mon iPhone=
