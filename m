Received: from outbound.mr.icloud.com (mr-2002i-snip4-6.eps.apple.com [57.103.68.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813523E51FE
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790891742; cv=none; b=VSqsNFzjOY2nUkJoBHdPI/FsoSrq7TQElcf7tMDgY8+YR79FlxXCTxamCeULGBJhaA3veLRCfzeq1aslNOeUnHmgQ2Vkwp49JZ057HLyRUklfQOvp2aAOEf4iHoIQ/QdK2YaYh49TRF13d0bpbzR8VdMed4NJkSUe//VKW4rAGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790891742; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=R0PiLl+T+jvYxgOoo00kMGcIKU8f3JakfmguPEGESgUHuEBKnlTN2I768KDTLcjfYRhDIvSvZ0rBmbm1JD+v4QD2N5ncoh+o/pWZ/UsjWtK+bFF3kx8l0oj2nNbnNzjyihfdoTZ3uQgRqAt6fhMj4cg0ZcBlacJnXkzI6oLJgjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=0GeDTpwQ; arc=none smtp.client-ip=57.103.68.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="0GeDTpwQ"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPS id B240518000B9;
	Thu, 01 Oct 2026 21:55:38 +0000 (UTC)
X-ICL-RepId: 01a0f977-45d4-744c-b5a3-b58449ad3f69
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAUMCUxxBDUAdXABSEhVdRVkCUkVBAFwZQR4HXgJIeRFQAVgeVl5aF15NUQ8PGVoUXBhTRVEfVFhBDgpZEhhcFFxQWB5GElYNXQkZBkBeUBtfAkIPHBNWFRMdQxkPKwhKBEMHRQJeCyUTCVNWWxNVF0YJGQhdHRkVWgkKVwA2C0sEXQAvHzF6OwVAA1hxMhQ6AVRxRnNCAU9xLHVcCkIIO3MEVAddBV1WUAJaVRIEQAhWUF4IXh9MHA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1790891740; x=1793483740; bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=0GeDTpwQKX+bRR7sAi8XXIm2jo2suRIY2XJhkoKi4mMYZFBNUWD8EGQi+uPIG5ahrlWfyjMfh4JJ3hZAkFqkwaq1ugC5VqC0AoniX6cmQHtmTHhy8SOPACDHKh8rFEjm8G+7BKNwI6aDEj73XD3+8PDB6kAoWKgJY0Qmamz7eHpqBbidvAv5dTDmljRL/htx7stlwsdXJDnUIYlIc+LmMtB015W1+j1/O32MvfexcOUopgMi9wcvrfyBi1oyDLKPzgSwX3iOFkWkxT0BnI83z6N7VwGrfiTC0wqtA57/UJnB/10x3QgDI1n0GW56vA8d2TSfpiMEnsH76uc3zEUYTQ==
Received: from smtpclient.apple (unknown [17.156.200.36])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPSA id 9EC0018000A2;
	Thu, 01 Oct 2026 21:55:37 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: joe.spears0508@icloud.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Thu, 1 Oct 2026 16:55:21 -0500
Subject: Who are you
Message-Id: <2F23707D-ACC6-43CB-B29F-A287BAB7821C@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (23G71)
X-Proofpoint-ORIG-GUID: Dgdeq0scjzM9QXcNk2lgEcaQ7-myrchn
X-Authority-Info-Out: v=2.4 cv=KIlXzVFo c=1 sm=1 tr=0 ts=6abed6da
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=SQPV6zAvII0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tclcd6dtLQvEqt9_mmAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Dgdeq0scjzM9QXcNk2lgEcaQ7-myrchn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4NyBTYWx0ZWRfX1jLwq3W4FadW
 bowuKJdVTd19huOP0Y4U/14XBoqXjWYPYDEnWgMOwZAkVbY5oFYDeoaERBjTorpqsWU/WrzTOBU
 scaW002zDGAQD47hqO34LmEe1DjNvwyf6N48ZXJJw0j/VHNw1PYGYjftHyihMlKdjr1ZuF15npl
 k+R1j/5HcohbaGV/0CjMWr3ZPJNPg1zoeUswZ+6ydiQAelorgjJFV4cjnm68qvfnEGBk8hxkQRa
 7K8x8YumUf2K6GfpiarIIqAM7ZyAfvS5POxN6ioYcnMhGsisMRjFwuSTBBTBUMqmItusCBr8TfL
 mSSiPK2WFyuadB9La8YeGGfTut2f1CPC9FBBtRqZ/Zn25n+KzCi63D0J4S58sQ=
X-JNJ: AAAAAAABb5IzCpt5Y1A8bta5MtzSzNjJTbU6KDWJ+x3gZQ8tgVzsdj+w7oxDpUZi0m3tgE
 asqMwDiOug1nIQ+EvxrT431NQfZcHuLpyrOhwtiEWztjvgZgCn8Zb4vlGqDfXUNNjoYDwG
 58iPuv93eLzinUPSV484oTianWgeTj69bKwsQN3G88MFzARcvMxXKLJpiJp/XkOhLFQhJH
 3Wybn0X2VXBxmpd82F/4ZRSwkeEv6erSPc9D8ltBg3U60oK496fcc1INkKvwEWDn8rvl2u
 45wjRdo7NX5pCaSNqYqO7yhQbdVLNuwlO8ohOOL03uQf4INOL1n679uojq76PPvzozbpiY
 4M5R7iePC2visN05MKwIAIQWgZeg+4HnXhk/tvGqUdnn1x9KlTzz7e+hiyvz7Lhd9zyHYD
 4aE8rK9PeXPUA5ac6w6F+UmWRGH0llXpcQCRkPZfZdQEJ2LIkhOgA2RbApl3ObTrzdtZi/
 3p5/qYq+al2IcAZds6H4FG/Q9f5mXiQueg0SXbi0gnXWrHdWkPIbZURy21szMFaeX5brtk
 fAuZl6bBDq05qI9Sfk3yd6ME/Ri145lebU6AZPx/dhzdeTUaBrxx3aZUscFOKBKP0ZktGZ
 DzmJ6KZr7DYQEmBXH0hbWzO06x7X1E+owyidwSaU4jB+UplhoumqdMmWdtuwetzgS/jJyw
 kVMbnJXnXuWQUZCTThxVrq8vXBkgWUUhxZHHBjcltBzzl1p7zn6jZWSHr5mP34f3hSaYwh
 nEiNpm1mf+iCnnsxPTfxrnq+peJoZGrgSeTvxt9FI+3TSysi0EB78xRaCWS6OJE1ucoINv
 aZjWOm5/T9De2eDsp5HhpfkSlZM51PLdb4/pxzeyvi4k2Z76D+Q3MHISAWkEFbj+GfeHip
 eUxiwELuyNhGJoY2APUlIbahpJXn2xDMLQ9+hOWsnF+hRYxIoJ2vFkwpmlR87gNbD/DQV7
 0dGocBJZZUMwLKDvc3ZhO99EflN30IJVpWo5ySor2Q9OQgbkykNpQP4whbCj5zXz2oO05I
 8UKMlFIibQuZtEcddmOvRo4u0PnTYjLBojcRu/NbAyv/idO495EYf56QZtD9+tReSFgZwD
 Ct1RTSWESWBtfOxUz80i5N8ZBX3rTQHRklGbWJPL7xYgAhKnnChZlqYQqe9Cd7kvPGm2Wo
 7OipUgSNHB
X-Apple-Category-Label: MTkxMzMxNjA5MTY6JGNhdGVnb3J5JF9QZXJzb25hbCw=


