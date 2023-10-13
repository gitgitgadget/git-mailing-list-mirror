Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7822F1E
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gf0L/bl7"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F398591
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 11:29:22 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C3E71A8CAF;
	Fri, 13 Oct 2023 14:29:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dtIuNXCcD2egVrXXV6EFtxCOS4HS3le492vkd1
	FPd64=; b=Gf0L/bl7F97MF3iN1m/5/f0VuX7iKOnSrawAM1whCEdWysk9EUO4sj
	y131+h7++tMbgLyPwKC7lSaY/+0bJz3nW+QGL5ctOgZGQYifyiHTLoAPRwZgFRI+
	XCZIHUKUrKOUyiAL7kDIRy9eA/drAmQ8IYcU8LLmPE5iXkq1nmcAY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 445F91A8CAE;
	Fri, 13 Oct 2023 14:29:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC6861A8CAD;
	Fri, 13 Oct 2023 14:29:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Isoken Ibizugbe <isokenjune@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] branch.c: adjust error messages to coding guidelines
In-Reply-To: <CAJHH8bE15VotFy7QQ-Npmfk9ePvf=-h5SP+Q8phrDBRj8Ti=hQ@mail.gmail.com>
	(Isoken Ibizugbe's message of "Fri, 13 Oct 2023 16:40:01 +0100")
References: <pull.1590.git.git.1697211227.gitgitgadget@gmail.com>
	<91e4ad3984147fcc277254a3f6836bf79f5c9550.1697211227.git.gitgitgadget@gmail.com>
	<CAJHH8bE15VotFy7QQ-Npmfk9ePvf=-h5SP+Q8phrDBRj8Ti=hQ@mail.gmail.com>
Date: Fri, 13 Oct 2023 11:29:20 -0700
Message-ID: <xmqqr0lyz88v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6DA11F5E-69F6-11EE-B502-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Isoken Ibizugbe <isokenjune@gmail.com> writes:

> I am sorry if I made any mistakes, It's my first time using
> gitgitgadget. This commit was already sent before through git-send
> email. The patch was intended to submit the revisions.

I cannot help with GGG, but it looked strange for this change to be
in two patches, especially since what the rule of deciding which
message is to be touched in which one of the two patches were not
explained anywhere in the series.

I suspect what you want to do is to squash these two commits down
into a single commit, review the resulting code change and also the
commit log message to see if the latter still matches what the
combined patch does, update them as needed, run the test suite
again.

And then format-patch without the cover letter to send the resulting
patch out.  Or force push to tell GGG to resend a new iteration
without any cover letter.

Thanks.
