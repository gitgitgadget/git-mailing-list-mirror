Received: from outbound.ci.icloud.com (p-east1-cluster2-host10-snip4-8.eps.apple.com [57.103.88.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF043FF1
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.88.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756035669; cv=none; b=HwEtYzuBCgcZSzq90ERfhfCqk4ceAXtO55gFwEwHoMxGgZESXL4L12S1GKqXPZxIy+F8FJRYmoJdK2Y/+CCh51MBjkKIwTOq7G8s1MJld3/e6i1I6VBfLwpWh8hHhg/PdtULHI5XxHOl/8ltMNaTYY1HupBo+CqDouH0L8op/Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756035669; c=relaxed/simple;
	bh=4ehOCB8d3LgT5wwVtZ8ipuqihjzHs13Sqa4+TB/F5RA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:Cc:To; b=DzVRI4kAT+SraPqZd5PbswWKnoP0MYe/1qS1wVEhv+m17rf6xuGN0SltRnAv4Mw7DBhAYeUkov6/ba1XzvBjbrmfNR8frDV7o7pcSWuchOHxnFCNBozz0o+dxKSLJt/QP+onSUHsYdibairRQTmA2jIsX+CQm+/9Bx5KSJJal7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=yZJJ9yWX; arc=none smtp.client-ip=57.103.88.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="yZJJ9yWX"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-7 (Postfix) with ESMTPS id 13D11180018B;
	Sun, 24 Aug 2025 11:41:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=4ehOCB8d3LgT5wwVtZ8ipuqihjzHs13Sqa4+TB/F5RA=; h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To:x-icloud-hme; b=yZJJ9yWXpeHQvKnvDI5TiO9lmL3h6cCD8Uk1HExU9igElSNUoHqiVNlhXV1avQ1yyBD3YzGz/Bl3wNje3jq/omLQpqfmxbGFB2OlONV5oqf0Y6zYK9P5wqesSDkoLKNLrhQN7OlDmexQX4E+ZrA7dkASX/xo2q3CcKrm4ONLocWWDa97qfcU1bhurw4X+r19qd51UkuTrnqeMizLOYYY1S6uXNNZcztm6xsPL2xjkXP3bT7TWbp72hLEDpnf9suSay8GvqyEtzKopyWfgEHIrTvn29Bv3IUgVZYw3L50DZAoxQH3s4WFcKUcEDI4quIUQpBb4sFto6/jmpcd8OpZzg==
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-7 (Postfix) with ESMTPSA id 7CE1B180009C;
	Sun, 24 Aug 2025 11:41:02 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ehtisham virk <ehtishamv123@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] git-diff: Introduce --index and deprecate --cached.
Date: Sun, 24 Aug 2025 16:40:59 +0500
Message-Id: <408AF8C9-50DB-43AC-8C12-F20A18AF9FDC@icloud.com>
Cc: ae@op5.se, git@vger.kernel.org, jakesteward0916@gmail.com, junkio@cox.net
To: svidrasevaldas5188@icloud.com
X-Mailer: iPhone Mail (22G90)
X-Proofpoint-ORIG-GUID: idYXMEIa5BmpaaFwiZvEkyEUMdMUCyzn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDExMiBTYWx0ZWRfX0Ob7XEa9nIGD
 Gnt6Qjj3w2HLM1D2MXKaXVlK120sxDmMGBty1msMxc554CRUv81M6l13C9BSWwlrZ2cPON/5i1n
 Um263ZxJ8DcJ1uJ1hdECCVPaGB7/dsGhqrOiETypA0KFapxi/e0SR7qpkL8hm2rZLKSiMKYi4G4
 3XSM29JbwDUa/DYRm4Qor/OGFSDGLEAMwLssi5jn/ycPv0BDFKB4Eb8KseQ/R8mlRHPx8kr/W4y
 ZGDzQTmH9cvmkZ18qGBoaBzyfWurkHSibOF/U1a6KXTr5MDwbkgqf03NlRRMUbCKm9tyTqPF0=
X-Proofpoint-GUID: idYXMEIa5BmpaaFwiZvEkyEUMdMUCyzn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-24_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 clxscore=1011 phishscore=0 mlxlogscore=542 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508240112
X-JNJ: AAAAAAABgXrtNW3NudroS3K5oXQnOLybIcgPqaB0AmoUIk2cig4Ns9iTg2hued0m7NqD7GieuXOuIcY4WRLj8TExeBqDzx+x+W8vSBk+9//1Ya1gdVDH/hyXDHr6BaLL+RrYuliF4JdR7Dv+NalZH4PuhTOlOwNPR3efURCgv0Cie8VfXwSR/Sey067R+SJ8ZvCUt6Zgg1HTOrhe7Zdvd9DaqvauBdYZsRgoyPKXMu+gfgJiDO67Klu/2yBoKaxMq3AqFUsZ8lDKPsuJgSqkUnt/Z8MHT6HtzO+k36JpELcHrD8+/LQlw++xKYvGuT6xGdhhPF6J7lAs9sZ+cnpl7cDv4dxiqbLyh1k0HZzE+F9F6SOAT3UKt63WoSfskdOiDCg+wI3L5IFb0Se3lhfGjyvutboo4cE/3CMm03GYWKtXds7D2Ob46UoK8i1LzlUjQj85LTkoLgRIKBx8glS2rtbmAzGr2plQIPEDOI06DMjzaQ9ENdc=
X-Apple-Category-Label: MjE5MjQ1MjQ2NTk6JGNhdGVnb3J5JF9QZXJzb25hbCw=


.
