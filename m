Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D31CA0EC8
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 02:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbjILCiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 22:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbjILCiF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 22:38:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BB973E89
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 16:06:32 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DBAA938E0C;
        Mon, 11 Sep 2023 19:02:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=RiLGogSq85xNuGM9SpzuIHSW/SeIjtnX7X2inX
        EZs7k=; b=t3ihdzQah5zi3/VwpFL7b9cXQGvt7ByMPvTRKRpuAI3CyK0oPtrgD+
        aPlklnkrU2ntTd2qQVwVzKgkSJwvSHVmyfVFjq9nla6t8TzFd9dHCdwAYeaX1w1g
        BpZ5dm4suJ5h4rGYag4/bee+qQvzEacN6JOM/UVYuKYrJ1qHPrA1s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D40D338E0B;
        Mon, 11 Sep 2023 19:02:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 58D2C38E0A;
        Mon, 11 Sep 2023 19:02:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] New configuration option "diff.statNameWidth"
In-Reply-To: <261907dbfafc8d7b3b048854b663e82d@manjaro.org> (Dragan Simic's
        message of "Mon, 11 Sep 2023 20:56:43 +0200")
References: <eb8f524eca3975f086715ec32a8a1fbb@manjaro.org>
        <xmqq8r9ommyt.fsf@gitster.g>
        <72c114086590b9b15a3fdd9e0d6bd67e@manjaro.org>
        <xmqq4jkcmdaw.fsf@gitster.g>
        <a879c9c7d3b9bdae9a49f67fbe6316fc@manjaro.org>
        <261907dbfafc8d7b3b048854b663e82d@manjaro.org>
Date:   Mon, 11 Sep 2023 16:02:40 -0700
Message-ID: <xmqqo7i8s48f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FF70166-50F7-11EE-BEF5-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dragan Simic <dsimic@manjaro.org> writes:

> On 2023-09-03 05:43, Dragan Simic wrote:
>> On 2023-09-03 00:16, Junio C Hamano wrote:
>>> Having said all the above, once we start seeing the actual patches
>>> and its sales pitch (aka proposed commit log message), we do guide
>>> and help polishing the patch into a better shape, so it will not
>>> be like the contributor has to work in the dark without knowing
>>> what level of bar their contribution has to pass.
>> Thanks, everything sounds great and welcoming to the new
>> contributors,
>> who of course need to be willing to put in the required amount of
>> skill and effort.
>
> I sent a patch to the git mailing list today, about five hours ago,
> but it hasn't appeared on the list yet.  Could something be wrong with
> the mail server(s), as I also received no other messages from the list
> in the last six hours or so?

It is a high-volume mailing list server and occasional hiccup is
part of regular life.  Waiting a bit and then poking the postmater
at vger.kernel.org may be needed from time to time, but I am seeing
your message on the archive, so it seems "waiting" has worked fine?

