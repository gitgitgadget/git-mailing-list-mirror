Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57C11F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 00:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfJCAy2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 20:54:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54277 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfJCAy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 20:54:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9726D842BE;
        Wed,  2 Oct 2019 20:54:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IaLrXfxHPsRyEnAPkQMXHUQkI6A=; b=iHnrPe
        lAQ4RoPkdUA8krShPU448anYGBo+FQBVF8TNeMXd4ealE12/qI6x2UsBf9Z5XwMz
        RkK5YjCdKjRNDTChuYQOQVYv9df2kp1LhucT9ivvQMJa/ikdA5hI4v5LjJ+B7yf0
        teVqDYjeGWfZr/glvL1RFW+2Hxsde7CnAQAQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KHzcrSNxOF9iE/V/fVm6/9R5jxNKmCdR
        ydKoNLhVNfdzrtOOLi2l2QSM79sCSUl4v2hNdL7yDEQoTtreqbign8WcZ2hTm3a/
        hCUoUefEGE1wDEYH5FlVQIRxb2ZOOPIjxxOa3Eri9wyGaRtjrC55++CJUUWEQL6h
        t8AiDri+WHY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 90A17842BD;
        Wed,  2 Oct 2019 20:54:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6DF99842BC;
        Wed,  2 Oct 2019 20:54:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] format-patch: create output directory including leading components
References: <1aeacd8af4b83142f160c63be4746554e823cfc3.1570051490.git.bert.wesarg@googlemail.com>
        <d959e78af1cb7ef49bca970643b2136c436cd57d.1570051490.git.bert.wesarg@googlemail.com>
Date:   Thu, 03 Oct 2019 09:54:20 +0900
In-Reply-To: <d959e78af1cb7ef49bca970643b2136c436cd57d.1570051490.git.bert.wesarg@googlemail.com>
        (Bert Wesarg's message of "Wed, 2 Oct 2019 23:26:12 +0200")
Message-ID: <xmqqimp6d4xv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 56AEFFCA-E578-11E9-A346-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---

Squash these two into a single step.  If "-o <output directory>"
forgets to create necessary leading directories, it is just a bug.

Thanks.
