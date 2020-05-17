Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1ABC433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 15:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EA92070A
	for <git@archiver.kernel.org>; Sun, 17 May 2020 15:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="USxttYW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgEQPq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 11:46:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56591 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgEQPq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 11:46:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7005573B7;
        Sun, 17 May 2020 11:46:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BH17Vc5lqzp7dVwUX7VM3OmN0t0=; b=USxttY
        W51kFoQz8xi+spvfv8DWZ1Y7P80HGBfoCHITum+3vLCBIvdBFsDL+lYRccHAjrdS
        0RNDKN+3L+ldK+n9Q7qFUkNZH1jzSqRo1mwJXVkmdF2ALikGdKnEq+fxyBp3H/jN
        /gfWAZ702nTnZw88glRNr06TYCCVOLGnRbkzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ftknlaYgbhoH0FT9SYKZqkaJZ1B6u0j4
        zCX0xaw6N4sR19tsLGPeRRClOiGZmM37CncXDNLjCTanH448UCUwQWPqr5QveVSE
        EySvjY6ZA1lUtbQyqcR4QRwzyP5FFwzUbXX/SKyRZ2tKFpSR9fVVyouCagPvBH8N
        zZ4YCTLlZpo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD408573B6;
        Sun, 17 May 2020 11:46:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5EDF3573B3;
        Sun, 17 May 2020 11:46:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Guillaume G. via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Guillaume G." <guillaume.galeazzi@gmail.com>
Subject: Re: [PATCH v2 0/3] submodule--helper.c: add only-active to foreach
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
        <pull.631.v2.git.1589697023.gitgitgadget@gmail.com>
Date:   Sun, 17 May 2020 08:46:53 -0700
In-Reply-To: <pull.631.v2.git.1589697023.gitgitgadget@gmail.com> (Guillaume
        G. via GitGitGadget's message of "Sun, 17 May 2020 06:30:20 +0000")
Message-ID: <xmqq8shq7edu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1E56D9A-9855-11EA-A12E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Guillaume G. via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH v2 0/3] submodule--helper.c: add only-active to foreach

Are we still adding 'only-active'?

Does updating the cover letter needs a better support from our
tools, I wonder...

