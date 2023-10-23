Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E821B26D
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EZ1ZRfzu"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1761AD68
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:13:21 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C094727C2C;
	Mon, 23 Oct 2023 16:13:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=86cj2W7pJAvBut9teVKM5ZQ2jmMS+Jm4IJ1yPm
	6CPBc=; b=EZ1ZRfzuzF4eustJ0BGRZ58Zk2zrvfELBCs0hrXZkeSQEKSLbtc4E9
	UI2Px+0JT77NECu5OB5hMuA+hk1uA9TPy/G2Yz6M02nkzNeIXTGXCoJXVvQaA524
	HPoVzxIoflrAb4SILuH7smeHubdvq6S67DcerNlcZfjQzyH2kaZ+c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B8E6327C2B;
	Mon, 23 Oct 2023 16:13:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DBE6827C29;
	Mon, 23 Oct 2023 16:13:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,
  jonathantanmy@google.com,  calvinwan@google.com,  glencbz@gmail.com
Subject: Re: [PATCH v3 0/5] config-parse: create config parsing library
In-Reply-To: <ZTbK3QTJYXxYj/M6@nand.local> (Taylor Blau's message of "Mon, 23
	Oct 2023 15:34:53 -0400")
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
	<cover.1695330852.git.steadmon@google.com>
	<xmqq34y9jho2.fsf@gitster.g> <ZTbK3QTJYXxYj/M6@nand.local>
Date: Mon, 23 Oct 2023 13:13:15 -0700
Message-ID: <xmqqr0llm71g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9A39CE66-71E0-11EE-AD5F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> This feels like churn that does not yield a tangible pay-off, at least
> in the sense that the refactoring and code movement delivers us
> something that we can substantively use today.
>
> I dunno.

That matches something I felt but was too polite to say aloud ;-)
