Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C667F8
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 02:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="T8/TsMSL"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC66C5
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 19:26:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F067B1B94E1;
	Mon, 30 Oct 2023 22:26:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9qq5LGI0U09ZuXJjg8l2UQ9OKjpetmGE9EKvoW
	HIgq0=; b=T8/TsMSLFMuVuUKObrowsde7KBFH4Ww9zcel8oEBQec61KqWYT+6A1
	boV0iciH5SChjCu44r/a/fO5wvqJmM7EIFAHnMPgpkoDVkNicowHVeztRO5cuNnn
	GIr6S0b7bJ0dufcKXpVDGUw1lGzyvPWqN0UYHQHA1L/gpNQaNW+XA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E76261B94E0;
	Mon, 30 Oct 2023 22:26:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 545B81B94DB;
	Mon, 30 Oct 2023 22:26:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 00/12] show-ref: introduce mode to check for ref
 existence
In-Reply-To: <ZUAEyc0i6iISekiM@nand.local> (Taylor Blau's message of "Mon, 30
	Oct 2023 15:32:25 -0400")
References: <cover.1698152926.git.ps@pks.im> <cover.1698314128.git.ps@pks.im>
	<ZUAEyc0i6iISekiM@nand.local>
Date: Tue, 31 Oct 2023 11:26:32 +0900
Message-ID: <xmqqv8an5xyf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E8711E72-7794-11EE-921E-25B3960A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Oct 26, 2023 at 11:56:16AM +0200, Patrick Steinhardt wrote:
>> Hi,
>>
>> this is the second version of my patch series that introduces a new `git
>> show-ref --exists` mode to check for reference existence.
>
> All looks quite reasonable to me. I'm happy with this series as-is,
> though I left a few minor comments and suggestions throughout.

Thanks.  I'll wait for hearing from Patrick and then decide ;-)

