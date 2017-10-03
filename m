Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA21020281
	for <e@80x24.org>; Tue,  3 Oct 2017 06:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750812AbdJCGUv (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 02:20:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60905 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750720AbdJCGUu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 02:20:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1807FB66DC;
        Tue,  3 Oct 2017 02:20:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iQ4ItHaGDKaA
        ziyOeUIAAWen+fw=; b=jqg64IDo+jvS2nSEiI+CnSft89ECwCsoojxaNqsl/Mh+
        cdwpSmyYcfT/vAf+fdrcpAtUxgnByfbgh6coc9Kvu3OeMC8/AOp3LszT3GHngzhK
        MIij6yo6xF1cjLEp+ln2dtv3dMbzyQ1IFgzfrm/Y5+Y3a5O9b8+l8Np9Nnx/DgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kl1nOy
        FIUbghK2YRTybI4x12PgARPnp61rZ8iXVOEtxZjnUG34SgJu+TMKPEfpZ1+konyj
        2SlNXNkIQ7mgWvC8DSUOOTpWoW/pi82wh7NUIplM6qPM0WeuG8xwZEPxYTjs1ufo
        9L//ICWEIRjEXW0ByNaHoPVsQUdqlDSzi1qG0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D5ECB66DB;
        Tue,  3 Oct 2017 02:20:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 74315B66DA;
        Tue,  3 Oct 2017 02:20:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/: add UNLEAKs
References: <20171001174208.1693753-1-martin.agren@gmail.com>
        <20171002062528.naa5hrqoao5sifs3@sigill.intra.peff.net>
        <CAN0heSoson-KkbgVnRPdTmRL2MMDU1+L6XdOHhi6xcZS5rwQcQ@mail.gmail.com>
Date:   Tue, 03 Oct 2017 15:20:43 +0900
In-Reply-To: <CAN0heSoson-KkbgVnRPdTmRL2MMDU1+L6XdOHhi6xcZS5rwQcQ@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 2 Oct 2017 12:20:56
 +0200")
Message-ID: <xmqq3770kb0k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FCED9244-A802-11E7-9F8A-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

>> Seeing hunks like this makes me happy with the UNLEAK() solution. It
>> would have been a real pain to do this via actual freeing.
>
> Yes, I was very happy to have it handy. :-)

OK, let's merge this to 'next', then.
