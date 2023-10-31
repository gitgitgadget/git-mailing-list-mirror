Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C01805
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w/f5wJ1E"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0D811F
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 19:17:29 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 23CF61B948E;
	Mon, 30 Oct 2023 22:17:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1NJyYLlosYpj6+ZM0qNY5ZNAue8lQeJ9h9OFjn
	5OK7M=; b=w/f5wJ1EUdJ4f+09Cnejb/NVN61zy5EMDofjNz9fgMa7PpBCRcSJs/
	LD9ACmI5CE2vyO+ikJoLjQDuT87yGjqWOGriHwhk8QkwBoBULUjiFCzsPY32wm7a
	GKk3OgUnDTrhElbaP3RC78uS7PjT3TaQzWJZAljwR5SRUfPg0RT8g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 193C91B948C;
	Mon, 30 Oct 2023 22:17:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7678E1B948B;
	Mon, 30 Oct 2023 22:17:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  emilyshaffer@google.com,
  git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Sheik
 <sahibzone@gmail.com>,  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v3] bugreport: reject positional arguments
In-Reply-To: <xmqqfs1radrj.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	31 Oct 2023 08:31:28 +0900")
References: <20231026005542.872301-1-nasamuffin@google.com>
	<20231026155459.2234929-1-nasamuffin@google.com>
	<CAPig+cTmYtWR=QN3LeN9yw3HmsKEmD2fUiRjKf=eJHhAZyT-yA@mail.gmail.com>
	<3e15f266-c790-4b71-84b6-1328339425c1@gmail.com>
	<xmqqv8apez0o.fsf@gitster.g> <xmqqpm0xeyp9.fsf@gitster.g>
	<xmqqcywwg9am.fsf@gitster.g>
	<881c7fea-47bb-45a9-b6e3-314f9ed9e0cd@gmail.com>
	<xmqqfs1radrj.fsf@gitster.g>
Date: Tue, 31 Oct 2023 11:17:26 +0900
Message-ID: <xmqqzfzz5ydl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A315BE7E-7793-11EE-8273-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> ... it is determining that grep
>> failed in the first place that I find annoying. I've also found the
>> output from test_i18ngrep is helpful when debugging CI test failures.
>
> Thanks, I agree with you that it is very useful for debugging to
> have an explicit "I did not find what I expected to see".  On the
> other hand, the other side is not as severe a problem, I think.  If
> "grep" expects not to see an error message in the output but the
> output has the error we do not want to see, we will see the message
> in the "-v" output when we run test.

Everything I wrote above makes sense, but what I continued this
message with (below---omitted) is total opposite.  Let's discard and
maybe retry sometime later.
