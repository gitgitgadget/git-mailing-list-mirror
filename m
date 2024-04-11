Received: from renault.us.lt (renault.us.lt [79.98.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F32D257B
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.98.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867641; cv=none; b=kfycecOvQnMWGZDnUCObkH2DL0P3qKZofx43l0ova1A6nydP+RD/MtJikMBTk2ecmZBnef56JuXCiR6tNUVNq9B8rVixsZeFrsl0ludMjTnEkIO1ZlJ++TOpO5CEWu/FkKgiTJ4JsK7B2chALNtVGDgekL0FU5YqFcgOoB1I9Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867641; c=relaxed/simple;
	bh=X4bWkEF4zwcF7iXsxJJYcZvMPvm077fiVAyRsydy/j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgWh4WDCNXOy031PB6q1g425BGhDF1G/DvSNPdsypyGHdSDAgPLQ7FDiKhKtDxr6eyDLXfs+BRh7kXyMNgi/tcr38x+9ftDUQJoaVQqZtCzhES7kk1a48ubR1ANUlyZtf95xdrfIHczJQD+g5Aj6bVooKMwz9ugn9XffINIhO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org; spf=pass smtp.mailfrom=kipras.org; arc=none smtp.client-ip=79.98.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kipras.org
Received: from [157.230.0.129] (helo=localhost.localdomain)
	by renault.us.lt with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <kipras@kipras.org>)
	id 1rv17H-0006mW-Ok; Thu, 11 Apr 2024 23:33:52 +0300
From: Kipras Melnikovas <kipras@kipras.org>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org,
	kipras@kipras.org,
	wyattscarpenter@gmail.com
Subject: Re: Short form of --force-with-lease
Date: Thu, 11 Apr 2024 23:32:26 +0300
Message-ID: <20240411203225.82557-2-kipras@kipras.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <01e101da8c45$66d33240$347996c0$@nexbridge.com>
References: <01e101da8c45$66d33240$347996c0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: kipras

> If this is mostly about saving typing, you could get a similar effect adding
> an alias. Something like
> 
> git config --global alias.pushfl 'push --force-with-lease'

Correct, and I already have an alias:
'pf = push --force-with-lease --force-if-includes'.

However, I see the config option more valuable - it would protect against
accidental `push -f`, which, out of habit, is very probable to run on accident.
With the config option, would feel safe and wouldn't need the alias either.

Thanks.

