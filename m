Received: from ci74p00im-qukt09081502.me.com (ci74p00im-qukt09081502.me.com [17.57.156.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2752C859
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 03:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727580577; cv=none; b=IeF4Afm33wl7o+UvWWN43ip3LlgCkRJlWAOvcRSGGcTCoAN+TYC3/fuNgZuG5kPDC9HCGwtP0m21YLMlTF+sdH1HJYEc6mqzqLX/XK+j1f+zPqaFKE94il853GAWneLRi/sOhOyOX5o28pUvmSkc21lIBi+wtas34/2762H3QBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727580577; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=NO29Eaa+vXHsL6673hhDshfV+s5sZTk9c0rx+OvNxfVeKLzHhKt0jVE+mv2hr4ZfosUjJ2ypvHKJOFgOvaXBJP5fexVSaeq+JtwOtCruhL9K3T01sVFuyiK5i/ayg06UFVM/hYaN848RQyjKyN+h/yZlFfRYH+dZKJVpKf/rlqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=k9cSCEkN; arc=none smtp.client-ip=17.57.156.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="k9cSCEkN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1727580575;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=k9cSCEkNmWiZzPXC5++WBdfbfbY40aramlGQA/vgDxSYcdiNsqazjh/G4BxkIz0Ym
	 9JfNMDCUk0VyJqZzH7RVESW1WoiRKHoIZ8Ev+2uCqY/6B/3+T/uVHM7qNzdZTUBHPv
	 hwdk6TnffINSNPJXO4fM2rKxgQ63FhESAWOtwu3Dxe5Bvzh/uzaHdt+4gQZdDVFR1y
	 7E3wNOd+zMxop/7a8ALleZ2ChK9cpE3w5ZFoHmviddhJQHHw8Cf5SrLXA2rvnOBJZ2
	 gqNC7kOHp3U127eVvg6uPuccN8o6eZgLZlHHQp48ChxZSpl3DvP4zYMLB3w4MqQ+En
	 02TDMPzPHSYNA==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09081502.me.com (Postfix) with ESMTPSA id 6E83728400EB;
	Sun, 29 Sep 2024 03:29:34 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Crystal M Baker <bakerdot@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sat, 28 Sep 2024 23:29:22 -0400
Subject: Re: [PATCH] git-diff: Introduce --index and deprecate --cached.
Message-Id: <96FDD5C6-FA7F-45B1-94C9-B15017B82496@icloud.com>
Cc: git@vger.kernel.org
To: ae@op5.se
X-Mailer: iPhone Mail (21H16)
X-Proofpoint-ORIG-GUID: mJBNRxAGO0KGXMG9MrGMyht74x6ud0Tl
X-Proofpoint-GUID: mJBNRxAGO0KGXMG9MrGMyht74x6ud0Tl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-28_20,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=615 clxscore=1011
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409290025


Sent from my iPhone
