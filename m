Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B5A2090A
	for <e@80x24.org>; Mon, 20 Mar 2017 21:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754711AbdCTVpl (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 17:45:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51633 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753230AbdCTVpk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 17:45:40 -0400
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Mar 2017 17:45:40 EDT
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D47E680E0E;
        Mon, 20 Mar 2017 17:45:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FQBDrQ3WGgywSNFej8Btf6jREx0=; b=GzRaNC
        IZC6IseX0BbJrBbqtm0hiz4i7/UbuUUEs12szUBSFgjrycm8Wqi5h0xNJ2Y1T7Z5
        J4MYpt2CSlj4+GaaYQ7F7lG7dy8UIfVmmBP18R7IkqLR+CGWc3Jy9pBkNrBhOd0B
        /zoXFHM13jFDBdpE8SscoY1aGaS8qYxEkIxAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uJ4bjyFrsaDw1LxHFwgZpT/xSGSYz2ds
        GBeFlJ406TaPNhADlKJiND2N40wi0qcJxACB3sugE2sOXYWwYkSb0U0Y/91dL6Qs
        trsvSx+fb6XC2H2iEhCmaoQl34SyPzo2dON5xFTRs3yT725diHBOp60z9vAoqZDo
        PnLN/2aTCCw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CBA5680E0D;
        Mon, 20 Mar 2017 17:45:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2330980E0C;
        Mon, 20 Mar 2017 17:45:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.12.1
References: <xmqqzigftyps.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 20 Mar 2017 14:45:34 -0700
In-Reply-To: <xmqqzigftyps.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 20 Mar 2017 14:39:11 -0700")
Message-ID: <xmqqtw6ntyf5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D2BA842-0DB6-11E7-A2C9-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The tarballs are NOT YET found at:
>
>     https://www.kernel.org/pub/software/scm/git/
>
> but hopefully will be in a few days (I am having trouble reaching
> there).

Now they are.

Thanks.

