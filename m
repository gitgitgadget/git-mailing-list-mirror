Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86A035F174
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652141; cv=none; b=hXABbhWyhd/2D0lUtIC1RhPUEpcYk3uBYDPZG0df8j+KH9hVOLSNcOpyjboHDx1WV1yrl0QRaijGwa6qNHdiwRlAN9v1rXlLtszC2yMje0wYXnJdcm9xi8WxZ3carfHQP0aqlaPFhimfoTRJ+hzjuthtZEXQi+MiJhO8OuHy44g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652141; c=relaxed/simple;
	bh=+vfHZGmtfvKU4CK3/QbMbY69wkUFpAtBqdiISAlG0Vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgQLiwI+8Fm3x0IvqycYdOoSOLkhv7Bkxe2f4R32V7WBIiRB7tCBKQCMHb9UcTUo4T9wUoTHlmujke6+DOExY1/Ks0oyaY3CLg2cS+kdWU3s8cbrEoFTeFEz3Z43LBjVe2uJsqQX9dhCkQWZrQfJBEefAsfyhCGDabCR/xF+XwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4fR2c25whfzRnlL;
	Wed,  4 Mar 2026 20:22:10 +0100 (CET)
Message-ID: <4c3acb06-dea0-4402-b466-e3775a2fd866@kdbg.org>
Date: Wed, 4 Mar 2026 20:22:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] git-gui: shift tabstops to account for the first
 column of context diffs
Content-Language: en-US
To: GitHub Chris Idema <github_chris_idema@proton.me>
Cc: Chris Idema via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2179.v3.git.git.1769595640008.gitgitgadget@gmail.com>
 <pull.2179.v4.git.git.1769684944593.gitgitgadget@gmail.com>
 <191b6fe4-e273-4ecd-9b73-725c2dff4306@kdbg.org>
 <Hf23ZjoLMdkhr77C9rfhukpwi1zKpjyEwhMPfsqHbL4Cqruu8WRHHeFrX7mtPzxbmV3uyEgK5yXDBxUUVparcHo0f3PSipKEfTipswpYC68=@proton.me>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <Hf23ZjoLMdkhr77C9rfhukpwi1zKpjyEwhMPfsqHbL4Cqruu8WRHHeFrX7mtPzxbmV3uyEgK5yXDBxUUVparcHo0f3PSipKEfTipswpYC68=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 04.03.26 um 14:32 schrieb GitHub Chris Idema:
> Any updates? I see it hasn't been merged yet.

See https://github.com/j6t/git-gui/commits/master/. I'll send the
patch(es) upstream in due time.

-- Hannes

