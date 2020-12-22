Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66B6C433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 20:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7098B20771
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 20:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgLVUGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 15:06:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59992 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgLVUGg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 15:06:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B9A2110A3C;
        Tue, 22 Dec 2020 15:05:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v/5f2piPB2ySPUCExcjd46RcllY=; b=DoiHH8
        6PEx/12eIo9QPXmx0m4RHphL7de/pznGeSOFiQDDCBtPYKB2LIIn8HKg2XmRZsxd
        1LJn6em3IJv7TCKcOhoApPVdc7IKr0Ye5do3RkFBO/Xahq06xazX7ivdY2alvM/v
        QoEtjtCQ+LfSCrxYddTO2ihCfAyoWZIHvFyv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t975eVhGhHIEQ8QgjvphykJn1kNlWBg7
        loy7SF9Ibk/kB9fi7qe9yDL8yvYvHgtx2fH/JUv6kJ0VOpjGCZ2EAoGOWqlWxoRu
        wo3QEim/8d+MUvcCyCQVh+wf8ZK48JxorJ6yNaz7srlg6G6qeVfpUkf/ctHq8r9l
        f0xrOKlvAfU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 64DAB110A3B;
        Tue, 22 Dec 2020 15:05:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A70BF110A3A;
        Tue, 22 Dec 2020 15:05:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2] git.txt: fix typos in 'linkgit' macro invocation
References: <pull.934.git.git.1608651140403.gitgitgadget@gmail.com>
        <pull.934.v2.git.git.1608651882510.gitgitgadget@gmail.com>
Date:   Tue, 22 Dec 2020 12:05:50 -0800
In-Reply-To: <pull.934.v2.git.git.1608651882510.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Tue, 22 Dec 2020
        15:44:42 +0000")
Message-ID: <xmqqsg7xhaht.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 174F9BC2-4491-11EB-80FB-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> The 'linkgit' Asciidoc macro is misspelled as 'linkit' in the
> description of 'GIT_SEQUENCE_EDITOR' since the addition of that variable
> to git(1) in 902a126eca (doc: mention GIT_SEQUENCE_EDITOR and
> 'sequence.editor' more, 2020-08-31). Also, it uses two colons instead of
> one.
>
> Fix that.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---

It seems that 2.29 shipped with these typos without anybody
noticing.

How did you find them, by the way?  Anything we can do to prevent
similar mistakes with automation?

Will queue.  Thanks.

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index c463b937a86..a6d4ad0818b 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -609,8 +609,8 @@ other
>  `GIT_SEQUENCE_EDITOR`::
>  	This environment variable overrides the configured Git editor
>  	when editing the todo list of an interactive rebase. See also
> -	linkit::git-rebase[1] and the `sequence.editor` option in
> -	linkit::git-config[1].
> +	linkgit:git-rebase[1] and the `sequence.editor` option in
> +	linkgit:git-config[1].
>  
>  `GIT_SSH`::
>  `GIT_SSH_COMMAND`::
>
> base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
