Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FE924A1D
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DRk0//yl"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F47EE8
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 16:55:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 29575288C1;
	Tue, 31 Oct 2023 19:55:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=egb12o4Kufc8Yo/NC4EbKUT3R8/paqzQiXtJPs
	LlSuw=; b=DRk0//ylff2mXdYZoBfwNkII42ugojPZvpZJNlE9wmQ8DYQrRAIqZz
	janHOw0JCe9cx4Sd4SS649zFt57P/8CRdF0dUmlxuFC1EnHKujFmjhp/IjUl6hOS
	J6yJpMmJgiaG0nubyjyLcsb6d2JasxBGpmN8pkmgHJpeu3esd5OLc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 222E5288C0;
	Tue, 31 Oct 2023 19:55:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BAAF5288BE;
	Tue, 31 Oct 2023 19:55:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Taylor
 Blau <me@ttaylorr.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/2] commit-graph: detect commits missing in ODB
In-Reply-To: <cover.1698736363.git.ps@pks.im> (Patrick Steinhardt's message of
	"Tue, 31 Oct 2023 08:16:09 +0100")
References: <cover.1698060036.git.ps@pks.im> <cover.1698736363.git.ps@pks.im>
Date: Wed, 01 Nov 2023 08:55:52 +0900
Message-ID: <xmqqlebiz6rb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 06D7D090-7849-11EE-A2E5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is version 3 of my patch series to more readily detect commits
> parsed from the commit graph which are missing in the object database.
>
> Changes compared to v2:
>
>     - Rewrote the help text for `GIT_COMMIT_GRAPH_PARANOIA` to be more
>       accessible.
>
>     - Renamed the `object_paranoia` variable to `commit_graph_paranoia`.
>
>     - Fixed a typo.
>
> Thanks!
>
> Patrick
>
> Patrick Steinhardt (2):
>   commit-graph: introduce envvar to disable commit existence checks
>   commit: detect commits that exist in commit-graph but not in the ODB

Yikes, isn't this already in 'next'???

