Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAD27211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 07:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeLEHk2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 02:40:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50580 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEHk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 02:40:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30BA91198BF;
        Wed,  5 Dec 2018 02:40:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3gzJabBZSs/upC2aD+QixoIx2rQ=; b=RNisP8
        Ip4Ug+cTbQD0SvNdolb2I5nvoPoHeBuSA4f6WcsPctHBJdhQWySdwVDyfWsY+ijK
        mJ2VMmTUXJt9VxDlBD9gxL9R2YTzqRQKh9NrBTXTXmI1Y73W/0Moxq8QYsCR1GwK
        eRwJWKJ3ItKSW0hGIG7N/jBhPawq0CQWsVJ9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x+/yjmL2npIkNq9XQqpVsZ7NEaM6Sw+p
        CWeg5yhBGxLKMPULa6s7b951NSkjznHh2QhdOkqmbR9/AjGJ6/9Fp0fs7JWbFNBn
        bnbb7SNc8MrpR6zHFIWwv/cGsBR306whmll2RzXImokJ/9ZUFq5SohDfiZ5KXcV3
        X04CkmbBDSk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29CDC1198BE;
        Wed,  5 Dec 2018 02:40:24 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A15061198BC;
        Wed,  5 Dec 2018 02:40:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase docs: fix incorrect format of the section Behavioral Differences
References: <f2ed3730-03f3-ae92-234c-e7500eaa5c33@kdbg.org>
        <20181204231709.13824-1-newren@gmail.com>
        <xmqqo9a0d3w6.fsf@gitster-ct.c.googlers.com>
        <CABPp-BG=4K9VCc8zuUm0KTRG5cHPijtvQTK4QXWRVbSFu3o_fQ@mail.gmail.com>
        <76537e8b-3b66-e1f1-eb4d-e9e1c18012df@kdbg.org>
Date:   Wed, 05 Dec 2018 16:40:22 +0900
In-Reply-To: <76537e8b-3b66-e1f1-eb4d-e9e1c18012df@kdbg.org> (Johannes Sixt's
        message of "Wed, 5 Dec 2018 07:57:06 +0100")
Message-ID: <xmqqr2ewbevt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0657C232-F861-11E8-B278-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Please let me deposit my objection. This paragraph is not the right
> place to explain what directory renme detection is and how it works
> under the hood. "works fine" in the original text is the right phrase
> here; if there is concern that this induces expectations that cannot
> be met, throw in the word "heuristics".
>
> Such as:
>    Directory rename heuristics work fine in the merge and interactive
>    backends. It does not in the am backend because...

OK, good enough, I guess.  Or just s/work fine/is enabled/.

