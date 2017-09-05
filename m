Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,PI_IMPORTANCE_HIGH,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5567A208CD
	for <e@80x24.org>; Tue,  5 Sep 2017 02:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753639AbdIECUC (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Sep 2017 22:20:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58069 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753511AbdIECUB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2017 22:20:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA408A65D8;
        Mon,  4 Sep 2017 22:19:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=tNFffVW4K6qNpNyZpoasE81Tru4=; b=s7+Yiefzkq95y2f9Bd6a
        y/drBkF7Kj9yyZT+PMZhtRVds2H7fHoSFfW6zS0ezIV54N4P+MUB3uUEVlaSHSIf
        Lobtx6O+xFqZ5+PQT35JTSprbb4gZwenLabrHX7qaJkCFepeKB40+n7XYcGDsufW
        VA75P0j4Qj1LZjDOMgZK2SE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=d/ZVWr0lUH0jy1IUivCaCFlE6zSBoY4c1IOvEEuIq1rGiB
        XLGfbbNf9cXKon0/pdl821KGRPgOt4ft4meMVVtmCu5ittGBTm6jH26LXcLsz5Ot
        Aw2PYo49Um4nbZ7Qabu8sCdZDyV1U7qwPlfxKqcQFQQu/EXI0MdAGqqDf15pY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A22D4A65D7;
        Mon,  4 Sep 2017 22:19:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F1933A65D6;
        Mon,  4 Sep 2017 22:19:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Git in Outreachy round 15?
References: <20170901223059.xsbcpqff45mnblnj@sigill.intra.peff.net>
Importance: high
Date:   Tue, 05 Sep 2017 11:19:56 +0900
Message-ID: <xmqqk21ddgz7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6961790-91E0-11E7-BA78-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   2. Do we have the money (and want to spend it on this)?
>
>      The Git project does have money to cover at least one intern.
>
>      I'm looking into securing outside funding, so that we don't have to
>      use project funds. If for whatever reason that doesn't happen, is
>      this something we want to spend project money on?
>
>      (My opinion is yes, but I'd like to hear what others in the
>      community think).

$6,500 is a bargain if we could guide an intern and help set the
course to become a competent open source person.  It would be nice
if the intern stays in our community, but I do not even mind if the
investment follows the intern elsewhere and enrich other open source
projects.

It is a different matter if our mentor pool is rich enough to give
sufficient support and training to the intern, but if you are
volunteering to mentor, I wouldn't have any worries.  I do agree
with you that it would be a good idea to polish the project-ideas
page.

Thanks.
