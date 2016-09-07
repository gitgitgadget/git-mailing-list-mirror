Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC5E11F859
	for <e@80x24.org>; Wed,  7 Sep 2016 16:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935242AbcIGQrL (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 12:47:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53335 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934101AbcIGQrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 12:47:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D31D2389FF;
        Wed,  7 Sep 2016 12:47:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DkP23m3MjEMAqiDZJ5rjDsi7w18=; b=GiG+nA
        qkAIRXHdN+jn0WO9Ku6Aw13k7bT3+4i6iixLWbYgserVEvnZxGNgFezoj0cCpLXH
        ZoFnYbyDwZTQwj25EQo4FfjKf6bALPGkCXQaX8ve07MuOMH2txpnGg+5ixThIvgQ
        NK8XDc80pGSYysHFIWaefyVkNXc2S4/OOuASk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f+7qe7HNxQGCau55Kv3ayKEjzRFvsU0H
        VbDztjHFZuEWurMLIHXLXkUqjyd7MosOQqm0alqKP67aE9XugSx7u/NFUFuxEvZl
        60wN0GYqN2QMN3JrgJsR7X1pSX+uxq3ZKnymnMCtaSWXbpa5KfA1Pxt/ltqMsmDj
        tNXD1upuFXw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CBA7A389FE;
        Wed,  7 Sep 2016 12:47:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 50464389FD;
        Wed,  7 Sep 2016 12:47:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, spearce@spearce.org,
        sbeller@google.com, peff@peff.net
Subject: Re: [PATCH v2 1/2] tests: move test_lazy_prereq JGIT to test-lib.sh
References: <cover.1472853827.git.jonathantanmy@google.com>
        <cover.1472836026.git.jonathantanmy@google.com>
        <cover.1472853827.git.jonathantanmy@google.com>
        <360866f27d0bfcefca99b79c33daa9df2b82cee9.1472853827.git.jonathantanmy@google.com>
Date:   Wed, 07 Sep 2016 09:47:05 -0700
In-Reply-To: <360866f27d0bfcefca99b79c33daa9df2b82cee9.1472853827.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 2 Sep 2016 15:06:11 -0700")
Message-ID: <xmqqwpinodx2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B69337E8-751A-11E6-92A8-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This enables JGIT to be used as a prereq in invocations of
> test_expect_success (and other functions) in other test scripts.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  t/t5310-pack-bitmaps.sh | 4 ----
>  t/test-lib.sh           | 4 ++++
>  2 files changed, 4 insertions(+), 4 deletions(-)

Makes sense.  Thanks.
