Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E56C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 17:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA502084C
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 17:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oz6ffZJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436536AbgJPRGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 13:06:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53833 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395456AbgJPRGO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 13:06:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8271580170;
        Fri, 16 Oct 2020 13:06:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WB8qNgflwSDgwIKwlhuo60Z6D2w=; b=oz6ffZ
        JDA+0QrkG3udE9h0o0mVQx2KyYLY+V+GdQC726LBAWLW+OLqz9TE06mFVByEOsuC
        KseTnurwN4nRZFQO0+21Q84GYMoGkDEXsYp4L2vXQDgyQY7lABlErsAfzLMGq4s5
        esxTMHN3MtelMyS5oFQOmfJBxhGnN/VWYhths=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BBLtsTNxhuXVRz/Y33/LH1wA8po+csks
        ABdhUn2+NzPz9rcZxIGaSyEqnj9bLSyiAHncuihZR+sQUWqifof2VuZ6oY48Uw4+
        ckuXuio+g/uyFn6doMQrfBxe5yH3pVzkye0W8/D3ZaT7twFyOFpjRfceFrbiVr6/
        pq+ZRncBhPE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79A498016F;
        Fri, 16 Oct 2020 13:06:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07AC08016E;
        Fri, 16 Oct 2020 13:06:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Haller <lists@haller-berlin.de>
Cc:     Alexey via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alexey <lesha.ogonkov@gmail.com>
Subject: Re: [PATCH] Fix zsh installation instructions
References: <pull.814.git.git.1593687080695.gitgitgadget@gmail.com>
        <xmqqr1to8dv9.fsf@gitster.c.googlers.com>
        <abc4ab95-ed65-1d6b-e964-73734c08cda9@haller-berlin.de>
Date:   Fri, 16 Oct 2020 10:06:12 -0700
In-Reply-To: <abc4ab95-ed65-1d6b-e964-73734c08cda9@haller-berlin.de> (Stefan
        Haller's message of "Wed, 14 Oct 2020 17:10:23 +0200")
Message-ID: <xmqqpn5icd8b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E50F973C-0FD1-11EB-A06B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Haller <lists@haller-berlin.de> writes:

> On 07.07.20 0:42, Junio C Hamano wrote:
>>> From: Alexey <lesha.ogonkov@gmail.com>
>> Thanks.
>> Any zsh users raise their hands?  Does this change look sane?
>
> Sorry for the late reply, I only saw this now.
>
> Yes, the change is sane. The wrong file extension (.zsh vs. .bash) was
> a documentation bug that I had noticed myself, but forgot to submit a 
> patch for.
>
> The other hunk (adding compinit) is not so important to me; I suppose
> it was not in the original version because most zsh users already have
> this in their .zshrc anyway. But it's not wrong, and doesn't hurt to
> have here, I guess.

Thanks.  Will queue.
