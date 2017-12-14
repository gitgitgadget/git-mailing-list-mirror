Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 617B41F404
	for <e@80x24.org>; Thu, 14 Dec 2017 18:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753942AbdLNSIt (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 13:08:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50091 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753698AbdLNSIs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 13:08:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F514C72BD;
        Thu, 14 Dec 2017 13:08:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fVHnO+XstMvM
        1BRlRYMXsar4Kzk=; b=YXBPrUezmXqJZhN1VSjb8zqR0wWEOwmGvdMUBTU8Ju5u
        1WfCEnLRO21QDJpHbFMpQcESJUuyceyvQinh9LlH2KNXHPmN+5h352M17AWYlZyI
        vsuuoFBIpJ4qk0ycT4tP4DpErCyIwGaQf5yR+zVul/s8yP9HU4dQlGscKcPLMqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=n+vnXR
        7+TOp1yMQAsHF+EaD9TRPU6Dg2hgyFlopTgrFwA8d2oknNjYR6W8x6+r1crvlbGO
        cW9Y+Zzpbqxq2Ol9T7SlWWeV5e1RiofHkeb3XOKTqM1d3kEXvPpO03XPlZ2bDLNb
        SlS508lyHMrwe9wdkoz/fae4DMvkUKJHT56ss=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47D1CC72BC;
        Thu, 14 Dec 2017 13:08:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ACD96C72BB;
        Thu, 14 Dec 2017 13:08:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "David A. Wheeler" <dwheeler@dwheeler.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] doc: Modify git-add doc to say "staging area"
References: <E1eOwqn-0005Bd-OB@rmmprod05.runbox>
        <CA+P7+xrWFE+6t-Z8cGQX5WtZP1_EQSa+J7vF65dLDSOnLfFxXQ@mail.gmail.com>
        <01075529-4B7B-4C05-927F-0504315F2B3F@dwheeler.com>
        <CACBZZX5XDKwwXWtH8V9QD5v-4i+nHPuZ8x2n_Z3zuexQmg2mgw@mail.gmail.com>
Date:   Thu, 14 Dec 2017 10:08:46 -0800
In-Reply-To: <CACBZZX5XDKwwXWtH8V9QD5v-4i+nHPuZ8x2n_Z3zuexQmg2mgw@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 13 Dec
 2017 13:54:04
        +0100")
Message-ID: <xmqq6099uqq9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D4A6FF8E-E0F9-11E7-99B4-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Dec 13, 2017 at 6:46 AM, David A. Wheeler <dwheeler@dwheeler.co=
m> wrote:
>> On December 13, 2017 12:40:12 AM EST, Jacob Keller <jacob.keller@gmail=
.com> wrote:
>>>I know we've used various terms for this concept across a lot of the
>>>documentation. However, I was under the impression that we most
>>>explicitly used "index" rather than "staging area".
>>
>> I think "staging area" is the better term. It focuses on its purpose, =
and it is also less confusing ("index" and "cache" have other meanings in=
 many of the repos managed by git).
>
> After your patch the majority of the docs will still talk about
> "index", is this part of some larger series, perhaps it would be good
> to see it all at once...

... or none of it.  I do not quite see a point of spending list
bandwidth on a change like this one.
