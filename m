Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2055C20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 21:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbdLEVfJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 16:35:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60626 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751823AbdLEVfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 16:35:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B990C28A9;
        Tue,  5 Dec 2017 16:35:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lSf73wWAzsxS
        0cfjv5e/xynlp0M=; b=F+/nWbN7uB7K8pkcaAWYkceyyJzsaDI/aO+bxJ0cf9Xr
        bIQAIWwzPAI9/MTzhpiGAAbqmaaScglPZ8Rv7loJ+q1IjM3yCg0zdpvsifYWbGWm
        dvqiAuG1a4p2+A2STSSq/DnRIZeAQBGf4ONGibSvpUmM5iBSk+wnStUMFXdAIoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=o8vvvR
        T5uG4mRlsN9WIZfkEPnzttyQkOWNoj1SRy8bWUHwZT5POjw6Y18icY0xMQANP3GU
        J2aoNQalP49Y5Kt8EYf4AOPokA+dSSYir3M9pHoPx/k0U7mxUNqWcBxgPpMjoyaX
        UPX1xaQQrY/VWzbdK/Ead0Q4z4FGqfARhzp1w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 635DDC28A8;
        Tue,  5 Dec 2017 16:35:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D1408C28A7;
        Tue,  5 Dec 2017 16:35:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Jacques <dnj@google.com>
Cc:     j6t@kdbg.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v4 1/4] Makefile: generate Perl header from template file
References: <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org>
        <20171205212625.6616-1-dnj@google.com>
Date:   Tue, 05 Dec 2017 13:35:06 -0800
In-Reply-To: <20171205212625.6616-1-dnj@google.com> (Dan Jacques's message of
        "Tue, 5 Dec 2017 16:26:25 -0500")
Message-ID: <xmqq7eu0j1th.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2A138CF0-DA04-11E7-9E08-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Jacques <dnj@google.com> writes:

> Thanks for checking! The patch that you quoted above looks like it's fr=
om
> this "v4" thread; however, the patch that you are diffing against in yo=
ur
> latest reply seems like it is from an earlier version.
>
> I believe that the $(pathsep) changes in your proposed patch are alread=
y
> present in v4,...

You're of course right.  The patches I had in my tree are outdated.

Will replace, even though I won't be merging them to 'pu' while we
wait for =C3=86var's perl build procedure update to stabilize.

Thanks.
