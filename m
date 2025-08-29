Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [46.235.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287521553A3
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756450722; cv=none; b=gDeFbgbB7k0aSRZQRuKBPNRzl7tVahKMR7arb/JDbxhthD1Cop4kCrcXW0zZnSsaX1ikrbyu6h0iDVAMxHblFWgzBPGRoOKXYyaJlKbtw3rHkgR5A8IdriSpkJyyaj06T0AN0nt+Bz/EkocTLQhfrR7A6DIGBQV44+Dg+l862Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756450722; c=relaxed/simple;
	bh=kjPLny/vm1iw2K+1LDy83kLzrMToE5PEGuUBR/JgFbs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=CUzt+HeevmAw292b5e6U02fRVHMQ7DDcE/D82nUOsbBlhxB1Bkojj69lvpyJkXOACMTXT19rIFr+seH0fzlMe4EcgGjUKpoNYZ4gkYfHwIhQjhaE6FDv0h2DTYQ/Wcl9rQV31nyY2mHNd9JmfIRUCwxZ1QLf/vnPnmXgkOpV7Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=frippery.org; spf=pass smtp.mailfrom=frippery.org; arc=none smtp.client-ip=46.235.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=frippery.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frippery.org
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmy@frippery.org>)
	id 1ursjx-00CmoH-10
	for git@vger.kernel.org;
	Fri, 29 Aug 2025 07:37:37 +0100
Received: by argus.frippery.org (Postfix, from userid 1000)
	id 394BA631A; Fri, 29 Aug 2025 07:37:34 +0100 (BST)
Date: Fri, 29 Aug 2025 07:37:33 +0100
From: Ron Yorston <rmy@frippery.org>
To: git@vger.kernel.org
Subject: git whatchanged breakage
Message-ID: <68b14aad.X1BRkbvYn8oZ8Dhp%rmy@frippery.org>
User-Agent: Heirloom mailx 12.5 7/5/10
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 10

I use 'git-restore-mtime' from git-tools[1].  The latest release of
git broke this.

What happened to politely deprecating things before breaking them?

Ron

[1] https://github.com/MestreLion/git-tools
