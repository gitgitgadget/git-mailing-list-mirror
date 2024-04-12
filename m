Received: from renault.us.lt (renault.us.lt [79.98.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693935102F
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.98.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911743; cv=none; b=p1djHBlIi2WlBdrt/OH+8nCAIsgWlVC25J5RmZw9JKfuRK0xMF74OzwIMIk6M6RjQ1XuYhUA9b3n+MyYWAx6DUt+TCzieGTYPwlBrxe3afXBlko3JvzcjdC8NsmJ9kqmac9OmkTLY7iA7w9F/D8nMI8cqGpxqod52LEmcUw8bbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911743; c=relaxed/simple;
	bh=KcUxja3nWSEaINg0RExdmYZwniVd1gSGT+RkJu+Occ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRcPpPcPdAHhMej0fri/wwljvGhd1ctQ/wg9P8nomXqBjiXDFYkP1FwAV9HyF65vXQknC+G/AJculo+J7Fcpje44DXnykH545jooeWzja6N0vbFtOZ3hU8to2ZSzXioEujcBf8ibt4078iLVqM00P7XqK4XiMfpbdqGUzs9zTQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org; spf=pass smtp.mailfrom=kipras.org; arc=none smtp.client-ip=79.98.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kipras.org
Received: from [157.230.0.129] (helo=localhost.localdomain)
	by renault.us.lt with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <kipras@kipras.org>)
	id 1rvCaT-0001LT-38; Fri, 12 Apr 2024 11:48:45 +0300
From: Kipras Melnikovas <kipras@kipras.org>
To: linusa@google.com
Cc: Johannes.Schindelin@gmx.de,
	git@matthieu-moy.fr,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	jonathantanmy@google.com,
	kipras@kipras.org,
	nasamuffin@google.com,
	ps@pks.im
Subject: Re: [PATCH v3 8/8] SubmittingPatches: demonstrate using git-contacts with git-send-email
Date: Fri, 12 Apr 2024 11:48:44 +0300
Message-ID: <20240412084843.87197-2-kipras@kipras.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <owly8r1jsjby.fsf@fine.c.googlers.com>
References: <owly8r1jsjby.fsf@fine.c.googlers.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: kipras

>> I don't think `git contacts` is available by default?

> I could add a blurb about this to avoid confusion. Will update.

Thanks, v4 looks good to me.

