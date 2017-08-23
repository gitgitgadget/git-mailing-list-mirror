Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5944720899
	for <e@80x24.org>; Wed, 23 Aug 2017 17:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932356AbdHWRge (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 13:36:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52793 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932204AbdHWRgd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 13:36:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8F939A306;
        Wed, 23 Aug 2017 13:36:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H5X1dJ1cQHSIxEnSuGaiSfTKHUI=; b=Cx9cOn
        Crh3LtE40L/XsYnz9CIujRwRmJ9LRqEIioZLtF5pQWl15gHRPTZ4n5kREQJqOey5
        QQDCbDlDd5QP+YxWAmn9qYDs66UeTjNni4LWe+iDKflYbgI5ZZkodfNq3NvMWCqa
        hR+yzVgm06JloiVLCT207IdZNXJhEY+dUoQ6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t2smdz9ZSLARxRrNLHeYhCjXrmUbW98s
        atxXDBFsdiy+LoLXhdMQ7XM0js4V+NwL1MqPhs5y3e5B/TDcgBiIG2IZGFfPmFL6
        78Kw6R82oci4Fe3/VCpJYgSj0PNN4Mp9WA99N11hAx9e0sjenSWyb++5WTU5PgH0
        tfB5QCHcZw0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E6FA9A305;
        Wed, 23 Aug 2017 13:36:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D60819A304;
        Wed, 23 Aug 2017 13:36:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrew Ardill <andrew.ardill@gmail.com>,
        Anatolii Borodin <anatoly.borodin@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Please fix the useless email prompts
References: <CAH8yC8=i33rtopVt=sgg0k+P4JQO+1EVpPJ+u5CPGEXKvZ+PBA@mail.gmail.com>
        <xmqqbmnba50e.fsf@gitster.mtv.corp.google.com>
        <CAH8yC8mpPRN2y1k07_Jk9QP88=gpLKNWfV3W0QQwXTWxyL5STQ@mail.gmail.com>
        <20170820091807.l23h44gnjajfv5bn@sigill.intra.peff.net>
        <CAH5451m58n8mYvt=BC_t2=EAv0HOOdAWrCHCNEPQ3NVjT174nQ@mail.gmail.com>
        <CACNzp2kao+hu6a2nO=gVaLctzoDauB+xyj=cfQLUdNOXTNKQfQ@mail.gmail.com>
        <CAH5451kcb0Y4mm2U804ruqBewB2AV991Hm0_-8ExdEoDTF8DJw@mail.gmail.com>
        <xmqqinhh7pz1.fsf@gitster.mtv.corp.google.com>
        <20170823153553.jg4g55f4biqzu5mw@sigill.intra.peff.net>
Date:   Wed, 23 Aug 2017 10:36:30 -0700
In-Reply-To: <20170823153553.jg4g55f4biqzu5mw@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 23 Aug 2017 11:35:54 -0400")
Message-ID: <xmqqy3qayyn5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A2A28C8-8829-11E7-B66F-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If we could reliably tell the difference between those two cases, it
> might be worth doing the up-front check. But I'm not sure we can do that
> without declaring that people in the ff-only case should be using a
> different workflow (e.g., fetch + "reset --hard").

Yup, it _might_ be nicer but I tend to think probably it is not
worth the potential trouble.

Thanks.
