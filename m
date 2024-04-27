Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8498D522F
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714230560; cv=none; b=Jh6WvKYb/hPkSVDRqD7+8oz4nxbsdvF7BoraRF06QAYBgoJ5vOt31H8fBn3LJ9LWxvn2ynf4YU777y2yNn5RDw/c7iYYrsMf5mCpX+9frgZQoKPZRprrzoyrxV37vgzwkbawXVNhTgWQImrTYfZm2cqUMSN+s9vzZo6G7yM9zVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714230560; c=relaxed/simple;
	bh=Ve/DVtowgCJsepHMjLGBp53712qQkX0ykyvE1os8Ah0=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=jrl2osvWUqoXFCfFx5E36uHSsWuy+XUAZu2X/QmX3xR9FKcKXS3RhBxH3bXJlPB461eYj7hSm4urSsi0nota4vOiHc4sJLlOxyiwWf9VWWIKhqOIBLF7iO4CHGer7RfRnT4/zNVoHTPkPvANsoBEtFJ4uK4coAaFLKxAbkMgH2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4VRX4f5SdSz5tsf
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 16:28:02 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4VRX4T3GBbzRnmF;
	Sat, 27 Apr 2024 16:27:53 +0200 (CEST)
Message-ID: <0241021e-0b17-4031-ad9f-8abe8e0c0097@kdbg.org>
Date: Sat, 27 Apr 2024 16:27:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
To: Git Mailing List <git@vger.kernel.org>
Cc: Pratyush Yadav <me@yadavpratyush.com>, Junio C Hamano <gitster@pobox.com>
Subject: Git-GUI change of maintainership
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

In [1], Pratyush has expressed the wish to hand over maintainership of
Git-GUI. Since Git-GUI is an important tool in my toolbox, I would
volunteer to pick up the task.

Pratyush, please let us know if this would be OK for you.

I will let you all know if and when I have set up a repository to pull
from or to fork.

[1] https://lore.kernel.org/git/mafs0wmxkcs3o.fsf@yadavpratyush.com/

-- Hannes
