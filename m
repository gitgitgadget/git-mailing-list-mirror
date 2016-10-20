Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23DC01F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 16:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965543AbcJTQZd (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 12:25:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59614 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965549AbcJTQZc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 12:25:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1388046CCF;
        Thu, 20 Oct 2016 12:25:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KZjJmD+2rJuGNmnTljeKXSJHRO8=; b=YWKEVZ
        GJ2tmLSZoYjCQdiZ7AOsVqSyDsWDVAY1YauLvUyp7eWO4zsK4F36XTJD+hR5xSET
        2h+aJavVNMTEmZXxHeiZoH/XtD8ZYew3HyFsqzgQvyx5Ghgjag9wBqootUw7CLyN
        dhVJY2OSpC618YC0kSvdYP56CeB0WXJmIn0kU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=icFaX2K2a0gmc4NZwO1rT+XII9bdi7Mz
        KDYt3kUNPQE0MRJojgx4vnWY70P563853dUumjF3I2o5rKs0uFv0lEsvU1eoXml+
        tXS/48OqGqID6PvBEZ0sJheeH1cdJqBoRv8VTBXJ6LsB5zIlvPtnO52+KjwyZbdL
        wx+nKcSC0ws=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 066B446CCE;
        Thu, 20 Oct 2016 12:25:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 497F046CCD;
        Thu, 20 Oct 2016 12:25:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        Jakub =?utf-8?Q?Na?= =?utf-8?Q?r=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v4 01/14] i18n: add--interactive: mark strings for translation
References: <20161010125449.7929-1-vascomalmeida@sapo.pt>
        <20161005172110.30801-1-vascomalmeida@sapo.pt>
        <20161010125449.7929-2-vascomalmeida@sapo.pt>
        <xmqqy41kkxzd.fsf@gitster.mtv.corp.google.com>
        <1476980461.14459.10.camel@sapo.pt>
Date:   Thu, 20 Oct 2016 09:25:28 -0700
In-Reply-To: <1476980461.14459.10.camel@sapo.pt> (Vasco Almeida's message of
        "Thu, 20 Oct 2016 16:21:01 +0000")
Message-ID: <xmqqeg3bhts7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1402496-96E1-11E6-9530-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

>> Not a big deal, but this makes me wonder if we want to do this
>> instead ...

For future reference (for others as well), when I say "makes me
wonder" or "I wonder", I am never demanding to change what the
original author wrote.  I just am trying to see that pros-and-cons
have been considered already.

> ... Also I think msgfmt checks if English source and translation
> both end with newline or not.

That is a good enough safety belt to me.

> I will leave this patch as is.

Yup.  Thanks.
