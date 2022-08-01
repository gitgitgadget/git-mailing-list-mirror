Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13585C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 16:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiHAQ4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 12:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHAQ4W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 12:56:22 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EA16385
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 09:56:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E45B7139384;
        Mon,  1 Aug 2022 12:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=unaZOsriQji2
        VTFXKbtwTgHtqIFprmty3BpQMpwlEsE=; b=MBOv+EimTnEL7YPTZJXgb57S5Nf4
        CvIh9X1OgJc98BkZdL0knegu92PmPLAPXogt4IHOWQ5btpsY8hpfk/+AlpQYqoid
        vjOx7eAPXAi7uHqnPaLzGm7gXjBH2HgMwFWFPJv6XtJi2F6tMEGI5lbXokT61HEf
        aFGmzM9FabDj1+s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD10B139383;
        Mon,  1 Aug 2022 12:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 50AAD139382;
        Mon,  1 Aug 2022 12:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ab/leak-check
References: <xmqq7d3v33to.fsf@gitster.g>
        <220801.868ro8i2yt.gmgdl@evledraar.gmail.com>
Date:   Mon, 01 Aug 2022 09:56:19 -0700
In-Reply-To: <220801.868ro8i2yt.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 01 Aug 2022 14:01:01 +0200")
Message-ID: <xmqq7d3rzyvg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DDF10C8C-11BA-11ED-9E7C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Just a note on the summary: This isn't "plugging more leaks" (although
> one leak is plugged as it's trivial, and stands in the way of 15/15.
> Suggestion: New test instrumentation for extending SANITIZE=3Dleak
> checking, and marking some existing tests as leak-free.

Good.  Will take it.
