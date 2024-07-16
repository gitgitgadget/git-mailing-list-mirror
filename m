Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED72208BA
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163206; cv=none; b=ei7cR6maCRJD6I1vUDvDKysQ35uF2eIPs81A8Nlv0tpsmdeO9apkodUvU9JPfsqukUlstm3JZpVOGiLeN5P9wI7k+T2YSD9N2BWSSbPBg9NvSUYyhtWE7Bkfsxfc/d/JjG9zIIMP4G8sfvRZpEZUukfufZy8w1yotHUskAUbAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163206; c=relaxed/simple;
	bh=AN95zExQQLHkEDt6pZ1gWmmauwlmW8Z8+J21xFfmfqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fu/Px6FiBVZ7j0G0FDjj+WAgi/WUPBFgXL6pKuJ1Iksg/fIW48i4TmgiDrsDGk8ABuVO6uY7QavQsiyun5vqlPt3gcBVPggpl7GYsBvVgcl4ExMj0JdJu60YAeAbEa/wc3L7SR4BOUDyobkRqadbVjDI4/5UorqCrCWQrWCgQhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (089144221249.atnat0030.highway.webapn.at [89.144.221.249])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4WNrrD4RjHzRnmP;
	Tue, 16 Jul 2024 22:53:16 +0200 (CEST)
Message-ID: <a1dc575b-a13e-4685-98ea-a6037c8e059c@kdbg.org>
Date: Tue, 16 Jul 2024 22:53:15 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] userdiff: add builtin diff driver for TypeScript language
To: Matthew Hughes <matthewhughes934@gmail.com>
Cc: git@vger.kernel.org,
 Matthew Hughes via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1746.git.git.1721061218993.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1746.git.git.1721061218993.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

We have had a submission for typescript just recently:

https://lore.kernel.org/git/20240404163827.5855-1-utsavp0213@gmail.com/

And two for Javascript

https://lore.kernel.org/git/20240301074048.188835-1-sergiusnyah@gmail.com/
https://lore.kernel.org/git/20220403132508.28196-1-a97410985new@gmail.com/

Please review these earlier submissions. If you think you can improve on
them, you are very welcome to do so. But you can also just resend one of
these series with a note that they are sufficiently mature and that you
support the submitted version.

I may very well mistaken, but I think that Typescript is a syntactical
superset of Javascript, so we need just one language driver and mention
in the documentation that it can be used for both languages.

Thanks,
-- Hannes

