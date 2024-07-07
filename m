Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02C620DC4
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720362117; cv=none; b=ewJ2ozx/rNFvnHjJAvcwnoMOUwXNrEyd0vxh315Z0aLsYsltuACvBdaGzqC8vJBBkodfwxKW+YCgQA50/IcdnMYCSaGwTbPY/ghRlkFFd9SloDYEOonlkkGM8x0AW34taIv2oAyV3RX6cOyN/ZpVidRkohIR3RnR9qqnTnfjnC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720362117; c=relaxed/simple;
	bh=iU55GDd0D8YLFtdPjJvrQOwmzutHIQoThT/npooQnVM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VJWhmFMbFU9u86uTLenrZABi8vC0tp3asvvtDFybeas1JjRM7de/Avo8ddZ/H+fmXYP0zgR93spSiE3sk8vGduySGVSrLo22zoHpa2dg/5ifMvD20C5ej3FhGW275qaFr0pWuLI4rp7c9ENMyNhH748vDzGMeDFImUbRu/5U4y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4WH8Rv64k2z1qsP1
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 16:15:55 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4WH8Rv5kP3z1qqlS
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 16:15:55 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id RwG2QYWhyZnQ for <git@vger.kernel.org>;
 Sun,  7 Jul 2024 16:15:55 +0200 (CEST)
X-Auth-Info: 4JQHtySIr/kxHBrPNzygbpw//Svy53kay6dTVdZAzHWy7jz4+YJAqUv6XyrCFJ18
Received: from igel.home (aftr-82-135-83-213.dynamic.mnet-online.de [82.135.83.213])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 16:15:55 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 00E622C2343; Sun,  7 Jul 2024 16:15:53 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: git@vger.kernel.org
Subject: Re: Remove your ZSH completion in favor of the completion script
 distributed and maintained by ZSH
In-Reply-To: <mrn75pj663u6ikkwfnoq6c342l7w5plfeju4ji7norsmlzx4jn@3se3fmuqes4p>
	(Doron Behar's message of "Sun, 7 Jul 2024 14:53:50 +0300")
References: <mrn75pj663u6ikkwfnoq6c342l7w5plfeju4ji7norsmlzx4jn@3se3fmuqes4p>
X-Yow: SANTA CLAUS comes down a FIRE ESCAPE wearing bright
 blue LEG WARMERS..  He scrubs the POPE with a mild
 soap or detergent for 15 minutes, starring JANE FONDA!!
Date: Sun, 07 Jul 2024 16:15:53 +0200
Message-ID: <87cynpnv8m.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Jul 07 2024, Doron Behar wrote:

> ZSH completion is almost always distributed with every distribution of
> ZSH, so there is no need for the two projects to maintain two completion
> functions for the same program :).

How do they keep it in sync with the particular version of git installed
in the system?

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
