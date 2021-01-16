Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AE3C433DB
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 07:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9E423A55
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 07:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbhAPHCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 02:02:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52996 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbhAPHCB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 02:02:01 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB95CAB2C9;
        Sat, 16 Jan 2021 02:01:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I2OYnSbvC1fNK1+tp09SX3wWh5M=; b=AIlEpq
        dsMt/w6RGmaLy/qS5+gCxntFrlaYuoz0wXbLfoLn/t1JcAls40nNqPBawsJUSVqv
        WAF/DU5YcCtJD5AXHVTk/qOMfHdVPtZ6ov4M0VujMKe88OQDAJjJ4Mp/wGLe+4rU
        yUGhS2iCpA2Hl0NTZWV8UU8RHQAGqsrL6MRhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jr2uVHYmjOgvQGDGAlGaif4UEh5KbOUc
        MrTAEHubRQaKQL51wMs5mvOxHeEk7z5ovzHpC4Ozin/36ZAQKwbhRH+DL3TWm5pA
        4PZeEAel+gNRzQNpggmWcHx4v+aMzCFtQk6pLYuHmAbUA9f9IPnWiUMb5fTwJz2v
        9f67/0/bO1s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2A51AB2C8;
        Sat, 16 Jan 2021 02:01:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E834AB2C7;
        Sat, 16 Jan 2021 02:01:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 00/32] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201221152000.13134-1-sorganov@gmail.com>
Date:   Fri, 15 Jan 2021 23:01:17 -0800
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com> (Sergey Organov's
        message of "Mon, 21 Dec 2020 18:19:28 +0300")
Message-ID: <xmqqmtx9pdqa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1C53862-57C8-11EB-A378-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> These patch series implement new set of options governing diff output
> of merge commits, all under the umbrella of single
> --diff-merges=<mode> option.

This latest round hasn't seen much review reactions, so I gave it a
read-thru with fresh eyes.  I didn't spot anything objectionable, so
let's start merging it down to 'next'.

Thanks.

