Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA9BA20288
	for <e@80x24.org>; Fri, 21 Jul 2017 16:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754141AbdGUQKX (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 12:10:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64466 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753516AbdGUQKW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 12:10:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4909194E1E;
        Fri, 21 Jul 2017 12:10:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G7pxORNy2wKeTjiaopSu5Fi6fQ0=; b=YK32Jk
        g5fFUFbgt3yKvTR3qEeSUlHgGjb/mrb9GFsbIdPWIUjg7xSOzGJx4SMEFex4AnS4
        aw82hpNqeTYrkdZJpq1otYRBNshIjWBrUdHmv7gAf3/05vjk3j+f5LQjFYJBI2YV
        OgT1D89lO/3ixmnFC1Mb01HZ/gDJ+9WSVA+KA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RFlVk6eil5jeUkscv5yt8ftl+ToHF2vx
        MVajIS1qOO6jFlD37VCryBIVWfQByed0V1KzhZdFHsU0tklSZpFts+6qb+z3TdQX
        0vxY9NLmGe+wtu888YuJYcxAXQ3JUA1ZAuWgLfLIR/wyQESqaTYd1LtWxFIb9uCB
        dkmg3oNRVPw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E82894E1D;
        Fri, 21 Jul 2017 12:10:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9981694E1C;
        Fri, 21 Jul 2017 12:10:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git@vger.kernel.org,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        Magnus =?utf-8?Q?G=C3=B6rlit?= =?utf-8?Q?z?= 
        <magnus.goerlitz@googlemail.com>
Subject: Re: [PATCH v2] l10n: de.po: update German translation
References: <4f846a80-dfd8-f895-3b90-df1f78041a9f@gmail.com>
        <20170721151144.4410-1-ralf.thielow@gmail.com>
Date:   Fri, 21 Jul 2017 09:10:20 -0700
In-Reply-To: <20170721151144.4410-1-ralf.thielow@gmail.com> (Ralf Thielow's
        message of "Fri, 21 Jul 2017 17:11:44 +0200")
Message-ID: <xmqqshhphitv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18D33616-6E2F-11E7-A3EF-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ralf Thielow <ralf.thielow@gmail.com> writes:

>  #: date.c:116
>  msgid "in the future"
>  msgstr "in der Zukunft"
>  
>  #: date.c:122 date.c:129 date.c:136 date.c:143 date.c:149 date.c:156 date.c:167
>  #: date.c:175 date.c:180
>  msgid "%"
>  msgid_plural "%"
> -msgstr[0] ""
> -msgstr[1] ""
> +msgstr[0] "%"
> +msgstr[1] "%"

Sorry, but I think these need re-translation after -rc1 because the po/git.pot
is generated incorrectly.  See the discussion:

  https://public-inbox.org/git/%3Cxmqqk233klvd.fsf@gitster.mtv.corp.google.com%3E/#t

Also, if you can, please try the patch in 

    <xmqqfudrkkci.fsf@gitster.mtv.corp.google.com> 

like so:

    $ git reset --hard origin/master
    $ git am <that message>
    $ make pot
    $ git commit -m 'update po/git.pot' -a
    $ cd po
    $ msgmerge --add-location --backup-off -U de.po git.pot

to make sure you get corrected entries for date.c.  If it works out
correctly, I'd want to ship -rc1 with that Makefile fix so that
Jiang can do the first four commands above to give translators a
correct po/git.pot to base their work on.

Thanks.

