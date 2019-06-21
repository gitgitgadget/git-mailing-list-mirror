Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2FC1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 17:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfFURTB (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 13:19:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50962 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFURTB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 13:19:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F37A696D1;
        Fri, 21 Jun 2019 13:18:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8eRPlFayyXZmYACIGDOVb4ZSc8s=; b=m4PNeO
        JMekoI3+alY/NS4XrBgTIgUeIImbGPso0DorO+p73EZxwwPClZqp6bA7AGNbp+fg
        Yx21JcgIVJtBH/LiqjMd4blzVRHsGOLe0wR743hEfw+VpN/i6HUdqCSsICmWzkKw
        9x3w8gNOIOhxTLB5GbVxcLOMTLWsAnqzZ4Dwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OtyBj33+VjgOofM99GCPwDxEN5Hy/Bdz
        7WXKPcbGWEbiOxQiB9oh+6XeeLCt8/UIJBPeNq2WKFoJVFEAYtqrOJnTqY3r9ub4
        YNbs5MxplXHNEsG3dKWCSvSCSps3rmkhSiYun4bsPdd4IXVVTfVjlM+28YCgZMb/
        acpvjAicBP4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 37DF6696D0;
        Fri, 21 Jun 2019 13:18:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2FC6F696CF;
        Fri, 21 Jun 2019 13:18:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] doc: improve usage string in MyFirstContribution
References: <20190619221315.7343-1-chriscool@tuxfamily.org>
        <20190620212922.GB87385@google.com>
        <CAP8UFD1KRq9gUJQbDP9d3xewS9F_9wHnt463Qt7UXoi7VdmOJg@mail.gmail.com>
        <CAPig+cQh0MC9JQPMkxhDKFzzCwRTC-_rVBR7RnzcP3SM_kn_vA@mail.gmail.com>
Date:   Fri, 21 Jun 2019 10:18:53 -0700
In-Reply-To: <CAPig+cQh0MC9JQPMkxhDKFzzCwRTC-_rVBR7RnzcP3SM_kn_vA@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 21 Jun 2019 12:37:59 -0400")
Message-ID: <xmqqmuiakgaq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A66B5652-9448-11E9-B66A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Jun 21, 2019 at 6:43 AM Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Thu, Jun 20, 2019 at 11:29 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>> > It doesn't require 1 or more args - you can run it with no args. So it
>> > might be better suited to state the args as optional:
>> >
>> >   'git psuh [arg]...'
>>
>> Yeah sure, I will will resend soon with such changes.
>
> More correct would be "git psuh [<arg>]".

I think this takes 0 or more, not 0 or 1, so "git psuh [<arg>...]",
no?
