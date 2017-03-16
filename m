Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E240D20323
	for <e@80x24.org>; Thu, 16 Mar 2017 18:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbdCPS4r (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 14:56:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54671 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751979AbdCPS4q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 14:56:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E38996ABA5;
        Thu, 16 Mar 2017 14:56:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pC7GKv8Me5hZhNfiUIzs+838UQ8=; b=YBm3F2
        B2TzXya0UbpBpm7meS+tGWh1K+Qd8byKeSbC3VUeEsBAbt7KAeGxIoTiqMkmd2zF
        slS6HaDSlBwP9+HTklurZw6CwD77d4pDuNzMfUZckus0jmaSKXe4lsu8Vi6eaqwp
        buBv8l1vqVt7liO0hN+gCKep1EQaXDF6olSTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EROnS+4+BJckal/JpCJasbMNmO4fw9vn
        2aUB5PClDl006c455v45rwGERpwz+ih3t/cM34YtB3i3g8XNsd2v8x6Yil05HJE7
        ca3YNr2ilsD/yb6vwU1iRAj+oRhSGB0lMvEvrjpEOjHCe9eg0KHm/jr9ir//caRT
        nwlMYfGWy5A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBC0C6ABA4;
        Thu, 16 Mar 2017 14:56:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A7226ABA3;
        Thu, 16 Mar 2017 14:56:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     sourav mondal <souravcristiano502@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH]v2 adding built-in driver for javascript
References: <20170313200854.6905-1-souravcristiano502@gmail.com>
        <CAP8UFD3toXk36wmJu+EeBnTvCa0yHWqCmQOfoJ0+2QTs8MpB-A@mail.gmail.com>
Date:   Thu, 16 Mar 2017 11:56:43 -0700
In-Reply-To: <CAP8UFD3toXk36wmJu+EeBnTvCa0yHWqCmQOfoJ0+2QTs8MpB-A@mail.gmail.com>
        (Christian Couder's message of "Thu, 16 Mar 2017 19:54:46 +0100")
Message-ID: <xmqqo9x1aw44.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C75DA78-0A7A-11E7-84A8-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Mar 13, 2017 at 9:08 PM, sourav mondal
> <souravcristiano502@gmail.com> wrote:
>> javascript is one of the famous langugae,it's needs a built-in driver.
>
> Please use "Javascript" instead of "javascript".

While we are typo-spotting ;-) Wikipedia seems to prefer to spell it
"JavaScript".
