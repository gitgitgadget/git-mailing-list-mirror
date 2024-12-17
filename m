Received: from pv50p00im-zteg10021301.me.com (pv50p00im-zteg10021301.me.com [17.58.6.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0811B95B
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734397453; cv=none; b=ZSNiuDiJQkXt66szTt9Rp2/0PcWAMKLeMF/2Fdrsvstv3Yeh46fHcwaWkeO2yNVsZEsIL3W7aIFirW7wy7OBihhGFkzMezhra+z9M4A4Xv0d5yy+r7cka9jz56ahTZa3d1ZFsneTN0u8xGNJWlA90GkEG1DPWvqoWOdamAMWHcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734397453; c=relaxed/simple;
	bh=BxHwjCABiI3nlcGkkw8QZso2Q1DLLzU+Fh8dCZaZLPU=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=YUs+CKOBSG/nP/RitPo39fBPQAZVXU39hHYuWVepsBijHUvAv2pl+jCBE37+UP0VqXjWChknLsDBu3DT6KG98z4zI9Py6IN/RzIUFF5scl1h3lsDQFtbrzmhRt0PHzTQ6OB7IoGXbPPhz/OdzDRRw1jrfGON1hVRLBOkopHtd7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=uAS+a8ZP; arc=none smtp.client-ip=17.58.6.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="uAS+a8ZP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734397452;
	bh=BxHwjCABiI3nlcGkkw8QZso2Q1DLLzU+Fh8dCZaZLPU=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:
	 x-icloud-hme;
	b=uAS+a8ZPbcZHMRneWOVccE6O3sWzT3QHf9f8YbDU4WuMUpRQ0bBbbBCb5+pzDdRO7
	 fNaxwsZHalPEhQ2gRXa3sG1R9hzj+7w6cm4KRNDKia9kcZQyLDEQXwGz0ZY/qlF/NM
	 T56w4gy2Q06O1DqxFRuGKgQyMk50kJNEt0KZdnQeS/uMkpiS1WptC/GaeGXv9HwhkY
	 NalVm2/37l/uCfNFTX6M71LISlFbYU5Q+nehskszAbTyHnGjXg3hDuv6j0dZI6Py24
	 kFhpMtomJ4urz0SkgnbiyzkN5vTnGhUFtLNS8q/NxLBSPlhFMZTimPXJqWOiL0+4vB
	 YbJMBCo8Yzc5g==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id 62BEE5001E5
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:04:09 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: =?utf-8?Q?Ph=E1=BA=A1m_Duy?= <duypham.nt6@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Tue, 17 Dec 2024 08:03:55 +0700
Subject: C
Message-Id: <B8063C78-BD88-45FD-8387-D1E67421D052@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (21G93)
X-Proofpoint-ORIG-GUID: F6VX3g7DGdi89eqHYviTTlemXrBbNmsm
X-Proofpoint-GUID: F6VX3g7DGdi89eqHYviTTlemXrBbNmsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_10,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1011
 mlxlogscore=449 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2412170007


=C4=90=C6=B0=E1=BB=A3c g=E1=BB=ADi t=E1=BB=AB iPhone c=E1=BB=A7a t=C3=B4i=
