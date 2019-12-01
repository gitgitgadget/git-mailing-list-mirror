Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71980C432C0
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 06:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4742620867
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 06:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G3pIG8hE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfLAGf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Dec 2019 01:35:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50986 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfLAGf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Dec 2019 01:35:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 440843A809;
        Sun,  1 Dec 2019 01:35:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n/Df5C64M2CpHxkYeaExISAou+s=; b=G3pIG8
        hEwEOKtzPtF5gHSRzLEVqkJY9CVXTKdr1w3vkDLF8MXM6z2NqPYDatL8XytoBzBS
        Kdj3FeiilR2Ajy4jSAvdYjOIyfClQmkRayUdxGuav2toEpT9t11F8g+uQbKTCnXM
        EjVE9ZNiVWyJAHsT6SfUmhXSajSZtFzWX20Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XISB1K61RlNXk/xXjvW42uRI34x85Gwi
        vs4MgJWQezdjZIvVkpcIL5vDh95VWtDiKCDOGiiMx+bceZwLOF2L5TTvRsgVeQAG
        CMEtOlbEsd0xMvzS+Ojvh5BlwzuBthO725c8K/w3iEPR5Yt1eH9glU0RforXS9rk
        tSUiRAl57eg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BBB13A807;
        Sun,  1 Dec 2019 01:35:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F5AE3A806;
        Sun,  1 Dec 2019 01:35:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>,
        Junio Hamano C <gitster@pobox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH] Documentation: networking: device drivers: Remove stray asterisks
References: <20191130180301.5c39d8a4@lwn.net>
        <CAHk-=wj8tNhu76yxShwOfwVKk=qWznSFkAKyQfu6adcV8JzJkQ@mail.gmail.com>
        <20191130184512.23c6faaa@lwn.net>
Date:   Sat, 30 Nov 2019 22:35:54 -0800
In-Reply-To: <20191130184512.23c6faaa@lwn.net> (Jonathan Corbet's message of
        "Sat, 30 Nov 2019 18:45:12 -0700")
Message-ID: <xmqqblss1rjp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3EB48C6-1404-11EA-9CBF-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

> On Sat, 30 Nov 2019 17:20:10 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> Do you use some special options for git? Like --whitespace=nowarn or
>> --3way or something like that?
>
> Sigh, that has to be it.  I have --ignore-whitespace in my script. When I
> take that option out, the patch in question no longer applies.

OK, so it appears that the tool is working as documented.  The
"ignore" stuff kicks in to fuzz the whitespace difference for the '
' lines and '-' lines, but the option itself does not give "git
apply" enough information to decide what to do with the extra
whitespace that is CR at the end of the line on the '+' lines.

I would also say it is doubtful that it is working as expected.
Perhaps --ignore-whitespace and --whitespace=fix ought to work well
together to allow matching preimage (i.e. ' ' and '-') lines, but
still fix whitespace-broken material in postimage (i.e.  ' ' and
'+') lines before replacing the preimage with the postimage, or
something along that line?



