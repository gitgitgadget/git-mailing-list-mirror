Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA7647426B
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430056; cv=none; b=h5lYfx2nUTCiHn2HUWuqXWcetmcbyJqok8g6GdFLo8jrYPvXntWY41JIXKQSnRPB0m0jn+Ldg1hIVbYDPd47mo3khvT7Tgdc7vIR99o6Y7ftdOqB54n/30fQb09XiX/J/rTNxsYMJXvLXrk9Bt4GYrdjBXKp/s5HG3kDhh7PIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430056; c=relaxed/simple;
	bh=wPggyiHt909OvfMKaciJOExqe8w2XVujLn8p2QWkmig=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=rxKDyFKZR/gPycmXpT6DLg3KMvLPlyGZkROY5nz5X1rqAig/STeqC7PR2ZQ0djKemlxee3WpeF1UlshSDHxd0oE0j4qGo4Rm8M25fgcjJ5r3sQGqsGeiaA9wgk5cwncA7xRA0EQJf1M/hRpixVW2KpCgcS982/eX6NAHUOOvSlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=1qwx/DyT; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="1qwx/DyT"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hbFdW1yj8zKnRc
	for <git@vger.kernel.org>; Thu, 03 Sep 2026 12:07:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1788430047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPggyiHt909OvfMKaciJOExqe8w2XVujLn8p2QWkmig=;
	b=1qwx/DyT6NiVgoPqHhnu/BLhGhr+g9tbkLjt/Vljgq/qeOPofl91TlJGHFqa0scoISBz5w
	bRtJzfhBRE6en7/T385AeI4fQKqnOtluJFVdMO9uDC3CCfNyeVn116qV5vSttCTnB3xy5L
	KV1zNA4NczBLE3uSGC5kOB3XMvwwfUZC300p+2xNPoFSotQV6u1Z3GMNHuO8P7YODXnBLL
	Che9HxvNgYF/r3LD0vZPZSegezMUnYWKtLyLDgbIs+MSc8LUGHF7VZZxZ9X8tIjDYo2juB
	MjYYvNUj40s7TVmeRGytwQYkUsMiUNEeUvP0cETzxmlqiUxC6Tpg+NNbgKROVA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of dev@ytausch.de designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=dev@ytausch.de
From: Yannik Tausch <dev@ytausch.de>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH] dir: do not apply prefix to negative pathspecs
Date: Thu, 3 Sep 2026 12:07:16 +0200
References: <0CA8678D-0540-4A2E-B314-B9BEB04E2BF5@ytausch.de>
To: git@vger.kernel.org
In-Reply-To: <0CA8678D-0540-4A2E-B314-B9BEB04E2BF5@ytausch.de>
Message-Id: <41A4C5A6-17FF-4048-9C18-BA78C8DBAA49@ytausch.de>
X-Rspamd-Queue-Id: 4hbFdW1yj8zKnRc

Note that v2 is here: =
https://lore.kernel.org/git/81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.d=
e/T/#md8de0b0b0e4426847abd60890e6db05da010b204=
