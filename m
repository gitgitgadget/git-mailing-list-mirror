Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B40C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 01:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353509AbiCYBTi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 21:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349657AbiCYBTg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 21:19:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863D613D13
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 18:18:03 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B72512F1DC;
        Thu, 24 Mar 2022 21:18:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VXJF8p/7awXP
        WrumVsfqhzY/7PQVUcp3PyM4EFVy+E0=; b=BV5Cyr9XtTxD91vzVaGhaat5QGkC
        7fQHUXtxMfWBY07LOpbbXEVU00tsB/ZG13rPbj8VWiLrguYdS4/jXJUB+v6A0std
        Q5aPrWESD0yR2oSe+qS+1OhuOkqH/TClRYeyFRyVCynaRCVPUF8oqvSZLyWqPgS7
        CFk7qUZ2ECROPRI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6143512F1DB;
        Thu, 24 Mar 2022 21:18:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 96CE112F1DA;
        Thu, 24 Mar 2022 21:18:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 19/27] revisions API: have release_revisions()
 release "filter"
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <patch-v2-19.27-d5b7a8a690e-20220323T203149Z-avarab@gmail.com>
Date:   Thu, 24 Mar 2022 18:17:59 -0700
In-Reply-To: <patch-v2-19.27-d5b7a8a690e-20220323T203149Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 23 Mar
 2022 21:32:09
        +0100")
Message-ID: <xmqqo81ude48.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 69694114-ABD9-11EC-B8EF-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Extend the the release_revisions() function so that it frees the
> "cmdline" in the "struct ref_info". This in combination with a
> preceding change to free "cmdline" means that we can mark another set
> of tests as passing under "TEST_PASSES_SANITIZE_LEAK=3Dtrue".

Read that again, perhaps twice if needed, and you already know which
typo I was about to point out ;-).


