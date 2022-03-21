Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060BCC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 19:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347462AbiCUTFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 15:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352408AbiCUTFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 15:05:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBBBDF50
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 12:03:50 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B245178CF4;
        Mon, 21 Mar 2022 15:03:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9Uwue+eL2twZ
        c2tmwbtHRSe5cmP8FaGfDX3SLlTL5B4=; b=k0t0qiHbwMeD+EYwk/RIwvQ/dC/s
        T0SwTYoV4EbaI/P6RAS5GWxM2Si8gsdfnBQKUyxHG20BZ3WsvYbZHcEorN2FVnF3
        qib9PRYcTUI9XB60CLWec9OlJZIzde8onVYC8/suxnT5GMkNyZENu6YHKptjmr4h
        fkfWr7bixNPPGqI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 13D5F178CF3;
        Mon, 21 Mar 2022 15:03:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E1FB178CF1;
        Mon, 21 Mar 2022 15:03:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        git@vger.kernel.org,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/7] More i18n fixes
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
        <e44b6ccf-21a2-72c6-4d40-dc0004895255@kdbg.org>
        <220321.86ils79z0c.gmgdl@evledraar.gmail.com>
Date:   Mon, 21 Mar 2022 12:03:46 -0700
In-Reply-To: <220321.86ils79z0c.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 21 Mar 2022 14:59:24 +0100")
Message-ID: <xmqqlex3xh4d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A313BB34-A949-11EC-969F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Disclaimer: neither am I a translator nor a user of a translated Git.
>
> Just to add to this:
>
>  - Careful use of sentence lego is OK, but e.g. in my native language a
>    command-line option would use a male noun article, whereas commands
>    would be feminine.

Hmph, if we gather wisdom from folks with different native languages
and varying rules, I am unsure that we still can say that "careful"
use of sentence lego is OK.
