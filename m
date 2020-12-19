Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97845C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 05:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6082323BA9
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 05:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgLSFZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 00:25:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53400 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgLSFZK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 00:25:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3FA3011264D;
        Sat, 19 Dec 2020 00:24:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=K1uF1XbIJW3oenGj9kQqlQqEe
        o4=; b=EX+5ObMDi1FyNKKV0D4tqaN71HAp83IwjkbI8Fw9FzEfl4zUeiCgAalBt
        dV5eJwsNLHUzC7NvAyuW18oXdLqFqvRPGOsSBOiZ/98zYvsdrkj6Q4q5fQz2+3nT
        9CjCWULZKn810rMIMgmqMPfc/4vSsyl6KXjv/ST40iB6V7ivn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=DjPVA8rWLqh1Q0c2Hfg
        yPHcDQBe8mquz6C5AfIk3xJ+ghhS/P9ZrIgn/7anAGlAUj0PfyaloYUL/fZ6d2Iz
        WX78S6N/QcgjaZMFhyvGQLJg9nL6CWghQFLTVL4/xxXHBZh5Ix+jdYOP1hsiayo5
        OP6I1bKtAuSwEHYpt5xkGdT0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2CDA011264C;
        Sat, 19 Dec 2020 00:24:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2FA2111264B;
        Sat, 19 Dec 2020 00:24:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
Subject: Re: [GIT PULL] git-gui pull request
References: <20201218195128.z7zuvraj4mm2e6tz@yadavpratyush.com>
Date:   Fri, 18 Dec 2020 21:24:23 -0800
Message-ID: <xmqqh7oiqsfs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7544D686-41BA-11EB-9469-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> Hi Junio,
>
> Please pull in changes in git-gui for Git v2.30. I hope the PR is not=20
> too late this time. Thanks.

Thanks.  Between -rc0 and -rc2 (like "today") would be a good time
to do this.

Pulled.

> ---
> The following changes since commit 38c2ac2e2ab00a8bcef528f24cb5b883b441=
3e5c:
>
>   Merge branch 'sh/blame-tooltip' (2020-10-17 15:05:27 +0530)
>
> are available in the Git repository at:
>
>   https://github.com/prati0100/git-gui.git
>
> for you to fetch changes up to 7b0cfe156e1f1fbb77ab35d55d48eef41625944d=
:
>
>   Merge branch 'sh/inactive-background' (2020-12-19 01:02:34 +0530)
>
> ----------------------------------------------------------------
> David Aguilar (1):
>       git-gui: ssh-askpass: add a checkbox to show the input text
>
> Dimitriy Ryazantcev (1):
>       git-gui: update Russian translation
>
> Martin Sch=C3=B6n (1):
>       git-gui: use commit message template
>
> Pratyush Yadav (8):
>       git-gui: Only touch GITGUI_MSG when needed
>       Merge branch 'ms/commit-template'
>       Merge branch 'dr/russian-translation'
>       Merge branch 'da/askpass-mask-checkbox'
>       Merge branch 'sh/macos-labels'
>       Merge branch 'rj/clean-speedup'
>       Merge branch 'st/selected-text-colors'
>       Merge branch 'sh/inactive-background'
>
> Ramsay Jones (1):
>       Makefile: conditionally include GIT-VERSION-FILE
>
> Serg Tereshchenko (1):
>       git-gui: Fix selected text colors
>
> Stefan Haller (2):
>       git-gui: fix colored label backgrounds when using themed widgets
>       git-gui: use gray background for inactive text widgets
>
>  Makefile         |    2 +
>  git-gui--askpass |   15 +-
>  git-gui.sh       |   30 +-
>  lib/commit.tcl   |    1 +
>  lib/themed.tcl   |   41 +-
>  po/ru.po         | 3053 +++++++++++++++++++++++++++++-----------------=
--------
>  6 files changed, 1728 insertions(+), 1414 deletions(-)
