Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CB7C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BBBC60F01
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhG2T5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:57:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54861 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhG2T5T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 15:57:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B78313A980;
        Thu, 29 Jul 2021 15:57:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ozr/czZUjjUucwovoawh9caKDHlSMlHyY3p6Gy
        o0Qck=; b=P72tH0banr1QoExqi0pe2vb39tkBdF/T1gEnGcFiIfqyMURl9rnZEr
        5Z82m68yuRPSjxHfLM5JzFzX+bTKAyfVFTYEPnOXvjza+UTQa3FObcIpctmQNBqi
        ZoG7BwzAyWwn0OoFsJOkgLvcy9LICzriLMLwFngg9SrB834Ns1CUI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 62D4113A97E;
        Thu, 29 Jul 2021 15:57:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 31B9413A977;
        Thu, 29 Jul 2021 15:57:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>
Subject: Re: [PATCH v6 6/9] ssh signing: add test prereqs
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
        <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
        <18a26ca49e7a9b0046559ac8d5c62c99ea7262ae.1627501009.git.gitgitgadget@gmail.com>
        <YQL8+UFtVJPlJroe@google.com>
Date:   Thu, 29 Jul 2021 12:57:09 -0700
In-Reply-To: <YQL8+UFtVJPlJroe@google.com> (Josh Steadmon's message of "Thu,
        29 Jul 2021 12:09:45 -0700")
Message-ID: <xmqqsfzw51wq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 298C781A-F0A7-11EB-85BC-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>> ...
>> +GOOD_SIGNATURE_UNTRUSTED='Good "git" signature with'
>> +KEY_NOT_TRUSTED="No principal matched"
>> +BAD_SIGNATURE="Signature verification failed"
>> +
>
> Is there a reason why we don't use these variables in the script above?
>
> Also, in general I feel that it's better to add tests in the same commit
> where new features are added, rather than having standalone test
> commits.

Again, good suggestions.

Thanks for excellent reviews.

