Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC8AC2036B
	for <e@80x24.org>; Wed,  4 Oct 2017 04:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbdJDEBo (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 00:01:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53345 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751931AbdJDEBl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 00:01:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A0A4A02BE;
        Wed,  4 Oct 2017 00:01:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=papxTPdkD+qatzf2Dcr0OvPtiGw=; b=n3i0sK
        mur8BuRGjLU8L7csUMEBLbmdDb7/cwpu0lpEQu4v425MWOlKAAUf9P0R15YnoBqd
        4ork2MQNF3AVY8lNjJH7T+58CBF88UqQV5toqbQIDbvvV5benbqd5XmxchS1AWgd
        eWPLZli7dLqFGocqhUpi8Jdm4RK+yUgXV/yP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h2VadxQo8qx9f0Eqjn5/Jv5t1FAiT4FM
        acRE3n2c9TTcyY8nkPMI9OvWKbd6joVmpJMYJFZ5pR+xjBeIB+AYKvMscCRKlwLH
        PS7j4B+z2R8Z8qyz3QywLaUfORbW8m6/ARXqtsP2YUwjG53gYwNiH2RP0bDJ45Xt
        7BsQOBzvIV0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01E77A02BD;
        Wed,  4 Oct 2017 00:01:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D2E4A02BC;
        Wed,  4 Oct 2017 00:01:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, rpjday@crashcourse.ca,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What means "git config bla ~/"?
References: <20171002061303.Horde.SL92grZCqTRV9oQkBFPELQ7@crashcourse.ca>
        <20171002171300.GP19555@aiede.mtv.corp.google.com>
        <xmqqfub1m6u5.fsf@gitster.mtv.corp.google.com>
        <1964024229.332266.1507031152104.JavaMail.zimbra@matthieu-moy.fr>
Date:   Wed, 04 Oct 2017 13:01:39 +0900
In-Reply-To: <1964024229.332266.1507031152104.JavaMail.zimbra@matthieu-moy.fr>
        (Matthieu Moy's message of "Tue, 3 Oct 2017 13:45:52 +0200 (CEST)")
Message-ID: <xmqqd163ftng.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9EA4FBC-A8B8-11E7-A01C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <git@matthieu-moy.fr> writes:

> "Junio C Hamano" <gitster@pobox.com> writes:
>
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>> 
>>>> what's with that "git config bla ~/"? is this some config keyword
>>>> or something?
>>> ...
>>	git config section.var ~/some/thing
>> ...
>
> I prefer your "section.var" proposal above. I think people who really understand shell quoting do not need the explanations, and others probably need the example.
>
> While we're there, the formatting is also wrong ('' quoting, while we normally use `` quoting for shell commands).
>
> Sounds like a nice microproject for my students :-). A patch should follow soon.

OK, thanks.  Lest we forget, this is #leftoverbits for now.
