Received: from outbound.st.icloud.com (p-east2-cluster4-host11-snip4-10.eps.apple.com [57.103.78.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530182E36F6
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297948; cv=none; b=d3dW7uCS3zmHWlSVAT5new5IVUJWaojAmTA6nc1V/c5IaMMxgxSYvPfLo11sJmBMv3NHH0nrV/zkr7+Pj3noAp8C+pB+528EVgpek/kab6a0Hda1aVBx7AdnuUJj9BHl/t7wV6C6ZN+DQd/UjzjKpdIEc4dkTXKt/iR/+wtEKcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297948; c=relaxed/simple;
	bh=EZUHSwbHpWmKrh1p1uYlYmJ8PhV4cQaa+3l2tKARcvQ=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=U59iZNIMyvPsQXRMOYkxnRRvLPXd7W6Kpn4/4pOJwgIgdVYewM5dVnGcuTqsV21Bbhz4oTczILGavcmJGvN4ruQtDhQZHWxjIZd7QdQybfIlevxpy1th2OZgTEjGomY5vV+GfYiH3uhs08nBvaPyhzXF5oYF5F2DUZ53dlFBM2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=DFj7nBJ3; arc=none smtp.client-ip=57.103.78.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="DFj7nBJ3"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-20-percent-0 (Postfix) with ESMTPS id 0BA2B1800869
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 12:32:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=EZUHSwbHpWmKrh1p1uYlYmJ8PhV4cQaa+3l2tKARcvQ=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=DFj7nBJ3JFA0EkAINec/hRmplHNOESns9SqzQMr3FnN8QwyR0v+o6Ota6oscgRNfZwOgMkFX6T1Ms4VIvjGBMEZFvaFEKSZjyvlpRDYSZcrygId+fhl1INx3gVUkWer6BKogubfjeuYiqpjX1YBazKCiTxpN7QPUdOjG6Iex29U1630OJ9bl7zu8NE5gnR7gww0u+KTfO4ai5WDCghAhj9JVXxD5eEkw2gr9O/c3cpvyR3hy8YPEIq7vSZZAafEfHr7DEWR+h0lpekNcecxvFH2Jz4oIBFlHMv/WDFvhAereaXmnz9KzroqT31BERpeXcznTLncIawyjG3v30sy5Tg==
Received: from smtpclient.apple (st-asmtp-me-k8s.p00.prod.me.com [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-20-percent-0 (Postfix) with ESMTPSA id D78731800844
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 12:32:23 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Jesus Govanny Gonzalez Rosas <jesusgonzalezgovanny@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Wed, 27 Aug 2025 06:32:10 -0600
Subject: Xxx
Message-Id: <2E1BD283-5077-4034-B5D7-955C319CA632@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (22F76)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDEwNyBTYWx0ZWRfX+nFdzLfHt+NG
 Uyfyvttjw2rJn4RH3fCR9GCnHucZdj4dUkdapAZiUgkxgTLh0s+liX08OOoQ53fwu0mz8leF3Hv
 sHmt80BGZ3hkirloXJIQS3WqrgKgTX8Ycfs8rX07bwKjjcG3ZtCVePTswyEcIS7pDCMukqfSdD9
 zyN6B72mcCh8N2PrrK1nY1bkgQTh+J+UB4jYVquIhtsoGdDk/rZW3HZ6cXNA3xW074kKxVMcltt
 ypwnK9wq27gUPlIa6m2gvy6EAhco3ewBNAoBepc0rH2thMUzGF8DFqKQ2pb3OO/GZkjXB9xeU=
X-Proofpoint-GUID: QbGK3egMu1V7ob-kHXWXcf5y0OgPPigc
X-Proofpoint-ORIG-GUID: QbGK3egMu1V7ob-kHXWXcf5y0OgPPigc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=494 malwarescore=0 mlxscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508270107
X-JNJ: AAAAAAABWYzcUBksRznS/SwmncWozKTIPeJ9B2gEPrbg/gRnBRCl1af9Cpic5bJCvXT5Imclsmoe+qij3RqqwyxXmiaRjhq16/mWl5H3v8VpCqUMBw7P7O156KH71u/+pYnIdhgtXjZBYx0pYAqmgnDf4xjq1fAnBO1MfsbErVW0cRKIB6o0u9EwSzIpZ+MzmUUT8ZXBf8AxF/iQpb0M9KoLde7DRSAwPjMO/xQGx7WBkYVn3waMSd4J6VNLgmtz5VzegZa1BqLY5hALC+t1nNlNAsjZlJp3/GHC8QTqKx1UE/tigyX6i8fCyKRxcoT8B2QI6pZecct3i3QQdfLuE6akzbEMb2VHEFWfNWn18rBR8ds2I9oQdkDU0I+GUmwcB5Rq/RqH3OgKlyDFXegENQO2KWSSzx46


Enviado desde mi iPhone
