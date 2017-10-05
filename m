Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ED732036C
	for <e@80x24.org>; Thu,  5 Oct 2017 01:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751221AbdJEBNl (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 21:13:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61387 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751177AbdJEBNk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 21:13:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06E75B1F8A;
        Wed,  4 Oct 2017 21:13:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gGP8WAZaOBCjGMnSRj7M8+PGrNU=; b=DH/fHM
        70Ajr1M9Bg7dHX3iJ5ovGTBxDqQSKyoZQdzrCsB3ToXTpdSVAwFb3iOuLqwnn7af
        ga0CVw4+aksth0ZeB0hVhZuoYwr+avpTpBoFzc8jQ4xToyYk9CquioKsac/RMt7w
        +6CgaaG+pGaZWWSIRCVNujOZ2B5P482LvRyXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iNVUmagNV55jq5Wojw7We2mG21Y5n8zZ
        VQgPGXWcQ+TD8RRpr+INi3B7mQzBgnyEpBjbFj/oebMVa0c5oDa7kNpFkSW7hn9n
        WySSzoZsrg9akpUQ59/azAWjGW0TTT/nou8SZBPChsLQogkkfgpRUKGQZtFwCcVQ
        xoF2tdBr11s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1F7DB1F89;
        Wed,  4 Oct 2017 21:13:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B667B1F88;
        Wed,  4 Oct 2017 21:13:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] branch: change the error messages to be more meaningful
References: <20170730115908.13841-1-kaarticsivaraam91196@gmail.com>
        <20170821133608.5652-1-kaarticsivaraam91196@gmail.com>
        <1506964786.3504.3.camel@gmail.com>
        <xmqqbmlpm67l.fsf@gitster.mtv.corp.google.com>
        <1507058081.7360.5.camel@gmail.com>
        <xmqqwp4beemb.fsf@gitster.mtv.corp.google.com>
        <1507121174.2245.3.camel@gmail.com>
Date:   Thu, 05 Oct 2017 10:13:38 +0900
In-Reply-To: <1507121174.2245.3.camel@gmail.com> (Kaartic Sivaraam's message
        of "Wed, 04 Oct 2017 18:16:14 +0530")
Message-ID: <xmqqmv569z25.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B933588-A96A-11E7-A2E0-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> Moreover, as a consequence of my assumption that the tests don't check
> for the error messages themselves; I haven't even thought of checking
> whether the tests or the travis-ci build succeeded as a consequence of
> my patches that touch "only" the error messages!

That's a bad thing, right?
