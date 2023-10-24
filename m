Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BE310E5
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 00:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DaxzHt/R"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D711A4
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 17:12:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A5D328940;
	Mon, 23 Oct 2023 20:12:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=86/POQUxICbXCwjf8s8i1UVcMNOLBgnlQVNDLv
	KPzas=; b=DaxzHt/RzgLgJ0QKPuE+uINfYWkm3GC+ADAdW0SWe+KY3fuUSgIo6/
	Gfo3tc4E0nGL9c4+XgIeghVpsg+7ATh470biJ6RZ54TZnrxvczDBIcS3KGrO/ytp
	V2wbrU+cWnCxrjPQCpGNL4W7wIM/TL9Bsar9sE9Xy3IoVAfIuD3T0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 02C3C2893F;
	Mon, 23 Oct 2023 20:12:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 666692893E;
	Mon, 23 Oct 2023 20:12:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Javier Mora <cousteaulecommandant@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  cousteau via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2] doc/git-bisect: clarify `git bisect run` syntax
In-Reply-To: <CAH1-q0hNSKgr1-dtZac=z7Bx15gON0Y-1pyBM57zuXaFPaJJKQ@mail.gmail.com>
	(Javier Mora's message of "Mon, 23 Oct 2023 23:53:16 +0100")
References: <pull.1602.git.1698004968582.gitgitgadget@gmail.com>
	<pull.1602.v2.git.1698088990478.gitgitgadget@gmail.com>
	<CAPig+cQuBwzaG7ZssGUY6k8wf8pcGZHAGLnbRy579uTPMKqwKQ@mail.gmail.com>
	<CAH1-q0hNSKgr1-dtZac=z7Bx15gON0Y-1pyBM57zuXaFPaJJKQ@mail.gmail.com>
Date: Mon, 23 Oct 2023 17:12:07 -0700
Message-ID: <xmqqfs207uaw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F912BC4C-7201-11EE-8174-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Javier Mora <cousteaulecommandant@gmail.com> writes:

>> the patch subject becomes a bit outdated with this addition.
>
> Right; I wanted to change it to something like "clarify `git bisect
> run` syntax and other minor changes" but wanted to keep the title
> concise.
> I guess I could change it to just "clarify `git bisect` syntax" though
> remove the "run").

Quite honestly, I think at this point we are entering into the
"diminishing returns" territory.  The title is still clear enough,
and the patch is good.

Thanks.  The patch has been merged to 'next'.
