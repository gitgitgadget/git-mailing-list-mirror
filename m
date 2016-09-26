Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCFF4207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 14:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034549AbcIZOVZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 10:21:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55420 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034455AbcIZOVY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 10:21:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59CBF3F5C8;
        Mon, 26 Sep 2016 10:21:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KQCTM1FfZMlGcwxtspkL58/j2cU=; b=caHc+4
        P7Veql1UR1c5PexN1uo0ppSfNp2vt342BzXhEveCaKqhHuzN1RTn3Rfr/AWp0x+4
        lkNNT224dMmTygg6UZKTgha8iWV5Jtr9SF2H96ZFPy+IyqbCQte7rQdYn2dkNMKj
        8xaxYPCwJu/wXqoY5BBJnXVar6AFNwKFFaSXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=osV66Kbo3jOagrvXSt4JZHjO1JBUfwRO
        oVX/X59oKY0a0LiZeK9x13UJib7nsmjWNOjf9XzNxu5l2xzS628OBTM70XQlltCj
        RN5pfi+qtGcPDHxdpiIRFy75izXh8/r2cEkoK1alGpmzV21ANv94U1gEyMC9aGXn
        VNY355hy+As=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 518EB3F5C7;
        Mon, 26 Sep 2016 10:21:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB6473F5C6;
        Mon, 26 Sep 2016 10:21:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: git-gui, was Re: [PATCH v2 6/6] git-gui: Update Japanese information
References: <1474378663.1884.41.camel@sapo.pt>
        <xmqqlgyl86fe.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 26 Sep 2016 07:21:20 -0700
In-Reply-To: <xmqqlgyl86fe.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 21 Sep 2016 11:16:21 -0700")
Message-ID: <xmqqoa3avj1b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 804215AE-83F4-11E6-9E74-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>
>> I have sent some git-gui patches on May this year and I think it will
>> add value to accepted them at some point:
>
> Yeah, they may be of value, but the thing is, I am not really in the
> position to review or apply them (I don't do git-gui).
>
> If Pat is not going to return, we would need to find volunteers to
> be maintainers of "git-gui" first.
>
> Thanks.  I may get to these patches when/if I find time, but it is
> not likely to happen very soon.

This I just did (haven't pushed out the results, which will happen
after today's regular integration cycle in the afternoon US/Pacific
time).

Thanks.
