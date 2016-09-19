Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 533202070F
	for <e@80x24.org>; Mon, 19 Sep 2016 17:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbcISRym (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 13:54:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62640 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751437AbcISRyl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 13:54:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 729013F306;
        Mon, 19 Sep 2016 13:54:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MTT9n9AjmsI4eX3I9yhgg2bVs2I=; b=Ttu2wH
        g5U5iyDF9etLIvioDidsBcJw75/oGQpZMdSEWsMvFiOY7fswc4DAgfSdtogyk6nL
        bR00CLsPBwECuJkAOOIX7SE0XkFwWPYXTzQAaeKjpkJWYFGEe4AWlLZMMoHOuesN
        WkY5OQ6wCll2D7OtzObsn34Z2bYzQmrTHTKT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F0iS2rXWJjsAzfuzDslhKru/N0aGN05H
        M+pVv66AYLRNjM+ArxZD31ZqRowunGq4RdTpa+DCs7DceGnodgNSmPuwPJWyEJLF
        NSj/RkLn/FjmEKJIr+4qfYVsBuEzWKjUFzlKdRAqT8abCIYIA4Cv1pc2BmoCW/NP
        JMFyiB5Y41w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A89C3F304;
        Mon, 19 Sep 2016 13:54:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C89123F301;
        Mon, 19 Sep 2016 13:54:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Subject: Re: [PATCH 1/6] i18n: commit: mark message for translation
References: <1474290501-2743-1-git-send-email-vascomalmeida@sapo.pt>
Date:   Mon, 19 Sep 2016 10:54:37 -0700
In-Reply-To: <1474290501-2743-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
        Almeida's message of "Mon, 19 Sep 2016 13:08:16 +0000")
Message-ID: <xmqq60prg4gy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22F7B276-7E92-11E6-9E08-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I am responding to 1/6, as the series lacked a cover letter, but all
of them looked good.

Thanks.
