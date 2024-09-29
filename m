Received: from ci74p00im-qukt09082102.me.com (ci74p00im-qukt09082102.me.com [17.57.156.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790AB42040
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727593250; cv=none; b=R8Q8E841xmhVPBT/5jADjnU3+MCgkbKd5z19NrTBbRJOgS52d6Gu2c/qPNRe06HFPRMn4PI6eQ1W6utOS91jVygAQuwnhPhzpJPLXDN3k0dyfgsTHwPlkNoYm7ccB1fsoMAOSiZHtCgtRwAy9Uj0A5Af6CnwLGrsWHUNPXbYYho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727593250; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=FYxhzAuFA2tQ3cx8HN+KQlfoMjxKOX7ryGNSuNdOhYhb+LpLmlk7Zeha5ccgtd208fXtV7Pv4E4t1wtaOiVsrR33q70gxRHL8yXhUg5nf4S1JRRXr9hYggQqGImLTicb0UqemhD/MQ4i6YxK2e3b5fDZnjQzASTv1rUJjJ/BfBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=XGUQkBNt; arc=none smtp.client-ip=17.57.156.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="XGUQkBNt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1727593248;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=XGUQkBNt9q3ddDgNQ4dgpxM1rCAaqOEYxKwXxlh2T6rJmVFeLT1W8fdO/LmCjK3Ou
	 Ww3XKH/X1TLg6c0tta+MkBW5gMWodUynT8lNzoM4oiZw6eZAfSm4dPoDuUmMkSjAM2
	 KV+nni4XO3tP0fiuM6ZuVoij1VKzftHbGXKU330TAxCGg6U4w1NwxMxIhywVS9bBqN
	 Uzv5861juD9UES3MiTVwkirtREgxgsG0MpJOv6htsNJBxEV02fVdkI/O8X8CRFD1BV
	 XGkHUPlFYaLxxBJN+rSLEWGzLZO1QIP45f5XlVNpcxT+RWbYiRcvrb45lb4F7pulLY
	 Y1z1CYJt8rfDg==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09082102.me.com (Postfix) with ESMTPSA id A9B1519C01B9;
	Sun, 29 Sep 2024 07:00:32 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Crystal M Baker <bakerdot@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 29 Sep 2024 03:00:20 -0400
Subject: Re: [PATCH 05/22] reftable/basics: handle allocation failures in `parse_names()`
Message-Id: <F9A2C0B1-2819-44BC-B911-2208032D5703@icloud.com>
Cc: ethomson@edwardthomson.com, git@vger.kernel.org
To: ps@pks.im
X-Mailer: iPhone Mail (21H16)


Sent from my iPhone
