Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D58C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 00:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205C06141E
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 00:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhD3AHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 20:07:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54685 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD3AHz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 20:07:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DB5AD733D;
        Thu, 29 Apr 2021 20:07:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oPOHMB7Mx1DJ
        HLG1EMrDPHPC7cIlUcx0vywvMGMePSc=; b=NGgciaOOOBV0BrRr5UtpVW8d9Ki2
        3DtqmODnXFmis2fMBUq1ppX6SyvQJzpFY0qV0e6ltDGix492NTUXtFOxiXnPck3a
        f63/eLeS2YVlCVam9JIbcX0is+saCVxPF0zy89/z20RrM49IlknYwJkPAjqf6t+B
        ohWFukpR/V4elWw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00CF0D733C;
        Thu, 29 Apr 2021 20:07:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D572D733A;
        Thu, 29 Apr 2021 20:07:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: Nesting topics within other threads
References: <87k0omzv3h.fsf@evledraar.gmail.com>
        <patch-1.1-e1d8c842c70-20210428T161817Z-avarab@gmail.com>
        <1ecb3727-106f-3d04-976a-36aa03a61caf@gmail.com>
        <xmqqsg397jyj.fsf@gitster.g> <8735v9z32l.fsf@evledraar.gmail.com>
Date:   Fri, 30 Apr 2021 09:07:04 +0900
In-Reply-To: <8735v9z32l.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 29 Apr 2021 14:14:52 +0200")
Message-ID: <xmqqa6pgfxef.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FFCB73B0-A947-11EB-96D7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> In RFC 822 terms. Are you talking about the In-Reply-To[1] or
> References[2] headers, or both/neither?

Neither (I think Peff explained why it is a good idea to defer to
verbal communication not to confuse tools better than I could).
