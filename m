Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0C1E1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 16:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfFGQgW (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 12:36:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53350 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbfFGQgW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 12:36:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3816572A43;
        Fri,  7 Jun 2019 12:36:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Y16kYbabmdQ3
        51Hp6nzIWsWRWHo=; b=JS8W3vaJ9X2GR8IQG3BCYr7omUysPLNs9aPkbXgltkUW
        wUyiJZURJEKE0zGHHrAq3PUe5HS+mKntYZ1Bm3Kgz/M5Lrlw/aTcESJ7cnFHvj0G
        Nzyj4xF9o0C7oPZft/npPy6PNyhwR/tZRjKFJGRzYkJp34pw+/KbDlqCTNKZZeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EibCwZ
        hnyC9x3uWfQDvaek48WE7wdjpBNVsFZTcr6zkZWaBw06DLgSUXWGeEdylM6A6lSA
        qAV66bzGjqZQ9IX7wQvTxLdTZ4icVv4vznIBYp5ycCxclaJo75d2kEHGSZkkMdYb
        ufXI+TD3Rjx6KlTv0SC5X06EP3HDNcrUVRIw8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2BE1272A42;
        Fri,  7 Jun 2019 12:36:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3A19272A35;
        Fri,  7 Jun 2019 12:36:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        =?utf-8?Q?C=C3=A9dric?= Malard <c.malard-git@valdun.net>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Fangyi Zhou <me@fangyi.io>,
        =?utf-8?Q?Jean-No?= =?utf-8?Q?=C3=ABl?= Avila 
        <jn.avila@free.fr>, Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Tran Ngoc Quan <vnwildman@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [GIT PULL] l10n updates for 2.22.0 round 3
References: <20190607100812.24413-1-worldhello.net@gmail.com>
Date:   Fri, 07 Jun 2019 09:36:10 -0700
In-Reply-To: <20190607100812.24413-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Fri, 7 Jun 2019 18:08:12 +0800")
Message-ID: <xmqqv9xhpd39.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5CFECD16-8942-11E9-B854-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Please pull the following l10n updates for Git 2.22.0.
>
> The following changes since commit 74583d89127e21255c12dd3c8a3bf60b497d=
7d03:
>
>   Git 2.22-rc3 (2019-06-03 11:25:12 -0700)
>
> are available in the Git repository at:
>
>   git://github.com/git-l10n/git-po tags/l10n-2.22.0-rnd3
>
> for you to fetch changes up to 0cdb8d2db2f39d1a29636975168c457d2dc0d466=
:
>
>   Merge branch 'fr_review' of git://github.com/jnavila/git (2019-06-07 =
16:51:09 +0800)
>
> ----------------------------------------------------------------
> l10n-2.22.0-rnd3
>
> ----------------------------------------------------------------

Thanks, all.  Will pull.

> Alessandro Menti (1):
>       l10n: it.po: Updated Italian translation
>
> Alexander Shopov (3):
>       l10n: bg.po: Updated Bulgarian translation (4577t)
>       l10n: bg.po: Updated Bulgarian translation (4580t)
>       l10n: bg.po: Updated Bulgarian translation (4581t)
>
> Christopher D=C3=ADaz Riveros (3):
>       l10n: es: 2.22.0 round 1
>       l10n: es: 2.22.0 round 2
>       l10n: es: 2.22.0 round 3
>
> C=C3=A9dric Malard (1):
>       l10n: fr.po: Review French translation
>
> Fangyi Zhou (1):
>       l10n: zh_CN: Revision for git v2.22.0 l10n
>
> Jean-No=C3=ABl Avila (3):
>       l10n: fr.po v2.22.0.rnd1
>       l10n: fr.po v2.22.0 round 2
>       l10n: fr v2.22.0 rnd 3
>
> Jiang Xin (15):
>       l10n: git.pot: v2.22.0 round 1 (270 new, 56 removed)
>       Merge branch 'master' of https://github.com/vnwildman/git
>       Merge branch 'master' of git://github.com/alshopov/git-po
>       Merge branch 'master' of https://github.com/Softcatala/git-po
>       Merge branch 'master' of git://git.kernel.org/pub/scm/git/git
>       l10n: git.pot: v2.22.0 round 2 (6 new, 3 removed)
>       Merge branch 'master' of git://github.com/alshopov/git-po
>       Merge branch 'master' of https://github.com/vnwildman/git
>       Merge branch 'master' of git://git.kernel.org/pub/scm/git/git
>       l10n: git.pot: v2.22.0 round 3 (3 new, 2 removed)
>       Merge branch 'it-l10n-wip' of github.com:AlessandroMenti/git-po
>       Merge branch '2.22' of https://github.com/ChrisADR/git-po
>       l10n: zh_CN: for git v2.22.0 l10n round 1~3
>       Merge branch 'master' of git://github.com/alshopov/git-po
>       Merge branch 'fr_review' of git://github.com/jnavila/git
>
> Jordi Mas (1):
>       l10n: Update Catalan translation
>
> Matthias R=C3=BCster (2):
>       l10n: TEAMS: Change German translation team leader
>       l10n: de.po: Update German translation
>
> Peter Krefting (2):
>       l10n: sv.po: Update Swedish translation
>       l10n: sv.po: Update Swedish translation (4577t0f0u)
>
> Ralf Thielow (1):
>       l10n: de.po: improve description of 'git reset --quiet'
>
> Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (3):
>       l10n: vi.po(4577t): Updated Vietnamese translation for v2.22.0 ro=
und 1
>       l10n: vi.po(4580t): Updated Vietnamese translation for v2.22.0 ro=
und 2
>       l10n: vi.po(4581t): Updated Vietnamese translation for v2.22.0 ro=
und 3
>
>  po/TEAMS    |     8 +-
>  po/bg.po    |  7688 ++++++++++++++++++++++------------------
>  po/ca.po    |  8989 ++++++++++++++++++++++++-----------------------
>  po/de.po    |  7399 ++++++++++++++++++++++-----------------
>  po/es.po    |  7336 +++++++++++++++++++++-----------------
>  po/fr.po    |  7702 ++++++++++++++++++++++------------------
>  po/git.pot  |  7415 ++++++++++++++++++++++-----------------
>  po/it.po    | 11094 ++++++++++++++++++++++++++++++++------------------=
--------
>  po/sv.po    |  7229 ++++++++++++++++++++++----------------
>  po/vi.po    |  7342 +++++++++++++++++++++-----------------
>  po/zh_CN.po |  7143 +++++++++++++++++++++----------------
>  11 files changed, 44506 insertions(+), 34839 deletions(-)
>
> --
> Jiang Xin
