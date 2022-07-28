Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68883C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 17:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiG1Roc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 13:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiG1Roa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 13:44:30 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48183747B1
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 10:44:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E807D19CF22;
        Thu, 28 Jul 2022 13:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IQSX2GzfoeLC
        fpVRS+m6DVJAP8AOpbJQ7v4F6agUnj8=; b=ZgM4ihhV9aFOxYtaZHnVmYxKFLa4
        yTgSUa9bsgz5JdPMF7Azqsoslb0EljhuxzxovJCrRAKFZEboXr2IKOWj35LeRvY1
        JTQMhHurUxi16zvoUXHZAORooKkLl+j74aDKbhvjDmtL6YXWgYqeBB0X0pWHFrWf
        iDGZob+r0RruF80=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E091D19CF21;
        Thu, 28 Jul 2022 13:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6BD4919CF20;
        Thu, 28 Jul 2022 13:44:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eugen Konkov <kes-kes@yandex.ru>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Re* --creation-factor=100 does not show code
References: <1196830250.20220726145447@yandex.ru>
        <7229p500-p2r4-on87-6802-8o90s36rr3s4@tzk.qr>
        <xmqqo7x9ch7n.fsf_-_@gitster.g>
        <220728.86k07xjh11.gmgdl@evledraar.gmail.com>
Date:   Thu, 28 Jul 2022 10:44:25 -0700
In-Reply-To: <220728.86k07xjh11.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 28 Jul 2022 19:12:45 +0200")
Message-ID: <xmqqwnbxb092.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EC8B106A-0E9C-11ED-8EF6-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> That algorithm section also says:
>
> 	The cost of an edge o--C is the size of C's diff, modified by a
> 	fudge factor that should be smaller than 100%.
>
> Which I find quite confusing to follow, isn't that "fudge factor" the
> <percent> (or <factor>) we're accepting with --creation-factor? Doesn't
> that also need to be adjusted?
>
> I still find this documentation quicke lacking, if the default is 60 an=
d
> it's not 0..100 what is it then? Are values of 200 sensible in some
> cases, 1k? 10k?

I think 90% of your responses are better answered not by me.  Feel
free to edit "to:" header field when that happens next time ;-)

Thanks.
