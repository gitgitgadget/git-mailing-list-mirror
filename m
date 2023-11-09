Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B87338FA2
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hpd7C2Wc"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0293449E
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 15:33:54 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 46B271C362;
	Thu,  9 Nov 2023 18:33:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CdGgkddS0aI1W2ex+4DA8FK5enrpFxvPHN/OCa
	QYfBI=; b=Hpd7C2WcubBf8ybQnbSWMButq3BrV+zeynTganHK6pi6Y2pb+GdIJw
	74t9toYcY8txOsoy0S4tP9mooRNg6um3I/cOhUNAWWq7I8iXYPnvlQ3beRfv7AdX
	E7YBvwuzb0KcBABPxTWo7FEtAjBczqeCHlt+ZCeIGBMbuMniXp+ec=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E8831C361;
	Thu,  9 Nov 2023 18:33:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D17CF1C359;
	Thu,  9 Nov 2023 18:33:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>, Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2023, #04; Thu, 9)
In-Reply-To: <ZUzcmsfJe6jk4fTk@nand.local> (Taylor Blau's message of "Thu, 9
	Nov 2023 08:20:26 -0500")
References: <xmqq34xg5ek3.fsf@gitster.g> <ZUzcmsfJe6jk4fTk@nand.local>
Date: Fri, 10 Nov 2023 08:33:49 +0900
Message-ID: <xmqqpm0iy00y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 700BFDAA-7F58-11EE-975B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Nov 09, 2023 at 02:40:28AM +0900, Junio C Hamano wrote:
>> * tb/merge-tree-write-pack (2023-10-23) 5 commits
> ...
> This series received a couple of LGTMs from you and Patrick:
>
>   - https://lore.kernel.org/git/xmqqo7go7w63.fsf@gitster.g/#t
>   - https://lore.kernel.org/git/ZTjKmcV5c_EFuoGo@tanuki/

Yup, I am aware of them.

> Johannes had posted some comments[1] about instead using a temporary
> object store where objects are written as loose that would extend to git
> replay....

I was hoping to hear from Johannes saying he agrees with the above.
It is not strictly required, but is much nice to have once we hear
"let's step back a bit---are we going in the right direction?" and
it has been responded.

Thanks.
