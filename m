Received: from ci74p00im-qukt09090302.me.com (ci74p00im-qukt09090302.me.com [17.57.156.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDE66AA1
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 06:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727592710; cv=none; b=NiXWMwgB/rR9xr1btd7ddQdXJQNiwzWwAmcaYniTVtoTI1SvYnIT1YFq+Mi5rNUSPt1v9g3d/7m+xAESn7nr/kseXUWtGAngGrx8y/GZB5duN6nMAbhSoq/rXPGgtBehpW1bBikAlpsPg87MR3WR1EIM0OFs0SQIjRHTd5bAwo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727592710; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=rQzOX06Z8XU3wcZnfCsyNdueZlzTCX4Hjnd77xQqhoXDZXmTchy57FiQdwIYa3sg3CELe+g1fgaLqgmpojJprAM7iO/2mQvsOAN8YyrdYEF22z2NiyL1Ci5d1QganjS06zEh10+6CwKR6DjEos0HuMHRPInjbYJEND9T3mSLa2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=iGctHXMo; arc=none smtp.client-ip=17.57.156.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="iGctHXMo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1727592708;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=iGctHXMoEeOch10uBqIR72jyQPa3C1iGX0ciLuxGruERpUoTwazuYseV6yRYiL5LR
	 r19ePksdIfEZ0cY6TcSEsWF7BE3cZSBNnJXD3KubKxjU4x28InSRAwA/s+hzS0ubQm
	 zXo2Jr98Gjwi0CIgvOJjjhXRoPLTaS5k7AxTgV/8S0VjCrx1wo9Z4RbMjQ8vkl5tMy
	 wL0gUJ0ytImR4XReTtaATO9s8UIPl38KNxYuywlTH5w2eOzvp9zUN2IW5EQMq+OU5p
	 ejC7gvF2cEbXAArURxEkuDodlSWqLzY0MpDmXqdf7IMmwJqKEn7xGhE7eWuwz2C1xs
	 OlTttw5nFrv5g==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09090302.me.com (Postfix) with ESMTPSA id 1D8235BC012B;
	Sun, 29 Sep 2024 06:51:46 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Crystal M Baker <bakerdot@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 29 Sep 2024 02:51:36 -0400
Subject: Re: [PATCH] send-email: document --mailmap and associated configuration
Message-Id: <A950B09F-C04B-4979-93C2-CF545E3C879F@icloud.com>
Cc: git@vger.kernel.org, jacob.e.keller@intel.com, jacob.keller@gmail.com
To: gitster@pobox.com
X-Mailer: iPhone Mail (21H16)
X-Proofpoint-ORIG-GUID: 2awtK5E3kOfmA9AHLhlwbMAVKjAGw35E
X-Proofpoint-GUID: 2awtK5E3kOfmA9AHLhlwbMAVKjAGw35E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-29_04,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxlogscore=720 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409290050


Sent from my iPhone
