Received: from ci74p00im-qukt09090101.me.com (ci74p00im-qukt09090101.me.com [17.57.156.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE1A1C3047
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058600; cv=none; b=AAvzuD/yivCPEYmQR7jmajcjYcu/MCoDE+hqTd/qgb/9vz1HNYr/qjjgXDBRI2/y2D3KaecVEK8zfibQquHQDTo/jUgw85uIjGZv/Ieu+i46XoGkYjwAxR1AFuI26X1jmqOc2tObIMiNbScVHrMJ0cty48x1uzMLjPJM2eMz5TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058600; c=relaxed/simple;
	bh=5aI7TFzE3cDJbxZvzDshjCIQRkvsyPkVpc378I1ZiK8=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=dnUJB5RZm/7aCIMHx5oF6PJ/3u9bEERgXgN8Xr4UeRG4WqZO+GHlvaBRZccJks+JvGUVxtFdW0y9yiDrW2xStptkT+k4u3TdK30hV5At12t1CtMVJixh03zbxsnuyq9xX/OLji/6mX2sPo91w5oSq4I5Y6A67bNBKI0GWCzXNBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=K4vq4XHp; arc=none smtp.client-ip=17.57.156.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="K4vq4XHp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1728058597;
	bh=5aI7TFzE3cDJbxZvzDshjCIQRkvsyPkVpc378I1ZiK8=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=K4vq4XHpbzlj5ZtBs8hSQ1zeFB1MYacGK6PI5T62gtFFCS4giAnu5cmLfRmCkEyMq
	 0MViX7dLSEpqEzqaAiSidnzhB2OCTcYn9B3D2YlyqPfsfgVnHBXDF9cE2OUektaRSc
	 JEnlpjwwMkE3liOhWyZodzPWhqcLnFITWD6gt2wZum2UQgHIRwvrASPgPgIGyxtSh4
	 lrWiF3a0GUg4DbWvhp88t7zPg3dAFE5UqwOBq055kVoJtbj1BdvC7CLYeZpG8bEk9I
	 8u7yhmGZfOxqyYsI/bpSwbqFRxZ+taRJf9CEH/r1rNhIZO5W56EytJ00aC9EYzXY4w
	 uHozViRwYJT7g==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09090101.me.com (Postfix) with ESMTPSA id DAB3A35C0465
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 16:16:35 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Segun Fashina <fashinasegun08@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Fri, 4 Oct 2024 17:16:21 +0100
Subject: Outreachy 
Message-Id: <84515516-2468-4821-90D2-36BACE00151C@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (20A380)
X-Proofpoint-GUID: pp1ll_E4v4wws4vAt1p9ZCQyplHtXe6V
X-Proofpoint-ORIG-GUID: pp1ll_E4v4wws4vAt1p9ZCQyplHtXe6V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_13,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1031
 spamscore=0 mlxlogscore=511 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410040113

Hello team,

I'm Fashina Segun Kazeem. I'm thrilled to be working on migrating our unit t=
ests to the Clar testing framework. Currently, I'm dedicating time to thorou=
ghly understand the requirements and familiarize myself with the necessary r=
esources.


Best regards,
Fashina Segun Kazeem


Sent from my iPhone=
