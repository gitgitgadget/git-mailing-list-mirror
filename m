Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D70CC433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 05:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbiDNFHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 01:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiDNFHV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 01:07:21 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729D01E3EF
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 22:04:57 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E3BC12F9A0;
        Thu, 14 Apr 2022 01:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wiMh8Zo6JQmg86rH7qJF1HFM6bRg4Im8YAGan/
        Y8MK4=; b=g2lOR0sUILpnVAEBjk553ugATvT0DlrMzyrHDGD2jDx0C6obXr0Fkm
        /XQsNIGhnNzMeNSaWCS+GT7yzsxIj6VGOcF7M19DnSw7gXLcm/DeQdOmhJ3BDbsZ
        9Csmw9j3+k3e03OB+o+Rs0hSuOx/2F/KbWKXjX+1k/HnTDmkDpPiY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76B5212F99F;
        Thu, 14 Apr 2022 01:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF98712F99E;
        Thu, 14 Apr 2022 01:04:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Thanks for git and especially thanks for git add --interactive
References: <CANgJU+WApga2t+Ubzz5sk=7AR5pNCy-Sm8P7pwMULsBpmb8asQ@mail.gmail.com>
Date:   Wed, 13 Apr 2022 22:04:54 -0700
In-Reply-To: <CANgJU+WApga2t+Ubzz5sk=7AR5pNCy-Sm8P7pwMULsBpmb8asQ@mail.gmail.com>
        (demerphq@gmail.com's message of "Thu, 14 Apr 2022 06:46:47 +0200")
Message-ID: <xmqqwnfs2r2h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D053B7A-BBB0-11EC-9B67-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

demerphq <demerphq@gmail.com> writes:

> I don't know who to thank directly, and I guess it is a community
> effort anyway, but I just wanted to thank everyone involved in making
> ... I have seen people describe it as an
> "advanced" feature, and maybe it is, but I think it is one of the
> *killer* features of git that has impacted the quality of commits
> across the industry.
> ...
> So thanks to everybody on this list, Linus, Junio, and everybody
> involved with making git such an awesome tool, but *especial* thanks
> to whomever it was that dreamed up the interactive commit modes and
> everyone else who worked to make it such a fantastic tool. It has
> literally changed my life.

You're welcome ;-)

If you limit your search of origin to the Git land, I am reasonably
sure that I am to blame for "add -i", but I'd freely admit that I
stole it from darcs.  They may or may not have borrowed from
somewhere else, but at this point I do not really care where it came
from ;-)
