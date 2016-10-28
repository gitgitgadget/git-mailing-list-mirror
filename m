Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 696D02035F
	for <e@80x24.org>; Fri, 28 Oct 2016 21:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942551AbcJ1VT0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 17:19:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63195 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933956AbcJ1VTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 17:19:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 631354A20A;
        Fri, 28 Oct 2016 17:19:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Omv2TmrohshenfaB/X10PJQmzUo=; b=Qo8xuj
        LusDsJQ85I1WxqK4sPn0iyNMUeAsmvLoj4y/lCjv89FP0BjAP1Sx7AnYYdw1JBE7
        5dtXcmU1LwVWHdGU4FXUQsGjMEkVQ6Q/93+ozRXoBULpbce0aawPI9ZzeqhukNCq
        +fCBAtR34PXy8U8ipp7NrLMqFl/V50t9EQWGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CrRHHO6HTaBTGWPY0wQq+Jqcml7wYmEz
        41rEv1Jc+ZQAZQI0sXKfJmyjSTZpBVCn15PUF//0Nxj8D6J7ZpPj2WYd3sVtTPdJ
        AR2JMYwakMQwm+NwOoXRsC0/PQ21Bt8e9Q3YX6RwS/bWje4f3xnztr6oqgyqiu51
        0w8YoWeKal0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C00E4A209;
        Fri, 28 Oct 2016 17:19:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CFCD94A207;
        Fri, 28 Oct 2016 17:19:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pre-receive.sample: Mark executable
References: <alpine.DEB.2.10.1610281438000.60842@buzzword-bingo.mit.edu>
Date:   Fri, 28 Oct 2016 14:19:21 -0700
In-Reply-To: <alpine.DEB.2.10.1610281438000.60842@buzzword-bingo.mit.edu>
        (Anders Kaseorg's message of "Fri, 28 Oct 2016 14:40:41 -0400 (EDT)")
Message-ID: <xmqq37jgyxwm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32EE2666-9D54-11E6-B72C-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Kaseorg <andersk@mit.edu> writes:

> For consistency with other hooks, allow the hook to be activated by
> renaming pre-receive.sample to pre-receive without a separate step to
> mark it executable.
>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---

Makes sense.  Thanks.


>  templates/hooks--pre-receive.sample | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 templates/hooks--pre-receive.sample
>
> diff --git a/templates/hooks--pre-receive.sample b/templates/hooks--pre-receive.sample
> old mode 100644
> new mode 100755
