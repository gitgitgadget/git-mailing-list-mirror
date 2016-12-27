Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63BE0200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 21:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753647AbcL0VST (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 16:18:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58690 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752567AbcL0VSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 16:18:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD38E5B5E0;
        Tue, 27 Dec 2016 16:17:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=LSeCZs6VKdpguunibbmMBY+aQsA=; b=WBKbbKXqj+0nG7qCOR2W
        dX60oOnk/9WQlRa8B3pjZQ1KbHYpBFTinwSXlOEmoHut76CbP2+NXYiQEtl3uX4g
        k7li5Pp2cWY+ic2EsIfviS9zjt0JANPdo8UTV17ECHATeYqurx5iY5GvqvdZNoDD
        ACOOi7AvST6wYbT7HYT7Ku0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=OhqKBd/JIU00sZKUbDXLl1NY2HowItWWOiT9a0VvPWZTbq
        Xc+eTOp1BIpwQskM4bVVzpgN4p1M4dXO9+59BsO8/DmhJL6SHPrw+73lPT5cNF1y
        /SZ8tCFiG5spuFa3yoHLpOfA1b1+9RPoiru3dkhmQNFS//5LIyLhY3HWaFUAA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4E2A5B5DE;
        Tue, 27 Dec 2016 16:17:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 269485B5DC;
        Tue, 27 Dec 2016 16:17:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v9 02/20] ref-filter: include reference to 'used_atom' within 'atom_value'
Date:   Tue, 27 Dec 2016 12:59:36 -0800
References: <20161227162357.28212-1-Karthik.188@gmail.com>
        <20161227162357.28212-3-Karthik.188@gmail.com>
Message-ID: <xmqq60m5842g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEC1B012-CC79-11E6-B9FD-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> Ensure that each 'atom_value' has a reference to its corresponding
> 'used_atom'. This let's us use values within 'used_atom' in the

s/let's us use/lets us use/;

> 'handler' function.
