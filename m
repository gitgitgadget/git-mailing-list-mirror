Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1C5101D2
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="prCM4WaM"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D04119
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 10:27:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C5CF2F1EF;
	Sat, 21 Oct 2023 13:27:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LpToWrl72M9w
	gPf2wSBQoXyLcb5mGVlxrkUoPKD/uzo=; b=prCM4WaMSMUCq5wgW+hntI4H6ayB
	SKEESzUQlxRopXH6hXB52wNjAlH2XN5ZmmI52B+eao8m0JGCFieu8URcnaws7Glw
	pAGr9+fOxwXOMMEE8eDv5YCqnD1uKfTmRKbAGE0f4RM04Oh6KYw5NJohxpjn4Kfv
	CD1ZJZfeqrby25g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 95FDD2F1EE;
	Sat, 21 Oct 2023 13:27:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2AC2F2F1EC;
	Sat, 21 Oct 2023 13:26:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?546L5bi45paw?= <wchangxin824@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] typo: fix the typo 'neeed' into 'needed' in the comment
 under merge-ort.c
In-Reply-To: <DE904895-230C-436E-B7DE-499E6E503DB9@gmail.com>
 (=?utf-8?B?IueOi+W4uOaWsCIncw==?=
	message of "Sat, 21 Oct 2023 09:22:36 +0800")
References: <2DB9ED79-FE58-4072-91E0-B4C51A3F6C5B@gmail.com>
	<xmqq5y32zgnk.fsf@gitster.g>
	<42D0A6FD-1314-4977-92E6-BF6535D82E8A@gmail.com>
	<xmqqv8b1s0pf.fsf@gitster.g>
	<DE904895-230C-436E-B7DE-499E6E503DB9@gmail.com>
Date: Sat, 21 Oct 2023 10:26:55 -0700
Message-ID: <xmqqa5sbubs0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 099DB520-7037-11EE-93DD-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

=E7=8E=8B=E5=B8=B8=E6=96=B0 <wchangxin824@gmail.com> writes:

> Sorry about that, I am not quite familiar with the process. I mean
> I can receive emails at both @qq.com and @gmail.com, but
> <foril@foril.space> in the signed-off-by trailer in the commit
> message doesn=E2=80=99t actually exist.

I cannot tell you which between these two to use, as I do not know
your situation.  When a contributor works on Git and send a patch as
an employee of a company, sometimes the employer wants to see their
name prominently shown in the commit, and that is why we see commits
by folks working on Git for GitHub for example with their
@GitHub.com addresses, even though they may have personal addresses
at @gmail.com.  When a contribution is made as a hobbist (which I
was back when I started contributing to this project), people seem
to prefer using their personal address over using their work
address, so that the name and address recorded in the commit will
stay with them even when they move on.

Whatever name and address you choose, if you are using GGG, you'd
need to update your commits locally, perhaps like so:

  $ git commit --amend --author=3D"Name <a@dd.re.ss>"

(and in the editor you have a chance to make sure your sign-off
matches the authorship).

After that I would suppose that you force push the result to update
your pull-request and /submit again (I am not a user of GGG, so I
may have got the details wrong).

Thanks.
