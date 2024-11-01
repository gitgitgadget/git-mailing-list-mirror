Received: from qs51p00im-qukt01072102.me.com (qs51p00im-qukt01072102.me.com [17.57.155.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749D11A08C5
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468602; cv=none; b=P2WTkMdGpq20s4nyv2VVOR0lh2pLTb8vtluWgIrwbd00MWOzt/2OhnclivqaZggpL4jKSOQSHhvgSuEtQ0nqjrmc+aH6beV2qtMqO6NoTgtaeCifzqktPn8X1LdMJpr/vNQND+ilggMDmJalOP75DXK+t66pFf+qr/P6F4iwOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468602; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=FfMpmPwZmKOJdiUPiGoWPQvMwXpP/s6PIqygtewhamlaZwh9PL/hPT/qxZOMRf2pMLmlwaorbpbSeu7Y7wXEIRAXtSGaewkA5sZWCVjAntwxubA3XVf6tJ228WF6Q+FLHFnqdqAxM/2WZY0QIiLWa9BRaIPcl9hWSPXFTgB1Z+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=u3wO7yU+; arc=none smtp.client-ip=17.57.155.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="u3wO7yU+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730468599;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:
	 x-icloud-hme;
	b=u3wO7yU+Kqy7+PYRs3xMZnkSo97Vr38NB4k9Zzv9MI0lrZKm/8UVlKp3WMfOU14TS
	 6p750IakSjZYEZLBugedZuBvBOPOSU53QL7TYSfQcr3bgqiRRTaOS4X05zMn1gKsTr
	 J00O3kOPDaLKiy/s0HO82oNEsVq8jOheITmFNi0DnoY6cobWN6cI5aE33diJ7ELpPM
	 zboGVfZLSqKsSCfeBAPQpsmSVxuBPao8lyykpDqQnwCWoQxYdyAjqXtqC6BhsfJmDv
	 AcTmp2GaCcN/P2yti2ZLLy3F5uTCLrPbBDi1OjiXyEoCXhxDBJ+KmC8XLypNmLr7VH
	 tRzYxvX/KZ9+Q==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072102.me.com (Postfix) with ESMTPSA id 8BAFE3401CB
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 13:43:18 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Mohammed Favas <m_favas1@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Fri, 1 Nov 2024 17:42:45 +0400
Subject: You do not need to subscribe: you will be Cc'd in replies. Please keep the Cc list intact when replying (use "Reply to all"). Greylisting may delay your first post for a few hours. Note also that the list only accepts plain-text email; please disable HTML in your outgoing messages
Message-Id: <5FF28FCA-E8C6-45C7-9F61-3C576C6A38D4@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (21H16)
X-Proofpoint-ORIG-GUID: ujX_aRAk3RnorI3WC6gK94Jpr3TKKbAR
X-Proofpoint-GUID: ujX_aRAk3RnorI3WC6gK94Jpr3TKKbAR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_08,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 clxscore=1011 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=719 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411010099


Sent from my iPhone
