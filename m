Received: from outbound.mr.icloud.com (p-west2-cluster2-host9-snip4-10.eps.apple.com [57.103.68.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EE972634
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 05:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753765930; cv=none; b=W5hDFTRGOvjWYXjJJO+nxgB9Gmlv+v7NJx4n3IvWcwQWkQatSvGHeFstNcrhifR8aXIE6jxgMs5JM+awJ8EJjPjYbLo7Rt+jcsqAmXYyRHuK0MyzQNdORrAgF7IccNYDjsKdAQ2+5N1FVkboDTzp4eEzzjYwoBF/inz083G8LJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753765930; c=relaxed/simple;
	bh=EZUHSwbHpWmKrh1p1uYlYmJ8PhV4cQaa+3l2tKARcvQ=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=YiS9F9EuQdDYC8/qCyJqH2a4agSckZj+14SIP8qxiF5gAX/Zm8Mgvc1gjykWi5n30zmaTKu2UOYfM5bsoJ6DTqGVh4vg+prMKYNJQFptwoCwOePkNgklGoXVbr24hXuqYybKhGrkxFeq+6s3UL+iQ9DZhKwq96OXrNSaj7AOe64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=eUJAiFzb; arc=none smtp.client-ip=57.103.68.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="eUJAiFzb"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id 9330118000AC
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 05:12:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=EZUHSwbHpWmKrh1p1uYlYmJ8PhV4cQaa+3l2tKARcvQ=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=eUJAiFzbvqc92GJyNQFhJUD9eFMvHpon8I3s4MFCtI06r+jZvZikIobVM+KrZg8txYbhZeBDWHQQzjBHfkvrMyeVm+uFJGcvGP88pS4+xgOqCP+1xiP1EZmm3n6yrGQNe2PSXMMc9M273ozg50aDGzfuLjq3hWA2SbFgaUjXftBLOQTzey51EP4BjvFb/10l/YPvZLUUjQgCGIL+uZ6nyTvzZtSIPSb8BNWMAzIGfy2/TPDrP1qIdC7y6+o24o4RtbupJ8Y6/LZ5hzyAamtlZ5/DXKhuLwQB4njcjRyo8Jz8IDQuBRJxoo4NXzXzoOzQj0Fvm44uzXjFMTUR5/cUvQ==
Received: from smtpclient.apple (mr-asmtp-me-k8s.p00.prod.me.com [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id 19DB81800252
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 05:12:07 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Leticia Cruz <gustavolacastilo179@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Mon, 28 Jul 2025 22:11:54 -0700
Subject: No f
Message-Id: <C36F7E92-9A7F-4513-B2C5-738510A85376@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (22F76)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAzNyBTYWx0ZWRfX0kf1ygYt1Prt
 r3rD/CiuUwSpXeWdux3fCYlfUgpWlKcHfK6ZZXFyLht7I0Rg82U+NoMaeNQFNr+ft0EOOesjiau
 Y53arUz9zyVU9gWEepoq6uMDupALSZ2NRCBLKoRXZ0VT1lKYFOsEZijBbY2Z3Pr76nf/c9XjdF8
 UGrM2oz2HaTplyUZnAH6gbfZElC5WNJ3UkSx2PH6tuePdlVseqeATT+MG2WrHxZ6U3jHQL11QLN
 pu7nN1WXA07TdbCx+2EdiZTGwgQ1gBiL1fdOicy+XodCdkuq2L5aOoVh/Pd44afVGMAYzTCuM=
X-Proofpoint-GUID: bjS3kazn-fAfD_JeF1ChMb-Ok9tm6vsI
X-Proofpoint-ORIG-GUID: bjS3kazn-fAfD_JeF1ChMb-Ok9tm6vsI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxlogscore=503 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507290037


Enviado desde mi iPhone
