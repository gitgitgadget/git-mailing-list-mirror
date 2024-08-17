Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823CE8BE8
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723912131; cv=none; b=Ccv+R0I7cSRA+cZyCx3KDDnJZQsl7rbFNhdhCzihP6RyI5jl2NecHc3iDW8B6YYE8Y/DLGTJtg0k0kjaA0CD0IrmDMkzxc7zF6c87Nq8OA/gjz2jMF8ZWP1Nmi63bA9qxXmyfdLaVwUf17ve5ZsNxdu69WG0zBrxqojD8zH5gCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723912131; c=relaxed/simple;
	bh=KXBC6+mJGXtcw1hW1ZPsRBp507PgVNxuGpihZNkreLs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SI5aYbWA6ztEnMowrM65fZXc4++5ZhxAbOJIehBodHx5DpjfNbZ7cETNT3W7bPJ8j7oNxPM0i7uVXKmdgwRVgW8oc5FiAuLEyEln0RtKbcyRhMPTsrwF5kZ3Be97xmVzDVlmAXzxFqOU3SbiFd+xwEFKHsOG9XvJYHVfUI5PktQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=L1aemfHr; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L1aemfHr"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 925C33224B;
	Sat, 17 Aug 2024 12:28:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KXBC6+mJGXtcw1hW1ZPsRBp507PgVNxuGpihZN
	kreLs=; b=L1aemfHryW6tVhn61UxTeKdKJ8yDzaFKVHfdb0pYabwZQvQ/NZ6nXn
	swG8kkKvvrMnbyc0ThufPD8NXrwO40ITurhxyE4Md0zihE7swwe/WiTxhe8t7dLx
	U9/hTK9lybeepGSN62gnPOCDYRFsSWNWKH43nQ9iirlV71dN1AlTs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 89E863224A;
	Sat, 17 Aug 2024 12:28:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 34D5B32249;
	Sat, 17 Aug 2024 12:28:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: avih <avihpit@yahoo.com>
Cc: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 5/8] git-prompt: add some missing quotes
In-Reply-To: <12028161.4698975.1723889226498@mail.yahoo.com> (avih's message
	of "Sat, 17 Aug 2024 10:07:06 +0000 (UTC)")
References: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
	<pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
	<3a41ad889cc33a1fc0414b8f14af6438b49c88ee.1723886761.git.gitgitgadget@gmail.com>
	<CAPig+cQVHVoDFD484dxu2gOuvzVHj9-78pyTnCo2-uy6=N5P-g@mail.gmail.com>
	<12028161.4698975.1723889226498@mail.yahoo.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sat, 17 Aug 2024 09:28:38 -0700
Message-ID: <xmqqcym7i05l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C302960A-5CB5-11EF-9E48-BF444491E1BC-77302942!pb-smtp20.pobox.com

avih <avihpit@yahoo.com> writes:

> I was trying to wait few days for more comments on v2 (perhaps
> like yours), but I noticed that v2 was already was just integrated
> into "seen", so I posted v3 to address the existing comments on v2.

Please consider that it is just like being on the list and nothing
else to be in "seen".  It merely is another place some patches I've
"seen" are published, to help those of you who find "git fetch &&
git log -pW origin/master..origin/topic" a more convenient way to
review the changes.  This is outlined in the note I send out
occasionally.

    https://lore.kernel.org/git/xmqqmslewwpo.fsf@gitster.g/

If you think that v2 needs a few more days' exposure to receive more
feedback from reviewers, and that v3 might be incomplete before
waiting for their feedback, just saying so as a response to the
"What's cooking" message is a very effective way to make sure I'll
wait for an updated iteration.  Such a comment on individual topics
is *not* limited to the author of the topic, e.g.

  https://lore.kernel.org/git/owlyil264yew.fsf@fine.c.googlers.com/

is an example (but the particular example was sent a bit too
late---such a "wait, don't merge, an update is coming" needs to come
before the topic is merged down to 'next'.

  https://lore.kernel.org/git/13f08ce5-f036-f769-1ba9-7d47b572af28@gmail.com/

is an example of a reviewer sending a "stop, I have an improvement
to suggest on this one I'll send soon" on a topic by somebody else.

  https://lore.kernel.org/git/Zr2_4sNu56_frqlr@tanuki/

is an example of the author saying "this topic of mine should be
complete already", which is a bit less usual and takes some finesse
to avoid sounding too self-promoting (this particular example does
so well).
