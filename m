Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7EEB2047F
	for <e@80x24.org>; Sat, 23 Sep 2017 23:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbdIWXsU (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 19:48:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50076 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750959AbdIWXsT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 19:48:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BC51A0CAB;
        Sat, 23 Sep 2017 19:48:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kimLit4zwWpQ6dpXUvc40X2aMJ0=; b=SCUIur
        ZrvuwzuPEuNOt9+c/ZQXmzRPjeE6U+WscgENr4+MDVza6AXorvKoQpsEkMLycpbE
        lZJfufhRva6nAnzywVNlnR9upWAOAOjP0EG+OriJBcL4+oBInKJFuyKyRIfTI9Ej
        wfc3cCjcYNG1JstNmWe1zY0QRJTfl7sbTT+VE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lbFDwh58m74hgS0wbfgX8T5HdHIDuRSF
        DveOt8TOecSWicsH/Bxk/ZDRHvwC5zu5jcOAG386HmZepWms4FNorrzI0CZq7oiT
        +f1xWbSex5q83BjDzT9ph3FOc0qYh0c76dH24WJNCdGumy9BJZGAD0096SYtBStz
        fFISXiOIWYE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9355DA0CAA;
        Sat, 23 Sep 2017 19:48:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0248AA0CA9;
        Sat, 23 Sep 2017 19:48:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/4] merge: --no-verify to bypass pre-merge hook
References: <cover.1506081120.git.git@grubix.eu>
        <bdc45cade9a8d108b7d11d66c0eecb27c2f23af6.1506081120.git.git@grubix.eu>
Date:   Sun, 24 Sep 2017 08:48:14 +0900
In-Reply-To: <bdc45cade9a8d108b7d11d66c0eecb27c2f23af6.1506081120.git.git@grubix.eu>
        (Michael J. Gruber's message of "Fri, 22 Sep 2017 14:04:14 +0200")
Message-ID: <xmqq60c9j7sx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB3ABA6C-A0B9-11E7-8D6B-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> From: Michael J Gruber <git@drmicha.warpmail.net>
>
> Analogous to commit, introduce a '--no-verify' option which bypasses the
> pre-merge hook. The shorthand '-n' is taken by the (non-existing)
> '--no-stat' already.
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---

It appears that some of the pieces in this patch, namely,
D/git-merge.txt and D/merge-options.txt, belong to 2/4, where we are
fixing up an earlier addition of --[no-]verify option to the
command, to be updated to only add mention of pre-merge hook in this
step?

The end result looks good regardless, I would think, though.
