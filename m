Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD417207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 19:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938318AbcIZTnJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 15:43:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52246 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934845AbcIZTnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 15:43:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7430040552;
        Mon, 26 Sep 2016 15:43:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h2My/TpkNqspawkBb8S9QRWXmcI=; b=euEQaP
        /XB/dmi3C4D+v8Je0uhFa09BM8BtGITpV//yz0cRHr8ymYb7h/IYLtvruIaNJzQb
        U67dUWA/8/qI5S6d3vwrS10GosVZvnGyn+kE3I3UtSp1UO+zoQ1Kj0L9JPXQAlsA
        yzXt6HlCi1iYBXrclCJHfVWgEaJ6df+pFTwVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cVpiBJSxR+tXADSUmgyeyyItOWUbqPnJ
        Wx9j4aZH3cNuWZOKRowMCSGNRNdwhLK6CLZGmLbiFBsTe55ll7sugeXktKMQDP71
        YWtBWs2AMG11Kfqe4GryBeM1SnQc8uI4mA0VeEk2n5Mok1bmzfzSe03szVtQIxv9
        ioXmW6q6YrU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C60440551;
        Mon, 26 Sep 2016 15:43:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E307640550;
        Mon, 26 Sep 2016 15:43:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu
Subject: Re: [PATCH 0/2] tree-walk improvements
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
Date:   Mon, 26 Sep 2016 12:43:04 -0700
In-Reply-To: <1474918365-10937-1-git-send-email-novalis@novalis.org> (David
        Turner's message of "Mon, 26 Sep 2016 15:32:43 -0400")
Message-ID: <xmqqshsmqwfr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7265BA9E-8421-11E6-8B24-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <novalis@novalis.org> writes:

> The first patch is a re-roll of Peff's patch from 2014 -- here's
> the archive message:
>
> http://git.661346.n2.nabble.com/PATCH-tree-walk-be-more-specific-about-corrupt-tree-errors-td7603558.html
>
> Not sure why this wasn't applied then, but I thought it looked pretty
> good, so I added a few tests.

Thanks.  Adding tests is very much appreciated.  I however wonder
why you needed to reword a perfectly readable "truncated" to
something else, though?

> Email address note 1: my employer wants me to use my company address,
> but not my company computer, for patches I write on work time.  This
> means that I'm going to continue corresponding from
> novalis@novalis.org, but will send patches with the @twosigma.com
> address in the author line.

That seems like not an uncommon practice ;-)

> Email address note 2: I'm not subscribed to the mailing list these
> days, so please CC me (at novalis@novalis.org) on replies.

It is good to tell others this, but I suspect that it is known by
those who are likely to respond to these messages that always CC'ing
to individual is the norm on this list ;-)

Thanks.
