Received: from mail1.dyalog.com (mail1.srv.bramley.dyalog.com [81.187.219.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2FA36D4FA
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.219.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810627; cv=none; b=efkeVMZv9SnaaazdbpRaflUY0IXp8kEXS3uJxeDojZ67uRZ3qGALznON6m4xqHU2hauo1+Rzh3dExOOAxJJpQVCMgdi4s0wkE1Wm4WcQszwdmcz1M9OGxNI9m0/fZHP+Els35FPB8qLB9E94n3vY/oC8PhETJzwL4KtfVJ8twus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810627; c=relaxed/simple;
	bh=8DAT7KjuYDVLyoIn23XLDpSH6vXrWRRUkP/GKaqKWqI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VrT9rznPG0gknGz11mZID3jDILkxNLi9oA8fU0Q7iJTX9PP6e/HpeXkkhIAEe8345pFctiCRrUiigwsLqO7/9EjTE5uc4WYn8QTUFXu3l0mvPfuNqD5taklA0WhAy8z9GXWFbq5jgJkUrDn16hwy/0EefpVzsxZPLzgt8Ui7FC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dyalog.com; spf=pass smtp.mailfrom=dyalog.com; arc=none smtp.client-ip=81.187.219.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dyalog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dyalog.com
Received: from [10.0.0.46] (unknown [62.56.43.190])
	by mail1.dyalog.com (Postfix) with ESMTPSA id CFF311E0790;
	Fri,  6 Mar 2026 15:14:14 +0000 (UTC)
Message-ID: <882432fe-30f5-46c5-9efa-5b8a047283b6@dyalog.com>
Date: Fri, 6 Mar 2026 15:14:14 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: gitgitgadget@gmail.com
Cc: git@vger.kernel.org
References: <pull.2209.git.git.1771774770368.gitgitgadget@gmail.com>
Subject: Re: [PATCH] Fix typo in MaintNotes regarding versioning scheme
Content-Language: en-GB
From: Silas Poulson <silas@dyalog.com>
In-Reply-To: <pull.2209.git.git.1771774770368.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Bump

I'm aware this is a very minor change, but it would be good to not let 
this fall through the cracks.

Thanks,
Silas
