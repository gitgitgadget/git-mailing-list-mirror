Received: from outbound.ci.icloud.com (p-east1-cluster6-host12-snip4-10.eps.apple.com [57.103.90.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92B2EAD11
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.90.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622868; cv=none; b=HArhgcnQGmgvHbtjAwl9mUm/BQDTVnDlQi6ya1ltofu6ZiC02h+v6pIECjzqiZrVr8hQ2144/IrX2PyixJ9B3IcJ76ed/7mFRrg/Dm4mjTOlT4Ii7IpSz5l3O/cK/Zcl4ogX7+ZGPCOVratQPuQzaKKsMbpKGmjsH0eGsbS2M50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622868; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=OTQJqf26a84PD6n2I8O9JPtT0AW44bGw37ovq67D+ctsCNeT7ijxDcul5t9v7pFSoy9Rk0YkcrKBPjwaKEOiLg2L88nWo5dPTwGIt5mrWTvDgEq6gLdbTY3RasD3YEtjUg8SjCvgGaM3T2GVY4mjoDKLhDTIk/DHdr2eOmM4k2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=bS1R6MMz; arc=none smtp.client-ip=57.103.90.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="bS1R6MMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
	b=bS1R6MMzhUBQ5IUMYAKbnAgse7JOJcI1zgTb+k7qg9b/qWBt/EX+DTOC2u1/sBhAK
	 M33/mozB5zZPjW1CPgHoBE47WadGOIdsly3QrTleZRMca+Jqax1XNjkEph+CT55WmR
	 9Uug9RoSfJjsFlSL2ncnNgL6NOP9vshkdOGiIqt5+kPZr1WlLEL9DJsDujcPkKRyeZ
	 q4KPQ7BlYfmpl1AWSmjNeBzN86dtZqZ0Ei3JFgPnVpuX958QLfmO5EgVsTXTmJ3NO2
	 MZQmCmi96N1asfRksZ2XRfNOrkABiDjvU9j1cAXWblveoDcQsnGSRsK1NuBx+ucYUV
	 yk3tvzSp9oFJw==
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by outbound.ci.icloud.com (Postfix) with ESMTPS id C9E0B180020D
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 09:54:24 +0000 (UTC)
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com [17.57.156.36])
	by outbound.ci.icloud.com (Postfix) with ESMTPSA id 6AE1F18002DA
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 09:54:23 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Pretty Natasha <natashababy001@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Fri, 4 Jul 2025 10:54:20 +0100
Subject: =?utf-8?Q?Hey_I=E2=80=99m_not_interested_blocked_all_this_?=
Message-Id: <88E8C1A4-DC86-43F0-A9FB-2734FA0C5AB6@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (22F76)
X-Proofpoint-GUID: jtxWob7EQoOIk3XmEg-3Y64CcrbpBjTt
X-Proofpoint-ORIG-GUID: jtxWob7EQoOIk3XmEg-3Y64CcrbpBjTt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDA3NiBTYWx0ZWRfX9VP0Nt3N3GcU
 yFh7yRHL71wFF/QbHydADTzdEabeJwzZPzlzpLKAjmyUxYjKzt40+eZQgjUQYMgAwK9kd8RYKEn
 7m6d+cId7V6TOSof99T6VTpD086b6VkMcOV2wngqfWPfmGAzI0WPCMFrK/EeoBvFCNXonYlS25M
 qCJIwYFqkfXLWIn3M9FPyo78iabRdpPuc/IioLk7wRzmA48EuYqGi0bSIJufo/THNkJBJlEAWHc
 owyeqDuafaW3K/XFVfjNDnvj1B9f2kDII5lmODVTTBKkZrA1BLZyw1pLPH8UR4l6FlInbX5qA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 clxscore=1011 malwarescore=0 suspectscore=0 phishscore=0
 mlxlogscore=254 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507040076


