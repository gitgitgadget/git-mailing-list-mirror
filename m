Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55B8920281
	for <e@80x24.org>; Sun, 17 Sep 2017 08:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbdIQIDr (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 04:03:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60572 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750793AbdIQIDp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 04:03:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97ED5AF858;
        Sun, 17 Sep 2017 04:03:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=15Ib2WHiW0ryfJUUctFIiFmfiRE=; b=HPpci7
        v9buIMkuSyhQm/Lo24Vepbv+MB/zl0GO/5zlyDdbqB6+wFCGFwgCNkRJXMRhy64B
        wE2ZqoBk/CdbgnsB6uTt1RlJ/ReuPSfpTnNwWi45N/GAZDtmb77Hh1c7xYUarDXx
        nl4BJi6sssCa7Qgun0gv57YBB5HZeQl346+eU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SjtxwlXEuUAuPMAnyowKtEJJuREyUv1D
        xW+V91/qfylPpqkUuhMMcir2L8k7mEGKmBYtlmrtFeX5PSvQxqaymHlm2iFWVxzl
        +8L0XkVkeJA/nSV1aCZO4JAZdXdsxcGp8fQtnZ4iTR0DF3MpNA8JQ5FZGy48w/Nn
        X5kVwpKj0wc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D6DDAF856;
        Sun, 17 Sep 2017 04:03:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6A73AF855;
        Sun, 17 Sep 2017 04:03:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH v6 05/12] fsmonitor: add documentation for the fsmonitor extension.
References: <20170610134026.104552-1-benpeart@microsoft.com>
        <20170915192043.4516-1-benpeart@microsoft.com>
        <20170915192043.4516-6-benpeart@microsoft.com>
Date:   Sun, 17 Sep 2017 17:03:42 +0900
In-Reply-To: <20170915192043.4516-6-benpeart@microsoft.com> (Ben Peart's
        message of "Fri, 15 Sep 2017 15:20:36 -0400")
Message-ID: <xmqqpoapu4yp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B991AF84-9B7E-11E7-B231-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> +[[fsmonitor-watchman]]
> +fsmonitor-watchman
> +~~~~~~~~~~~~~~~

I've queued a mini squash on top to make sure the ~~~~ line aligns
with the length of the string above it by adding three ~'s here.
