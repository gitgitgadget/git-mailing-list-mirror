Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F1B220986
	for <e@80x24.org>; Wed, 19 Oct 2016 22:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755035AbcJSWnZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 18:43:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60959 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751503AbcJSWnY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 18:43:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C479147934;
        Wed, 19 Oct 2016 18:43:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dqOS5yND2C6Z0zhLayWyVwe99Pk=; b=hRcAPw
        r5MWk3j2dNEPA305KZF6QIMb75wqnHgwBmMvw48+vrNbzSypSTJ4ZuwkRA/br/zh
        VMlRf549MPZAUwikK4ohvI273JACtZVbWtJjrR0cypgTLvtQveCNXp0BEvrDWvH7
        LChQcl98PXgaQLqcWRcET+9OixpaqBVkmOuqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GFRBztQIrhMWT99Vjv816S0RvosJ6i+4
        W8AIgJ9Ft+Z+32fIv3vTVITHONW37cDPJaDC/b6gSBfc9OFp9dXChQ2R6DDHC+tU
        gg7vJRJvhY01m0MeVr/3sjWVO/fEX2EVhpQnoEkXwfoU9ZsJzr3ughDAvLeznGBz
        /GcgI++FaR4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA4ED47932;
        Wed, 19 Oct 2016 18:43:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 317994792F;
        Wed, 19 Oct 2016 18:43:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] submodules: update documentaion for submodule branches
References: <20161019204254.97659-1-bmwill@google.com>
        <xmqqmvi0j9rv.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 19 Oct 2016 15:43:20 -0700
In-Reply-To: <xmqqmvi0j9rv.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 19 Oct 2016 14:42:28 -0700")
Message-ID: <xmqqzim0hsdz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70E6C8FA-964D-11E6-8298-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Brandon Williams <bmwill@google.com> writes:
>
>> Update the documentaion for the the special value `.` to indicate that
>> it signifies that the tracking branch in the submodule should be the
>> same as the current branch in the superproject.
>
> Thanks.  Will typofix while extending with info supplied by Stefan
> like so:

Ugh.  Should have proof-read before sending it out.

>     4d7bc52b17 ("submodule update: allow '.' for branch value",
>     2016-08-03) adopted from Gerrit a feature to set "." as a special
>     value of "submodule.<name>.branch" in .gitmodules file to indicate
>     that it signifies that the tracking branch in the submodule should
>     be the same as the current branch in the superproject.

    ... in .gitmodules file to indicate that the tracking branch in
    the submodule should be ...

"to indicate that it signifies that" was overly redundant.


