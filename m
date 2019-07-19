Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B59F91F461
	for <e@80x24.org>; Fri, 19 Jul 2019 21:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfGSVrr (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 17:47:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63371 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfGSVrr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 17:47:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7530D7AC32;
        Fri, 19 Jul 2019 17:47:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cV+UaaOxE0fxEPRRU66M33luDP0=; b=fWKxAk
        TojTAqj5wOZ/5JGzEvFz4NHWqc5NO8CRKNZ4Mjn0oVSm56YudilWt78T357k8bjb
        y+erOAddkJv5FWd2zfjRY55bw505dHglwx7aJaEvlexHcRpAU9ith+aPqz7Y+E/T
        dtrkxUAHFo6yI8zOyMW7l/Wnv/3fBdcfWLSwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AMIBRfhNfvcr2nUarYLaZfnPnayP+cJQ
        qgQk3uekLZzuYQFWQzoYBws4tSsAmWgNSmhnuUvZmA5EwbYYN8FYhmYwisa1caeY
        rdE0arf4mhMGWUiLT0LlQvzvqPi7aZKkstLe4snHrH9DONuwpp1DSVs6QTJK3l2t
        xIzH3kZPol4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DE217AC31;
        Fri, 19 Jul 2019 17:47:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9CA727AC30;
        Fri, 19 Jul 2019 17:47:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Dscho <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Martin <martin.agren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>
Subject: Re: [GSoC][PATCH v2 0/2] rebase -i: support --committer-date-is-author-date
References: <20190712185357.21211-1-rohit.ashiwal265@gmail.com>
        <20190718190314.20549-1-rohit.ashiwal265@gmail.com>
        <xmqqa7d9vhq0.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 19 Jul 2019 14:47:40 -0700
In-Reply-To: <xmqqa7d9vhq0.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 19 Jul 2019 14:26:31 -0700")
Message-ID: <xmqq1rylvgqr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D618C8DA-AA6E-11E9-836F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:
>
>> Another revision to keep this thread alive.
>
> And on top of what commit have these two been built on?

I had trouble figuring out where to base the other one, on top of
which these two apply.  Why are these split into separate topics?
