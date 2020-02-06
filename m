Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABE2C352A2
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 16:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40ED214AF
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 16:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SK8BtfpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgBFQeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:34:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54811 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbgBFQeF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 11:34:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4AA8BD907;
        Thu,  6 Feb 2020 11:34:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HcZmsNdkfcEv
        CkQPjB/KFeZja5w=; b=SK8BtfpT7K9hZDg0JOgd0YStkkP78LLppN/hkVZAcroK
        9T+LsTomG4nYvbUXd3a/0zsLHCikryfBJR7r8WvMXgA3NohlJ2H6ermdJ48h/5vU
        EkH28FggUg9rwwPBjBbT9+BJ7J0sqgE7rd+ga9PRbcsv1lA13eyoEOYG9/5OCYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QQDUmR
        3EQRzAEWdk82sd1/xB/sq/H9nodJSms7ISmzNwn2s3FuNA5SY+U1jvXU6N/xL0uS
        Hf7n9y0BcP2QfQNNzO3sjVy1OkW2zp1KFZFEIiG3h6HmOKU/OhGKMiL7fIUHKbm5
        zrpBFWy67hgGyCIbcQL3T9Y25chPuwPaJBh9g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9DDCBBD906;
        Thu,  6 Feb 2020 11:34:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6CA38BD905;
        Thu,  6 Feb 2020 11:33:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v7] MyFirstContribution: add avenues for getting help
References: <20200124210148.220007-1-emilyshaffer@google.com>
        <20200124212602.74194-1-emilyshaffer@google.com>
        <20200124215628.GI6837@szeder.dev>
        <xmqqh80kctcn.fsf@gitster-ct.c.googlers.com>
        <20200206010704.GN10482@szeder.dev>
Date:   Thu, 06 Feb 2020 08:33:54 -0800
In-Reply-To: <20200206010704.GN10482@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Thu, 6 Feb 2020 02:07:04 +0100")
Message-ID: <xmqqh803fzf1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7840805C-48FE-11EA-92A1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Fri, Jan 24, 2020 at 03:44:40PM -0800, Junio C Hamano wrote:
>
>> ...  The more important part, from my point of view,
>> is that we offer choices (the proposed doc update illustrates
>> three).
>
> I remember a discussion about whether that list and its archive should
> be open or closed, and I agree that offering choices is good.
> However, since that mentoring list requires registration, we have to
> carefully consider how to present it to newcomers.
>
> Openly accessible knowledge is a fundamental value, and it's the
> foundation of open source.  Therefore, we definitely should not direct
> newcomers to a closed mailing list as the first option, it can only be
> a fallback.

I am not that dogmatic ;-) I would be very unhappy and probably
would not have joined if the main development community was closed,
but I do not think the "knowledge" the "closed mentoring list for
those who are shy" are meant to impart to newbies will be something
that will be so well kept secret that are shared among only those in
the closed list.  I expect the mentoring list to be repeating what
those who graduated "new"-ness consider pretty much common public
knowledge.

Having said that, my reading did hiccup when queuing Emily's text,
in that it listed the mentoring list first, and (more problematic)
the only choice among the three described with a word "great" was
that one.  Also, now I re-read it, the last sentence "You must join
the group to view messages or post", without explaining why it is
set up that way is bound to give a wrong impression, I suppose.  I
presume that the reason why those who wanted to make the mentoring
list closed was because they thought it would be nicer for shysters,
but if that is the case, it probably is better to spell that out.

> The text should list git@vger as the first option, since that's the
> only open mailing list we have, it should clearly emphasize that
> newcomers are very welcome, and should explicitly encourage them to
> post their questions here, no matter how trivial or silly they think
> those questions are, we'll be always glad to answer them.

I have no problem with seeing an expanded invitation to the main
list.  I do not have a strong opinion on the order of three items.

> The closed mailing list can be mentioned third as a fallback for those
> who would prefer not to end up on public record right away or who have
> any technical issues with posting to the main mailing list.

I'll mark the topic on hold (it is in 'next'), and would give the
stakeholders some time to settle the discussion, perhaps with
counter-proposals in an incremental patch form.  Would it be
reasonable to set the deadline around the end of the next week?
