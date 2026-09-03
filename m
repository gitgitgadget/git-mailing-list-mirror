Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37B63B7777
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461881; cv=none; b=Jj10lK66mXBM2+uDYfwFpxaQyvl8Gd6F9xjMSeTc1hHWgVYGtLyWHuzEnqQPG2scAxmKhGzH1vVzHWaFODPs9sqdiT0nBb33nbTernU+kpiGuVNClRZ9OktdbNar/iBwtvBsOFXOkBGirq/gkwpBMcHavy7zzT1aK0XvbWItMd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461881; c=relaxed/simple;
	bh=cZAAgj987aGZrp1XmNpLkJdRnHkn3VYZmRAxh6qgkr0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=auO3rLcGBpy9GKSuHYAYYRhBI0u9xlfL/nmXZsb0VsUGQ3uYxbSPuHqX7wQqHCuVWSbiJWbOahwzf0kYIN74Sr+sbvTQKcr/zFzmqobJj55+VgzE+zs8g47sm5V8ugkX5n9n2N4cNBIoi6XndSccCXgn+PnJV/HXbCLTZctIwmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=BSIK0Iyo; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="BSIK0Iyo"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hbTPS1tnHz8t4x;
	Thu, 03 Sep 2026 20:57:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1788461868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7XM9/tJsRtTmsywEk1ZOY0JVbVvI8atNeCkxcwsZ8gI=;
	b=BSIK0IyooL1YwhOMANWA7nn9/lb8wKgchQDIkFclGf+Z1DHZT+DxeZ3l3sVs29DTmKKfLX
	AL5qKjiCCHhVW+AZva0W49br5z4mF0SV87GnNThEeN7jCMavyV7Ohq8sGqtx8U8Y75qkuA
	Zh4GE1SoQRsbOfUqZF8AoQ39hJ8R797jUvPhMAdAKKPYPmq00cqcMbsPKeZ5MMjD1edq+P
	S9efAXc0UInbvOvT4k4UepEl/qiF+t4opyJRnkK2osGjkAQ3v861igtPumCZT9AA1BRSI4
	5edlVPuWzfEA3PKuMAJhow1bKT1EXDhgHgl1cV+mqGXYZp79o1Z18e/z3ICQAA==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Yannik Tausch <dev@ytausch.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: pathspec: match and original in pathspec_item are const
Date: Thu, 3 Sep 2026 20:57:36 +0200
Message-Id: <15ABB1A3-AAA6-4F53-B46C-C92E0B529520@ytausch.de>
References: <xmqqbjaeb22p.fsf@gitster.g>
Cc: git@vger.kernel.org, dc@diogocastro.com
In-Reply-To: <xmqqbjaeb22p.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>


> The 'const' patch will be queued separately, and a synthetic base will
> be prepared for your two-patch series by merging the 'const' patch on
> a recent tip of master.
> 
> Unless you have other changes, there is no need for you to send a
> three-patch series.  We do not need to take the 'const' patch hostage
> to the 'pathspec' patch.

Okay, anything I need to do now since I already submitted this as v3?
