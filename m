Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 005BF1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 15:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbcHWP7A (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 11:59:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57991 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750862AbcHWP67 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 11:58:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E053A351DC;
        Tue, 23 Aug 2016 11:58:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5jQSL94Cui72
        EcwIkvjwmf4ahGY=; b=f6I7futgas5ugPe4SuCtQZao7HQJ5QHJ7b9yerWhZenU
        YgnGIFB8OGPXj32TD1+IFxzItur/AQhvmb04SozLFOSy0iR2aFm1L/rFIrDAqZws
        H5iSqOFwkpq0hJdwjBzOXdCe5YQDtp5FZexx5vcg6QQKmmqlx7FXH1/F1YSXiek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=lIlXhW
        MMBbTVai076VoHQi2vjc0TUDcKbxHcJd01dUjHY1jljNeI5sWeQNMCYt2/NwHb3M
        lsFV1qXP1jFvoMJF5SjsubI7QN1m9/VGp7u1/NRU+uCH04z1yCLHlEln6Fyz/e3a
        iuHc6Bq2nYkwELLtAdPd5rUThupV3Szzg5BNo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6EFC351DB;
        Tue, 23 Aug 2016 11:58:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 573C1351D9;
        Tue, 23 Aug 2016 11:58:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Marco Sousa <marcomsousa@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Nelson Martell <nelson6e65@gmail.com>,
        Brian Gesiak <modocache@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [L10N] Kickoff of translation for Git 2.10.0 round 1
References: <CANYiYbGL+GVRNuhszp1UShaN_oJgm3netsQxZfbW74pVK0gOYQ@mail.gmail.com>
        <9262712.D6TC1VHfMN@cayenne>
        <xmqqy43rxqqz.fsf@gitster.mtv.corp.google.com>
        <4016813.pOBvC7ZxlR@cayenne>
Date:   Tue, 23 Aug 2016 08:58:55 -0700
In-Reply-To: <4016813.pOBvC7ZxlR@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Sat, 20 Aug 2016 20:38:40 +0200")
Message-ID: <xmqqoa4jxyrk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7FD1E8E8-694A-11E6-A669-E86612518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

>> > 3. git-rebase--interactive, in this_nth_commit_message and
>> > skip_nth_commit_message are not localizable,
>>=20
>> As the "TRANSLATORS" comment alludes to, "This is the Nth thing" can
>> be rephrased to "This is the thing N" or "This is the thing #N"
>> easily, and if that form without ordinal is acceptable for many
>> languages, we should say that it is also OK in C-locale without
>> translation.  So I agree that the recent change was pointless (even
>> though the result may be localizable).
> ...
>> so I do not think we cannot do it with ngettext().
>
> Let's cut it like this : first ten are literally translated, the follow=
ing ones=20
> fall back to a general rule.

I actually once wrote "It is rare to squash dozens of commits into
one, so the first ten or dozen messages that spell the ordinals out
may be a good thing for readability", in the message you are
responding to, before realizing that the messages actually say
"1st", "2nd", etc., not "first", "second", etc., and scrapped that
part of the response.  I do not really see much point in forcing the
first ten to be translated differently.


