Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43155371DCE
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763659190; cv=none; b=XRB3s8FFPw83d6OoMG2oDYwBhulSqyMxQfc4n+0rC/bwL3qfzytDKyewtN9Kab03M3/58J5u3nQxL2BxnLRE51TIQqblFY+cokTS61bahj8ZYEmzA0SVJbOvQNsMrUgNpJdp6ONXXid5FMTWgsluKjS6rWu+IdnehGg5Jvf4EXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763659190; c=relaxed/simple;
	bh=UG8AYBTies+Bhaoe1kQXfTdTqfwv0eKlhbPYe7GvDkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXcVsCUzLuEda5DhMlt/vZl1+58rXD94ep3NfFLe0BP6fmxFNqfZiBbfG0ORfqY0nWuwdgjUke0rXBRa2eiy+C08AEs2y09exudZ042pVFeFjBHpknb1XTk3PkhSyAWuXIUIsslk7ktnCWQCzAUV98/IfI8MpgUguOWY+qJ2ooI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4dC4pf5QvZz7SXyg
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 18:19:38 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4dC4pS6FkpzRpKJ;
	Thu, 20 Nov 2025 18:19:28 +0100 (CET)
Message-ID: <f3c586b0-e7a8-4cf1-96ac-ac8bd0dfcff4@kdbg.org>
Date: Thu, 20 Nov 2025 18:19:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: warn against --committer-date-is-author-date
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk
References: <d17060d9b72.1759952528.git.code@khaugsbakk.name>
 <V2_committer-date-is-author-date.1@msgid.xyz>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <V2_committer-date-is-author-date.1@msgid.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thank you, this round looks good to me!

-- Hannes

