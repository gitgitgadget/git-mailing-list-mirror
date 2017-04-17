Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A4DC20D09
	for <e@80x24.org>; Mon, 17 Apr 2017 04:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbdDQERX (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 00:17:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58561 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751030AbdDQERW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 00:17:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AD808C22C;
        Mon, 17 Apr 2017 00:17:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zweoIroKm4IlAkXNPpw5ZQ7OMXM=; b=earDGn
        kVR8RX+t6NTIEbIDR62PR8B5UPVzYAphdFZsTMGy1xiwKEmkf3JvU0RbMQYDq0tg
        sR1lfBOdxDHvSHr9lm/hoNMlFfb5I5TSGS4bwGknzcm+evAnniHaV1Qfk+Cipp7+
        4C7xqRMiyMpdkAcMLW9Xhr4H4JB691sr4yWq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nt1FJ4iyOFfwuzzGku8wXQNeYAIcX8iK
        wMQJzRCgNRtDDtm/9SkyIsGkh85RSEscEPYLSshBFS0hE4uRy2UNdlX1+RpQNSaE
        wAY0JRiLVao4yKz9NJmK0aXrUiaEiRoe9Yj+Uz4ScxJbui3Dkz3r7UjymSZqr180
        lGXFm9AdSuY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 613258C22B;
        Mon, 17 Apr 2017 00:17:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3CE68C22A;
        Mon, 17 Apr 2017 00:17:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] rebase: pass --[no-]signoff option to git am
References: <20170415144103.11986-1-giuseppe.bilotta@gmail.com>
        <20170415144103.11986-4-giuseppe.bilotta@gmail.com>
        <CAOxFTczZS6aDGzDVLskQGObtDOeLL_i3-8jJdh8OrQFXVGbOHQ@mail.gmail.com>
Date:   Sun, 16 Apr 2017 21:17:19 -0700
In-Reply-To: <CAOxFTczZS6aDGzDVLskQGObtDOeLL_i3-8jJdh8OrQFXVGbOHQ@mail.gmail.com>
        (Giuseppe Bilotta's message of "Sat, 15 Apr 2017 19:45:54 +0200")
Message-ID: <xmqqa87fk6r4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C02E4712-2324-11E7-B64D-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Damnit! I just realized that I forgot to amend before the format-patch:
>
> On Sat, Apr 15, 2017 at 4:41 PM, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>
>> +signoff!           passed to 'git am'
>
> This should be without the ! or --no-signoff is not accepted. Do I
> need to resend or ... ?

Resend or send something that can be "git apply"ed, which would
reduce the chance of mistakes.  Let the maintainer _TYPE_ as little
as possible, or typoes will sneak in.

Thanks.
