Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99DB01F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 17:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbcJKRFL (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 13:05:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58343 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752183AbcJKRFL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 13:05:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A6894349A;
        Tue, 11 Oct 2016 13:05:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wBrEVw76GiA2WfkAMjFowEy8LoA=; b=mM4Oyy
        8DsdZng8lDPuGnvWqbQokf2A49Ln+eN1hSLAPXbSLcBNPTAMWYyITAP5xVyM8rVb
        h1o0TgZqdUMxz+R/Sjpt3V4ihPR+qXQfxA7kJQIz+E8XuHjyZLR/klADuP9Plei/
        /nVb+BWTbKEKLz4zDv1Trc9/eMEWhbqpwrfpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iPEMTXIa1l/994OQclXwwAxkF4WK3tUY
        WoNYTMt/QGij/wZwGLAq03kHBKXPjMIEMhO8yFYmfoHHTCU7vkgoysCV6aqEyP1s
        uNRyjaZYv4qDrpaNOZ/N1vsN0Irnl4yjCXEAC4xK09vysxPiZ18UBNYTpy9rztsy
        cX+6oNVk2WA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9294943495;
        Tue, 11 Oct 2016 13:05:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C74443494;
        Tue, 11 Oct 2016 13:05:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Luis Gutierrez <luisgutz@gmail.com>
Subject: Re: [PATCH v4 4/4] mergetool: honor -O<orderfile>
References: <20161008000130.22858-1-davvid@gmail.com>
        <xmqqa8ecf48c.fsf@gitster.mtv.corp.google.com>
        <20161011050623.GA14278@gmail.com>
Date:   Tue, 11 Oct 2016 10:05:07 -0700
In-Reply-To: <20161011050623.GA14278@gmail.com> (David Aguilar's message of
        "Mon, 10 Oct 2016 22:06:23 -0700")
Message-ID: <xmqqr37makak.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD568900-8FD4-11E6-81AC-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

>> I only see 4/4 in v4; am I correct to assume that 1-3/4 of v4 are
>> the same as their counterparts in v3?
>
> Yes, 1-3 are unchanged since v3.
> Thanks for checking,

I'll queue these four with Reviewed-by's from j6t.

Thanks, both.
