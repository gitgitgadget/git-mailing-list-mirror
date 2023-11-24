Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IAhT49ia"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E03CB
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 18:31:42 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C57D419E3C;
	Thu, 23 Nov 2023 21:31:41 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=p0ktUfEBNEBg
	uqQcYOYt1VfOMTq/ucJ5o/5H3e9lCi0=; b=IAhT49iaQJ2RifMlmrZENDfOIZbG
	3yVKWUTfBEUbGqyvGAd1LlLRYZQmsq1t2bMkuRhYQL/w/Lc86gPneIGFsekuoB3C
	AyJ9OvHsgPq25Z0cZexRpDL0bHNfV3c+qOi/e4meLKKiCl/7TxvJcGiJJiklAckk
	tvTsYFDCi0rZU+Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BD4FE19E3B;
	Thu, 23 Nov 2023 21:31:41 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6234619E3A;
	Thu, 23 Nov 2023 21:31:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Chris Torek <chris.torek@gmail.com>,  Craig H Maynard
 <chmaynard@me.com>,  Git Community <git@vger.kernel.org>
Subject: Re: Orphan branch not well-defined?
In-Reply-To: <CAPig+cS6dAANqm7AcrjU9nhBezXRvB0Y-zPOzdar7s_8E-c28Q@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 23 Nov 2023 21:27:56 -0500")
References: <FE2AD666-88DE-4F70-8D6D-3A426689EB41@me.com>
	<CAPx1Gvf_meaEBq9XfS9aPg0yLja-2sAW5SUg0jx6f1jNyfmWHw@mail.gmail.com>
	<xmqqwmu79ac4.fsf@gitster.g>
	<CAPig+cS6dAANqm7AcrjU9nhBezXRvB0Y-zPOzdar7s_8E-c28Q@mail.gmail.com>
Date: Fri, 24 Nov 2023 11:31:36 +0900
Message-ID: <xmqqlean9913.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 982DF670-8A71-11EE-B97C-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Nov 23, 2023 at 9:03=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
>> +[[def_orphan]]orphan::
>> +       The act of becoming on an <<def_unborn,unborn>> branch.
>
> s/on an/an/

I actually did mean it.  It is not a verb whose subject is a branch.
The user (or you can call a repository) gets on a branch that
happens not to exist yet.
