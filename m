Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372FC5663
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 03:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pYO/Gy3R"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABD7A6
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 20:12:46 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 539281B9A63;
	Mon, 30 Oct 2023 23:12:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0WnyWU0JpbkWWVUUAdWXiQoOhiFe3CMe6Ce/Yd
	M5Klw=; b=pYO/Gy3RsgdCmjvha2rLopzaZOG+h/1i4gSj14eHMDgFWo1b8VWWqj
	M6n4M05k3KQgLboxEYV6VoBbrD/ZRRpv3394LuQgZ+N5UT/r3nMdxeRjxRF5TJJy
	+gzhUmh5cvIWsI17kotEt7ycNVTQkIGk0CqRn2Kuy8XV0/JiPFzlE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B4E41B9A61;
	Mon, 30 Oct 2023 23:12:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AFABB1B9A60;
	Mon, 30 Oct 2023 23:12:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Aditya Neelamraju via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Aditya Neelamraju <adityanv97@gmail.com>
Subject: Re: [PATCH] chore: fix typo in .clang-format comment
In-Reply-To: <ZT/gQZlVKfgn/+BZ@nand.local> (Taylor Blau's message of "Mon, 30
	Oct 2023 12:56:33 -0400")
References: <pull.1602.git.git.1698610987926.gitgitgadget@gmail.com>
	<ZT/gQZlVKfgn/+BZ@nand.local>
Date: Tue, 31 Oct 2023 12:12:43 +0900
Message-ID: <xmqqpm0v5vtg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5C4E9A94-779B-11EE-841B-25B3960A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> On Sun, Oct 29, 2023 at 08:23:07PM +0000, Aditya Neelamraju via GitGitGadget wrote:
>> From: Aditya Neelamraju <adityanv97@gmail.com>
>
> We typically prefix commit messages with the subject area they're
> working in, not with "chore", or "feat" like some Git workflows
> recommend.
> ...
> That said, the contents of this patch look obviously correct to me.
> Thanks for noticing and fixing!

As a comment for a new contributor, it is a bit unhelpful not to
suggest what the "subject area" string we would use if we were
working on this patch, I think.

I also suspected that valuve may be a valid word in some language,
as the indentation in the example looked as if the six-letter word
was meant, not typoed.  https://www.gasolineravaluve.com/ was one
of the first hits I saw in my search ;-)

