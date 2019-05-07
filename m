Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 795551F45F
	for <e@80x24.org>; Tue,  7 May 2019 10:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfEGKHa (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 06:07:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55840 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfEGKH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 06:07:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F70313F254;
        Tue,  7 May 2019 06:07:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5fcKCSB7MKANNaOZVXZV5XVIUQ0=; b=DBfImJ
        X2IQxkRwjqrXd/IV1gOcWrnFujoo2GVPG8M8tkGvjXpownsud5PD5CrRxygeVobA
        oBfKjNziaKFkX3x22ekWEugOzf11K6UuluDEsocRRPjT/JPBKBE0So273ux7Ovul
        PJTiFtKxnnZx8QV1+mWhm/e/B88Vqe8Ly86LM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XQlS0ctKMs1YoDn0ig+XZ/Sv/s3A2Zcr
        uUM306RUg8AHzTmmYldv9jiLCHBP7eMFzRxqTihiTZvw9Vnb7Dl0jrHlRuv7DU6M
        E/nBFzdJZ3n56Bhxb4X2DEQAU7RlsDfGqzesn8JXLsi425CTQjdwT3Id2wao9vrn
        Z8mYPpKTTo8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9731B13F253;
        Tue,  7 May 2019 06:07:27 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07C1813F252;
        Tue,  7 May 2019 06:07:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Dr. Adam Nielsen" <admin@in-ici.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] make slash rules more readable
References: <20190504101905.7522-1-admin@in-ici.net>
Date:   Tue, 07 May 2019 19:07:25 +0900
In-Reply-To: <20190504101905.7522-1-admin@in-ici.net> (Adam Nielsen's message
        of "Sat, 4 May 2019 12:19:05 +0200")
Message-ID: <xmqqlfzilgrm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EAAF6AEA-70AF-11E9-B946-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Dr. Adam Nielsen" <admin@in-ici.net> writes:

> gitignore.txt: make slash-rules more readable
>
> Make all paragraphs valid, even if they are not read
> in strict order. Make paragraph better understandable
> for pattern without slash. Add paragraph for pattern 
> with slash. Be precise whenever a trailing slashes
> would make a difference. Add some examples.
>
> Signed-off-by: Dr. Adam Nielsen <admin@in-ici.net>
>

Have you run "git diff --check" before committing the change?  It
seems that many updated lines end in trailing spaces.
