Received: from gatalith.at (gatalith.at [45.132.245.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25F8DDAB
	for <git@vger.kernel.org>; Sun,  2 Nov 2025 00:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.132.245.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762045011; cv=none; b=UCaj+RKKiSFCIrOxvkANlQUDGTaC+jo9oEEQJgtDVgk6NnevPEf4pX3MGKQEOyYsghVDmrGdMsgGTSzSNxplaCFxxF1G/kN9qqL8ECyFIgZ988GmKonyOE67+X41vF61MuR4hiOTow+BAVXAHlrHFJ1TQtFmNXmFTlZ8vxGQX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762045011; c=relaxed/simple;
	bh=0e6bxnXZQyNiQrTtPdRkDubFPuGhSqJEEj2DSZ2aHko=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gZkv5bjhshyfXuvbYjjkU7LKHO5UQjxADClrTae+LdFXSpPPbqHJGXrOXe/nEWEcdA9zKGCnSzphF/v2Rsof7jp+j0m7ybBO8O5KDr275KFI5jrfDc2Qtb6Ni/W2QV3QP+E342XKfDdxQRRzrVEeco+VjxvZHUMhjvWkPoq6qRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gatalith.at; spf=pass smtp.mailfrom=gatalith.at; dkim=pass (1024-bit key) header.d=gatalith.at header.i=@gatalith.at header.b=ZLtpzx9c; arc=none smtp.client-ip=45.132.245.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gatalith.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gatalith.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gatalith.at header.i=@gatalith.at header.b="ZLtpzx9c"
Received: by gatalith.at (Postfix, from userid 1000)
	id 97E1D3917D0; Sun,  2 Nov 2025 01:48:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gatalith.at; s=dkim;
	t=1762044535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Al7Lhr82+xy4bqmD+lrus120M58JEm0TndkPGIQwO+A=;
	b=ZLtpzx9cy4loOEUGu4PkmprtsqgyEMGHVUDwKi46IW3NtyZDTbYRjCnKL/K9X8QBcz/v4d
	uLtWLLxtNOMZ3526XwCNOknzrgQBesY3jqAYUsz0Fh5WqClC1E0f37n+GJnFTrUgydkzgP
	NnstzW6UaOnRQ2HkDr8WPYn5WHG9/So=
Date: Sun, 2 Nov 2025 01:48:53 +0100
From: Thomas Klausner <wiz@gatalith.at>
To: git@vger.kernel.org
Subject: CVE-2024-52005 status?
Message-ID: <7mfgh4ufx6wr3ict2ee6utg3vvfpiy6xi3rfyfu4yionmcwu6a@yry3kefdxbwf>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

I'm trying to find out more details about CVE-2024-52005 so I can
handle it correctly in pkgsrc.

https://nvd.nist.gov/vuln/detail/CVE-2024-52005

points to

https://github.com/git/git/security/advisories/GHSA-7jjc-gg6m-3329

which lists many affected versions, but no fixed versions.  I only
found one reference to the CVE in the release announcement for 'Git
for Windows' 2.47.1(2):

https://groups.google.com/g/git-packagers/c/ZWDc6K6tYcc/m/VxikezMeCgAJ

The CVE description sounds like this also might affect non-Windows Git
versions. Can someone please tell me if this was fixed, and in which
version?

Thanks,
 Thomas

(Please cc me, I'm not subscribed.)
