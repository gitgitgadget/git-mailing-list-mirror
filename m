Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E62567D
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727032527; cv=none; b=iNIUN60r2Dhd9TpZ6l3nW30QuILg9WoD/T0cR87Nt0rRf67S9VaFioMLCVDRyj2DgYSWtelkkNoetWm96ZsLFhi51332cn974oAVwtz+j+u5TSc5J1GvkAG07jrjheHvKV6OB8jKP/sbgBnH678+PXwaq0BB0WfUaCOsA6S/yMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727032527; c=relaxed/simple;
	bh=5U+hDU3oFBvwZvWW2bsm4bc2GCdEmApJlhtfNQ372O8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EQF5/a0uyozMfeXH+7c2QYDbXBdzuryP+p2agsJU9VbCg2uxwJgIM79l1zoxXeSCn3lkgutXSjXY+/DLOVprsS1OnaITiBJnHiNCET66f4HlEDqsZKZGqCRCWjaqHBOR9embBymDqipro0IpjCypw6f6mCGDcarZx2civ0CJ65g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tjNV13Ah; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tjNV13Ah"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FCC13EE13;
	Sun, 22 Sep 2024 15:15:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5U+hDU3oFBvwZvWW2bsm4bc2GCdEmApJlhtfNQ
	372O8=; b=tjNV13AhXnSrtLGzjSA686bnPlM6NedjhhQAACPjDhJ8Tb+Wu417o6
	c1S5H0HgzCcdyC+oHRbDgkw30ZE3pvXvM1tzcVwEsVi83BfqpgEUD8+C0E/rCLKc
	6vFXS8cRGAtqQG5lGdD8QRXzza3yLSPwx0kGJbe5X9obwJa2Q1NUA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 979DB3EE12;
	Sun, 22 Sep 2024 15:15:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 096263EE11;
	Sun, 22 Sep 2024 15:15:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [TOPIC 07/11] New Contributors and Discord
In-Reply-To: <Zu78E+0Uk5fMSeQv@five231003> (Kousik Sanagavarapu's message of
	"Sat, 21 Sep 2024 22:32:11 +0530")
References: <Zu78E+0Uk5fMSeQv@five231003>
Date: Sun, 22 Sep 2024 12:15:22 -0700
Message-ID: <xmqqsetr5wl1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 049FB188-7917-11EF-9E17-9B0F950A682E-77302942!pb-smtp2.pobox.com

Kousik Sanagavarapu <five231003@gmail.com> writes:

> Another thing that would be great is having a list of things on which a
> new contributor could work on.  GitGitGadget's issues used to do this by
> tagging the appropriate issues "good-first-issue" but I guess it is not
> properly maintained anymore.

True.

> I know there is also searching for "#leftoverbits" or "low hanging fruit"
> on the list but the "good-first-issue" tagged issues on GitGitGadget are
> probably more new-contributor-friendly than whole email threads.

Yes, even with these search terms, finding an issue to work on from
the mailing list archive would not be suited for an absolute newbie
for four reasons.

 * Anybody can write "low hanging fruit" in their message.  Such a
   label added by somebody without understanding the issue would
   lead readers in a wrong direction.  These phrases need to be
   reserved for a case where the person who adds _know_ they can
   solve it themselves fairly easily if they dedicated time on it
   for a few days but deliberately chooses to leave it on the table
   unsolved.

 * "#leftoverbits" is just that---a direction we could explore in
   the future, and the journey that goes in the direction is limited
   to a short and trivial one.

 * Both labels are opinions of the author at the time of writing.
   It may turn out that what was thought of as a "low hanging fruit"
   is not all that easy, and it may turn out that what was labeled
   with "#leftoverbits" would not lead to a productive direction
   after somebody actually tries.

 * And the list archive by its nature will show hits for ideas
   marked with "#leftoverbits" and/or "low hanging fruit" that have
   already been fully explored, and those who completed the task may
   not reference to the original message that inspired them in the
   References: header, so the archive search cannot show that the
   task is completed already.

We could improve the situation for all of the above four downsides
by making it a collective habit to follow-up these messages with
"#leftoverbits" or "low hanging fruit" in it, if the situation
changes, but your "whole email threads" comment still applies.

Unless we make a habit of sending a separate message with such
markings in which we summarize the discussion, that is.

#leftoverbit.  Perhaps one of the how-to documents that describe the
project workflow (i.e. my first contribution, how to review patches,
etc.) can mention the best-current-practice to encourage such use of
these tags?  Something like

 - When you mention a good idea that is not squarely inside the
   theme of the current discussion, instead of adding "#leftoverbit"
   mark in the message, write a separate message as a follow-up to
   the message and summarize the issues and idea in such a way that
   people who later looks for a message with such a mark can grok
   the idea by the message alone, while still allowing them to learn
   more about the backstory by going back in the discussion thread.

 - After you find "#leftoverbit" message and worked on it (either
   you produced a patch series, or you failed and know why the idea
   described in the #leftoverbit message does not work), make sure
   you mention the original "#leftoverbit" message's message-id in
   such a way that a person who found the "#leftoverbit" message can
   find your message.  Sending your patch series as a reply to such
   a message would be the easiest way to achieve it.

or somesuch, perhaps.

> Not exactly a regular community meeting but Review Club was kind of a
> large step towards this I guess.  I was exactly in one review club
> meeting and it sadly got shutdown right after that :').

Anybody motivated enough can take initiative to reignite the Review
Club; you do not need permissions from past hosts to do so.

Quite honestly, I sometimes failed to find much value in the review
these meetings produced, and I suspect it was not due to lack of
preparation on participants' side, but was largely due to the fact
that the face-to-face meetings cannot go to sufficient depth in
technical conversion in a single sitting.

It might have been more productive format if it weren't "let's
critique this series on the fly".  For example, it could instead
have been "There is an excellent reviewer-contributor exchange
thread on the list.  Let's read these exchanges together and learn
how to effectively convey the idea from the original author's side,
and idea for improvements from the reviewer's side".  I dunno.

There however was a lot of value in the mere fact that people had a
face-to-face discussion on something, anything, that was related to
the project.

Thanks.
