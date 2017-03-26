Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDCCD20958
	for <e@80x24.org>; Sun, 26 Mar 2017 22:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbdCZW5B (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 18:57:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50976 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751380AbdCZW47 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 18:56:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89E826DD68;
        Sun, 26 Mar 2017 18:56:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1A3IP2lUH774
        irxpu5a/JamOr3c=; b=LZEYgj9AcUQlbmQErv+X+YtqsdlMYK9zZ24pQDbENQUY
        qMx4usv3Fj23KsSxe7XmW2TwlLOeQtd6gKEJUk/LNCKAdAiNOCWrXiZhkIARSo/x
        h5ifRY6YIaDpU2+90yDCNlnIgD8eFrg5SnfKEyEYNzU5SsI/3OPOXTNcgv7bGFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=e2MzcI
        Kunsp2fboHBfBipL+c7Po7HuKwncwybQf8q2tkpw1vgrH6voKqj8b2DkOty4Zkg/
        AAXuZBg9YyKYI+HchjGKsy8zIxz8gQL5T3y1YWjIAagjtCXGNmlJr1B4S2g03YUs
        MZgecwuK9DDahYVHFKcj5SSGsaj9bRfCPxiTU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81D0A6DD65;
        Sun, 26 Mar 2017 18:56:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6E4A6DD64;
        Sun, 26 Mar 2017 18:56:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] l10n: Add git-add.txt to localized man pages
References: <20170312200248.3610-1-jn.avila@free.fr>
        <5036581a-f989-2db6-06ba-621db05c6de1@free.fr>
        <xmqqpoh9kx5q.fsf@gitster.mtv.corp.google.com>
        <4046320.m2qk9b67WH@cayenne>
Date:   Sun, 26 Mar 2017 15:56:55 -0700
In-Reply-To: <4046320.m2qk9b67WH@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Sat, 25 Mar 2017 16:40:39 +0100")
Message-ID: <xmqqshlz4pfs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8331B47E-1277-11E7-99BD-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> ... So I would=20
> think the other way around: for those interested in translated the=20
> documentation, some script would allow to checkout the git project insi=
de the=20
> gitman-l10n project (like a kind of library).
>
> This would be mainly transparent for the git developers.

As long as the resulting layout would help all groups (1) developers
who do not worry about documentation l10n (2) documentation i18n
coordinator and transltors (3) those who build and ship binary
packages, I personally am OK either way.

Having said that, I am not sure if I understand your "translators do
not have a fixed version of git.git to work with and po4a cannot
work well" as a real concern.  Wouldn't the l10n of documentation
use a similar workflow as used for the translation of in-code
strings we do in po/?  Namely, *.pot files are *NOT* updated by
individual translators by picking up a random version of git.git and
running xgettext.  Instead, i18n coordinator is the only person who
runs xgettext to update *.pot for the upcoming release of Git being
prepared, and then translators work off of that *.pot file.  Which
means they do not have to worry about in-code strings that gets
updated in the meantime; instead they work on a stable known
snapshot of *.pot and wait for the next sync with i18n coordinator
whose running of xgettext would update *.pot files with updated
in-code strings.  Doesn't that workflow apply equally well for the
documentation l10n?

