Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A6612B177
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674855; cv=none; b=gYL8kaNzO1ZzGw2xiiEEi7Ip6QGdmTje7z7cGLvrGGhQlioBapIFNEkpthyt7KTx4xCPaO/C7tst5x0Ry4zdHT/JISRNAKRUaBRL50niapYJ2yg16r3o3/PEBIucpwVIKhazoq7PhtsqzTiGCJh9gvEqbnHuZ/TsOThV4xcj9KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674855; c=relaxed/simple;
	bh=dQUdIoy+HH5JD7K3B0VaqZ7OwORPy6apwetPoqJtGIw=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=GX7OfdLreHpNcDv0iizWwUTgaaOT2W1DuRWZLop38ZFqw1TljQ0XLtZ9F+VTIQngYF5slrdqJ7nfqwFgikoRnJrn0pT4hvh4OrzhcBlYbInp5gVashVFSsN6PgDrfpNbUl+AZwVkD3JWrgnDDhq3s5nwbcTL9I+lF2d+0RCXO6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=dkD9hkl6; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="dkD9hkl6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1709674853;
	bh=dQUdIoy+HH5JD7K3B0VaqZ7OwORPy6apwetPoqJtGIw=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=dkD9hkl6X4xMgsmAWBCJO/WqlY2TZy96YfD0E3j/8x1bDpkQR3sISSl32ZdI3M5V7
	 yxsyJA90waIaiYawnuWRrjsXhknypunSxLDnnKRGtUeaoC7fYuwZcPi4spiarOhUPD
	 mezXUR6Ccua51dDxc0xcZxVf8BpayDI0ifAy39Ahf0S0YvY7663rcfyNEig8idGx0G
	 CPI0YalbZUQOccDq+8QMtRl40tTNU+Qye87uukwrMn5RkkrEKkpVjFAnAPOdvsCGT0
	 0zIPKvSB/tZonkOKvGp2+2CHWDRuTNknUjoB1C8/EWkPRZ58fKry3bF6B+yMkClCT/
	 NBRWelyqQ3Qlw==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id B470EC801EF
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:40:52 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Rifani mei <m4ichen@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Wed, 6 Mar 2024 04:40:42 +0700
Subject: git
Message-Id: <019C937A-8ABF-4D58-9662-5816D01B3D4A@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (20H307)
X-Proofpoint-GUID: jvtdKriZzrgYwvCz3Irf8GH2K7ygVYZb
X-Proofpoint-ORIG-GUID: jvtdKriZzrgYwvCz3Irf8GH2K7ygVYZb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_18,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 mlxlogscore=402 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2403050174



Dikirim dari iPhone saya
