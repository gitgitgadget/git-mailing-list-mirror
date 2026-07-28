Received: from outbound.ci.icloud.com (ci-2003e-snip4-11.eps.apple.com [57.103.91.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7878E41D10F
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229877; cv=none; b=G018sMcIzVojQX7i391I58LrXjVFlv9uw/pyK+wF2rOVUckLF97mUH3C1sCEzdSQT3EOlTxky6q/QienQV5RqXGnmMahOU0W24kdzbaqHgXVivd/3FQEPMC11SlE2XuYChU76k+Q/wPwgBH7XxjXCgCVE+rJnLzPZRnUBRtD6co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229877; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=PHIJp5h1kbhl27oMowyMAngMDvVcqSgg25Uha4imxz7bLqfnoGPtyM7rPn9vlgXGspbQNvztPSweSFxXjIN+6QblQwo0J5Jp36N26GYtg/+4gzBTmEqY2t+Yfzy4MugGER/EbhhUJ4qnlfNwZmm5DyoydxR+FdFGLw/uUqUQYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lFfBRZab; arc=none smtp.client-ip=57.103.91.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lFfBRZab"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-7 (Postfix) with ESMTPS id DA42D1800195
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 09:11:13 +0000 (UTC)
X-ICL-RepId: 019fa7fe-12a4-7a39-ac67-c2783e09950c
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQBBHV4PRQBCAFYBWARLVxQEEUEIUx1fMFAbXwJCDxwTVhUTC1NWWxNVF0YJGQhdHRkKUFAGS1oVVRcOAkIfUB9MFldDVAIcGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKAlEcVg1XQ1QEX1BUEVdQCy50NH1OCykPRgNBfz0eWQItCl0BPgZVGikFRABLAVQBXgM1ADhaDlsERxQXG1wACUtGCUkdDgRUB10FXQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1785229875; x=1787821875; bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=lFfBRZabahhD4dCg4dbqFZTRgZNcsxLCFqbEDgyZCAouReqTxIQ3OMuhpCYG8EjPx9N9t/kzXdIRZarIKzmHP5XRQ6yRvAkvQsqInZVWCDFTiDAn5rZ/jsfVrP6dpzbndA0wWEuhMWbh0mJxzLNNAlABCJL/j6hX3IrbI1GiafT+YwIlLGLY9HvZntdTTrRnGbXBIYxcSZLmmyiezd3YfXjWbzb2KfEWMwwNlrNkya64vwZ/qMfG8VJm3Msibx7XP6uy23e0rKe+xwPlbaT9z6A/yd8JgtuQKF9Djne6f1w5EBlciki98EZns5qP4WSKT+lTe+7y4jQoo8It0/0AjQ==
Received: from smtpclient.apple (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-7 (Postfix) with ESMTPSA id 417C9180013E
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 09:11:13 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: DANIEL CATONI <iredvm@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Tue, 28 Jul 2026 05:11:02 -0400
Subject: Let me get kernel
Message-Id: <EFDD68D8-11FE-45F8-8F58-B749329651E9@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (23F84)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA3OSBTYWx0ZWRfXy0Rhtr4T76EG
 4tpDOy1xBTAb7LwsBUD2pKQoovxaqiYXlHGzqeZhoHK+5hmAetj05VMwlI2Fr7k4qgja6kMZPx5
 7TBYjjhsNbbatXuX73gK9ag91r0Wx0BLekCeBGDar/vA2cKyDmltp6qcfmqAJefxnUTkbRNP3BP
 0zzR3ubUjX5BC0Ts+BEdZwgmEeq8rW1JYRrvwIdbWtCqm3uaatTLTjSJXrRPtfgUuzg6YN0k/hx
 e5YppDgA+oBCtmxA9wLXA8YI+D+68xuVP/QcH4MSTwM+1vdJVVDV6FmN8qUAjLfq7N7CoABDcse
 dleb6rd6LepejVqNNJZRhJjVEZ5nxpoMCDQi2k3AHv7s1ZvxuAPDPYZ6VzO+zs=
X-Proofpoint-ORIG-GUID: zFPuS3Y9FzCP968RMei1Eb9jCHlIo9Vf
X-Authority-Info-Out: v=2.4 cv=VZL6/Vp9 c=1 sm=1 tr=0 ts=6a687231
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10
 a=x7bEGLp0ZPQA:10 a=5owJUTMDJoYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YPKi6sGXXs_AdLeIGfsA:9 a=CjuIK1q_8ugA:10 a=P4FZZRP6rPu2-ETPHK1R:22
 a=dSJV5w6vZlluInltLr7m:22
X-Proofpoint-GUID: zFPuS3Y9FzCP968RMei1Eb9jCHlIo9Vf


Sent from my iPhone
