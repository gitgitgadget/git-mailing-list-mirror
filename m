Received: from ms11p00im-qufo17291201.me.com (ms11p00im-qufo17291201.me.com [17.58.38.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4632B9B7
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730014373; cv=none; b=aUTrOXfLZyocBnUAPcN+o5l7HJOfjiVLvXWDDTYbOK2ovDfVqKlj+uwrApznXBgrcAXIuJ2aA7MPVO54iKZJRFsA3Et8NoHesVT5nobH1o6j9+r4TlZCcW6Mo8XHNAHY0E+3DvgBAV4TvpSF+riYbb1xqubRsQUgW/VDtqXanpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730014373; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=jMdaZaBf9svjzT/QjQ9+2pcpqdCHS9nO1HAuC2tgJYr0vPCdGjp86GkhtClwv8ykNrqVl9pgytRdV2jyxoSpPAkgokUM7LqfNm7hoh4zwSyQSmedHx+bw3utvRvmwf3t+P1dnUdNoOAyJW3qdbGn716D4IULG9Qzzyi8r7N1NuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ybyoTzcH; arc=none smtp.client-ip=17.58.38.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ybyoTzcH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730014370;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=ybyoTzcHbV3cbxDmW6Hhx4PY0nT0MzuwXudlgG/62DPl+i05mYlcOIPW4I1ZIBDDk
	 dyNCYA5kKaCFz91kuwT+awzzVjw79OfZT2P6m20AgX+jlMITpzkB7gRwZdaF5gAg/+
	 4YdZe78HJSf6zj1PjGqD8AU2J4na2d9cn6CFD0RRo6LYakfHX8LPfMb4aRoaXOvFSU
	 FXX/e3C9aE26AD0ya1doCxoQ3CDXg6h2UJq4lzUFqcSlow2tM1R2xGRY6x2KqAW9bq
	 ibSYXc1ADdO1/UcMTQEAJbXb7uF6IjAD69PWYT8UALZ+xijef8P7s8QkRKuCT6FAM+
	 /zoq5/+sHGHLQ==
Received: from smtpclient.apple (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17291201.me.com (Postfix) with ESMTPSA id D4BE5C801EC
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 07:32:49 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Gloria Moran Hernandez <g.cantarero@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 27 Oct 2024 00:32:38 -0700
Subject: https://github.com/GloWE3/supreme-spork/blob/Polyglots/encoding/encoding.go
Message-Id: <F5CE5C11-3BF4-4B73-9B6E-8FE27028C8C1@icloud.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (22B82)
X-Proofpoint-GUID: z8jgwhE3rxmpue8dD4FOnAABvEslkgSA
X-Proofpoint-ORIG-GUID: z8jgwhE3rxmpue8dD4FOnAABvEslkgSA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-26_08,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=751 malwarescore=0
 clxscore=1011 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410270064


Sent from my iPhone
