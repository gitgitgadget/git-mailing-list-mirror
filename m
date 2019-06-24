Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBA9D1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 18:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfFXSEn (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 14:04:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64369 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbfFXSEn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 14:04:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D0F465A26;
        Mon, 24 Jun 2019 14:04:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZUAR62qahRD7r4Uo4AKIxFLm8ow=; b=pN5VrJ
        Kq1XHovmTh+fkfPm1C7x6CFj60MeXDtCjdWpwQ8IZ15aO4A8y7rtRBFciBw32hFl
        4DajBAzbylELfdxCwEAYbhj2T12d78ZdSJhaGxD4PNKo2Vo3KsOuRyyRoBm0m1F0
        X2aaXhKYWZKxaQsW7v7yDbxHCT3GIi0V/C9Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bTJgeyTWTZjjolHp88dhtgqkhF5dQJ4K
        ddoJW8PT5h8aSNDpFpwjKybqwbEhTp1fjbfc2fLTj7xZ/S0o0ntc7RN7u9k5l5sK
        C7bRtwlNiPxcPcqpzbizgfnafVWUsuQlz9mzDlp1epNtj2yjBDiipbcEdVwJp84d
        96yfxTnJ2Vo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 743B065A25;
        Mon, 24 Jun 2019 14:04:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9638965A21;
        Mon, 24 Jun 2019 14:04:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Dimitriy <dimitriy.ryazantcev@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] l10n: localizable upload progress messages
References: <20190622093655.80092-2-dimitriy.ryazantcev@gmail.com>
        <65cf1cfd-bb5f-dba0-17d6-7fee0ed1f51f@kdbg.org>
        <20190623010311.GC965782@genre.crustytoothpaste.net>
        <CAPUT4mSHK8bD-TGf9QOM2O2ChxTvwScCvmmQH37pedGDVR2w-g@mail.gmail.com>
        <2074c719-a077-35c4-f30b-769580e17879@kdbg.org>
Date:   Mon, 24 Jun 2019 11:04:36 -0700
In-Reply-To: <2074c719-a077-35c4-f30b-769580e17879@kdbg.org> (Johannes Sixt's
        message of "Sun, 23 Jun 2019 15:10:56 +0200")
Message-ID: <xmqqwohahnbf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8844C14A-96AA-11E9-BC99-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Thanks for educating me. Given your explanations, wouldn't it be much
> more natural to keep the prefix with the unit instead of separating
> them, as the patch does?

Yup, that "octet" comment was illuminating.  Great discussion.

Also I am with Duy's message in the other subthread.  We should keep
the number placeholder "%[udf]" and the unit in a single string),
instead of hardcoding the "a number must come and then unit" in the
code.

Thanks.
