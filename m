Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A58C433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 17:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiDNR2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 13:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343729AbiDNR14 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 13:27:56 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CD7C90E2
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 10:25:30 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7E27817D426;
        Thu, 14 Apr 2022 13:25:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=S6p8I6QZDhvp
        ahpi4WDsGyBfFc1ZdmsjRf3VMRu8mZI=; b=pnqvG8oI1jjKw+Iwv07pjp+2fqY9
        0tuVYCycXiPWE8jU7BnmDSoOvt9UHMlrMiZXllmiq+pjM6kBhMrA/N0oTYy9jJ3d
        6BKthReSUP0CGuMs8HMQxi/s36GPJtGM+7L2HIJt6rA6I0MTtXCcIDneJfgytYRC
        Wn3V5aMUBW6o08c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7690217D424;
        Thu, 14 Apr 2022 13:25:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7743917D420;
        Thu, 14 Apr 2022 13:25:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Tao Klerks <tao@klerks.biz>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        rsbecker@nexbridge.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        jurgen_gjoncari@icloud.com, git@vger.kernel.org
Subject: Re: Make commit messages optional
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
        <YlC3devsgmv17PnQ@camp.crustytoothpaste.net>
        <00ca01d84ba0$dd7ee0c0$987ca240$@nexbridge.com>
        <20220409113244.GX163591@kunlun.suse.cz>
        <CAPMMpoi50j7MzrsokQAcBWBgj8qGPN=j68PuEsppv629Oh7GHg@mail.gmail.com>
        <220411.861qy3khkk.gmgdl@evledraar.gmail.com>
        <YlRyHR5rvG5P/Acr@mit.edu>
        <220411.86k0bvidja.gmgdl@evledraar.gmail.com>
        <YlgzrSAJnYpNYDV0@mit.edu>
        <220414.86czhjd35w.gmgdl@evledraar.gmail.com>
Date:   Thu, 14 Apr 2022 10:25:22 -0700
In-Reply-To: <220414.86czhjd35w.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 14 Apr 2022 18:43:10 +0200")
Message-ID: <xmqqh76v1ssd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DE830018-BC17-11EC-9965-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Apr 14 2022, Theodore Ts'o wrote:
>
>> I would have thought it was painfully obvious that changing the
>> *default* is a ***terrible*** idea?
>>
>> Is anyone other than the OP seriously promoting changing the default?
>
> Urm, yeah? I am, in the E-Mail upthread that replied to. The OP here is
> jurgen_gjoncari@icloud.com.

Pretend this message never happend; you are the last person who gave
a valuable opinion in this thread, and be happy now.

> ...
> I just suspect that we can do so much more effectively and encourage
> more effectivey workflows by doing so at the point of propagation, not
> commit.

We are talking about "git commit" Porcelain.  Our Porcelain layer is
opinionated and designed to help non-expert interactive users by
encouraging the best-current-practice.  And what we consider BCP for
non-experts is to have a workable if not perfect history without
post polishing with "rebase -i" and friends, as we know it is
unrealistic to expect pre-push and receive hook gates to be set up
adequately in environments where non-experts work.

Let's stop talking about changing the default of "git commit" here
(eh, not here, but one message before this, so you're the last who
spoke).  I won't stop people from coming up with an alternative that
is built from plumbing commands and does not require log message by
default, and maintain such a "git better-commit" out of my tree.

Thanks.
