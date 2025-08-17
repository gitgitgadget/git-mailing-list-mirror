Received: from outbound.mr.icloud.com (p-west2-cluster1-host4-snip4-10.eps.apple.com [57.103.68.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E721F221264
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755423801; cv=none; b=bYTMdWo6T3meq5oc32itbtDAmTbJuvuOzUXDu2YEWJiHUrYdeMD1jJHOESGbzWCSKqk1ZwtlnqBn8PAedppJFjtBSYVAszSOlO1a59SQ3HJIloWhsd4+tFjBAYYzifKFO92plBSSqcMbihio2h6WqI2o7vLyUhqzF02xgVUzPnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755423801; c=relaxed/simple;
	bh=F54aLMfBI3BtSLkg9iqiSa0TMdrvj/iuispL5+bgyYw=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=Il+dgkckmW+vO9EoHenLWiL8Iv99IKUzMPIbChMSnV2kzltAvwL8ZIq7aOnXFe3Yru6jnx6t+gowWq0HCIsbl+6BBfOQ0ofC6kr6+Ts7775YiA8zqYiuVU9EY3BKyCK3MYYqSwftgqn2GqGHRmpXEdXv7cBnrx4U0+OqFa0beII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=HaQH3Gyz; arc=none smtp.client-ip=57.103.68.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="HaQH3Gyz"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id 7F016180017F;
	Sun, 17 Aug 2025 09:43:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=F54aLMfBI3BtSLkg9iqiSa0TMdrvj/iuispL5+bgyYw=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=HaQH3Gyz3qBxPn+DQCJoK6Ct5T8Zj2sGwFebYCycdFZeRHkhIOBXr3QsG7h07hbA4f3U7H1c/iqLXcnz9Ar2m2YU/Eijgee3C063+HSDrr/OYqi/72k8OBPB6CXVfy7TgRh3BNNlBATYMWA+Sw/dCqCj0gisI547+rPlc9mPQjHuGMrdtcs3fcudVKYTAxnz1nGGiVZHB6gyvD3HYQdOnIS2HybwnrpwSSCLWEuh6F26sQiGNXZkJ1kCVV4DfHHbT579uTZ75K3tagF+t6JWyjSwr9LzHMtx7EZP8/aReUkAGaghxSdfYNSkBR8W+PFlmjTuRElRImSu1V4FA+XvVw==
Received: from smtpclient.apple (mr-asmtp-me-k8s.p00.prod.me.com [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id A3D2B1800178;
	Sun, 17 Aug 2025 09:43:17 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From: Excluzive <abraham.993@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 17 Aug 2025 13:43:13 +0400
Subject: =?utf-8?B?0J4=?=
Message-Id: <5F3100F3-7AEA-4C33-B4EF-352678DCC61B@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (20H360)
X-Proofpoint-GUID: RVHCmHkR4kpIxfql5rPjcxpuChbB3wCB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDEwMCBTYWx0ZWRfX8Dg4qZl6g7kT
 eBkie0F9b7aD1qP4UzF4dWeNRe9fXBHucVZf/mQV6JdeL0bNgtZ0r2SDu+th1UJXklSjTw0CB47
 eN9Wki623FHQoMrLZqgucepZGcLHpxhVdz98WZ36g4QAl7y5gtjW0QCqtmLaNG2jYCpfwkbWw8C
 g0j7yrsJZszTd3BL3ZOIfVDI/FqntcRepxNRwGKE64kOCWzbz3FJDq1FjxRM8qf1doHov4J+vy+
 KTR+kGr7S8Xv/q/FOk3rYZXIyjmTV/YKzlWupNiRV0VwWQYF0MPKZ7Lkv5P8HYk46VtdIISqI=
X-Proofpoint-ORIG-GUID: RVHCmHkR4kpIxfql5rPjcxpuChbB3wCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-17_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 phishscore=0 suspectscore=0 mlxlogscore=672 bulkscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508170100

DQoNCtCe0YLQv9GA0LDQstC70LXQvdC+INGBIGlQaG9uZQ==
