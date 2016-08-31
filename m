Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E2211F859
	for <e@80x24.org>; Wed, 31 Aug 2016 17:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030277AbcHaRXf (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 13:23:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50696 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935097AbcHaRXe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 13:23:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75723392A7;
        Wed, 31 Aug 2016 13:23:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aadv9sd3Tu/7tMrmBfup/nbMkSI=; b=SB+88x
        FcN5aA8McS6fMeX6sF9jLZ3hWafVbcYlw+XYpg9SxuAvz99Fb02t2rcjWqttRDZ9
        hw/AKRYIIDdDPeTBh/3Ww3n0x9d1tP5qiSkOeeG/4qugv9WKnEOFW1nLhWVAzbso
        ORzeXQm2iEK6BdigXUfco+DMxNv+Nl1qsE90Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ov9ycwuU1jK2X8k//FJmBJjpJROkpCDS
        zZ7zlt4XL7iyex1omsGmeCl84J5v05M8R0p01wAxx0EzUGNcr1GgRAJfo/RZqthF
        yAwPVuL/5wVc6y6RacGeypR11j7CDqMcGgQJX5J52RrBLWJWoY9VfISjf4YePAmu
        bq+IllDtpW8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D46C392A6;
        Wed, 31 Aug 2016 13:23:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF529392A5;
        Wed, 31 Aug 2016 13:23:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 00/11] Mark strings in perl script for translation
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
Date:   Wed, 31 Aug 2016 10:23:30 -0700
In-Reply-To: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
        Almeida's message of "Wed, 31 Aug 2016 12:31:19 +0000")
Message-ID: <xmqqtwe026p9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A45085F2-6F9F-11E6-B5AE-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Mark messages in some perl scripts for translation.
>
> Since v1, adds brackets so parameter grouping of sprintf parameters is easier
> to see.
>
> Interdiff included below.

Thanks; it is way too late for this cycle for i18n so I won't be
picking the series up right now.  Please ping me if you see me
forget to pick it up in a week after 2.10 final gets tagged.
