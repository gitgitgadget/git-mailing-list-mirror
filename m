Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uaxl5V7q"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A4AB2
	for <git@vger.kernel.org>; Tue, 21 Nov 2023 23:54:41 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D1447291FC;
	Wed, 22 Nov 2023 02:54:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7xteLVrtuHGZTI2qm0+ucH7utnrNxESDYG37Ap
	ekPfg=; b=uaxl5V7qcxPgb1GAhORAB0y/ktielgpvVwtQssax8Lnp5r5UTelrb0
	mPbBaUonxeNGHH7BzYhGWdII/Y76uiUQ7J/vUNNi2UfDxPs5DkQzdXGdkncv/M2u
	WlhfTg6rlUHJDOpddhW81P0jmRbTtOe/HQfSshKSnUqPBNk2rnIfg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CAE1C291FB;
	Wed, 22 Nov 2023 02:54:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 69194291F9;
	Wed, 22 Nov 2023 02:54:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
Cc: git@vger.kernel.org,  Shourya Shukla <shouryashukla.oo@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,  Denton
 Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2 1/6] submodule--helper: use submodule_from_path in
 set-{url,branch}
In-Reply-To: <20231121203413.176414-1-heftig@archlinux.org> (Jan Alexander
	Steffens's message of "Tue, 21 Nov 2023 21:32:42 +0100")
References: <20231003185047.2697995-1-heftig@archlinux.org>
	<20231121203413.176414-1-heftig@archlinux.org>
Date: Wed, 22 Nov 2023 16:54:33 +0900
Message-ID: <xmqq4jhedxza.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 60F6E4A2-890C-11EE-8A94-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Jan Alexander Steffens (heftig)" <heftig@archlinux.org> writes:

> Notes:
>     v2 changes:
>         - fixed code style
>         - replaced potentially unsafe use of `sub->path` with `path`

Hasn't the previous iteration of this topic long been merged to not
just 'next' but to 'master' and appears in a released version of Git?

We are all human, so mistakes are inevitable, but if we discover a
mistake that needs fixing after a topic hits 'next', we take it as a
sign that the particular mistake was easy to make and hard to spot,
and the fix for it deserves its own explanation.  Please make an
incremental update on top of what has already been merged with a
good explanation (explain why sub->path is "potentially unsafe" and
why using path is better, for example).

Thanks.
