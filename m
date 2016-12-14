Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD5191FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 19:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbcLNTCK (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 14:02:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56164 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753897AbcLNTCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 14:02:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84B6C56506;
        Wed, 14 Dec 2016 14:02:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hz13zj/ZHeZraIswEAkAe26HkOA=; b=UHi01t
        Kvy8UzoBnumYou9+3faEqm8XQ8sooqtLz/KjT/pRfdDEYtG1vjIccRnoBaBUHN4/
        pm20ezfXe2vmv1m35WC1RBoeKKGtU4nlBAspIXShTdQlNpb7q4w5q8m09Rr4tgs1
        TUC4pSARTf+Sw/pHdkP/dmyjagCUiuS1Hh+rU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WPZ5ahnw1v8m3nw7wf5BI3TK/p8KX+dA
        tzjksE0YnnoIMcUNshdt70xT8vSyoSbnvsyPQ73ZgWCQFdBCS7sXHRmC2YwE3s97
        V+c2fM5Hen4UhNagqBo0dvyFdCmO9wOmibRrK6fyxFWNuatV9jX8SBl1JH443eVE
        PLq9FIP9SGU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A8A256505;
        Wed, 14 Dec 2016 14:02:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4C8F56504;
        Wed, 14 Dec 2016 14:02:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        Jakub =?utf-8?Q?Na?= =?utf-8?Q?r=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v7 00/16] Mark strings in Perl scripts for translation
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
        <20161214125439.8822-1-vascomalmeida@sapo.pt>
Date:   Wed, 14 Dec 2016 11:02:06 -0800
In-Reply-To: <20161214125439.8822-1-vascomalmeida@sapo.pt> (Vasco Almeida's
        message of "Wed, 14 Dec 2016 11:54:23 -0100")
Message-ID: <xmqq37hqxrkh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF654286-C22F-11E6-9EFF-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Changes is this re-roll v7:
> * Add get_comment_line_char subroutine to perl/Git.pm and use it.
> * get_comment_line_char gets the value of core.commentchar configuration
>   variable. It handles the 'auto' value taking '#' in this case as the
>   comment line character.
> * When core.commentchar is not set to one single character, take '#' as the
>   comment line character. This follows the system behaviour programmed in
>   config.c::git_default_core_config.

I gave it a read and I think it is ready to move forward.

Thanks.
