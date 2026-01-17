Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABD53FEF
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768637750; cv=none; b=BgfzbuLCCuqxPeSzU/xr2UDTgZ9/Z6KrG7QHySgikrpJK+HvYqEhyOvOEiXBqSSGOT1JznMzSUDwcI39EFxg5xnPBJvpFNoKC9Ht3pwuZ8JTxL9Sq9o8eb4DA0lhwu/iVJmgBrfoR3jNRHYsrPG1/znYNVkYlt+E5z6XSV/AZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768637750; c=relaxed/simple;
	bh=94hoideWpE+rscXbNumhiJY5WvnwzJrYOo7n2CvdwNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWI8+N/OxTYJfsasQss5+OBmt/47JRyMW/doHK/Wwlq+graHiNY4V9z6NwqxaIZwmkkS7bMHlsiZnDe9hKDM8gx0Q34OOm2o6Ot/Cq3NKS2YFBtfxE0Kzx9fZ8tJCjt9yuKHQuBJY4WUqCHFjVZzueKZlLVvq4CqBJisvMp3scw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4dtV0L6rbsz7QgNN
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 09:15:46 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4dtV094trJzRnlL;
	Sat, 17 Jan 2026 09:15:37 +0100 (CET)
Message-ID: <fcfaaab9-d719-406b-bf18-0e4a0ce6a1db@kdbg.org>
Date: Sat, 17 Jan 2026 09:15:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] userdiff: extend Scheme support to cover other
 Lisp dialects
To: "Scott L. Burson" <Scott@sympoiesis.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Jaydeep P Das <jaydeepjd.8914@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
 "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
References: <pull.2000.v2.git.1764211096.gitgitgadget@gmail.com>
 <pull.2000.v3.git.1768519120.gitgitgadget@gmail.com>
 <fb4c8dc5d4434deab9c8f1872f309a79351dc799.1768519120.git.gitgitgadget@gmail.com>
 <3243b63b-b0c1-42d5-beeb-df42b891f09e@kdbg.org>
 <CAF5LJ4Du-x9ND-EHCe0Npz9GaE7kinEYNnpP_416cKpZuxc9hg@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAF5LJ4Du-x9ND-EHCe0Npz9GaE7kinEYNnpP_416cKpZuxc9hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 17.01.26 um 03:09 schrieb Scott L. Burson:
> So how about this:
> 
> - `scheme` suitable for source code in most Lisp dialects,
>   including Scheme, Emacs Lisp, Common Lisp, and Clojure.

OK, let's leave it at that.

-- Hannes

