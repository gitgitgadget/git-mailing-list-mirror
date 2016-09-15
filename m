Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7BF52070F
	for <e@80x24.org>; Thu, 15 Sep 2016 20:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755713AbcIOUTF (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 16:19:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51671 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754094AbcIOUTE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 16:19:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7C973CE21;
        Thu, 15 Sep 2016 16:19:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q01/2U2Nb1GNeDM7OzYyMvLqcHc=; b=kB2rhj
        OiefeszUn/4kAswQDjnpfmluq7oN3emcLDqerx2xX1jmoqc+XfwuEpHzbb2t4SWV
        slXtwnnLT3a/DJ5dT2G34ksUebk3goKQJtEvn/5vhwrUya7ojiT3BGCaLZHOHECS
        Zz1eBYP/gXdUEAgQ/z2QsdvQztfL/rUuRUQTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sonKjpbZ/P0Q8rKIz+SoFtmeAHOo1VAR
        XRraawDPoYf41SEHb1EFkqgzFIF8xzS896tA4Q9uTzxZlRSliXVKprETeoqTuN1Q
        LjuLawHfhy+F7gQjsaf7WSqi/7jsmCnDT2G3DHhDJzdkp3PSVmmo6lizQDqwtIVl
        ArJOYxJmOU8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF0DD3CE20;
        Thu, 15 Sep 2016 16:19:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 443A93CE1F;
        Thu, 15 Sep 2016 16:19:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Subject: Re: [PATCH v3 13/14] i18n: show-branch: mark plural strings for translation
References: <1473951548-31733-1-git-send-email-vascomalmeida@sapo.pt>
        <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
        <1473951548-31733-13-git-send-email-vascomalmeida@sapo.pt>
Date:   Thu, 15 Sep 2016 13:19:00 -0700
In-Reply-To: <1473951548-31733-13-git-send-email-vascomalmeida@sapo.pt> (Vasco
        Almeida's message of "Thu, 15 Sep 2016 14:59:07 +0000")
Message-ID: <xmqqtwdgncgb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A48B2A84-7B81-11E6-9DA7-92D512518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Mark plural string for translation using Q_().
>
> Although we already know that the plural sentence is always used in the
> English source, other languages have complex plural rules they must
> comply according to the value of MAX_REVS.

Nicely explained.  Thanks.
