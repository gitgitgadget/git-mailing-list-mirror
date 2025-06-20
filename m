Received: from outbound.ci.icloud.com (p-east1-cluster6-host3-snip4-3.eps.apple.com [57.103.90.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D80B383
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 04:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.90.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750392074; cv=none; b=WhcI1IH1yPqWU/1sMAnC+XeranX0VUEm/sxpsD8ORMay8JLCJTQHF8gP+bqvI7APDDa7MRc32Z3dP1+M2DTATi6VvuG4jxXp/3h5ceGEM7froVNHb7suQCqgUcZFE4ZzE4CuA6mG2DmhX4jMOe2BH91oI7+PNrdzXK0kNH3rQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750392074; c=relaxed/simple;
	bh=Iw2Sz+7ab4j8EfQ2HRy5Y/deHoPXqRtYIYWvoxj1bAI=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=NSKzQeHjgOSIglfEeMWQbr/GIuPU+samlwJRSRnQtKvnsfDQjbotEuxHMtuuFTrKFAU1i7DFCcBe9ExK/JTF2J50HMP7IE/MvD+5hm+Wu3+z/hN+1aD8IafqDQMr8CHxvaU018iRG9HAiodD2D7es20kRiZfIxZ3MVjQt81208w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=oT5EWVNg; arc=none smtp.client-ip=57.103.90.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="oT5EWVNg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=Iw2Sz+7ab4j8EfQ2HRy5Y/deHoPXqRtYIYWvoxj1bAI=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
	b=oT5EWVNgqQdgKprN4OOFrnvEcnEfDwnVGkI99go/c72w2LA4acdfI8jvvRlLswONK
	 A90+ofUJKi2BUraDxOGYfdttW1mcA1b7LGUsMYPpEErBj7+K/thPSroxD2deeraJ/A
	 c2eSvbFc6eJ4tiB4GlijBM4oOaxUaUS51D297lpPHbY4E4DZvETslqm0c9/7VJRYv/
	 TU5WO48ekfCqGmPAcWaaRyjWENMEQLPAY+r9nDeqyj0ob896WwHDOEtmRVqnW3NOfe
	 PEuLvr9BiM7QI5usyEbt5j06eU0FG3J+qEAk0rr3dLl9eZNV1H70AE3re57t0V0SUa
	 HEWYgUiAj68ng==
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by outbound.ci.icloud.com (Postfix) with ESMTPS id 338B81800E76
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 04:01:11 +0000 (UTC)
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com [17.57.156.36])
	by outbound.ci.icloud.com (Postfix) with ESMTPSA id 258791801D72
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 04:01:10 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From: Rashed Alnaimat <rashed.alnaimat@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Fri, 20 Jun 2025 07:01:06 +0300
Subject: Off
Message-Id: <054B5366-9AFB-4360-BE29-E65419F45FB1@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (20C65)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDAyOCBTYWx0ZWRfX7uL9BuRq08ZT
 Kes78Fr9ttmUugZP2x+MvwMo/44vMhRLCTYX0mbeyJ93pM0uO0M0pYm+P2bKfHGzNKgDVBAdS3L
 dzIhTJbLulRR3qs0sG00rzBtJfPw4crHcw2rZRTwp2wc7Oxl6YK5huU4RfOEZ1CiKR67Wu6+qrq
 WZnYVVnJFQhE0k8IQlP7rokDxilE2C+I3oio1s50hoRb4x0KLN+BjdY/VCpcVS7PoTSVC8OXruU
 0C6nkUmqgOPPG6f4x+tjQvJt3i0QRb+xMMKjYgLsmP0QRFPqe0KkC2F3/QDClvrJ2guc0/kv0=
X-Proofpoint-GUID: 1zZQQUOCQQxvzbV5nzrpC4sve_0vX99s
X-Proofpoint-ORIG-GUID: 1zZQQUOCQQxvzbV5nzrpC4sve_0vX99s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_01,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 mlxlogscore=570 suspectscore=0
 mlxscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2506200028

DQoNCuKAq9ij2Y/Ysdiz2YTYqiDZhdmGINin2YTZgCBpUGhvbmXigKw=
