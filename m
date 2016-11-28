Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8319E1FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 19:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754716AbcK1T3V (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 14:29:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62569 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754600AbcK1T3T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 14:29:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44BB75472E;
        Mon, 28 Nov 2016 14:29:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4arjv2pOPDaBs4itskv2sVDMVJc=; b=xO5xyV
        RGVXtPM5XEcp/v5QTpOZrGb3qtkd45gkA+EqgR5ZcVHzoaX62UBerhZr/MlEIAyA
        JAUNXNvSeTUBvEvtLLk1cUX9w0RTGP5+70GahQziFvV0vJSsBr5Mr+6RoByvHlb0
        AzPp59L3tNY5AntX0dzdWS5Fcwhstas48FSl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jUSTWctoW12yDn/UQwYrNkg4cbC7rdQb
        deQqfilH1MtQhM0ljTd3JgdmNuCoOYqSgltFc/EbQb1f11AcDKvfEoCILcLN1s9f
        2ZgHmyMdfquUXeFz7ZYMlpCoc8D3xshZZdmqzTGyKiAbpm0FlAlMfOCNy9k5gCuw
        mE/+ZOQuOkA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C3595472D;
        Mon, 28 Nov 2016 14:29:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A00365472C;
        Mon, 28 Nov 2016 14:29:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Sz <phillip.szelat@gmail.com>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Magnus =?utf-8?Q?G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>
Subject: Re: [PATCH] l10n: de.po: translate 210 new message
References: <20161124182500.6875-1-ralf.thielow@gmail.com>
        <CANYiYbEzoN8S0o7_1N4hpO6OHZqq5Y4cMPxPPLEMA4TJ2n-d1g@mail.gmail.com>
        <CAN0XMOJ0mQ7KF_f2dh9YFA62a4RxoYJMkT7HXUpArK5CdHimew@mail.gmail.com>
Date:   Mon, 28 Nov 2016 11:29:16 -0800
In-Reply-To: <CAN0XMOJ0mQ7KF_f2dh9YFA62a4RxoYJMkT7HXUpArK5CdHimew@mail.gmail.com>
        (Ralf Thielow's message of "Mon, 28 Nov 2016 18:55:38 +0100")
Message-ID: <xmqq60n7jtdf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F42D347A-B5A0-11E6-946A-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ralf Thielow <ralf.thielow@gmail.com> writes:

> 2016-11-28 15:21 GMT+01:00 Jiang Xin <worldhello.net@gmail.com>:
>> 2016-11-25 2:25 GMT+08:00 Ralf Thielow <ralf.thielow@gmail.com>:
>>>  #: sequencer.c:251
>>> -#, fuzzy, c-format
>>> +#, c-format
>>>  msgid "could not write eol to '%s"
>>
>> Unmatched single quote has been fixed in l10n round 3.
>> You can rebase and update de.po file.
>>
>> BTW, Git 2.11.0 will be released tomorrow, please send PR in time.
>
> I've rebased, fixed the subject line and send a pull request to you.

Thanks, both.
