Received: from outbound.pv.icloud.com (pv-2006k-snip4-6.eps.apple.com [57.103.67.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E681D86FF
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 02:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776909697; cv=none; b=pQBrNxPbn5ta7yBICM28kGcLKde7TgHpVWErmZk4dth7f+/wRlJ2IS9f1fn6wOVOVJiruePSgRHVe02RR7+0h2koy88QXfyxk4f7X3okyK4CEtnQExdZukoelfncONWi0LpO/CxDg6nzhEVEDBYOuxWYQ3SUYZZjJf2seVqsJlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776909697; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=bLhoX2qSyYDv+/s0Uzf0zLMDCPwIAjrcO7Qa4pLgDl2u0YZxnKU7xUmbP4YOPYOShvI++QpOUorslhs4p4dGFtIxS2El3ON/JIwq0MHSxZpHhxNlOV/JNSWCFY/RlReyNdyXlNEKoxRsHaUYvOhq8DNGYChwUJFRLTg5uTKdgso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ppIRD9G8; arc=none smtp.client-ip=57.103.67.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ppIRD9G8"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id 1CFB01800092
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 02:01:34 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAUMCUhxEClYBXQFLVxQEEVkCRA4LQHkRUAFYHlZeWhdeTVEPDxlTF0AIDltyGVoUXBhTRVEfVFhBDgpaEhhcFFxQWB5GElYNXQkZG0ReUBtfAkIPHBNWFRMdQxkPKwhKBEMHRQJeCyUTCVNWWxNVF0YJGQhdHRkVWgkKV3Y1DEwELAYtH0Z7T3dAAykLSRRBAiwARnM2f0gDLwdZB0IOO3MEVAddBV1WUAJaVRIEQAhWUF4IXh9MHA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1776909696; x=1779501696; bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=ppIRD9G8bHfl+sFc33kYT17Lpza5yAlh5pg8kt85fMA26GPoqSZ/q81qwnpvyYfTI/gz/tnmwRMeFOjbnjhjpamKudPalcLmNoZzXtiXGdeKHeqFZmR2xgR3zD3dXXr7AqNeObGeFu77lKVcKP432CQOlkmkFMBUm2q9UJmvxH8pZ3C1PIk3pQshiC9zqC4jb6DKIzJEzWujJzMZWVumnQ3dBq06xJLTRxBmvtkYMcVp8uwtva3IOJ+LwKzh7smRsBfh2pCil45eiYbGByTYsWRPb720mbPew42d26z7LW2QD21bRlOEMFxEjnmJ9PLdF4JOI7ehg3sX8keY7q0rcw==
Received: from smtpclient.apple (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id 6DCC8180032D
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 02:01:34 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: ijose90@icloud.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Wed, 22 Apr 2026 20:01:22 -0600
Subject: Subscribe 
Message-Id: <DE547A1F-6B7D-4B99-91A7-AFF00B02527C@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (23E254)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDAxNyBTYWx0ZWRfX6oOu/72I/VsE
 ovFg6F3nrgNN6U5H4ziqaZnf10yTromO9K+/UFxZu13PkZSDv++CcVJXyxCjv6jKxu3XTBt8WbS
 06HUyiIFGI5aCS1zYc4hL/+4tRJPVonNuQWc28M1p3aqwsv1324czyzFXv7GthsN7YS+xEnHa7m
 Ag42z4BO5BkU/1IFPR7TLLbWvMXP2Y7qKdiKvUJWrdKR/L7FJMduIl19lKIc7V4r86kzxcz9SF/
 oZL6gkyqPjVf0EFaa9vM0L0VVBwq/tkv6pNoNVvzgu+U1XC5MC8s+ofiFZqD7ynecErZB70o6Pn
 RS8vfolVqQhlp/RWU/a86Nj99fYYOXaaDsOj0myTJM7TKACgZo07ikjNn7tokg=
X-Proofpoint-ORIG-GUID: kcbwmiOFLh8rTnNdkfVAoGE-vWsnayPj
X-Proofpoint-GUID: kcbwmiOFLh8rTnNdkfVAoGE-vWsnayPj
X-Authority-Info-Out: v=2.4 cv=AYe83nXG c=1 sm=1 tr=0 ts=69e97d7f
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10
 a=x7bEGLp0ZPQA:10 a=sPygACZrUm8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YPKi6sGXXs_AdLeIGfsA:9 a=CjuIK1q_8ugA:10


Sent from my iPhone
