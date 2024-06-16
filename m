Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24797345C
	for <git@vger.kernel.org>; Sun, 16 Jun 2024 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718578206; cv=none; b=OHlPU859iSRk+u4MyDi6YsiYN38l8vYqseQEJJ3ESwQX2CLMSkoEHUwSMHLRFY/L1xta7RXOS8Nv9pDhcR7YJk6LYjdNk96VYm1yGjEA4DilWPBVjgROYAYAoArhr3RLQhCIiPqOCFIvaKBA7f8VCLOcWvNXA+UaXO1f21WuZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718578206; c=relaxed/simple;
	bh=LeUteyQfBEQm166/wucFbpaO5CEKhSHInwrz/rBecsg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cn5Y5blwknQxX0Hh05gwP/AmFINmSRAifQEZtslyKjLlr8g5c/iNmFYt2DZHF7BBSqn/oLj2SInZxBDDTG1BCuRMr9CJNQ5amyYQvlKCqyptygx+65ATDAYCTxibLh7kZk9Vo/5MUCNdWYE30A/aMHcn7uXs5jV2OPBNTqdhSSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baxters.nz; spf=pass smtp.mailfrom=baxters.nz; dkim=pass (2048-bit key) header.d=baxters.nz header.i=@baxters.nz header.b=Nky5h+Oj; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baxters.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baxters.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baxters.nz header.i=@baxters.nz header.b="Nky5h+Oj"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baxters.nz; s=key1;
	t=1718578202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=LeUteyQfBEQm166/wucFbpaO5CEKhSHInwrz/rBecsg=;
	b=Nky5h+Oji0kgkP3v8f1Nf6HWZXxl0d1FpHUJ7C9IjMmft8BrONY8Q0OhNPZcaPrqzBnUzK
	FKLvTgAmjhGiriTOyELMnD2d33/GQVYf/LYIjOwL/VKgx4x6qD8pbDtJUtBn+MYtfwS6/q
	G/Sx80o160OuyEfCfzMa623N8rbQGAtvdlAgxpSpqNmsmyySKalYN9P3nT8zNPcTj/hhvO
	3LZkQ64SRJ+uRWM9KviAJBnJROD9J8WaaHCU31Z8bC+4P9JBtjwUtndGQqD3tjGkkgBNCj
	TRJIMnFwKKBGmxKBIF+JqRLMUpQBoG0rAQHg+a90fwKCMcACozbdS4jMvtnhDQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jeremy Baxter <jeremy@baxters.nz>
To: <git@vger.kernel.org>
Subject: git send-email SMTP password command
Date: Mon, 17 Jun 2024 10:49:55 +1200
Message-ID: <87ed8w33l8.fsf@baxters.nz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Hi list, I was wondering if it's possible to configure send-email's
default SMTP client to execute a shell command and capture its output to
get the SMTP password rather than prompting the user on the terminal.

Would anyone know if this is possible without setting
sendemail.sendmailCmd?

Thanks,

Jeremy
