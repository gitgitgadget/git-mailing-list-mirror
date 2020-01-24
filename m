Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C57EC35242
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 20:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1F020702
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 20:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FBru3ga/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404345AbgAXUgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:36:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58153 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392499AbgAXUfg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 15:35:36 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1666EBC99C;
        Fri, 24 Jan 2020 15:35:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Oxi4NlOtkKGeeaou0kMlSaJwPT8=; b=FBru3g
        a/xzZmzCZaJByj5QCK4NFgk9v0sT6hTYyJKAd2RE3u9jwWrsgeWE0fMoghGRqko9
        mrEfngZxd89shFwAbJADQq7dGWKgSyNHjjhONjLC7gLgIgzPZmXhVb00oWxNauZ3
        qJ5cNLNy0GyVJj8ycIyFTXBzdQ2Nfkgb6ps+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xWEym5OHPEowtG9NoBneICKSV2SA+b2k
        xupii50vm4MS35yAJygXdNS2Zzxi7dpHQJIku6z1dCtyRahkgobBqZ+d/YO4DNU2
        NyOxSKoEAAmW2FP92JtabI7qmJhfWlZHEyC5kLpHdECiJgfcljqOdUpx1uKSYv8U
        /WdH3en7bto=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C046BC99B;
        Fri, 24 Jan 2020 15:35:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 24399BC99A;
        Fri, 24 Jan 2020 15:35:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>,
        Richard Kerry <richard.kerry@atos.net>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5] MyFirstContribution: add avenues for getting help
References: <20200124200915.249473-1-emilyshaffer@google.com>
Date:   Fri, 24 Jan 2020 12:35:28 -0800
In-Reply-To: <20200124200915.249473-1-emilyshaffer@google.com>
        (emilyshaffer@google.com's message of "Fri, 24 Jan 2020 12:09:16
        -0800")
Message-ID: <xmqq7e1gzj73.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10662686-3EE9-11EA-81EE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

emilyshaffer@google.com writes:

> From: Emily Shaffer <emilyshaffer@google.com>

Hmm, unlike folks who use GGG, your From: address seem almost usable
without having to waste two extra lines (which matters when one has
to review many patches a day).

> With https://lore.kernel.org/git/20191114194708.GD60198@google.com/ we
> now have a mentoring mailing list, to which we should direct new
> contributors who have questions.

Yay.

> Mention #git-devel, which is targeted for Git contributors; asking for
> help with getting a first contribution together is on-topic for that
> channel. Also mention some of the conventions in case folks are
> unfamiliar with IRC.
>
> Because the mentoring list and #git-devel are both a subset of Git
> contributors, finally list the main Git list and mention some of the
> posting conventions.

> +[[getting-help]]
> +=== Getting Help
> +
> +If you get stuck, you can seek help in the following places.
> +
> +==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
> +
> +This mailing list is targeted to new contributors and is a great place to post
> +questions and receive kind, detailed answers from volunteers on the Git
> +project. You must join the group to view messages or post.

OK.


> +==== https://webchat.freenode.net/#git-devel[#git-devel] on Freenode
> +
> +This IRC channel is for conversations between Git contributors. If someone is
> +currently online and knows the answer to your question, you can receive help
> +in real time. Otherwise, you can read the
> +https://colabti.org/irclogger/irclogger_logs/git-devel[scrollback] to see
> +whether someone answered you. IRC does not allow offline private messaging, so
> +if you try to private message someone and then log out of IRC, they cannot
> +respond to you. It's better to ask your questions in the channel so that you
> +can be answered if you disconnect and so that others can learn from the
> +conversation.

OK.

> +==== https://lore.kernel.org/git[git@vger.kernel.org]

Hmph.  I would have expected mailto:git@vger.kernel.org as the main
URL here, as this enumeration is not for those who lurk to passibly
receive information, but for those (new) contributors who want to
ask help by actively transmitting.  Mentioning lore as an archive
when talking about the list is necessary, but it shouldn't obscure
the main e-mail address people need to know in order to send their
requests.

> +
> +This is the main Git project mailing list where code reviews, version
> +announcements, design discussions, and more take place. The Git list
> +requires plain-text-only emails and prefers inline and bottom-posting when
> +replying to mail; you will be CC'd in all replies to you. Optionally, you can
> +subscribe to the list by sending an email to majordomo@vger.kernel.org with
> +"subscribe git" in the body.

Thanks.
