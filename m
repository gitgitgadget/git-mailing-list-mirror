Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0396F203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 18:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936368AbcLMSLj (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 13:11:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55879 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936053AbcLMSLj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 13:11:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27147567A8;
        Tue, 13 Dec 2016 13:11:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=95PmBugxqx0qPwp4BNJsghC9G0s=; b=NRAlkP
        f5FJ1+d11P7EmWeVFuiQ+mC2egJljr/Vy4MeC0uoEqGQnCVHKrAhZwdV3Ze21jUf
        pM4kXrfcxOCmB6nQSlamihoI1ZlTVndQoZLTaTXCDboe31qrOyI2JGJwRsidtbuy
        LUy1TJOEk8IIvy7Kx1wlo+xAfitF4BOaRs8ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EczSR8cmGGW9K7uLvflQloaDIqfv6W+i
        1q22iGVzNFJP+pFbGDtEVWmJmCGZ/N8wToNSPq1gZ1PEw5MtVgDdS8J8stokEadC
        Ch7EISvDXC89Xk5x55dfTVmfgA5El9wlscSSq5fYhQEDQ5RApRgsOMy1/Ru6MTPV
        pXeeciRJYOg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E532567A7;
        Tue, 13 Dec 2016 13:11:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 89C3B567A3;
        Tue, 13 Dec 2016 13:11:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] doc: add articles (grammar)
References: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com>
        <20161209155112.2112-2-kristoffer.haugsbakk@gmail.com>
        <88A192B34B3D4DDDA47628687AE458D3@PhilipOakley>
        <8737hsj7wp.fsf@gmail.com>
Date:   Tue, 13 Dec 2016 10:11:36 -0800
In-Reply-To: <8737hsj7wp.fsf@gmail.com> (Kristoffer Haugsbakk's message of
        "Tue, 13 Dec 2016 14:05:58 +0100")
Message-ID: <xmqqoa0f4s2v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96B3F30E-C15F-11E6-B8A1-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com> writes:

> Thank you for reviewing this series, Philip.
>
> Philip Oakley writes:
>
>> This looks good to me.
>
> I'll add this header:
>
>     Acked-by: Philip Oakley <philipoakley@iee.org>
>
> To the commit message of this patch in the next review round (version 2
> of the patch series).
>
> Let me know if I should add another header, or do something different
> than this.

I was planning to merge all four from you as-is to 'next' today,
though.  Should I wait?

