Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D3F199D6
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E8YglDx1"
Received: from pb-smtp20.pobox.com (unknown [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187B8DD
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 13:59:59 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A329A1E5D1;
	Mon, 30 Oct 2023 16:59:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SJL6U9lAhee4MudyEzY3bNV2c+BhOCSN8ORKZj
	5+LRA=; b=E8YglDx1PRXdgCUuezEum2m3BmCmRAV2jD4DbiJknkhGR2CVRbKpFb
	dzaM6kqibVxS+JP5TvJl0NtFItniKS83+IqJ17iyG9V1cSRfrXaPZOBPzs3HU9tB
	56GJe8jv8i7jABFJGdw2ACqsj3Bxgf56NdnnRNLV+spL/ELDYhQys=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9BB241E5D0;
	Mon, 30 Oct 2023 16:59:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 41F5C1E5CF;
	Mon, 30 Oct 2023 16:59:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Robert Coup <robert.coup@koordinates.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2023, #09; Mon, 30)
In-Reply-To: <CAFLLRpJCPxRMJEs5GxNuqmANn+DpuSAfGb9C94qvPuPNDdaWsA@mail.gmail.com>
	(Robert Coup's message of "Mon, 30 Oct 2023 09:31:36 +0000")
References: <xmqq1qddhtpi.fsf@gitster.g>
	<CAFLLRpJCPxRMJEs5GxNuqmANn+DpuSAfGb9C94qvPuPNDdaWsA@mail.gmail.com>
Date: Tue, 31 Oct 2023 05:59:38 +0900
Message-ID: <xmqqttq7ddxh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3E2294A0-7767-11EE-AEF5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Robert Coup <robert.coup@koordinates.com> writes:

> Any thoughts on picking up "upload-pack: add tracing for fetches" [1]?
> It received positive feedback from Taylor and Peff, and I submitted a
> v2 [2] addressing the comments that Peff has re-reviewed.

Thanks for pinging.  It slipped through the cracks.

Queued.
