Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D86A02021E
	for <e@80x24.org>; Tue, 22 Nov 2016 22:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934351AbcKVWYS (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 17:24:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52945 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932346AbcKVWYS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 17:24:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3201250CB4;
        Tue, 22 Nov 2016 17:24:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AjuVBnB81WEa6HxiYt+YZRzanJc=; b=qe1EyP
        aGkVmOXXVm4V0ta9vnuLeYrKtY9C4TRhUA+bgzSf+kCwOaaNiGfUuZXi3FhZ8ipp
        RWY+YI4J2SRewVd0CrXaVuFoWuUVsoy13gr3FyyE5tsFWpzF1peSaC/kuVNieAl4
        plXgrkm5kbtI6OdZck9be9Wr6XPyCf8ci+p1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=plcVofvnWxXObtIMHgZjRlsI5u1Kyfit
        IgUk7H9GNECAoS7BCK/mD0ozwNP9WcDyYSyFHVTS10kwJdre1UxT34TKBgDSzGgI
        Np3R6DY6JqoO5wNFF/pu9STLKPfSdl9AOy19a083vlqMLEXmml12e2sGEX1po2E4
        4oOoSLdHt4g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2976D50CB3;
        Tue, 22 Nov 2016 17:24:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8458250CB1;
        Tue, 22 Nov 2016 17:24:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOi?= =?utf-8?B?bg==?= 
        <vnwildman@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [GIT PULL] l10n updates for 2.11.0 round 2
References: <CANYiYbGtfZKshmfYxHM0sL2Z67=3KTF0kixP1OjumRw87e9XkA@mail.gmail.com>
        <CANYiYbFSpUmtv1eO_GE_yRU4CsXzd29qV2LTbXa67d=Uxbw2=Q@mail.gmail.com>
Date:   Tue, 22 Nov 2016 14:24:15 -0800
In-Reply-To: <CANYiYbFSpUmtv1eO_GE_yRU4CsXzd29qV2LTbXa67d=Uxbw2=Q@mail.gmail.com>
        (Jiang Xin's message of "Tue, 22 Nov 2016 23:11:31 +0800")
Message-ID: <xmqqwpfvnofk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 678561CA-B102-11E6-8EB8-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Git 2.11.0-rc2 introduced a very small l10n update.  Because the
> update windows will be
> closed tomorrow, I made a batch updates. See commit:
>
> * https://github.com/git-l10n/git-po/commit/275588f93
>
> I have a reduced diff for this commit using a custom diff driver, see:
>
> * https://gist.github.com/jiangxin/6384b1e865249228e00385fab84ef3f3
>
>
> 2016-11-22 22:59 GMT+08:00 Jiang Xin <worldhello.net@gmail.com>:
>> Hi Junio,
>>
>> The following changes since commit 1310affe024fba407bff55dbe65cd6d670c8a32d:
>>
>>   Git 2.11-rc2 (2016-11-17 13:47:36 -0800)
>>
>> are available in the git repository at:
>>
>>   git://github.com/git-l10n/git-po tags/l10n-2.11.0-rnd2

Thanks, pulled.

FYI, we seem to need a bit more time on the code front so we'll have
an unscheduled 2.11-rc3 tomorrow.  The final one will be near the
end of the month, tenatively scheduled on Nov 29th.



