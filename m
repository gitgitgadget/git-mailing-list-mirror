Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1409220899
	for <e@80x24.org>; Thu, 17 Aug 2017 18:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbdHQSEb (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 14:04:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51015 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753283AbdHQSEa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 14:04:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0021CA7B53;
        Thu, 17 Aug 2017 14:04:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FaRsgJjD8nQxgjWbbXbKvZEGK9Y=; b=K5a0WB
        yx4lCAnH0Ia9TxUPQB/VX0GNPwqEA9E/UPlO6rEtLHApcyipqYhEwVKBvzdO+7S6
        Jfx2Sv/ZHliCLy8MVLttHdk29ctQDmbhP3K9kAD3I0EeBwWUfZj3kiBdI8ObaH+k
        LiuK3qz6KETJm3zA5aoOpFhyd4QgDol8qMwbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AtQJMzTv69OlZddMPirgISvOskzX61bE
        7VyyNQBKiLViGqzWurKQb+a4FOHSFnPxa6CrIbpqXMlvAFywzyfHi3CVw/3flTC0
        /db132tBmL4jdnRroTDSfpDDzpSmN6dq4QSbeVjxjJiQ3Ot67+q1pLj2p9dLN2U7
        M+8ggQAMpak=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB690A7B51;
        Thu, 17 Aug 2017 14:04:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 510E4A7B50;
        Thu, 17 Aug 2017 14:04:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [Patch size_t V3 17/19] Convert ref-filter to size_t
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
        <1502914591-26215-18-git-send-email-martin@mail.zuhause>
        <xmqqmv6ygjha.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 17 Aug 2017 11:04:21 -0700
In-Reply-To: <xmqqmv6ygjha.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 17 Aug 2017 11:03:13 -0700")
Message-ID: <xmqqinhmgjfe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F50E0BC-8376-11E7-9105-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I did not see anything fishy in the remaining parts I did not
> comment on.
>
> Thanks.

What I meant was "remainder of this patch 17/19".  I am not claiming
that I read all other patches; I haven't, not yet anyway.
