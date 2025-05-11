Received: from outbound.st.icloud.com (p-east2-cluster1-host3-snip4-7.eps.apple.com [57.103.76.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1BC1C69D
	for <git@vger.kernel.org>; Sun, 11 May 2025 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746986659; cv=none; b=I/2KWrtg6E8e+8V4FXDY55/EnOyRIbL6v5QFQJ/WpKGEO1txKB+mZOqZl1+jMbs6HpkhbgYjAKtvZpdaCAtV8hZ89jwJViX0FndfZ4/0ixLZb7lzJvBG51M5fFT4Agcq40Z4gMd2hJQOGXIoWGwdfzacJnt+jhp9OMoWx9r6FwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746986659; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=I7Xei8SAdubGL+6bAYxbberDzRqcijyahKyLXYFNQU6nqmSBN1cFGMBhAA5XVFsUMJ636VfTsKer3Pwgu4jr9+lMxhKjm93JSmYlGP0sT1HIFZxp07Jec8pslaDERF8HbcM6lucPXMxKLSmGZOVKF7N28vBgD4nlv7yp0th6Y80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=WfpqPeVj; arc=none smtp.client-ip=57.103.76.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="WfpqPeVj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
	b=WfpqPeVjqS9Vg27ypEg/AabJLBj25GI5pwytRE/kZjMETCVutu27tawFnfXzjR9qw
	 JtKBkRPzcS7cxrbHNnm17TFzvdJ8Hi9RJApvwCpKGPVnLSLTurg+u9b/AzSopo/GaO
	 b0hFTGIL1gybqvm6FDyoF29CKP7TCtdXWyZWtpzw4W742huEPMPH1cp0/NIi76VWhN
	 II64nJtRMBnH3vUMPacB6/568wfhWL8vXzXrMOZwfR6GVppaioJT71NEi2WjxHEA73
	 9QzU7nI2nAamCz1ki6E0uBY/Zb+yYNLKuhdR9ko9BozWdqFJGdU0Pwcl8VQ5i9Szuq
	 HHliE9/K4Zjhw==
Received: from smtpclient.apple (unknown [17.42.251.67])
	by outbound.st.icloud.com (Postfix) with ESMTPSA id B3C2A1803C13;
	Sun, 11 May 2025 18:04:12 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: OryAkerbay@icloud.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 11 May 2025 14:03:56 -0400
Subject: Re: [External] git keeps recreating packs, exploding backup increments
Message-Id: <4491D94E-380C-4B13-B4F2-D08FDD30BC3E@icloud.com>
Cc: git@vger.kernel.org, hanyang.tony@bytedance.com, ps@pks.im
To: ossman@cendio.se
X-Mailer: iPhone Mail (22E5216h)
X-Proofpoint-ORIG-GUID: Llj6GulieJRHacF7Lg84hY5RR7JaG1cQ
X-Proofpoint-GUID: Llj6GulieJRHacF7Lg84hY5RR7JaG1cQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 mlxlogscore=765 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503310001 definitions=main-2505110190


Sent from my iPhone
