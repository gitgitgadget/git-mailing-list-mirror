Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E65C433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 21:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D693220734
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 21:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ap0cSR+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgFIVD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 17:03:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61305 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgFIVD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 17:03:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C0D2C2CA4;
        Tue,  9 Jun 2020 17:03:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CAGRv6MJZ2Iltp9RSJAz+mLUnBI=; b=Ap0cSR
        +I4fGxcn3hpkDMYO5I0dXq4x6OGlNaAOUIQPOY1y6KkcyajfR0QZuDljcyPb9Vir
        07TjilYns+6PUuvXpMXEsLkAdNu4qkcRw0ZPs44m/OjjUCzHk5HUC7LbF/eGvEhN
        8VSPmtJ2brbZdR+spmk7zMCmPlS/DruiFinh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mo7jZ9siENpiHXyLhvVnrM10ToQ/VawP
        juzEpkTH+VNwNc850jh+Pf+zhWYZO6sXF077I6VWATiVhg5XW0SlYTdDgZRiTJZo
        ls+xRbQ5IzfLqNRmomDnGWkmMNDuFcQZl7A5cXd9CgdNDgnDMYccL94ELOspPEZO
        oK3D0dWXjT0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 54D5CC2CA3;
        Tue,  9 Jun 2020 17:03:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9DE51C2CA2;
        Tue,  9 Jun 2020 17:03:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Simon Pieters <simon@bocoup.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, don@goodman-wilson.com
Subject: Re: Rename offensive terminology (master)
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
        <20200505231641.GH6530@camp.crustytoothpaste.net>
        <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
        <xmqqeeqoi5wc.fsf@gitster.c.googlers.com>
        <CAOAHyQzxG7Lc6+PLBtM6oe9vSoEEAmuXAaKF2VzO_phtkfGRVA@mail.gmail.com>
Date:   Tue, 09 Jun 2020 14:03:52 -0700
In-Reply-To: <CAOAHyQzxG7Lc6+PLBtM6oe9vSoEEAmuXAaKF2VzO_phtkfGRVA@mail.gmail.com>
        (Simon Pieters's message of "Tue, 9 Jun 2020 22:52:28 +0200")
Message-ID: <xmqqo8psgddz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9C1DDB2-AA94-11EA-9FD8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simon Pieters <simon@bocoup.com> writes:

> Hi Junio,
>
> On Tue, Jun 9, 2020 at 6:02 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Simon Pieters <simon@bocoup.com> writes:
>>
>> > If someone is interested in helping with this, please follow up with
>> > Don. But I would like to ask again for git mainline to seriously
>> > consider adopting this change, given the information presented above
>> > and the ongoing movement against systemic racism.
>>
>> I am OK in principle if a future version of Git, when used by a new
>> user of Git who does not have any custom configuration, wrote a
>> string other than 'master' in .git/HEAD when "git init" is run.
>>
>> Picking a good replacement word to mean the primary branch is
>> tricky, though.  Just having a notion that one is special among
>> many (i.e. the primary-ness of the thing being named with a word
>> that will replace 'master') may already be offending to some folks.
>
> I find this response not satisfactory:

And I find that response quite offensive.

I am not saying that there is any good replacement word, or there
shouldn't be one, or we shouldn't look for it.  If we can come up
with a single replacement word and everybody can agree on it, that
would be great.

I am just cautioning you that we may not be able to reach a single
word as a concensus, and you should plan with the possibility in
mind.

In any case, I wasn't responding to satisfy just you in particular
anyway ;-)
