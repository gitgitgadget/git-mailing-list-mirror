Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007541F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 20:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759389AbcJQU3P (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 16:29:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50872 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759488AbcJQU3M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 16:29:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30DA846CEA;
        Mon, 17 Oct 2016 16:29:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u+/blvc0Pfn5xEPlW6EHA5mykTs=; b=p3w7Q2
        Fl9AVDEX5/xVhTh12fab9iwWT+L5Xv/wOrLL/X1tjfy6vR9RqWvn9kIwsZOV5/NO
        LRZrOOcVIuJLn4dQWKQydVTYPQgYmnoc8wfLcLOu30FHYoFP87KQ27R8UL5QA2rQ
        mIbvvK+N5dxehJI/P3eu5ffewR8Q/2sSp5VDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u959U8m2OamvAx30EYhtCerOQMOmrLJS
        Q0ye9Mdj7t8aJPPiLiZDIRHLYiiBrkR3o0yKXbUNeI5mKdI/cNbGRjqIOAoGXfN9
        yfiq7kiv/cgDHLPgWd52TvPx50fx0CEzZ5O6DPe63kBo3rlDgDhcGLgySkIsdULj
        5GG0cmoJD7w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 281B646CE8;
        Mon, 17 Oct 2016 16:29:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9359546CE6;
        Mon, 17 Oct 2016 16:29:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.10.0 maint branch
References: <CANYiYbEip5fu9gz24ts_xcPBfPRLMOBrhjfF9gjs=bZym1aizg@mail.gmail.com>
Date:   Mon, 17 Oct 2016 13:29:07 -0700
In-Reply-To: <CANYiYbEip5fu9gz24ts_xcPBfPRLMOBrhjfF9gjs=bZym1aizg@mail.gmail.com>
        (Jiang Xin's message of "Sun, 16 Oct 2016 20:23:54 +0800")
Message-ID: <xmqqinsqu3cc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BCAFE06-94A8-11E6-BA17-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> Please pull the following l10n updates for Git 2.10 to the maint branch.
>
> The following changes since commit 9a4b694c539fead26833c2104c1a93d3a2b4c50a:
>
>   l10n: zh_CN: review for git v2.10.0 l10n (2016-09-11 21:34:23 +0800)

Thanks.

> Dimitriy Ryazantcev (1):
>       l10n: ru.po: update Russian translation
>
> Jiang Xin (1):
>       Merge branch 'russian-l10n' of https://github.com/DJm00n/git-po-ru
>
> Ralf Thielow (2):
>       l10n: de.po: fix translation of autostash
>       l10n: de.po: translate 260 new messages
>
>  po/de.po | 5182 +++++++++++++++++++++++++++++++++-----------------------------
>  po/ru.po |   52 +-
>  2 files changed, 2815 insertions(+), 2419 deletions(-)
>
> --
> Jiang Xin
