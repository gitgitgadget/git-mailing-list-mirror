Received: from mail.fhannenheim.net (mail.fhannenheim.net [188.245.251.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172F3DD86B
	for <git@vger.kernel.org>; Tue, 26 May 2026 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.251.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800781; cv=none; b=rFJcdZQLeLugIsW/fcwr3BenKrJeFguJ2vh3blRHeubGxodtdlRI5YpvfJuPeBxedR9dsuoLH7BsptjK+u8j0qV94oTB71Gk9lvgonYoDTg+HnmtcbnRNSLI6OE6CuwdiPUHNkdG/+d3/1I4C0pmePg7rzmiiHKeoNMv91wYAY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800781; c=relaxed/simple;
	bh=8mmJhXEmL0CCT5XrWuxSiWhv4jlYCGne3aRFzK9kKKA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Kda49vkD7T2HtyXcC7xQ/hnLdbDGTghFt2K9RDueD0uaYFZ3deBI/6A0ZjmHU8sjosEsQ0GEdZpbH9u7RwRPa0at+PcxDpLLMCWfju6xEEh3LfJ+sX2/63c+ztAB698slVqowW31Q/STvJaxICKyi+ZElTPKViHmxOPeDM9jKAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fhannenheim.net; spf=pass smtp.mailfrom=fhannenheim.net; dkim=pass (1024-bit key) header.d=fhannenheim.net header.i=@fhannenheim.net header.b=HU9yeus+; arc=none smtp.client-ip=188.245.251.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fhannenheim.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fhannenheim.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fhannenheim.net header.i=@fhannenheim.net header.b="HU9yeus+"
Message-ID: <02663c67-01ad-4dd1-aae6-9e9706f3d040@fhannenheim.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fhannenheim.net;
	s=mail; t=1779800223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8mmJhXEmL0CCT5XrWuxSiWhv4jlYCGne3aRFzK9kKKA=;
	b=HU9yeus++7msdK2SEfgfg+vBhBF48Pl4gHYedAUNCRbVm7n/yaYdykp7fss455Zjpge4qE
	9X902GCro/nKzaqQfqWTqIbQqz+1w8Wg72W5SHmlp67HtRodfejC8mAyGYSR+FkKBeiZ0B
	XcEURTLwHBOuwvCeElWx/QoOgTTKPdA=
Date: Tue, 26 May 2026 14:57:02 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Content-Language: de-DE, en-US
From: Frieder Hannenheim <mail@fhannenheim.net>
Subject: git mv after the fact
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'd like to propose a new flag for git mv, that updates the index
like git mv normally would but does not move the file. This would come
in handy when the file has already been moved, or is renamed by some
external tool and the user wants to fix up the index afterwards.

Thank you for considering this.

Sincerely,
Frieder Hannenheim

