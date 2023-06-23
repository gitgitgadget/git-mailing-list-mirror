Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26314EB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 16:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjFWQiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 12:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjFWQiV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 12:38:21 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B932968
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 09:38:10 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8676A1A8410;
        Fri, 23 Jun 2023 12:38:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YryeRpfDUzhdGyaZRuDXrOwdMvt3uCHAGX8aZX
        B3LoQ=; b=j83kASeZFJrEbR4B6qQSxfaqligKJOX5Gx2EeBK6V0kPP83khWjBkD
        ttTggvKgo0l0G/HJT8DpqQ4T/cZnI68d/uB2tZAo0gctC4xgYfVH6BClYwM3tcFI
        SboJM2quBmXlM1suEy9YdZVXSjZL7miEGAs9mFDoX5Gj+datc6WhY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E0FA1A840F;
        Fri, 23 Jun 2023 12:38:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D33E01A840E;
        Fri, 23 Jun 2023 12:38:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: bug in en/header-split-cache-h-part-3, was Re: What's cooking
 in git.git (Jun 2023, #05; Tue, 20)
References: <xmqqedm5k7dx.fsf@gitster.g>
        <20230621085526.GA920315@coredump.intra.peff.net>
        <xmqqttv0hhjv.fsf@gitster.g>
        <20230621202642.GA1423@coredump.intra.peff.net>
        <xmqqjzvwfp6f.fsf@gitster.g>
        <CABPp-BEQ0_UfUbdeFetCsvAnpO_=mvmjQk8JS0trKJtCL=uh1A@mail.gmail.com>
Date:   Fri, 23 Jun 2023 09:38:07 -0700
In-Reply-To: <CABPp-BEQ0_UfUbdeFetCsvAnpO_=mvmjQk8JS0trKJtCL=uh1A@mail.gmail.com>
        (Elijah Newren's message of "Thu, 22 Jun 2023 23:33:24 -0700")
Message-ID: <xmqqr0q2b0cw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 560A7B52-11E4-11EE-845D-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Anyway, your rebase of en/header-split-cache-h-part-3, including
> Dscho's and Peff's changes, all look good to me.
>
> Thanks everyone!

Thanks for confirming.  Let's merge it down to 'next' then.
