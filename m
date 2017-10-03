Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBDD920281
	for <e@80x24.org>; Tue,  3 Oct 2017 04:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbdJCEML (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 00:12:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60070 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751128AbdJCEML (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 00:12:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA7A5A7B77;
        Tue,  3 Oct 2017 00:12:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4i7YL+Hidh1I18uhbL6mg23+Kk8=; b=xVnpsb
        1pxvorNyouAYx2Py+PoaovaLrJ1SMNgfnNb0Opj/YL1XNn3TaCfVwWId8opwknCp
        bh/0sowC7ESlx/7/E8Foi9kUG6AvSh5eCKkrjiqAWc5kVZ9CoTqoB5ezEWI4yRPo
        Ux2q6DTI6fs5WZb6ZuzFRuJ3Id0M0Ky9Hx9v8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GwqCCUwgTyDaTH2Me/lX1FOnzYloRiLX
        poMP1JUfeYL3SoM3x/QV7weEmMxYcW17HpenpBQfKKFXN1a6VhulZOAxEFnWW8h0
        E7a3O2FgYdF7A4tOanToYD3C5dhEEfEiJSOhQ/pwx8sGdgbJpxdcg7dYN0tDqXun
        ZSZ25n4Ul9c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2930A7B76;
        Tue,  3 Oct 2017 00:12:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0953A7B73;
        Tue,  3 Oct 2017 00:12:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Ann T Ropea <bedhanger@gmx.de>, git@vger.kernel.org,
        Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH v2] request-pull: capitalise "Git" to make it a proper noun
References: <20171002225636.Horde.mXj_gBTKz-CxnFKzUqiNDA1@bedhanger.strangled.net>
        <20171002230959.GU19555@aiede.mtv.corp.google.com>
        <20171003000838.Horde.GkejIyyuKI5nlVernhZ1XQ1@bedhanger.strangled.net>
        <20171003003407.GW19555@aiede.mtv.corp.google.com>
Date:   Tue, 03 Oct 2017 13:12:08 +0900
In-Reply-To: <20171003003407.GW19555@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Mon, 2 Oct 2017 17:34:07 -0700")
Message-ID: <xmqq60bwlvjb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06B1D414-A7F1-11E7-89C5-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ann T Ropea wrote:
>
>> Of the many ways to spell the three-letter word, the variant "Git"
>> should be used when referring to a repository in a description; or, in
>> general, when it is used as a proper noun.
>>
>> We thus change the pull-request template message so that it reads
>>
>>    "...in the Git repository at:"
>>
>> Besides, this brings us in line with the documentation, see
>> Documentation/howto/using-signed-tag-in-pull-request.txt
>>
>> Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
>> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>> v2: rename patch, correct Signed-off-by line, add Acked-by line
>>  git-request-pull.sh     | 2 +-
>>  t/t5150-request-pull.sh | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks for the quick turnaround.

Thanks, but the patch is whitespace damaged and did not apply (what
happend to "reviewer's oversight statement" ;-).

As there were only three instances, I just edited the target files
and committed, which was far quicker than trying to match
whitespaces by editing the patch text.

