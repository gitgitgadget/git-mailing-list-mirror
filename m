Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F42773EE
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772361025; cv=none; b=UELwR5/AFIW+XkeXT+io98ZvSUu5Bf/3PsZEOTF8IsDY+D6XUs1cSdQd4U714g4a+PlLN3jYhqT3IGui0/2/b8sZV/MHsDoB3+wt64Vp5UmA4gA0S/ome+4xBX2lMHcCLMG10YnWeBb11WrRSqpIx/s3pf2WM6rBxc7b1ps5vTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772361025; c=relaxed/simple;
	bh=B8qrCatHnOJAy3DHmR7sEH1a7C1pd3uVOwYMiHjMkXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LI26zDZYcSk4mqMXuN032u6OquHuGvTusuu4cPQIW73ZI8K00/S612sRMHsvMWGe9dKvaCySCjfQooxh6gXkj7fWozJOe5iKnRcofzEe1OrSLU3Sk6bRX3Rj4b/LFNFsMV9Og/oXO5K/aBuZTrYR2V8kcgcOXoyahELJuiqlyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4fNyxd5814zRnlY;
	Sun,  1 Mar 2026 11:30:12 +0100 (CET)
Message-ID: <a8dff43f-0454-40a5-93b1-aeb7cab8e9c4@kdbg.org>
Date: Sun, 1 Mar 2026 11:30:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] gitk: support link color in the Preferences dialog
To: Wang Zichong <wangzichong@deepin.org>
Cc: Mark Levedahl <mlevedahl@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Gary Wang <git@blumia.net>, git@vger.kernel.org,
 Gary Wang via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2217.v2.git.git.1772251558434.gitgitgadget@gmail.com>
 <pull.2217.v3.git.git.1772265584806.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2217.v3.git.git.1772265584806.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks, queued.

-- Hannes

