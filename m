Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F5437F751
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380057; cv=none; b=mGrrkyVHzAyNx4cNK7hwtz1BMXlW/Rgj4D6dYA2sGdDcdJlnz96vN3blefBlfk4lj8ckggneyTiI3sGQiYd01TEDEEeT7W3M01q0cSPV902+EN7zbuk5syisPKbS84Yq0gcbVT/TDo6m1XFBFSdtUS/1mRDNO65quWxR4D/h1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380057; c=relaxed/simple;
	bh=QMxf3nrpQGKcCjL9FhvyuG5eV8YKKSrivKjHjAtRftI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOyETtf15u7vWnXcl1Gw6iTMKhbC/2wAF57pyGg2DpZdPhxdvBMOWNzNSEGE81i9bViqXCkvGmKlMaNUjGnhnRJXOnCXu318CMlDT4TSc9Cd+6bsZAGiQIlzyPw8s4cp+5IBbEQFwkhJ48emnZ3q+d5TWhBxpyxPmcBXIxz/PYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4drfhX56Zhz7QgNG
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 09:40:44 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4drfhM0QLCzRnlX;
	Wed, 14 Jan 2026 09:40:34 +0100 (CET)
Message-ID: <e0e82af6-7577-43ba-beef-944715d7743b@kdbg.org>
Date: Wed, 14 Jan 2026 09:40:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] merge with Scheme regexp; fix bugs
To: "Scott L. Burson" <Scott@sympoiesis.com>
Cc: "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>,
 Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Jaydeep P Das <jaydeepjd.8914@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
References: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
 <pull.2000.v2.git.1764211096.gitgitgadget@gmail.com>
 <86315aa3e36afa1ee741a2c9b9e95a71ca569302.1764211096.git.gitgitgadget@gmail.com>
 <b6656e6d-d1e8-4ebe-821f-9211643a71ab@kdbg.org>
 <7c642644-09a5-4a50-931b-a630d459932d@kdbg.org>
 <CAF5LJ4DrKkJpCfOkkEsYvDH7qF1Bx-v75GryxUbr6UgmJq05cw@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAF5LJ4DrKkJpCfOkkEsYvDH7qF1Bx-v75GryxUbr6UgmJq05cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 14.01.26 um 07:18 schrieb Scott L. Burson:
> The branch now contains two commits, yours and mine.  Do I just
> do /submit at this point, or do I need to submit them separately?

You should submit both commits with a single /submit command.

Before you do so, though, you may want to update the authorship of my
patch (`git commit --author="Johannes Sixt <j6t@kdbg.org>" --amend`).
That you have appended your own sign-off to the commit message is very
much appreciated.

-- Hannes

