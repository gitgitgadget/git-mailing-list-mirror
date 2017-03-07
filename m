Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BB021FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 22:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933152AbdCGW73 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 17:59:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50294 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755817AbdCGW72 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 17:59:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B64AC80BCA;
        Tue,  7 Mar 2017 17:43:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CtZCkOcGzjZvohlcokHLPw0BubA=; b=TGYiqV
        4wUGgFK9xZF/yhl93ytB2N035Bn+QN1x0ihDqWc1UWtBjYQr3PC4akv0T8XUN+Th
        w95Lub/604M8cEigI9FFnue29aHJMc3SAYBxesuh2i6GMblUwzsyd72LVdCQt+dJ
        wlKspE1g9LlN5tfxt1X0CSyuywAN2ty432hvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OrJH7Hi1AMb8BmsqLtk9PPwkUFIK9VEm
        XsBsKpQKgvzJWIteCYTYPzq0P0prnZateJQGfyOGvQkF1LptT1aF9QBXiZvlT3sT
        /llCUBi0n86DRSC16AtHh6vNL4eLYZX5SklV/NMTTP1USAlH7M2fk2RK7yeVXHaw
        KOEWSEbqMss=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF04D80BC9;
        Tue,  7 Mar 2017 17:43:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1178980BC8;
        Tue,  7 Mar 2017 17:43:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Hiroshi Shirosaki <h.shirosaki@gmail.com>, git@vger.kernel.org
Subject: Re: [PULL] git svn branch authentication fix
References: <1488779947-25264-1-git-send-email-h.shirosaki@gmail.com>
        <20170307213217.GA20443@starla>
Date:   Tue, 07 Mar 2017 14:43:22 -0800
In-Reply-To: <20170307213217.GA20443@starla> (Eric Wong's message of "Tue, 7
        Mar 2017 21:32:17 +0000")
Message-ID: <xmqqbmtc673p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 783D5A18-0387-11E7-81DE-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Thank you.  I fixed spelling in the title (s/authenticaton/authentication/),
> added my S-o-b, and pushed for Junio to pick up
>
> The following changes since commit 3bc53220cb2dcf709f7a027a3f526befd021d858:
>
>   First batch after 2.12 (2017-02-27 14:04:24 -0800)
>
> are available in the git repository at:
>
>   git://bogomips.org/git-svn.git svn-auth-branch
>
> for you to fetch changes up to e0688e9b28f2c5ff711460ee8b62077be5df2360:
>
>   git svn: fix authentication with 'branch' (2017-03-07 21:29:03 +0000)
>
> ----------------------------------------------------------------
> Hiroshi Shirosaki (1):
>       git svn: fix authentication with 'branch'
>
>  git-svn.perl | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks, both.  Will pull.
