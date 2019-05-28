Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78A1C1F462
	for <e@80x24.org>; Tue, 28 May 2019 16:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfE1Qm2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 12:42:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57536 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1Qm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 12:42:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D5F16BDE3;
        Tue, 28 May 2019 12:42:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PpG0NJruOrKWg21uH1YLDruQp/c=; b=dt0Etw
        2GpPFTd/wuihnwMRt5+5w2qKcbKIyh0Drgto76n8jwK26nPCDMNoVOqPKOaokK5P
        pFNF7SD939KmKAgdRuPplstromdBMgM3rerTvecMAhZcxk0ipRbgO6hRMrPzyVCU
        rdMbqePsy4AmmojAthu3DSaSnS4Zqo/SuvMIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tDZsDWCujjOONKdlQOH9TOQvUGeT04vR
        +afriOonPBmmnYSJ9/vF24Vyb0FCpQeCSnUlf8c6JwKRuhvB0m331GjK060MbM4l
        QLF9XmofBvujeQzaj7LKfS2/r6/DhfOKFDjMj3Bz2zcwb4WCfbdr2WvsRazuYioS
        lq6YVBkh0aQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 124C66BDE2;
        Tue, 28 May 2019 12:42:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EB7AF6BDD6;
        Tue, 28 May 2019 12:42:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] gitsubmodules: align html and nroff lists
References: <20190501203216.141398-1-emilyshaffer@google.com>
        <20190501210354.GC13372@sigill.intra.peff.net>
        <20190520205404.GA32230@google.com>
Date:   Tue, 28 May 2019 09:42:19 -0700
In-Reply-To: <20190520205404.GA32230@google.com> (Jonathan Nieder's message of
        "Mon, 20 May 2019 13:54:04 -0700")
Message-ID: <xmqqh89e4jkk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90A403E4-8167-11E9-B5A5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>
>> The patch itself looks good to me.
>
> For what it's worth,
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> as well.  It's a straightforward patch and solves the reader-facing
> problem.  Thanks.

Thanks, all.
