Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D924D1F466
	for <e@80x24.org>; Tue, 17 Sep 2019 22:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfIQWOg (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 18:14:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64324 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfIQWOf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 18:14:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CE52076E82;
        Tue, 17 Sep 2019 18:14:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RUMkc2Ab86npYvFNotCMKR1TTC4=; b=bepRAk
        zvSS/nWJQxN6w9ujNLzuK/rQbu/2G6NMRr5OR31e/v/+p+aShQI3Tz2L4U+3zZBE
        yIaSUKVMvJte7Q2qVGde424jeqrWuaDfH41Xw8EoXBUgAmXsg9OPQmP/C2f9dlE/
        y9oA/qKKbk1ozB2i8B2QTLNTKsTemhUJSEoaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eXPjVsytzOj0Q2nh6b3mqZy/9DJwrgRg
        sgKKTjBO6vxTsLhPB0f3nYaStVJtQ9pErHrelcacy993wH83b0rdjTJNeRkHssIV
        XCRPNJs5e973lUF9027iBnT8CqfAFbgUYua1hJ236v6K/qk6UFy1YnY87x3n1oNU
        Op4Ragx4tCM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6A5076E81;
        Tue, 17 Sep 2019 18:14:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 00FFD76E79;
        Tue, 17 Sep 2019 18:14:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH] gitk: rename zh_CN.po to zh_cn.po
References: <6feff2e73e1c4ca838efcabe90e0978a4d88cb7d.1568710294.git.liu.denton@gmail.com>
        <xmqq36guamym.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 17 Sep 2019 15:14:28 -0700
In-Reply-To: <xmqq36guamym.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 17 Sep 2019 09:48:01 -0700")
Message-ID: <xmqqlfum7epn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 858A499E-D998-11E9-B605-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This would make this in line with pt_{pt,br}.po, existing locales
> with country code in them.
>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>

Paul, I've applied this to a clone of gitk locally and merged it
(resutling in 2a4ac71ffb that should be reachable from 'master'), as
it was breaking my "install" tests.

Thanks.
