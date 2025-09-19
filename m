Received: from mail.jame.xyz (jame.xyz [142.93.72.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71524256C70
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.93.72.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758310436; cv=none; b=kbXDzakIii5kZq4Kg+x2HIV3SMIrrkO2yw1zDsPFmdB+weDzo0mfnLSqFEy2L/DV3z7SeQqdPYuDXdSwfwuCmGsMM+km9qZkvyeczjBUdpjKrYQEkURmvlduibuxQpMAsFQSVvI0vmeMEmVt+Ft0VWsVhfiMgnqf6GxdMrlZCus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758310436; c=relaxed/simple;
	bh=AX9ugljtGLItP3/bRQVaWDhs+sxpTyuxvFGsdd1KwKc=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=NPy5mPF9CTYNuNGQ12aNlHW1phx6Zt/0spsFdTPWSW9jwr6D3s8rmt9YuQn0bIvg7vaoQLR0h8WletmQAxzsehsYkBvuvFzl8GxaRJtjkqxPtPJmWs8qbhFTwa1zFJwdW7keLOmS2IVZDOub+2zESj6i8IPkGXjZWO5YETweU/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jame.xyz; spf=pass smtp.mailfrom=jame.xyz; dkim=pass (2048-bit key) header.d=jame.xyz header.i=@jame.xyz header.b=GrO9Ez/e; arc=none smtp.client-ip=142.93.72.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jame.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jame.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jame.xyz header.i=@jame.xyz header.b="GrO9Ez/e"
Received: from [IPv6:2601:84:8380:44d0::85b0] (unknown [IPv6:2601:84:8380:44d0::85b0])
	by mail.jame.xyz (Postfix) with ESMTPSA id DCBEF464BA
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 19:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jame.xyz; s=mail;
	t=1758309877; bh=AX9ugljtGLItP3/bRQVaWDhs+sxpTyuxvFGsdd1KwKc=;
	h=Subject:From:To:Date:From;
	b=GrO9Ez/eHsOqL+xavk87n9L0aLlV9EqyrSEDSjryeHAG+dzrx2ycodz8UmDtNCcE+
	 B9gjnyM7r6aCJ5L+xMrc64jWnrn1RaBxDm5eEteLyNMu+tJ6zFIMDhL0qEC5y9DFmP
	 x43qpBtO6y18CZThQJTfLQmvEoaM/Eqe1G1XElMqA8DLXpcUTb23YHHXH9cvFuDr5I
	 eU0HBy2Kx+0dKJvJquVA2WOVhiyXFrWtltN/20B4RKWOm03ZMfPmuSa9QZ5iz4g9h/
	 GD44ik0UutOCZCdlQzg+joSWbra7QpnGDic5BDFh8wJ1MiKYdos/tKGeBgpPBeECsy
	 fm8etBTiFoMog==
Message-ID: <d94afaec66f8ab8058764cee08e9dd56435dd667.camel@jame.xyz>
Subject: git whatchanged: fatal: refusing to run without --i-still-use-this
From: James Puleo <james@jame.xyz>
To: git@vger.kernel.org
Date: Fri, 19 Sep 2025 15:24:37 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello World,

I have git version 2.51.0. I encountered today entirely on my own this
fatal: refusing to run without --i-still-use-this

Why I was using this command: There is a bit of code I wrote in a file
since deleted (from the tree). I knew the path but not whichever ref
last had the file I was looking for.

Having a file listing consisting of purely the file paths that have
changed seems like a useful tool, that's all. If this isn't fueled by a
technical challenge, I don't see a reason to make simple things have a
difficult path.

Thank you.
