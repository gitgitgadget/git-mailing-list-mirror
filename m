Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206E4C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 19:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0328A61221
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 19:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345167AbhITTcB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 15:32:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61839 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347008AbhITTaA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 15:30:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2855EEEFB;
        Mon, 20 Sep 2021 15:28:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TqG2ndwlECgs
        V+AHnMBR22KQ8+QWCT2v6w4sxjKsm9g=; b=aUBVMi91NIk804lq1qjr73nlDIzB
        JTWrXDG1dzpFGbijhKn4NMVU4iuE91Fp7qcEjjtC3JteyMAmA1zhJApC7Zsdnm1r
        QlnnUzMq80jq50JtVJp0fuhsdocLviKUANVyqKgkw2uhG/X/rl1GICskAX0NROUs
        ZpJuXr3aYvNlnKA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAE65EEEFA;
        Mon, 20 Sep 2021 15:28:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5019BEEEF9;
        Mon, 20 Sep 2021 15:28:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Fangyi Zhou <me@fangyi.io>, git@vger.kernel.org,
        Peter Kaestle <peter@piie.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2] .mailmap: Update mailmap entry for Fangyi Zhou and
 Peter Kaestle
References: <20210920084719.29122-1-me@fangyi.io>
        <877dfbbigr.fsf@evledraar.gmail.com>
Date:   Mon, 20 Sep 2021 12:28:31 -0700
In-Reply-To: <877dfbbigr.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 20 Sep 2021 13:18:58 +0200")
Message-ID: <xmqqilyvavxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F0E9C9EC-1A48-11EC-B351-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I understand per recent mailmap discussion that Junio prefers having th=
e
> entries sorted over eliminating redundancy.

I have merely stated the project preference that can be seen in the
state of the file, which may not necessarily my preference (and my
preference would matter much less than project concensus, especially
because I do not have a strong one on this matter anyway).

