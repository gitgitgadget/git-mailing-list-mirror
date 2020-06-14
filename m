Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC71C433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 00:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9145206B7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 00:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CfM2+0bM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgFNApQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 20:45:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61419 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFNApP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 20:45:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 925946D634;
        Sat, 13 Jun 2020 20:45:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fVGDAqy1bslp
        jI8XFsCOLaP9YBU=; b=CfM2+0bMPZTP6msHOKMLFHR3h6KB+gFWTQ7w3RqgW12F
        Mt8badBLT3YfaLKQBDE+WK0bEL78WG5z3XsE27KYOIaHliidGGCFLfEzBS7Ppk6/
        uNbC3PJcIxJRipmgafPbfqsRCqidzj/giCUjYmoQF/qMEij6a6G4BqUprXdH87I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=P0YMa+
        h5bKkU51tDqYMr8Jkjad9XSj4FRdQPIzZAKolEBsi8BaUMohC9zLAx6Z2oTjsPvd
        GEHO4H3ItHkxfnhXqbg/1O4f5CjrTSCctg/P1k/FzwyVJUlpjzEAth6neyZuKT4w
        t+mpuxFdOvtWyKZHUqfkcKAh6/FcDCbUAQgQs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A7216D633;
        Sat, 13 Jun 2020 20:45:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12E896D632;
        Sat, 13 Jun 2020 20:45:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?S=C3=A9rgio?= Augusto Vianna <sergio.a.vianna@gmail.com>
Cc:     simon@bocoup.com, don@goodman-wilson.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net
Subject: Re: Rename offensive terminology (master)
References: <CAOAHyQzxG7Lc6+PLBtM6oe9vSoEEAmuXAaKF2VzO_phtkfGRVA@mail.gmail.com>
        <32b2d17c-71df-4c10-72d7-9696f1cb17a9@gmail.com>
Date:   Sat, 13 Jun 2020 17:45:12 -0700
In-Reply-To: <32b2d17c-71df-4c10-72d7-9696f1cb17a9@gmail.com>
 (=?utf-8?Q?=22S=C3=A9rgio?= Augusto
        Vianna"'s message of "Sat, 13 Jun 2020 21:00:41 -0300")
Message-ID: <xmqqy2oqxyp3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4E924422-ADD8-11EA-AF07-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

S=C3=A9rgio Augusto Vianna <sergio.a.vianna@gmail.com> writes:

>>as far as I can tell, no evidence that "main" offends anyone.
>
> I'm offended by "main". What now?

You make sure that the list won't reach concensus that the word is
good enough for everybody.

Even if you fail in doing so, there still is a recourse for you.

When you see a (future) version of Git that allows you to configure
the name of the default/primary branch, but does not yet switch the
name of the default/primary branch from 'master' to 'main', you set
the configuration variable(s) to 'master' (or whatever word of your
choice) in ~/.gitconfig and move on.  You won't be affected by the
future switch from 'master' to 'main' by being prepared that way.
