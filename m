Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4A7B2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 18:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753663AbcJYSeV (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 14:34:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57189 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751364AbcJYSeU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 14:34:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90CA64847F;
        Tue, 25 Oct 2016 14:34:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/bvg9DQXz+XtfjlD9eX5jdKOzng=; b=wi8odA
        CUouAGNjakaK/PhfxGhtzEM0D0pJo8vF6CGawG0O9eLXu38V2dnXnMxlq9iuvnU/
        1GDZ2B1RU3ccD70AGX5OgzQmdqKbdyxyQQmybSOwH9atVosQclV/SP08i1ikJnZf
        w9lo4WAGtMB+t4WjKUhxWjmHxqrlwwXeGrs8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ttHU8ji5z51rD7tm9o0bmChi0Kryb6fl
        jl47HnUgQn31Pi9tBDjSaFtePPtPTus3QpO24hg2zSpMYVCQ4khW2WWYDAobmJ+U
        hChjxFJK1yjF8IKMKko4vVsem4l+pNNZw8lvhMjqr3PdD3zG+tnHBcr1Y7OcfBKP
        ZvA1PExJ6mY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88ECD4847E;
        Tue, 25 Oct 2016 14:34:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 083374847B;
        Tue, 25 Oct 2016 14:34:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2016, #06; Mon, 24)
References: <xmqq1sz5tetv.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbtyuSXDiyi2eY6HKCAwEiKgk2KmNakSn=f+RiXCAC1bA@mail.gmail.com>
        <xmqqoa28s63l.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kb2XD8+y-Y_oiwSj3DsXjmTS=bd6fj5dn9NADmvDO5xtQ@mail.gmail.com>
Date:   Tue, 25 Oct 2016 11:34:17 -0700
In-Reply-To: <CAGZ79kb2XD8+y-Y_oiwSj3DsXjmTS=bd6fj5dn9NADmvDO5xtQ@mail.gmail.com>
        (Stefan Beller's message of "Tue, 25 Oct 2016 11:13:35 -0700")
Message-ID: <xmqq8ttcs2fq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3F61334-9AE1-11E6-B10E-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Ok. The first 2 patches are in good shape for this cycle, though.

I thought both of you knew we are in agreement on that by now, but
yes, the off-by-one fix needs to be in the upcoming release.

> So maybe instead of adding !MINGW we rather want to apply
> https://public-inbox.org/git/2908451e-4273-8826-8989-5572263cc283@kdbg.org/
> instead for now?

That sounds good to me.

The "/." thing we would want to come to agreement during the
upcoming feature freeze and it would be very good if we can push the
result out early in the next cycle, but I feel that it is premature
for the upcoming release.

Thanks.



