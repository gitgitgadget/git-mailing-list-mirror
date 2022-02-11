Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04C7C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 16:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351723AbiBKQxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 11:53:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343720AbiBKQxl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 11:53:41 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D6C21F
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 08:53:40 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B569186AB8;
        Fri, 11 Feb 2022 11:53:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jPjMLsVTlJMzhLSH532sgMnMmyfSoyPOjmz7k6
        DS90E=; b=V8KgJP9xLjql8c0hyQAOTsUwxI/0O2SOmJAPQZlO1nRWhLIg4lOaCJ
        K1Ka0pi/rBn7Nvj1TblOzlb4Q8vFX5y4I6c2UKIHo+6i66yAwNTbELYbB1/T6YjW
        azhCfRhZnDvr5m2bJqvIfNIzUg/S1985/YfpBwPqEv4b1LMDgQBW8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 31BE1186AB7;
        Fri, 11 Feb 2022 11:53:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 833CE186AB6;
        Fri, 11 Feb 2022 11:53:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [GSoC] [PATCH 1/1] t0001: replace "test [-d|-f]" with
 test_path_is_* functions
References: <20220121102109.433457-1-shaoxuan.yuan02@gmail.com>
        <20220121102109.433457-2-shaoxuan.yuan02@gmail.com>
        <Yer/oEZK6TBFSsde@nand.local> <xmqqr190g6gd.fsf@gitster.g>
        <CAJyCBORHE2+UMKYFfKArgK68fAT=pKVabVmfifzg--rHAFkaqg@mail.gmail.com>
        <xmqqo83fw5yc.fsf@gitster.g>
        <CAJyCBOTBcvgAcSaQ4xs-V=M-im_Umf3ymsWzCAGEmrj6b38pEA@mail.gmail.com>
        <xmqqv8xmvdoa.fsf@gitster.g>
        <CAJyCBOR7KbRxuXJUJ2TrffAjj=rwB3H-Ys9tVUuWGjUKf_LHsw@mail.gmail.com>
Date:   Fri, 11 Feb 2022 08:53:36 -0800
In-Reply-To: <CAJyCBOR7KbRxuXJUJ2TrffAjj=rwB3H-Ys9tVUuWGjUKf_LHsw@mail.gmail.com>
        (Shaoxuan Yuan's message of "Fri, 11 Feb 2022 17:56:21 +0800")
Message-ID: <xmqqbkzde44v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2844D782-8B5B-11EC-854C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:

> On Fri, Feb 11, 2022 at 1:23 AM Junio C Hamano <gitster@pobox.com> wrote:
>> FWIW, I have the posted patch plus the following SQUASH??? fix-up
>
> I'm not so sure what does "SQUASH???" mean especially the three
> question marks, i.e. is it just an incidental text or a commit message
> convention?
> Is it for the convenience of grepping through the
> "git log" outputs (cause I found the commit 50d631c71c right away by
> grepping through the "git log" output)?

It is primarily to remind me not to merge the branch down to 'next'
without dealing with it.

> Yeah, I think wrapping it around is a good idea :-)

Then will squash it in and merge it down.

Thanks.
