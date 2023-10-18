Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC9C39850
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CVUkSN4u"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3159E115
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 15:46:34 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AA56537C2E;
	Wed, 18 Oct 2023 18:46:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qm7OLAmLnuylixLqxHrNwmRy6Oa+WZuPAvciGu
	BT9Ts=; b=CVUkSN4uXMbJ6jsdzM65YEoE3SitRsqo1AyY5dDZxAZhoabWvczqTu
	Gtz1EJlrjSfR9RNLQz4QH/4J/1/LNaW4haKz6O8Gk/c3iTVJZxUAxDSLCH8xuxVk
	kza11tohk20Mdtf0QzUTlSUbVS4ogbk+HEzbTmFmMRS0P/6B3k2YQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A2A1F37C2D;
	Wed, 18 Oct 2023 18:46:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2243737C2A;
	Wed, 18 Oct 2023 18:46:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Matthew McClain <mmcclain@noprivs.com>,  git@vger.kernel.org
Subject: Re: [PATCH] git-p4 shouldn't attempt to store symlinks in LFS
In-Reply-To: <ZTBbqobbqQpxHPI2@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 18 Oct 2023 22:26:50 +0000")
References: <20231018185854.857674-1-mmcclain@noprivs.com>
	<xmqqil73sp8l.fsf@gitster.g>
	<ZTBbqobbqQpxHPI2@tapette.crustytoothpaste.net>
Date: Wed, 18 Oct 2023 15:46:26 -0700
Message-ID: <xmqqttqnpn0d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2C915554-6E08-11EE-BD5C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Also, as a minor request, it would be great if you could continue to
> email me at my personal address, since that's the address with which I
> read the list.  My work address appearing on series is more of a
> reflection that I'm more frequently finding time to work on things on
> work time (hence the work address) versus personal time (where I'd be
> using my personal email for patches).  I've fixed it up above.

Thanks.

With

    [alias]
	who = !sh -c 'git log -1 --format=\"%an <%ae>\" --author=\"$1\"' -

I say "git who sandals" to get your e-mail address, but I guess I
should use %aE instead to let .mailmap kick in.
