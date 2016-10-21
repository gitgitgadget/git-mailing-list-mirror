Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463A820229
	for <e@80x24.org>; Fri, 21 Oct 2016 18:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755677AbcJUSkg (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 14:40:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61037 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755567AbcJUSkf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 14:40:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7D0848B7D;
        Fri, 21 Oct 2016 14:40:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Oy4q2WXi0MkD3IkWezy+x7smn6M=; b=gY1ENB
        gvRuT32+qMldmumh5S5wWShfGNZeIsJ1acdzmgppUKBARJXbu9iKqumuEqzQohrp
        GzX2sFkNmndMhSSJAlFWJUzhVwXULLaJnDSACmVj5BxJDwx8C+h3u7avNFdVfaEj
        CMnUuStbagXmOZ90kuzEOUK+QvLl+FX9Iw+Ys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KUv13PvC0S9768jUziq9UrbwBT2HtysK
        LNvboi4wXdoQHY+WgLW5pQF8VTYC76ohQhsVza7/ZaIZiQ5FfZb8puOGYSWPkNfq
        yZwM3UKJ0iP0fS8dG269eTjS+2vhq3M7GR5A4pgth9n+QikwJM50oajsPCSqMGRs
        oxpQYtHXSdI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CCDA448B7C;
        Fri, 21 Oct 2016 14:40:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 29E1548B7B;
        Fri, 21 Oct 2016 14:40:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 00/27] Prepare the sequencer for the upcoming rebase -i patches
References: <cover.1476450940.git.johannes.schindelin@gmx.de>
        <cover.1477052405.git.johannes.schindelin@gmx.de>
Date:   Fri, 21 Oct 2016 11:40:30 -0700
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Fri, 21 Oct 2016 14:23:45 +0200 (CEST)")
Message-ID: <xmqqinslbl5t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D94F9EBE-97BD-11E6-A73C-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Changes vs v4:

I still do not understand (note that I am not saying "I do not
accept"--acceptance or rejection happens after an understandable
explanation is given, and "do not understand" means no such
explanation has been given yet) your justification behind adding a
technical debt to reimplement the author-script parser and not
sharing it with "git am" in 13/27.

As I pointed out, I think 22/27 is out of place in this series.

But other than these two points, the changes since v4 look minimum,
and they all looked good to me.

Thanks.
