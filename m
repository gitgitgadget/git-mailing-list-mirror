Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEAF71F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 21:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbcJEVlS (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 17:41:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53491 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752829AbcJEVlS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 17:41:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DA4544295;
        Wed,  5 Oct 2016 17:41:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6/iAy1iTeclISMqfj/OGP0Mb8oE=; b=Den10+
        v5Au9b1sHpgqxUIGKaX57F9RJ3FUmdZ8yHqBOA0l2FaJHw1Q1S+uLpzofkG4A0s5
        S8QjrTQSzmXOPER+pz5ymHcIIWvnfB65Wd6voyI9Y09PqrqFR+YFSI/HWKzHXLcD
        eTji4mp4uIU9bML408puv6qPIof74EjhH2H0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cLPsTnec1iWtaSk8Itb8hlujvO807F/G
        cdAeU525dPb5dJ+3no4cZZhWqwaZsbfk/z99ctO4LkB7EVlp2g8l3XRVwnesjdSE
        KvWJYQ3pBJIOfieJU0mw8gkXFERm0zCkjrtrcGOYEPRA46m6ewNWiWwNy+AfPL8L
        fnkaM0VuZeQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05D4844294;
        Wed,  5 Oct 2016 17:41:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C01E44293;
        Wed,  5 Oct 2016 17:41:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] Documentation/git-merge.txt: improve short description in DESCRIPTION
References: <cover.1475678515.git.sorganov@gmail.com>
        <e74ae8afc1bfc4cd9161ccaa56d926a89439551e.1475678515.git.sorganov@gmail.com>
        <xmqq60p6pt4k.fsf@gitster.mtv.corp.google.com>
        <871szuqyjo.fsf@javad.com>
Date:   Wed, 05 Oct 2016 14:41:14 -0700
In-Reply-To: <871szuqyjo.fsf@javad.com> (Sergey Organov's message of "Thu, 06
        Oct 2016 00:24:43 +0300")
Message-ID: <xmqqa8eio4n9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71D4CB90-8B44-11E6-9C25-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> OK, I see. So, what is the best way to handle this? Immediately follow
> content change patch with another patch that only re-flows?

Or no reflowing at all.

>> the parents".  I do not know if the updated phrasing is better.  The
>> "name" in the original was meant to be a short-hand for "object name",
>> and I would support a change to spell it out to clarify; "reference"
>> can be a vague word that can mean different things in Git, and when
>> the word is given without context, most Git people would think that
>> the word refers to "refs", but that is definitely not what the new
>> commit records, so...
>
> I won't insist on the change, but "name" sounded wrong to me, and
> "reference" was most general term I was able to come up with in this
> context.
> ...
> Last, if "reference" is not good enough and we get to internals anyway,
> why not say SHA1 then?

Because that is still colloquial?  I think s/name/object name/ is
a sensible change, but not s/name/reference/.

