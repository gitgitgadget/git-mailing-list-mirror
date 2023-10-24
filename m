Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F44734A
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iETbNwaR"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8B13AB7
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 15:27:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BED63218AC;
	Tue, 24 Oct 2023 18:27:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ImGMaVDK3JznZfFy6OZoMUy2O/CJ2Vyu4UngVr
	6UC00=; b=iETbNwaRxXMvCy0SZKDD1TM2ry/fx4bJKUq8NSK3zx8wb6PrR51MLb
	+QuYSL1lxdrdL8Z/dKVGXJJI+etFoJAzS38FF+EH7nd+WC6idu+IJxObgNEsQZNc
	mDsIvQAwS72kH/sHDNCUSFZ1/zW4pNSQSaqpStJwsW+u0iKcnY7l8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B8130218AB;
	Tue, 24 Oct 2023 18:27:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4DC5F218A7;
	Tue, 24 Oct 2023 18:26:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Andrei Rybak <rybak.a.v@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] SubmittingPatches: call gitk's command "Copy commit
 reference"
In-Reply-To: <20231024195123.911431-1-rybak.a.v@gmail.com> (Andrei Rybak's
	message of "Tue, 24 Oct 2023 21:51:06 +0200")
References: <20231024195123.911431-1-rybak.a.v@gmail.com>
Date: Tue, 24 Oct 2023 15:26:56 -0700
Message-ID: <xmqqedhj3bdb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 71C6B606-72BC-11EE-ACF1-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Documentation/SubmittingPatches informs the contributor that gitk's
> context menu command "Copy commit summary" can be used to obtain the
> conventional format of referencing existing commits.  This command in
> gitk was renamed to "Copy commit reference" in commit [1], following
> implementation of Git's "reference" pretty format in [2].
>
> Update mention of this gitk command in Documentation/SubmittingPatches
> to its new name.
>
> [1] b8b60957ce (gitk: rename "commit summary" to "commit reference",
>     2019-12-12)
> [2] commit 1f0fc1d (pretty: implement 'reference' format, 2019-11-20)
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  Documentation/SubmittingPatches | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for a very well researched log message.  Will queue.


>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 0e2d3fbb9c..653bb2ad44 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -266,7 +266,7 @@ date)", like this:
>  	noticed that ...
>  ....
>  
> -The "Copy commit summary" command of gitk can be used to obtain this
> +The "Copy commit reference" command of gitk can be used to obtain this
>  format (with the subject enclosed in a pair of double-quotes), or this
>  invocation of `git show`:
