Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0D1B1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 17:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfHGRPu (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 13:15:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63093 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729938AbfHGRPu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 13:15:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A25E8C61A;
        Wed,  7 Aug 2019 13:15:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VNBdTlpGV7FWox6SP6V9gJqBQ8I=; b=o2Ktsg
        LuchAe+OqgT3mV7T73KCtSPvIh0fX7fl83MaPu1ej7twYMd7Jh5+AqOazkgv6sYM
        ikhUcaOAF43v3mdYT5cSnagcqzFgvRGQ7Xzqp02U3IuObjuCMMgY69lP+4E9fLmA
        AbShVUlruWeoxI/TfXhtqPSNN535svE1Mv/Es=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tSzjWhP6MND2rLZVHivhexgStOO/AGLX
        b6YpifVwnJrZuICoh26rJ/cYijjE3Bea4PhkxW73qZvZBTFCUbmytpitCx78LikZ
        9VTPu5HjKd9KnDyS8f4M46h3GecIcIrnaUmbCtgjPHGtr2VCumiMrNeqLvG7pH8C
        Obuw/+eMVtU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 82BFE8C619;
        Wed,  7 Aug 2019 13:15:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A5A2B8C60A;
        Wed,  7 Aug 2019 13:15:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Andrew Ardill <andrew.ardill@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        git <git@vger.kernel.org>
Subject: Re: RFC - Git Developer Blog
References: <20190806014935.GA26909@google.com>
        <CAH5451=Qa5BGnoRdvtcmT6mXXK+i8iD7WAkKFfNU4b6J-0bX9g@mail.gmail.com>
        <e97608ed-1900-e2c0-c20d-e73586c1fdd5@gmail.com>
        <20190807170735.GA61464@syl.local>
Date:   Wed, 07 Aug 2019 10:15:43 -0700
In-Reply-To: <20190807170735.GA61464@syl.local> (Taylor Blau's message of
        "Wed, 7 Aug 2019 13:07:35 -0400")
Message-ID: <xmqqef1wj3r4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE479012-B936-11E9-8B37-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> It would also be helpful to have a post for every major release
>> highlighting new features and giving users examples of how to use them.
>> Taylor has been writing these on the GitHub blog [1], but maybe he
>> would be interested in writing them for this new venue?
>>
>> [1] https://github.blog/2019-06-07-highlights-from-git-2-22/
>
> Yes, I generally try and publish a blog post once-per-release, and
> generally with the following two goals in mind:
>
>   - talk about and publicize some of the new features in the latest
>     release (or releases, if I've missed a blog post or two)
>
>   - share some interesting tidbits about existing features.
>
> I think it would be good to have these blog posts in both places, should
> this proposal materialize. I would have to ask about whether or not
> GitHub would be comfortable about cross-posting to a new venue, and I'd
> be happy to raise the question when it comes up.

Yeah, I find these blog postings at GitHub quite helpful.  Thanks
for writing them.

I wonder if a semi-automated republication (ala "Planet"), instead
of cross-posting, is an option that is easier to manage, though.
