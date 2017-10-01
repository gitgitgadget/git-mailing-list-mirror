Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F2C202A5
	for <e@80x24.org>; Sun,  1 Oct 2017 02:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751071AbdJAClC (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 22:41:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64512 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750980AbdJAClB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 22:41:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D7C692F2E;
        Sat, 30 Sep 2017 22:40:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qpY8NoX5LgbCeCzfsdwg7Z7rCCs=; b=qPRyWM
        2b+dUkJB4WTTEbYtdopSLvxDwwO8GSAB2XuHRKluyYU0RZ3z9OOTsok1KQkmqLZ8
        RWAazLyoBGmqkYwVQuFoMS3/39Xa9j15qWtFXFXOkxwRinjkPGMWE5QHYOPFNu+E
        UllQa5kOMUPsKqUUcGDKzko50f8OkOFAvuTqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sFcgePY8Ec3olasS3dNVot2ytvBA2V0d
        FSrBpeR/iL41kHLTPZRIecFU0an7YXxmMo5yqOSR1rVsR4H4VmiOlxa/vAlBYHIO
        XQ3BPFPpik0smTbOSew6GD/PEznfC2y/2rj2CZWAze4FrLfJZE01wIYOsrDLGr+t
        Qm6HTvxRXUE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6506F92F2C;
        Sat, 30 Sep 2017 22:40:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C0EC292F2B;
        Sat, 30 Sep 2017 22:40:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH] clang-format: adjust line break penalties
References: <073f00fa11930a3607e34828e7563e1b2dc27d2a.1506709551.git.johannes.schindelin@gmx.de>
        <20170929184032.GK19555@aiede.mtv.corp.google.com>
Date:   Sun, 01 Oct 2017 11:40:56 +0900
In-Reply-To: <20170929184032.GK19555@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Fri, 29 Sep 2017 11:40:32 -0700")
Message-ID: <xmqq3773wpxj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4437968-A651-11E7-86FE-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi Dscho,
>
> Johannes Schindelin wrote:
>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  .clang-format | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> Well executed and well explained. Thank you.
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks, both.  I think the adjustment in the patch makes sense.

