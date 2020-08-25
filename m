Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE49AC433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 20:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 549872074D
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 20:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OjAELvvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHYUqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:46:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61233 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgHYUqA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 16:46:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B28D1813DA;
        Tue, 25 Aug 2020 16:45:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8qz0pjeCK9FF+2mCPfClVUlsTmo=; b=OjAELv
        vVtbCO6MXp9gf5jTw/AUt7HgBwH9bqq6rVLMa05UHE1VGWLpTLyC9hLSzmkKTc9L
        n0v/nGDrCKOblhexJ9Q6l5dFfjuQlZ3YDE3orklPCYtRJmVg6S9x16H7IA6EOuwi
        vaDMdbpnaB8l5K8keeWv3uXtyrzJmieLLBsy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h6sp2Vk6UnumcNfEAEoX+0ra05BnAybe
        UYBfunOguDPJEmb8sl4lY4D+FsVRYsT/qTLWsUK0mDTldGt1/o569v2nwyLR6Jcu
        qBQJVaWkCU+BQtYXRHCOI+AOf62anY+BiOAm3/ZnC9EMHa5LztuyDShLx2Sm/Mfx
        tgP1wbv5Eww=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8F79813D9;
        Tue, 25 Aug 2020 16:45:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 389A7813D8;
        Tue, 25 Aug 2020 16:45:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        peff@peff.net, liu.denton@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] submodule: fix style in function definition
References: <20200825113020.71801-1-shouryashukla.oo@gmail.com>
        <20200825113020.71801-3-shouryashukla.oo@gmail.com>
Date:   Tue, 25 Aug 2020 13:45:57 -0700
In-Reply-To: <20200825113020.71801-3-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Tue, 25 Aug 2020 17:00:19 +0530")
Message-ID: <xmqqwo1mzc6y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA91F85C-E713-11EA-9D4F-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> The definitions of 'verify_submodule_committish()' and
> 'print_submodule_summary()' had wrong styling in terms of the asterisk
> placement. Amend them.

I pointed out only these two, but that does not necessarily mean
they are the only ones.  Have you checked all the new code added by
the series?

> Also, the warning printed in case of an unexpected file mode printed the
> mode in decimal. Print it in octal for enhanced readability.

I actually did check this side ;-) and am reasonably sure that there
aren't any other irrational choice of format specifiers.

Thanks.
