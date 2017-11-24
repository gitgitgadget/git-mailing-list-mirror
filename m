Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38DB22036D
	for <e@80x24.org>; Fri, 24 Nov 2017 14:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbdKXOHS (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 09:07:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51727 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750737AbdKXOHR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 09:07:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A541DBBB70;
        Fri, 24 Nov 2017 09:07:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TQTYcbjeSwFJGebWyK9ovO8vAtQ=; b=l1aaKp
        6cwWSwCgdmTSYdm1EkwMmWoAP4729S8IjKgvmH25p6Q7eG4iHqixQOLY8Ft+z63Y
        FZu45WJzybZn5Rq0FZJCaEb0BIFcGWzvLd3QT6CebPaykMgDTHffKrL5egHYL8Wn
        SVSoJ+2Cag4yIK20j9SRpxhltZ9XbMYhg9f8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m1eztq2ce9Oy8mL8v9sZmoViUX+IytO/
        3IBHUEOloXsbqW7dsa1JVxOUlGb0hC01K5FMCtXbj/v41O35zU7fGdqRxf0+8vuV
        Zv/a5TB8/Bt+WNyj/mlM9V5ZrT9QvgY8FA2hLtBie9t1OCai5+/UouqtU+XwJzEm
        CFnbDmoC5Us=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E4F6BBB6F;
        Fri, 24 Nov 2017 09:07:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1B90ABBB6E;
        Fri, 24 Nov 2017 09:07:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] doc: clarify that "git bisect" accepts one or more good commits
References: <alpine.LFD.2.21.1711220729230.13545@DESKTOP-1GPMCEJ>
        <xmqqh8tkp9nn.fsf@gitster.mtv.corp.google.com>
        <alpine.LFD.2.21.1711240351170.30318@localhost.localdomain>
        <xmqqh8tjn6x4.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 24 Nov 2017 23:07:14 +0900
In-Reply-To: <xmqqh8tjn6x4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 24 Nov 2017 22:27:19 +0900")
Message-ID: <xmqq3753n52l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6B9BA26-D120-11E7-8805-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
>>   in this sense, i don't think "indicate" and "identify" are
>> completely interchangeable. in my mind, the word "identify" does
>> nothing more than, you know, point at something and say, "that one,
>> that's the one i'm talking about;" it goes no further than that.
>>
>>   on the other hand, the word "indicate" (in my mind) implies that
>> you're about to provide some *property* or *quality* of something, and
>> you do exactly that in the earlier quote:
>
> I do not think the two words have different connotations, so we are
> in agreement.  You do not necessarily need a property in mind when

Eek.  I do do think the two words are not interchangeable.
I should stop typing late at night.
