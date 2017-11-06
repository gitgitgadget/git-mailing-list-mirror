Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DFA220281
	for <e@80x24.org>; Mon,  6 Nov 2017 02:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750907AbdKFCpu (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 21:45:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52044 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750844AbdKFCpu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 21:45:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F23EB4CDD;
        Sun,  5 Nov 2017 21:45:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FCmgj0EjLLL/9FL+4bPicwSbc54=; b=DtVb4E
        /9wowlAFG8AD233Ba3erPUwkhV/fAE2LbIgXAAUlGKx0kZOokrdKZ5tGMGg4py73
        ocnMuM2eDU13wuuDFR6lF1G7NpOx2oGiEyDT9UgNzNGFaaGcoSE7TsFwIgrwus7G
        Gwhxto5cgqx/r5xVYncL+hmv8zgBhZ2CPpboY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nGIJITx5SZTYmecB+sYAl3IFaO8euDgz
        KxTxZcm8lWi9yKYl1uOxVa7TisHQI+A+TLBW3Xc0jjqs5YvDKHHZeaYT9Jtvvtyr
        FNs65BoqC1+dVKs4nns2v5kjRfyFT4D0fgiIPa9v0/2y2JC5FB2pL5zCaRgqHGXN
        AK0EIq8pUWQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 286F5B4CDC;
        Sun,  5 Nov 2017 21:45:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89240B4CDB;
        Sun,  5 Nov 2017 21:45:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ann T Ropea <bedhanger@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3] checkout: describe_detached_head: remove 3dots after committish
References: <20171105162730.31405-1-bedhanger@gmx.de>
Date:   Mon, 06 Nov 2017 11:45:47 +0900
In-Reply-To: <20171105162730.31405-1-bedhanger@gmx.de> (Ann T. Ropea's message
        of "Sun, 5 Nov 2017 17:27:28 +0100")
Message-ID: <xmqqtvy8i0pw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98688018-C29C-11E7-A0A2-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ann T Ropea <bedhanger@gmx.de> writes:

> This could be confusing not only for novices; in either case, no range
> should be insinuated by describe_detached_head.

We actually do not insinuate any range in these output.  These dots
denote "truncated at the end, instead of giving full length."

Another place these "many dots" appear is "git diff --raw", for
example.

