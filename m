Received: from outbound.qs.icloud.com (p-east3-cluster4-host5-snip4-8.eps.apple.com [57.103.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7620459A
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.84.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755372266; cv=none; b=Kj+672rqXU/+IdyNV57X/d60NY7hU0QhprezpNRU2oqQKlh17MKSaVpuLgn+VpGig0XwujzILX+2jO4XTTRLqSCX073SsKwvxJMt6XnRTAXz7nfMusqk0usqr9Rx8mVA24gl6zyafXyZhNW+M8GdPH6nODiYbDi6UPXumycqu9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755372266; c=relaxed/simple;
	bh=RK12q3FISP7/PU21DDIWZJRDsOH4Qf50paLrP9I3qUA=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=FIgdaABdv6HOgTNCb+wU+DeabMBJJHRfSrh8x+9wxCCuM2f+SxjyDxoUKBEsm0u4kgby1A8Oqj2aXRC/cfktsGJJpeDVkbpikxnyWQfjcBqdacUUkK8hbw3pJYJuVua+5rtPsddhMIzmZuDQm/9/G+SvWdiVYzIKXQktwspKRNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=XOx7kTX2; arc=none smtp.client-ip=57.103.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="XOx7kTX2"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id EEE1618000B5
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 19:24:21 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=RK12q3FISP7/PU21DDIWZJRDsOH4Qf50paLrP9I3qUA=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=XOx7kTX2dMpAWuXnD9QOhfZTou1NA3GJ85sbuELKRab50xfHbS12aT/xyrk7toCNxrS2AHWOQ91QFcdqP7EL9bcC3buDvQBcGF2Fz1vo4l6oWyg+djyKTXe3ytmqs0LUuj/0jiNWe45/qvf16Rt1GrrVFl3wYDt4supP+nIkSqghJ0CbsH3VpXsaSEuXod85C/90adzV0zn3uXYGMxWyhEWHRkexk9HvYON4SIEP2+Qq+aQakIktyeLXBzdd7joO1vAYNnXQk4HmxUYZY6c41c7LJWZ+XaMJVGSLt0DOTTjbqZx4WteajwdZiUT5si606Xqp024p8TyWBR2w1l/6HA==
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id 49800180014B
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 19:24:20 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From: Bassam turkry <xbassam9@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sat, 16 Aug 2025 22:08:11 +0300
Subject: =?utf-8?B?2LrZiti62YHZig==?=
Message-Id: <39EDEE2D-31D9-4D6A-92F9-D55432650257@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPad Mail (21G101)
X-Proofpoint-ORIG-GUID: eKROqKpW0uvlvV6NV07906wlqaUtX_dL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDE5OSBTYWx0ZWRfX2+MbxBDxICuh
 K/XjQG945oGvzo1vvOLCBpfJPGieecX/oDaHEXqbc9pnhttMijEblSjzh5JX6oaMmDvBwSyk4uG
 BVHP5OqQxyVOoEsGJVXdP4Vf4rw+i0Pf03QrSTg7RDk1XQ5VpACnv0pLYZYzu/soPKkLSn1kAeh
 iP3Smu2cd1pCM6bcFDNyj9qki+3Cfpy8wdSSNnVbMZw5FEASVfS71UDsZ6ZUFiVTPlKT6TyBC0g
 CIJUR83NfdcFn0Ed9Cfh4FNQs2HbsDcUcm31fCaUsAXjfQcLjLnw6G4CZuHvyTaoJD2tUq5ow=
X-Proofpoint-GUID: eKROqKpW0uvlvV6NV07906wlqaUtX_dL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 mlxlogscore=511 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508160199

DQrigKvYo9mP2LHYs9mE2Kog2YXZhiDYp9mE2YAgaVBhZOKArNio2LnZgdmK2LnZgdmB2LrZig==
