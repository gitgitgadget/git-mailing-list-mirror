Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58245207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 16:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933777AbcI3QQc (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 12:16:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54572 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933082AbcI3QQa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 12:16:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 453D6402AC;
        Fri, 30 Sep 2016 12:16:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bf9/ELZQzBU9vQ6X94Voz73YHGY=; b=NkF5EG
        Q526WCPlkbtcx847jV9oRKja9fNXnP4TuhZYkEE7wpfn/p5JA/PVyMFBSEVDrEre
        25P2YxcOAGnC6YrBLEHZ35TRfI7DL9wf5suLgXNhjAFoBwYWMUKhu2TJgNGhLEZR
        mg8egLbGHYuXzN19FJRuWy6kuHSIgSNvo9OV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vuHMvXgXaBa9tC+PHM9byf49JiT8BD4N
        nlqnSnLa3HZBKJCNRhLodKhlwbn/8FcCqT4pQr4YAtODhTHBxg9bpGGKcQaC+4DZ
        GhQKDfYNVAvZ5mRrV5HDGMELCUMSWemxCYjrRAtKqQkjW2/uRIZWzo7uOucQw8Z0
        JBiRSeXJ3s0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E2EE402A9;
        Fri, 30 Sep 2016 12:16:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8C69402A7;
        Fri, 30 Sep 2016 12:16:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        Alex <agrambot@gmail.com>
Subject: Re: [PATCH v2] gpg-interface: use more status letters
References: <xmqqk2dxp84i.fsf@gitster.mtv.corp.google.com>
        <c4777ef68059034d7ad4697a06bba3cabbdc9265.1475053649.git.git@drmicha.warpmail.net>
        <xmqqshsjiyn4.fsf@gitster.mtv.corp.google.com>
        <24ecc903-3e5a-47f6-f073-00a1c709d5e8@ramsayjones.plus.com>
        <85fa6296-17f0-0e8c-ec1b-54cd48c45223@drmicha.warpmail.net>
Date:   Fri, 30 Sep 2016 09:16:26 -0700
In-Reply-To: <85fa6296-17f0-0e8c-ec1b-54cd48c45223@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Fri, 30 Sep 2016 11:41:11 +0200")
Message-ID: <xmqq60pdbbxh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E3347B8-8729-11E6-8AC6-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Also, I'm open to using another letter for EXPKEYSIG but couldn't decide
> between 'Y', 'Z', 'K'. 'K' could be confused with REVKEYSIG, I'm afraid.
> 'Y' is next to 'X' and contained in 'KEY', it would be my first choice.

Sounds good enough to me.  Thanks.
