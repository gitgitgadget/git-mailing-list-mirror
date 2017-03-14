Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09BFF20953
	for <e@80x24.org>; Tue, 14 Mar 2017 21:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbdCNVN7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:13:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50106 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750905AbdCNVN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:13:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 096ED6CB8C;
        Tue, 14 Mar 2017 17:13:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/4x/iZaj9FAA
        cZJrr4Bc/dlSolc=; b=vE1MJSdvHBbQ6XJqkVDH5x3KiMa+0f6C585uOWV/LaKh
        UsZtLK+dyAJRCqNnUu9hlIOgBVlAxs3UZZeo839LXMZrUWNdIrvDp82SrE3zLWQY
        BN8SSXlDk2YQZHpuIYRdLkuk2THcqc/up6pEUaHYHd3ykqvQ3D1POGIOirEZQl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JmrDJ6
        WRvjgc1U9Ylk7hyoPSSje0TadWUYr9cFqcpPk09c5ckVe/k3OUXSJA3VVtmhS5YN
        hGkBhf2RyhQ2vKD6LTcHqj7JxfHKbpDbQEteoTbRmQw4zyUWzlvosdwjIdxeb1IO
        GtZrqBrJu9CE3oUke+5Vekb5bgDDJZL9BxDGY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 007126CB8B;
        Tue, 14 Mar 2017 17:13:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68A9D6CB89;
        Tue, 14 Mar 2017 17:13:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jean-Noel Avila <jn.avila@free.fr>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] l10n: add framework for localizing the manpages
References: <20170312200248.3610-1-jn.avila@free.fr>
        <20170312200248.3610-2-jn.avila@free.fr>
        <xmqq1su2ujsf.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4EGfBAu0M0y4xboVAtWf5N07XY8s40npQ1hN3rbgqmSw@mail.gmail.com>
Date:   Tue, 14 Mar 2017 14:13:55 -0700
In-Reply-To: <CACBZZX4EGfBAu0M0y4xboVAtWf5N07XY8s40npQ1hN3rbgqmSw@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 14 Mar
 2017 22:00:21
        +0100")
Message-ID: <xmqqwpbrh88c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 225CDABE-08FB-11E7-B914-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think this series is on the right track, and that po4a is the right
> tool for the job.

OK, thanks for the input.
