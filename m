Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A481E
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711246785; cv=none; b=mtc1/xJyXk8H/mwQl+WFNmhBYUFGiZa92mTUvzJY0amkVcBPKurgLd+CZGNm5/yasVNNGj1F2UxXx31+cFft+7ZjNFHJxmAvJgeUUt6UlUxDOk3l11hljm93pHNJpCUzaVmMKqpgHd7N2aoHWN5eb23VJug8OqG86DX12c/Wb5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711246785; c=relaxed/simple;
	bh=OD2praSQnflsVQevcuLQ+hibW0DsLUi8RyCseNaVk5k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hr05ZJJtWn5IyVEBAWrE4YOswaX8c5q2ckZ5d0pGN2l/7KEDvIU6YNOvpP4Q32UaC4XmKIEKq9bBoRUZbSBZ27wpVzsiZLitYz86VxjP8jf9z5tk/DUK0QOtKr0ZwP03FK+OzWkhGK1Yt4ehzv3HgWExkAnDmA3wOMZ+vPheWas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pUu5Hbqc; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pUu5Hbqc"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BB134190AD;
	Sat, 23 Mar 2024 22:19:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OD2praSQnfls
	VQevcuLQ+hibW0DsLUi8RyCseNaVk5k=; b=pUu5HbqcE8bbpMYmpm3R+0B6j1Lc
	9FVw7+eJz1cVBr+sXASXqXTy1vrTDRFZ0pbOQI1LDxNCu72Yc8nyMzmWFHcT1umV
	o/ulekTzg5NPNgDrXT/eZpnVT0NUylA7tQneqt2VLUpxZby0mCZIZLSB13jXJYCL
	52hyM4w5z7RENsg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B283B190AC;
	Sat, 23 Mar 2024 22:19:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 402C3190AB;
	Sat, 23 Mar 2024 22:19:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH] doc/gitremote-helpers: fix more missing single-quotes
In-Reply-To: <22254967.EfDdHjke4D@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Sat, 23 Mar 2024 20:58:39 +0100")
References: <20240320091748.GA2444639@coredump.intra.peff.net>
	<519698f1-1daf-4085-9aec-380f44492e72@gmail.com>
	<xmqq7chvblgr.fsf@gitster.g> <22254967.EfDdHjke4D@cayenne>
Date: Sat, 23 Mar 2024 19:19:38 -0700
Message-ID: <xmqqmsqov0at.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F81E8F46-E984-11EE-85C0-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl AVILA <avila.jn@gmail.com> writes:

>> Hmmmm, here, true and false are to be given verbatim.
>
> In such case, it's (`true`|`false`) . As well as the command before.

Yes, they should be given like so, I think.

>> I know we added the _<placeholder>_ thing, but have we added these
>> to Documentation/CodingGuidelines yet?
>>=20
>> Thanks.
>
> No, we haven't.=20
>
> I skimmed over different documentation projects and there's no real con=
sensus=20
> on what the formatting should be in detail, except for some common rule=
s.
> man-pages(7) gives some good hints that we should adhere to, which are =
echoed=20
> in the guide of asciidoc: https://docs.asciidoctor.org/asciidoctor/late=
st/
> manpage-backend/ . Basically, verbatim are in bold, and variables are i=
n=20
> italic.
>
> In our man pages, the asciidoc verbatim are rendered as bold and asciid=
oc=20
> emphasis are rendered as underlined, just like italics,  which adheres =
to the=20
> principles,

What I meant by "verbatim" was "what the user would give Git
verbatim", which are marked up as `true` (or `false`), and typically
typeset in monospace in HTML.  I just checked the prerendered man
pages, and indeed \fB...\fR surrounds verbatim phrases, which was a
bit surprising to me.

> Note that bold/verbatim are usually also used in terms of description l=
ists.
>
> I'm totally ok to change the CodingGuidelines and reroll git-clone and =
git-
> init with these new rules.

So to go back to the original example, what do we want to do instead
of ...

    'option deepen-relative' {'true'|'false'}::

... this?  Like this ...

    `option deepen-relative` (`true`|`false`)::

... or something else?

Thanks.
