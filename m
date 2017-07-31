Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3D461F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbdGaUIz (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:08:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60165 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751052AbdGaUIy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:08:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EADB38E6A4;
        Mon, 31 Jul 2017 16:08:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DuqBYp6lywlU
        esm9ICNhwIjPLoI=; b=JwEa2TMrz7lzy85b7zFkmdljbgCaaGexU5/8NAAvW6e6
        MxsDl8XsnLVFyrr5gOYcrktumwQtHmxmpFgRnpuRnqfy/EHY7zftuU55ORWoLqbV
        ZRqF759uNgBXl6cLNlVJx2hL6pk0TQw5JEbA1WEO99x1ptQBv94GmQ4nkabyDzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=S88RJ1
        6uXU/BMpXBSHipP1tC//i6Br0meAuJI20MBtjo0mNcaPcenPyaXPVgCuga125T4f
        KzCwqvPh2NxnURUfvRJtnu3u9iZ2yipXNRjKX+6FVqym7ds2KRUDWcKLErSGaOgL
        ycUX75Q25zyza/T04prJG0jXJTEm0DqvXenRY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E29BC8E6A3;
        Mon, 31 Jul 2017 16:08:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4346E8E6A0;
        Mon, 31 Jul 2017 16:08:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [L10N] Kickoff of translation for Git 2.14.0 round 2
References: <CANYiYbEJ3Gw=JvbhLBeFWBD7xLXxd=_fFdH3UX76H97ZU_3zKA@mail.gmail.com>
Date:   Mon, 31 Jul 2017 13:08:52 -0700
In-Reply-To: <CANYiYbEJ3Gw=JvbhLBeFWBD7xLXxd=_fFdH3UX76H97ZU_3zKA@mail.gmail.com>
        (Jiang Xin's message of "Mon, 24 Jul 2017 22:44:59 +0800")
Message-ID: <xmqqh8xsid2j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 135CEFEC-762C-11E7-814D-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> In the last round of l10n, some l10n messages from "date.c" are
> disappeared because of the l10n unfriendly PRItime macro.  This issue
> has been fixed by commit fc0fd5b23b (Makefile: help gettext tools to
> cope with our custom PRItime format), so let's start new round of l10n
> based on the new generated "po/git.pot" file.
>
> This time there are 9 updated messages need to be translated since last
> update:
>
>     l10n: git.pot: v2.14.0 round 2 (9 new, 2 removed)
>
>     Generate po/git.pot from v2.14.0-rc0-40-g5eada8987e for git
> v2.14.0 l10n round 2.
>
>     Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>
> You can get it from the usual place:
>
>     https://github.com/git-l10n/git-po/
>
> As how to update your XX.po and help to translate Git, please see
> "Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

As there is only one patch 9e7d8a9b ("blame: fix memory corruption
scrambling revision name in error message", 2017-07-24) that needs
to go to 'master', and there is nothing in that patch that requires
further translation tweaks, I am postponing -rc2 which was scheduled
to happen today.  Hopefully we can include the i18n/l10n updates
that way in the release candidate.

Please throw me a pull request when you are ready in the next few
days.  Thanks.

