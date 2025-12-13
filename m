Received: from outbound.qs.icloud.com (p-east3-cluster6-host4-snip4-10.eps.apple.com [57.103.85.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456DE381C4
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.85.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765644580; cv=none; b=La2x+DzMS58TziC1ms5c2UkFcC7n91PciI1FzkDwK2W467iF+nJVnBnwZQImcOrWGolPuPt/lr65yEIxcG/ssKYvU/NzCQq2Sod17JJ7RHpuZvgfcnoPIYTl7U20X483vEa1osde/9787dvBEJ029aQny4Q0h41jRBik1S48mwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765644580; c=relaxed/simple;
	bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:Cc:To; b=EJccnBQ7XzO96nVtQQLAgAWmYZOWTEsjxLSlGyOWutty2aGQcbSKbDTFrmgyAydAWSCAIFCEUwNWa92pmEOjgVkWFHsxsFNmLdwQGE2kghZRNYQ5h4a3oV8qaaV5+/9CerxZV7+eanOVyDMBX0OSVI2zi9XNmF9of4LT7AXS3PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tUOVKTDu; arc=none smtp.client-ip=57.103.85.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tUOVKTDu"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id 31F061800ABC;
	Sat, 13 Dec 2025 16:49:37 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=; h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To:x-icloud-hme; b=tUOVKTDuWcVnK0Qm2zgEOBEvLyIFHyzh84IgD9CWrTdWZMczJGBKYQUEvcuX/mfnfETORhy1Hcz0b5vkVdreLS19AHAGOPMGvHoZFa5/bwuNW7AN47zuLNcAUHDqae98JigcRfn4wBv0vq5AdP2akelGKm4bIiaa1Zt/KWeVaxvWHxLefNyFrR2I8QndfYSQU/ctkn9LBAB1LNB+iY0u2vus/QMUcCHkSsMBAZFYMTVuArb6+OC+IGakkM08ddc+KnTRBg/5a3zBxDzCwCVw2z66iLTlN/kS9KAO2Qq/j2pAGCAIbDV/LedD1MrZE8rzHpqTSZaFwSbx9OyBosPNYg==
Received: from smtpclient.apple (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id 7B8B41800AAF;
	Sat, 13 Dec 2025 16:49:36 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: AsAAd Chaudhry DUBAI <chdxb111@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: git-scm.com is now a static website
Date: Sat, 13 Dec 2025 20:49:22 +0400
Message-Id: <0573980B-5BE0-43C3-BDEE-DCB436C058BC@icloud.com>
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org, j6t@kdbg.org,
 kaartic.sivaraam@gmail.com, me@ttaylorr.com, mha1993@live.de,
 spraints@gmail.com, tmz@pobox.com, toon@iotcl.com, vdye@github.com
To: schacon@gmail.com
X-Mailer: iPhone Mail (19H394)
X-Proofpoint-GUID: xw2SLpT1W2-VdBbC6c1wxHxShSFCdxl3
X-Authority-Info: v=2.4 cv=Ztbg6t7G c=1 sm=1 tr=0 ts=693d9921 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=anyJmfQTAAAA:8
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=f7IdgyKtn90A:10 a=x7bEGLp0ZPQA:10
 a=SSrLRztwqlQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=TV1IOb7fWT0oFmjsXdMA:9
 a=CjuIK1q_8ugA:10 a=w392Uo6aq9xxqwIJir1m:22 a=wpv8m4_C0Z5Ld_xxCu6H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDE0OSBTYWx0ZWRfX3gFCjDOeIjVk
 OJyHy+97SowJn+mtnpGkLVxp1ANGBXmrzqCiTWeoRYyVSSzNYoEVQTwHHqYT0cE6cFdmsf/B69w
 gk6rDbqbr5PQBkzaSznZMwTNXO27cSAlFMC2zKJoDAL5xyLvG1jV9hqam0YD31peAyKBnkCaC71
 0CboNRRw7BzszRNrX0WdDLwALYccbf2D04eabOVQqsDR5HIo6jv61roEJ+H4cqaGx/Jj1dkByVv
 2YVm2TmUPfIn8z6lVsXorvWH4uO9uyiNKbCcE/k1fJYumH4HIA7oJkjNz7R04Bl4QwYT/zuzELy
 rgec3CdAaxdci9TovPx
X-Proofpoint-ORIG-GUID: xw2SLpT1W2-VdBbC6c1wxHxShSFCdxl3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-13_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=615 clxscore=1011 phishscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512130149
X-JNJ: AAAAAAABOJaW7mJvL8KY06HmNOw1Q3wErkCF+nW1SBFr5WqoQeYjwup1+2t1bzy4MoUvUstWum3hcy6cgy5B3/LumwquUKwhD3SEJmBWsTs3r8WNikWyfoE2PSdG0ZtYaPbGlk+7TtgdH8CtaFkXWWNlkdUvgc8dGtQESMLpmtV7my/Z4TiIFhWRPRtVImUlebXRVRRAdMVqHKrrZ//hjx5Gv1apPxsbCFczJGTx4I1YZ5DZF0fZQ5Xz2TPLfMJ65j9MDa10edHhrK+1ouduR5yyXMYIq82zv0NSwr5k2D1eKD4p/kb8EkMT/OiYkzkRox+2md8T8AvBZ7vdowrufzl7lmLkBcq3PL/7F6oDcbD414qvWR0koI4zzOMNfrcLbEyZl1gERe+GVvjos1UyhfpxX15v4tBbhjJq+TYTsH3AhjNAd84iajqloeORUNDqYLkGfJYlTfMZg8RU8cBnoDfXPQzx/vhjOp4l0ZpAAW2RCK/ATdYn1oziD58Myq/StNe1my4zsw/lyD3HVfmhpl4xNwxPHtK+36zAdurhfjYOvcb39aHCJ1DaY0Hoy0o/8Yrp4kh3HGoi9Syz1HJCoc3B/x3v4I7jWqYpEs9AbTTvqOiOu+TAipSNDEAAmCzQv3LPR63HBbNjopFknf0jjbFimpii9fxy+vttxta54tThqZdPq34Ev6JhAmjm6tnahjAk/3EHkwYTpEQT+Im1GNcgjMwO7ghHIqd9LsxDmtt3ZDQ2MoLqhu8YzOnJ0yC6RoQSdErGJN+/wgF3LWz896+l
X-Apple-Category-Label: MjI2ODYwMDM3Nzk6JGNhdGVnb3J5JF9QZXJzb25hbCw=



Sent from my iPhone

