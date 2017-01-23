Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8B020A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbdAWUD7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:03:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51784 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750950AbdAWUD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:03:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE4B062EB3;
        Mon, 23 Jan 2017 15:03:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CcY4XlsCPyZj4/8+sPIM9cDGob4=; b=LwjXqD
        gHDfCKDcIN7X7R8XjuGmtNAo36DeC+oMFpAIX76eDJNIRvSMT54NYyLAiWhsT6jt
        VO+tl03tj7vO9jng40b9eYIlMgYfnNmw4QqF2TLxL43/ZJKQ8lSzF1vnYgoV/20A
        2TDJkezTTCvlOR2NS/lnt41yGcTjiv8reXJz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SNoOdSTpAn9oMDZt3RlBfTtmdq5AV/nH
        yGO5cq/DkiWcn2qSsKiD0cXh2oDKGo7PBuQezfFe6KwlilCupb40w1h372fv9aUJ
        3mw5WvQzzhph7BvlST3FW4PK2Z4dx3hAH9MTgD4u3ZQ9oQ6TqqNakekhjjRERh60
        ilSPFaK86vA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D62EA62EB2;
        Mon, 23 Jan 2017 15:03:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4181062EB0;
        Mon, 23 Jan 2017 15:03:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vladimir Panteleev <git@thecybershadow.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/5] show-ref: Allow -d, --head to work with --verify
References: <20170123180059.4288-1-git@thecybershadow.net>
Date:   Mon, 23 Jan 2017 12:03:56 -0800
In-Reply-To: <20170123180059.4288-1-git@thecybershadow.net> (Vladimir
        Panteleev's message of "Mon, 23 Jan 2017 18:00:54 +0000")
Message-ID: <xmqqk29lr1ar.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12D09296-E1A7-11E6-A219-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vladimir Panteleev <git@thecybershadow.net> writes:

> Third iteration, according to Junio's comments. This time we keep
> show_ref and show_one separate, accept HEAD with --verify even without
> --head, and add tests for dangling ref validation with --verify.

I am no longer a neutral judge but to me the resulting code looks a
lot more naturally structured than the original.

Thanks.  Will queue.
