Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA4D1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 19:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933326AbeAITJv (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 14:09:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59967 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932986AbeAITJu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 14:09:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA046BE6CD;
        Tue,  9 Jan 2018 14:09:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HcaOVuPkEGgGtVrKu9IvBzHWbOk=; b=klL85T
        HP/XjJI+2mzS3wjRk43H6CnHtcekHab3orjZubBtcxUgC0UvuWoxBxcpch1ZsV9X
        cwIo1g1zeygSqKsgahBapRIqjkCtNjSm6rKov6/JjpS9vOsxhzwvPApUIMES7CCL
        7WTxfPfLSyfaFVy8T01vFvQ9k9Z3dpS4KUheo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gyaOVscLi0EjrtvpDRCUjij0XV1o+eaU
        ZcXlgEGQyZghN0SBpY2PggARutzMH4QQFwmwR4sF9J04WU4aBjRA7m83TQXijcqw
        c7wfmSNyb4sl55mHfG8myMe58rG6vU6msd1icqNk9NrwzylWQxXLb6TcIa5vBzcc
        QKIHuYRjK5c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0CADBE6CC;
        Tue,  9 Jan 2018 14:09:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 28903BE6CB;
        Tue,  9 Jan 2018 14:09:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] "Fast-"track Git GUI changes
References: <cover.1515508360.git.johannes.schindelin@gmx.de>
        <xmqqinca6em2.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 09 Jan 2018 11:09:47 -0800
In-Reply-To: <xmqqinca6em2.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 09 Jan 2018 11:01:25 -0800")
Message-ID: <xmqqbmi26e84.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9CA50BE-F570-11E7-8997-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> As it seems to be impossible to get the attention of the Git GUI
>> maintainer these "days" (I have opened Pull Requests on October 16th
>> 2016 that have not even been looked at), let's just side-step that
>> contribution path which seems to be dormant.
>
> Good to see that finally somebody else steps up after I did the same
> for a few times recently.
>
>> These fixes have been in Git for Windows for various amounts of time.
>>
>> Note: there are more Git GUI changes in Git for Windows, I only
>> accumulated the ones I deem wort considering for inclusion into v2.16.0,
>> still.
>
> Thanks.  I am not sure if it is too late for 2.16, as these are not
> fixes for regression during this cycle, though.

Heh, I changed my mind.  

Just like I pretended to be interim maintainer of Git-GUI for the
past two times, you are doing the same this time and I even agreed
that it was a good thing that you volunteered to pretend as one.

So let's follow through the pretence to its conclusion and merge
these directly to 'master'.

Thanks.
