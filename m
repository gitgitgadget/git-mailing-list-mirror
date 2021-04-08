Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017A2C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 19:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1048610C9
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 19:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhDHTwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:52:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60813 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHTwd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 15:52:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2993F1160C9;
        Thu,  8 Apr 2021 15:52:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9DvrnhnlG2YD8rKm6SNfr4IhiWE=; b=czyAeS
        6kc0MHLldDozqkzuV8Fn48FPFfle5iEj26B6az9KtdafaiYFNiDTnA/UsZrkJ/Ko
        rcPIYAdjV0b7CEddXXs6o2Z1dUl6CZJy5XvJVINkfN+nbxIH4wymqFHmFWmbrvwh
        ywVIZJdK7a7XZbLfe8QxZGHeLUhUOubC9AiDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e5UIBGK0J2dYFYX9hYPeMOdtgFLSJkci
        ZDrkMmIm0oi+feTlQ3cw2BjtHmQg9rHqlDtRgeTG1DdSDjTdUQI9S9uJxOHeGjEK
        fg71uW4ItAENXbnEOicQ03MqH3Bzp7W/p4Uu3I3F6D80s7Xh5XJihGWDohQm6BzA
        eDo7cbkbOpU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2245B1160C8;
        Thu,  8 Apr 2021 15:52:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6ADB61160C6;
        Thu,  8 Apr 2021 15:52:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        git@jeffhostetler.com
Subject: Re: [PATCH v2 0/5] Parallel Checkout (part 2)
References: <cover.1616015337.git.matheus.bernardino@usp.br>
        <cover.1617893234.git.matheus.bernardino@usp.br>
Date:   Thu, 08 Apr 2021 12:52:16 -0700
In-Reply-To: <cover.1617893234.git.matheus.bernardino@usp.br> (Matheus
        Tavares's message of "Thu, 8 Apr 2021 13:16:59 -0300")
Message-ID: <xmqqtuogsgen.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECC78D3A-98A3-11EB-8EB8-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> This is the next step in the parallel checkout implementation. As
> mt/parallel-checkout-part-1 is now on master, this round is based
> directly on master.

Thanks, will replace.
