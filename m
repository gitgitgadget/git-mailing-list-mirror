Received: from outbound.qs.icloud.com (p-east3-cluster3-host6-snip4-10.eps.apple.com [57.103.86.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107D922097
	for <git@vger.kernel.org>; Thu, 25 Dec 2025 00:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.86.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766620886; cv=none; b=tNl9MdAsWlFia7n25j1HwRJdA5UO/eNj4y13O/KIKMnYqCXGK69DwwY4C6u5eYE3PeF2Q/RUVCHOEHGd0XVsDONT1Mj5PZdAM2Td49gik7JsK+saYn9prbtD+IRh9DleR4pCti1xsSm1CL+ZSUZgnVeu9TaPwKM4O5BWp4bnOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766620886; c=relaxed/simple;
	bh=rbl8LDAWiDfrlCVApSzBqFA7hPa154zO+DvlaCIUcok=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=kY95ApytH4ZGXJcMRel7/W/sweHxPLnNWMzinwlPNQopoowz81UeIi26igkgEW3BE0X/VRWj8it1DlVV9hpdsoDw/myIL/F+DhRMnyuxK3K2NPtCnjKFsgkcK6iLyMPZZwTKuoUWpO8lOd8HXa2cJ8T6ZBHlKsw+lbU3SKwILuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Q1H+rAml; arc=none smtp.client-ip=57.103.86.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Q1H+rAml"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-11 (Postfix) with ESMTPS id 315F71800141
	for <git@vger.kernel.org>; Thu, 25 Dec 2025 00:01:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=rbl8LDAWiDfrlCVApSzBqFA7hPa154zO+DvlaCIUcok=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=Q1H+rAml8BNKeLAPoNsciC0mEF/2BNNqIrSuGjatEdi0EtAb6K1v/CADGmntk7f2wKVDXF34/ns2/2GYZhrtNrqbujkHqj/IfPjH0klR4xZDu4YFZ0TPlXub7NTPYOJAhu3Yb+lHhU1Wd2azCKIj9L2L3Aj7xiq1fkkIx/U8m/858hpg+KY7hAqBsxlxsGCEy33WJUPO/pohTSnbHQshVGxzFP2ipmLz5CJTTPGfcnzNTkzMKvMfavSWuxFT2gaTBq8AWdWYKlj65my5JbnwDDywF0T0ry02LxEYTBNyfkFXATa2WhBRpBunUJmySDyxq6+FizzTKx11zt7C8zYmfQ==
Received: from smtpclient.apple (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-11 (Postfix) with ESMTPSA id 52A761800164
	for <git@vger.kernel.org>; Thu, 25 Dec 2025 00:01:22 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: austinimei33@icloud.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Wed, 24 Dec 2025 16:00:50 -0800
Subject: I'm being hacked 
Message-Id: <F3FABEE9-9387-44EC-8A0F-938367B5D05E@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (23C55)
X-Authority-Info: v=2.4 cv=APDnIYrM c=1 sm=1 tr=0 ts=694c7ed3 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=x7bEGLp0ZPQA:10 a=5boR-pOWHtsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HjUR6Urv2rj5MffzQoQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: jBkgHr7FYAD_ZQQoFsJz00tlEa9C9BqK
X-Proofpoint-GUID: jBkgHr7FYAD_ZQQoFsJz00tlEa9C9BqK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDIxNyBTYWx0ZWRfX1Cj8XERo/3gP
 xcHtDDQI0512hQbpb6oKKpnZlMbjosTlAqAoIq0at8PYuU+JSPWXesrNdrxWU273okD1sn+X5z0
 vNa5/DXu/u1etLUqx1IiUSKQlGzCIU4sQwmffz0ZZyiD7IiDGsae/0RhHh0Vwx+oWW9CKSNlA3i
 d764fNFXHc4Lw7Md9QX4PLzxps6VwnvmfUjSTegS5LadOp//8TbkVxk/Ty05bryk2Md+m09qQ8B
 H30B9YHs+LZ3nNoIU9XktDKrqQ1Ve67tmaWH3Q7GlDjp7WQapuuP+xuCOc1NkUKEhyLRnwKScJk
 SMabcK7qwpbVBTnDClx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 spamscore=0 mlxlogscore=501 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512240217
X-JNJ: AAAAAAABUVWGYvZK6HJawzlIvxAwiEoK3WnZspuoNFNfzM7DiW+tqcvunF3NE2gGOFO/GU1eQbhDwq50pI/1/Pig/gZnnQ6CbdiFBfc3f8q34KAMOh5O7s+kJWBGBUWUJX3pMVpKtObkcSl42nskQDFothiaibaEliVmWli8RJd/KAV5th3BSUiLIf6uINGLrZj8nvv5Z2CEN193XTiyK99DT3mUw/MQL6DIvRk6/lh1owpjsJD3N1wOsVgZ4XDaghG4CXD+2XhFk9QGJufulqA25SnOxFPnn/p8yUe6IMVTLciDIa7eMWg2dqwwv1eEIcsJbbCBzh1mkPu41gr+fyPXXS5aVJEfm0y+ckNKJ+8NaicwTHGjJDiEIVos31KmBFBOHgsBZa4slFKVdGML1LGa4cybEoiEAmcAoJS4VqSBRvLDV1fFfOWIq6U+0se2MlrocKopLFuIqK9Gx2kS9FZJq9AwdUc72cE4KEaw471m788ZfmfG4cvxzePOVWfkCKX/GMp7NbCf54tPYLGrvBfilQLXEMS2KZgyTAJTG7aGwS4DNlXvrnH1ZOunaxkzC9YGLzB9kbr4P+8Skg==

I'm being monotred illegally
