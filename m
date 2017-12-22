Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EAF01F406
	for <e@80x24.org>; Fri, 22 Dec 2017 20:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756218AbdLVUCn (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 15:02:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52065 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755940AbdLVUCm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 15:02:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50E1CBC424;
        Fri, 22 Dec 2017 15:02:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r0xBd/iyCzb3XRah7VrFzB11vEU=; b=snccdX
        w3umHvYH9AcRnp+UICKnlRhHA8IxQ9oGXpbnpqPkJqhWU3pS3/vDBPQ2LbU9EYhO
        oGdwWrXYCmrmSBlm6ukPoZCPBa5PbPdd9umzp6L3Flas/7tGWHpaHTxYnGgEM+qe
        rH71WjZbhFkcKwpsuXBiFwfT2hHwzq7fww/o4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WU9jJ2G7cbfL6F3JSET/Nr7L6SjKSREC
        XBqaqCP2QONIaOysfwLcOusay4yMXga8UUaxbmXM64m0lH2xFy6+eQjiUkSfmVZO
        KyPXNSfASCdnEsgCNnPEUW0nUPp5bF0L1U6oBCkx/r28RoEh0CZQbuCUIyE7pT/m
        zt0a14FM0WU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 498C3BC421;
        Fri, 22 Dec 2017 15:02:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE879BC41F;
        Fri, 22 Dec 2017 15:02:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] t/helper/test-lazy-name-hash: fix compilation
References: <39238da4-c2b8-050d-51e3-675f5515776e@jeffhostetler.com>
        <20171220222416.130872-1-sbeller@google.com>
        <xmqq7etetyqo.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZ9rWYwzrG+fJu2neYVfHSgoR5TrkSmNf_EJeUm46QUvg@mail.gmail.com>
Date:   Fri, 22 Dec 2017 12:02:40 -0800
In-Reply-To: <CAGZ79kZ9rWYwzrG+fJu2neYVfHSgoR5TrkSmNf_EJeUm46QUvg@mail.gmail.com>
        (Stefan Beller's message of "Fri, 22 Dec 2017 10:17:49 -0800")
Message-ID: <xmqqtvwir0nz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1160C7DE-E753-11E7-87D0-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Heh; I do not think there particularly is much difference between
>> stricter flags and DEVELOPER flags, but I would rather not lose the
>> removal of duplicated 'today' I did while I queued the previous one
>> ;-)
>
>
> I did not realize it was queued anywhere, please ignore then.

I just did s/stricter/DEVELOPER/ on the one that have been queued.
Thanks.
