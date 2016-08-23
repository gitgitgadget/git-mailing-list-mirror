Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B81181FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 19:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754961AbcHWTgi (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 15:36:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59132 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754954AbcHWTgg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 15:36:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 918143788D;
        Tue, 23 Aug 2016 15:36:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OYekY47NnWXhilCtTW2eTgh3hsM=; b=DxVDud
        UBAfvSUPJqX8k/2r3ObfgMIO4HGXW+Do6iQNGDYqvgsBNtKr7DpxE8v0aWYaxdaS
        uXIO85N1hJMGloNb0owujwGIMr9t+VJLMT160ewg/KzgjeSGhB77yF6u9nzv4jaq
        Nxt2z/r0J7AD9oqPJEWohlePRJ+/hm2Hna+LE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AbcDWHuVFaKVXKmSkF45KBnEJBy+eIan
        Cu4NLP5huPwRTh3LlqTUMqu/+7NncnX83BNTMD4+rPwDTaQ2jf2zvKiOVe/yz4dq
        KgSWwp7XsNIKe1ykpH7JjkKvDdr4MFOVMFo5UzC9hG6pHmdZp+2IZmAPWUxG56nN
        vFqEV9Jgl/I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A3D63788C;
        Tue, 23 Aug 2016 15:36:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F075D37889;
        Tue, 23 Aug 2016 15:36:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nikolaus Rath <Nikolaus@rath.org>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: Most recent revision that contains a string
References: <87d1l3ce40.fsf@thinkpad.rath.org> <20160821024647.GA19536@starla>
        <871t1ghe5s.fsf@thinkpad.rath.org>
Date:   Tue, 23 Aug 2016 12:36:33 -0700
In-Reply-To: <871t1ghe5s.fsf@thinkpad.rath.org> (Nikolaus Rath's message of
        "Mon, 22 Aug 2016 11:06:07 -0700")
Message-ID: <xmqqr39fuvjy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6BC0282-6968-11E6-9F1F-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nikolaus Rath <Nikolaus@rath.org> writes:

>> Btw, please don't set these headers on kernel.org lists:
>>
>> 	Mail-Copies-To: never
>> 	Mail-Followup-To: git@vger.kernel.org
>>
>> Like any mail server, vger fails from time-to-time and
>> reply-to-all prevents it from being a single point of failure.
>
> Huh? If the list-server fails only I will receive the message so it's
> still lost for everyone else. But I am more than happy to take this
> little risk if it saves me from the nuisance of getting duplicate
> responses.

On a mailing list, your readers' time is more valuable than yours,
simply because there are a lot more of them.

I am typing this message ONLY because I want to talk to YOU, and I
want your address to be on its To: field, with Eric and the list on
Cc: field.  The recipients can prioritize their incoming messages by
reading what's addressed directly to them first and when they have
leftover time they can read ones that they are CC'ed, but because
you used Mail-Followup-To: I had to correct the headers manually,
which means you stole time from me.  And if I didn't then your
Mail-Followup-to: would have stolen time from the other recipients.

Please don't use it on this list.

