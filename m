Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7BB17BB1E
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483078; cv=none; b=MCYdEvgobwFWw9oHaG2gF+ZrJHO6b91cpw2+1XTvyVBuRRt2KxChsteXHaBmNEZNr5LyiTGh6Kbx+4VSZLLBVrv6phGZRZkqZk0sLpsnMhChyipZcIbhlCHi65YvnGpdE6+ImtB6u+cWNXCXfH9sOvP42U25iyMqJHiErJ1BkLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483078; c=relaxed/simple;
	bh=TSQymEVyWPwb16MocZZXOKtdPU1dbIanxSCbjaeK2lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlUOietjwqMmhP4L8tKCv6TbUC8OsoQR0bVETscCTH50I1YxEucbLhbWHf6EgflQ4ZYXV/01yyYeXv1Ad1nBT5RdV+PaPUTAsK6tyMV2TBDKaJACYeyWPEFWrLSZH7GPSOVBsM/LMk/uudPOcwEKWQ0oaSdkDHsMJkkNiz97C5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4XpFMF71BbzRnlK;
	Wed, 13 Nov 2024 08:31:04 +0100 (CET)
Message-ID: <1fe03d8f-89dd-4a93-b623-4b0838146bbe@kdbg.org>
Date: Wed, 13 Nov 2024 08:31:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] doc: git-diff: apply new documentation guidelines
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
 <c104bd50b646646e980905a9294209f381b9e61c.1731343985.git.gitgitgadget@gmail.com>
 <xmqqo72l8egu.fsf@gitster.g> <7b42828a-2cbe-47c6-b21e-b8c1e3a2ad01@free.fr>
 <xmqq34jw6ci7.fsf@gitster.g> <45211c3c-e077-4de3-a167-0fc973a78dba@kdbg.org>
 <xmqqcyj03vlk.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqcyj03vlk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 13.11.24 um 00:01 schrieb Junio C Hamano:
> With an explicit comma
> in between 1 and base, would we end up with
> 
>     -1, --base, -2, --ours, -3, --theirs
> 
> which may be worse than what we have currently?

Agreed, that would indeed be worse.

-- Hannes

