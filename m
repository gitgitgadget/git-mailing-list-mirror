Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CD9C433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 19:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E83F2207DD
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 19:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nAk3h+Wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgFQT4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:56:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52424 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQT4m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 15:56:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 46363E2BCA;
        Wed, 17 Jun 2020 15:56:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0TQ57p2w6vHZ8iBOxC7O94Wpglk=; b=nAk3h+
        Wn7cLpmu1XEpj1cKw4uxxWBlyDXuPXJGSx/WSzEznrlwd7gRxFyVWkRn+zIYGP17
        8miiI8hZjLdl2iObhdkwvwnK/BI2/Jj2PUqKb6r1W7C6C47p+ireCG9h5ZeD0fQz
        NKoiVWbQxc7nxnBgmEf5GSo7M79B6Hnb38Zl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PdMaKoCoZZOwVwRy0/wD6WYt81j8J2Gw
        37Vx6eSdmAVlspvB6e09oEkye/mJCC2dViHZvBF1VlFNQ8o7phA70KKsONigK2Z3
        vDexr8kJUEWCf9tLbg1WPLYwju4xCraorPeT+ZaekSDWEqM/47sGW2c0dZ9+9Q5a
        25hpkomawDo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C6F0E2BC9;
        Wed, 17 Jun 2020 15:56:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 83E3EE2BC8;
        Wed, 17 Jun 2020 15:56:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     demerphq <demerphq@gmail.com>
Cc:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        =?utf-8?Q?S?= =?utf-8?Q?=C3=A9rgio?= Augusto Vianna 
        <sergio.a.vianna@gmail.com>, konstantin@linuxfoundation.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        don@goodman-wilson.com, Git <git@vger.kernel.org>,
        newren@gmail.com, philipoakley@iee.email,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Rename offensive terminology (master)
References: <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
        <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com>
        <CANgJU+WoGNKuvZHAtLAfNAUfFdoLWHiDis_rSV-AfT9WspmHgA@mail.gmail.com>
        <20200616074316.GA21462@kitsune.suse.cz>
        <CANgJU+XzD9Nnnu4qWExpOUBy+u1=23SRCQy-=6aAVFJAowkjYg@mail.gmail.com>
Date:   Wed, 17 Jun 2020 12:56:35 -0700
In-Reply-To: <CANgJU+XzD9Nnnu4qWExpOUBy+u1=23SRCQy-=6aAVFJAowkjYg@mail.gmail.com>
        (demerphq@gmail.com's message of "Tue, 16 Jun 2020 10:01:54 +0200")
Message-ID: <xmqq5zbpv53g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A75BA11C-B0D4-11EA-95D3-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

demerphq <demerphq@gmail.com> writes:

> kind of confusion. Consider how this conversation goes for us:
>
> A: "No you need to fetch trunk from the remote, then you need to merge
> it to your local trunk and then push it to the master trunk".
> B: "Ok."

Hmph, why isn't the last one "trunk trunk"?

> Similarly when the perl project migrated to git we renamed "master" to
> "blead" to reduce the possibility "master master" confusion.

Or put it differently, "your local master?  remote master?  or the
primary master?" would be a way to state the phrase A asked in the
example without renaming the name for the primary branch to 'trunk'.

What I am trying to get at is, after changing the name that is given
by default to the primary branch in a newly created repositories by
"git init" to 'main' (which I am OK with, and it seems that the
major projects and repository hosting services will be doing anyway
with or without getting themselves in this discussion on this list),
wouldn't we risk the same "master master" confusion caused by and to
those newer users who learn 'main' is the word given to the primary
thing?

Wouldn't you teach your users to fetch 'main' from the remote, merge
it to the local 'main' and then push it to the 'main' main?


