Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A421238DC3
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 23:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ncy3QerM"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265551727
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 15:27:06 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C63621BF87;
	Thu,  9 Nov 2023 18:27:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=h1JAISxAPf0oMlKQpeaD4Fdp9NlZT+o654GZY9
	W1wzU=; b=ncy3QerM6J1SiFTwF893Di7Tqte3OckuF9NAN3laSduIs6prz9u37p
	yzw1BOvkPfgajSRqCxXZsSg19KHuIBp7I4IzIr41fcaCkF9QfOcZs+WW8i6nzcuW
	WykY1BjD8KEsGCSPxU9yi9xTw7ZUJRnt12mFH7aSBzRzsp7gtw1tQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BE4EE1BF86;
	Thu,  9 Nov 2023 18:27:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 540241BF80;
	Thu,  9 Nov 2023 18:27:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Joanna Wang <jojwang@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] attr: enable attr pathspec magic for git-add and
 git-stash
In-Reply-To: <xmqqsf5mgl0r.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	04 Nov 2023 14:11:48 +0900")
References: <20231103143508.896745-1-jojwang@google.com>
	<20231103163449.1578841-1-jojwang@google.com>
	<xmqqsf5mgl0r.fsf@gitster.g>
Date: Fri, 10 Nov 2023 08:27:00 +0900
Message-ID: <xmqqwmuqy0cb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7C8D82B6-7F57-11EE-B170-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Thanks.  The compiled result from this version looks quite good.  As
> you started a new round with typofix, let me start the final
> nitpicking.
> ...
> Here is what I ended up queuing.
>
> Thanks.

Any comments on the "counterproposal to fix nitpicks"?  I'd like to
make sure the original author is either OK with the update (in which
case I can just move what I have in my tree forward) or unhappy with
it and plan to send in an update on their own (in which case I can
wait for the next iteration), in a case like this.

Thanks.
