Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D8DF6D
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cqb+hacS"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FB3A9
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:25:46 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D00A31BAD61;
	Tue, 31 Oct 2023 02:25:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0j4oQ0XUnnw5H9ZwL0WMFkeQ34MG79s6dR8Q/i
	4QbdI=; b=Cqb+hacSy7/fNVft+kiUaOCE7td7m95s1tcdugmd3ws86kPal2IGbX
	YY+pS5XoaiCDt0H387rmjZk4/AujsFAvEcc73W080OvmJyRfNrtqaBxUq7UhQ8xe
	WytsifwiAxmvoQmlQpgV/hr6VA4jH5z9Ri6Ke5FE66e56VWksyQsk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C7A361BAD60;
	Tue, 31 Oct 2023 02:25:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 425E51BAD5F;
	Tue, 31 Oct 2023 02:25:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Hongyi Zhao <hongyi.zhao@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Git List <git@vger.kernel.org>
Subject: Re: Method for Calculating Statistics of Developer Contribution to
 a Specified Branch.
In-Reply-To: <CAGP6POK2yABRhJHQYfOFZ2h6BSy9XU6aZbnBaA11TJiEnBAa6g@mail.gmail.com>
	(Hongyi Zhao's message of "Tue, 31 Oct 2023 13:09:55 +0800")
References: <CAGP6POKg4mSFv-Z+dD1aXDFDbxH9Xu1WCdCA5TGfCAM3NUUQLw@mail.gmail.com>
	<ZS2qZtYDvItovjqg@tapette.crustytoothpaste.net>
	<CAGP6PO+SeZPzD21nErX=Vq=+d6oy-kg+diu=irot3enOhpQNMg@mail.gmail.com>
	<ZUAk6dPJyhfb7UBM@nand.local>
	<CAGP6POK2yABRhJHQYfOFZ2h6BSy9XU6aZbnBaA11TJiEnBAa6g@mail.gmail.com>
Date: Tue, 31 Oct 2023 15:25:36 +0900
Message-ID: <xmqqsf5r2tr3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4E15AD4E-77B6-11EE-A7F6-25B3960A682E-77302942!pb-smtp2.pobox.com

Hongyi Zhao <hongyi.zhao@gmail.com> writes:

>> But I think that there is a slightly cleaner way to compute the result
>> you're after, like so:
>> ...
> So, your method and my original one give exactly the same result.
> Therefore, I can't see what their fundamental difference is.

I think Taylor offered a "slightly cleaner way", and not a
"different way that computes better result".  So it is not
surprising, at least to me who is watching from the sideline, that
you cannot see any fundamental difference.
