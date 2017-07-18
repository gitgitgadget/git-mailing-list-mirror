Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC6F620356
	for <e@80x24.org>; Tue, 18 Jul 2017 19:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751431AbdGRTNV (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 15:13:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62554 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751402AbdGRTNV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 15:13:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F1B679017;
        Tue, 18 Jul 2017 15:13:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5+MqvHLSoURY
        BP4WeI+NN1JK/tM=; b=Yx7so9vAeVXvrkYA2qjAGndPes9n3bLh1GRFGc/aEc/p
        +blbNnC96e0eqeWcjfKA/Y6UGpNOu+9bDvmcVoeOkxIyh+63ZWhoqyNkx8UuJnjg
        kjgKifK5sG10GKLtU5Qig8RK205qUB1KTWqOGAy3B3mjWrp8UIEcTj5Qwf2U6i0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=U0TCj2
        EOOAt5KoVXn24YHKXOZK01zcFRpPxC+sqtLYZRpWXgg31lvY8njNUA4eY8rpFwWo
        zaO33kNh33BnVhFTPuXqkVFpXj2xGw9cT37Au6xzuzKcZJ6rV7yH/yztlDaPItjT
        gf7ckVq5+4j6RMzBJFCEG3i5K8t9/y6ENBgmc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56A8079014;
        Tue, 18 Jul 2017 15:13:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C39B479013;
        Tue, 18 Jul 2017 15:13:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 00/10] tag: only respect `pager.tag` in list-mode
References: <cover.1499723297.git.martin.agren@gmail.com>
        <cover.1500321657.git.martin.agren@gmail.com>
Date:   Tue, 18 Jul 2017 12:13:11 -0700
In-Reply-To: <cover.1500321657.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Mon, 17 Jul 2017 22:10:42 +0200")
Message-ID: <xmqq1spdpni0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 24DF4948-6BED-11E7-B62C-EFB41968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> After that feedback, v2 drops `pager.tag.list` and instead teaches
> `git tag` to only consider `pager.tag` in list-mode, as suggested by
> Peff.

That does sound like a more sensible and safer approach.  I may have
comments on individual patches, which I will send while I read them.

Thanks.
