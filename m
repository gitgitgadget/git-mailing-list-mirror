Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BC621F89C
	for <e@80x24.org>; Mon, 16 Jan 2017 00:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdAPAf2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 19:35:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63588 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751122AbdAPAf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 19:35:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 467A8610CB;
        Sun, 15 Jan 2017 19:35:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7ZeIfxFcrsnR9I37zqb8iario6Q=; b=WW0NM7
        aNjBK4ffALoe/qgbxUIpxW35RO622GfAy+NsvwpRk/1E1K+Ad1+ooYQFQqqJ3t4K
        jFd7PSzuH21kFYqtsESNReS7vowyGebF2Tp1uxKxR1nmG0rVzW0OB5Wviuzwv1mj
        l7HSVNU55TFFd5Ng3a1Jv0cp7svYB8qxHbZHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k7n8egGy/eYN3VvT9GFK7f/k6UmrMDFk
        SuqxTiiks0DxtQ5QyMK5HVY4qE8jgZ17CQs7Mkl3/0Tmm1JcCk5XC/Yvqy7QODDa
        eeDx3jt6S2jUg1UPvvVwT6nVFGlZ5t9Srq3ZUG622vWpZ3ADyFhqzRSf8q0bqZTk
        6LfQlufhZ+o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E76A610CA;
        Sun, 15 Jan 2017 19:35:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97C67610C8;
        Sun, 15 Jan 2017 19:35:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC for GIT] pull-request: add praise to people doing QA
References: <20170115183051.3565-1-wsa@the-dreams.de>
Date:   Sun, 15 Jan 2017 16:35:24 -0800
In-Reply-To: <20170115183051.3565-1-wsa@the-dreams.de> (Wolfram Sang's message
        of "Sun, 15 Jan 2017 19:30:51 +0100")
Message-ID: <xmqqlgubc04z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC20B55E-DB83-11E6-B9BE-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

> === new stuff starts here
>
> with much appreciated quality assurance from
> ----------------------------------------------------------------
> Andy Shevchenko (1):
>       (Rev.) i2c: piix4: Avoid race conditions with IMC
>
> Benjamin Tissoires (1):
>       (Test) i2c: do not enable fall back to Host Notify by default
>
> Vladimir Zapolskiy (1):
>       (Rev.) i2c: print correct device invalid address
>
> === diffstat, ...
>
> This patch is a very early RFC to collect opinions. I am not very familiar with
> the git codebase, but I guess using a filter needs to be reworked, the
> dependency on GNU awk may be frowned upon (though 'asorti' is really useful
> here), the reg-ex are not super-solid, and it should be a command-line option,
> of course. That all being said, it was a fast way to produce what I would like
> to add to my pull requests for the i2c subsystem and to see if other kernel/git
> maintainers are interested in something like this.
>
> Disclaimer: while this patch applies to the git codebase, I have to admit that
> I simply patched around in /usr/lib/git-core of my Debian machine :)
>
> So much for now, let me know what you think,

So the idea is to have list of those whose names appear on
Reviewed-by: and Tested-by: collected and listed after the list of
commit titles and author names.  I personally do not see much
downsides in doing so, but I do not consume that many PRs myself, so
let's hear from those who actually do process many of them.

As to the implementation, I am wondering if we can make this somehow
work well with the "trailers" code we already have, instead of
inventing yet another parser of trailers.  

In its current shape, "interpret-trailers" focuses on "editing" an
existing commit log message to tweak the trailer lines.  That mode
of operation would help amending and rebasing, and to do that it
needs to parse the commit log message, identify trailer blocks,
parse out each trailer lines, etc.  

There is no fundamental reason why its output must be an edited
original commit log message---it should be usable as a filter that
picks trailer lines of the selected trailer type, like "Tested-By",
etc.
